import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:watchlist/bloc/registration/registration_bloc.dart';
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
  final intRegex = RegExp(r'\d+', multiLine: true);
  @override
  void initState() {
    super.initState();

    registrationBloc = BlocProvider.of<RegistrationBloc>(context)
      ..stream.listen((state) {
        if (state is RegistrationDone) {
          log(state.response.response.infoMsg);
          Navigator.pop(context);
          Navigator.pushNamed(context, "/loginpage", arguments: userInput.text);
        }
        if (state is RegistrationError) {
          log(state.error);
          Navigator.pop(context);
          Fluttertoast.showToast(msg: state.error);
        }
      });
  }

  final formKey = GlobalKey<FormState>();
  TextEditingController userInput = TextEditingController();
  bool agree = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Appscaffold(
          title:
              Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
            TextWidget(
              "MSIL WatchList Login",
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
                      "Enter Your Mobile Number",
                      size: 25,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: TextWidget(
                      "A 4-digit OTP will be sent in SMS to verify your \n mobile number",
                      size: 17,
                      color: Colors.grey,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 25),
                    child: TextWidget(
                      "Phone Number",
                      size: 19,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.16,
                        child: TextFormField(
                          initialValue: "+91",
                          readOnly: true,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: InputDecoration(
                            focusColor: Colors.white,
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
                        height: 50,
                        width: MediaQuery.of(context).size.width * 0.71,
                        child: TextFormField(
                          controller: userInput,
                          validator: (value) {
                            if (value!.isEmpty || value.length < 10) {
                              return "Please enter valid mobile number";
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
                            focusColor: Colors.white,
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
                        Checkbox(
                          value: agree,
                          onChanged: (bool? value) {
                            setState(() {
                              agree = value ?? false;
                              log(agree.toString());
                            });
                          },
                        ),
                        const TextWidget(
                          "Agree to our Terms and Conditions",
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
                          backgroundColor: Colors.blue[700],
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (agree) {
                              LoaderWidget()
                                  .showLoader(context, text: "Please wait");
                              context.read<RegistrationBloc>().add(
                                  RegistrationRequestEvent(RegistrationRequest(
                                      request: Request(
                                          data: Data(
                                              mobNo: "+91${userInput.text}"),
                                          appID:
                                              "f79f65f1b98e116f40633dbb46fd5e21"))));
                            } else {
                              Fluttertoast.showToast(
                                  msg:
                                      "Please agree to our terms and conditons",
                                  backgroundColor: Colors.red);
                            }
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: const TextWidget(
                            "Generate OTP",
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
