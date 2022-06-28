import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:watchlist/bloc/registration/registration_bloc.dart';
import 'package:watchlist/constants/app_constants.dart';
import 'package:watchlist/constants/route_name.dart';
import 'package:watchlist/model/registration_request.dart';
import 'package:watchlist/ui/widgets/app_scaffold.dart';
import 'package:watchlist/ui/widgets/loader_widget.dart';
import 'package:watchlist/ui/widgets/text_widget.dart';

class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  late RegistrationBloc registrationBloc;

  @override
  void initState() {
    super.initState();

    registrationBloc = BlocProvider.of<RegistrationBloc>(context)
      ..stream.listen((state) {
        if (state is RegistrationDone) {
          log(state.response.response.infoMsg);
          LoaderWidget().showLoader(context, stopLoader: true);
          Navigator.pushNamed(context, RouteName.otpvalidationScreen,
              arguments: (ccode.text + phoneNo.text));
        }
        if (state is RegistrationError) {
          log(state.error);
          Navigator.pop(context);
          Fluttertoast.showToast(msg: state.error, backgroundColor: Colors.red);
        }
      });
    registrationBloc.add(AgreeEvent(false));
  }

  final formKey = GlobalKey<FormState>();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController ccode = TextEditingController(text: "+91");
  bool agree = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Appscaffold(
          title:
              Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
            TextWidget(
              AppConstants.watchlistLogin,
              fontweight: FontWeight.w600,
            )
          ]),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: TextWidget(
                      AppConstants.enterMobileNo,
                      size: 25,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: TextWidget(
                      AppConstants.otpinSms,
                      size: 17,
                      color: Colors.grey,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 25),
                    child: TextWidget(
                      AppConstants.phNo,
                      size: 19,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.16,
                        child: TextFormField(
                          controller: ccode,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: InputDecoration(
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 0.5),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            focusColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 0.5),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 0.5),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 0.5),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.71,
                        child: TextFormField(
                          controller: phoneNo,
                          // autofocus: true,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 10) {
                              return AppConstants.mobileValidation;
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            focusColor: Colors.white,
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 0.5),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 0.5),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 0.5),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 0.5),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.08),
                    child: Row(
                      children: [
                        BlocBuilder<RegistrationBloc, RegistrationState>(
                          buildWhen: (previous, current) =>
                              current is AgreeState,
                          builder: (context, state) {
                            if (state is AgreeState) {
                              log(state.isAgree.toString());
                              agree = state.isAgree;

                              return Checkbox(
                                value: agree,
                                onChanged: (bool? value) {
                                  registrationBloc
                                      .add(AgreeEvent(value ?? false));
                                },
                              );
                            } else {
                              return Container();
                            }
                          },
                        ),
                        const TextWidget(
                          AppConstants.agreeTerms,
                          size: 18,
                        )
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor:Theme.of(context).backgroundColor
                         
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (agree) {
                              LoaderWidget().showLoader(context,
                                  text: AppConstants.pleaseWait);
                              context.read<RegistrationBloc>().add(
                                  RegistrationRequestEvent(RegistrationRequest(
                                      request: Request(
                                          data: Data(
                                              mobNo:
                                                  "${ccode.text}${phoneNo.text}"),
                                          appID:
                                              "f79f65f1b98e116f40633dbb46fd5e21"))));
                            } else {
                              Fluttertoast.showToast(
                                  msg: AppConstants.pleaseAgree,
                                  backgroundColor: Colors.red);
                            }
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: const TextWidget(
                            AppConstants.generateOtp,
                            color: Colors.white,
                            size: 20,
                          ),
                        )),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
