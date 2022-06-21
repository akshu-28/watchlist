import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';
import 'package:watchlist/bloc/registration/registration_bloc.dart';
import 'package:watchlist/model/registration_request.dart';
import 'package:watchlist/ui/widgets/app_scaffold.dart';
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
    // TODO: implement initState
    super.initState();

    registrationBloc = BlocProvider.of<RegistrationBloc>(context)
      ..stream.listen((state) {
        if (state is RegistrationDone) {
          log(state.response.response.infoMsg);

          Navigator.pushNamed(context, "/loginpage");
        }
      });
  }

  TextEditingController userInput = TextEditingController();
  bool agree = false;
  @override
  Widget build(BuildContext context) {
    return Appscaffold(
        title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [Text("MSIL WatchList Login")]),
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
                      width: MediaQuery.of(context).size.width * 0.15,
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
                      width: MediaQuery.of(context).size.width * 0.73,
                      child: TextFormField(
                        controller: userInput,
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
                        context.read<RegistrationBloc>().add(
                            RegistrationRequestEvent(RegistrationRequest(
                                request: Request(
                                    data: Data(mobNo: "+91${userInput.text}"),
                                    appID:
                                        "f79f65f1b98e116f40633dbb46fd5e21"))));
                        //Navigator.pushNamed(context, "/loginpage");
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
        ));
  }
}
