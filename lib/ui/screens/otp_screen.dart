import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';

import 'package:watchlist/bloc/registration/registration_bloc.dart';
import 'package:watchlist/constants/app_constants.dart';
import 'package:watchlist/constants/route_name.dart';
import 'package:watchlist/model/login_request.dart';
import 'package:watchlist/model/registration_request.dart' as reg;
import 'package:watchlist/ui/widgets/app_scaffold.dart';
import 'package:watchlist/ui/widgets/loader_widget.dart';
import 'package:watchlist/ui/widgets/text_widget.dart';

import '../../bloc/otp_validation/otp_validation_bloc.dart';

class OtpValidation extends StatefulWidget {
  final String mobileNumber;
  const OtpValidation({Key? key, required this.mobileNumber}) : super(key: key);

  @override
  State<OtpValidation> createState() => _OtpValidationState();
}

class _OtpValidationState extends State<OtpValidation> {
  int otpCodeLength = 4;
  String? _otpCode;

  TextEditingController textEditingController = TextEditingController(text: "");
  late OtpvalidationBloc otpvalidationBloc;
  late RegistrationBloc registrationBloc;
  ValueNotifier valueNotifier = ValueNotifier("");
  @override
  void initState() {
    super.initState();
    registrationBloc = BlocProvider.of<RegistrationBloc>(context)
      ..stream.listen((state) {
        if (state is RegistrationDone) {
          Navigator.pop(context);
        }

        if (state is RegistrationError) {
          log(state.error);
          Navigator.pop(context);
          Fluttertoast.showToast(msg: state.error, backgroundColor: Colors.red);
        }
      });

    otpvalidationBloc = BlocProvider.of<OtpvalidationBloc>(context)
      ..stream.listen((state) {
        if (state is RegistrationDone) {
          Navigator.pop(context);
        }
        if (state is OtpvalidationDone) {
          Navigator.pop(context);
          Navigator.pushNamed(context, RouteName.watchlistScreen);
        }
        if (state is OtpvalidationError) {
          log(state.error);
          Navigator.pop(context);
          Fluttertoast.showToast(msg: state.error, backgroundColor: Colors.red);
        }
      });
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(10.0),
    );
  }

  _onOtpCallBack(String otpCode, bool isAutofill) {
    _otpCode = otpCode;
    if (otpCode.length == otpCodeLength) {
      LoaderWidget().showLoader(context, text: "Please wait..");

      _verifyOtpCode();
    }
  }

  _verifyOtpCode() {
    FocusScope.of(context).requestFocus(FocusNode());
    Timer(const Duration(milliseconds: 4000), () {
      context.read<OtpvalidationBloc>().add(OtpvalidationRequestEvent(
          OtpvalidationRequest(
              request: Request(
                  data: Data(
                      mobNo: widget.mobileNumber,
                      otp: _otpCode ?? "",
                      userType: "virtual"),
                  appID: "45370504ab27eed7327a1df46403a30a"))));
    });
  }

  @override
  Widget build(BuildContext context) {
    log(widget.mobileNumber);
    return Appscaffold(
        title: InkWell(
          onTap: () {
            Navigator.pushReplacementNamed(context, "/register");
          },
          child: Row(children: const [
            Icon(
              Icons.arrow_back_ios,
              color: Colors.blue,
            ),
            TextWidget(
              "MSIL WatchList Login",
              color: Colors.blue,
            )
          ]),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: TextWidget(
                    AppConstants.otpVerify,
                    size: 25,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 7),
                  child: TextWidget(
                    AppConstants.otpVerified,
                    color: Colors.grey,
                    size: 18,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ValueListenableBuilder(
                    valueListenable: valueNotifier,
                    builder: (context, value, child) {
                      return TextFieldPin(
                          textController: textEditingController,
                          autoFocus: true,
                          codeLength: otpCodeLength,
                          alignment: MainAxisAlignment.center,
                          defaultBoxSize: 46.0,
                          margin: 10,
                          selectedBoxSize: 46.0,
                          textStyle: const TextStyle(fontSize: 16),
                          defaultDecoration: _pinPutDecoration.copyWith(
                              border: Border.all(color: Colors.grey)),
                          selectedDecoration: _pinPutDecoration,
                          onChange: (code) {
                            valueNotifier.value = code;
                            _onOtpCallBack(code, false);
                          });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Center(
                      child: TextButton(
                          onPressed: () {
                            LoaderWidget().showLoader(context,
                                text: AppConstants.pleaseWait);
                            context.read<RegistrationBloc>().add(
                                RegistrationRequestEvent(reg.RegistrationRequest(
                                    request: reg.Request(
                                        data: reg.Data(
                                            mobNo: widget.mobileNumber),
                                        appID:
                                            "f79f65f1b98e116f40633dbb46fd5e21"))));
                          },
                          child: const TextWidget(
                            AppConstants.resendOtp,
                            size: 19,
                            color: Colors.blue,
                          ))),
                )
              ],
            ),
          ),
        ));
  }
}
