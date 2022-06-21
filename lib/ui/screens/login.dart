import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';
import 'package:watchlist/bloc/registration/registration_bloc.dart';
import 'package:watchlist/model/login_request.dart';
import 'package:watchlist/model/registration_request.dart' as reg;
import 'package:watchlist/ui/widgets/app_scaffold.dart';
import 'package:watchlist/ui/widgets/loader_widget.dart';
import 'package:watchlist/ui/widgets/text_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int otpCodeLength = 4;
  String _otpCode = "";
  bool isLoadingButton = false;
  bool enableButton = false;
  final intRegex = RegExp(r'\d+', multiLine: true);
  TextEditingController textEditingController = TextEditingController(text: "");
  late RegistrationBloc registrationBloc;
  @override
  void initState() {
    super.initState();
    _getSignatureCode();
    _startListeningSms();
    registrationBloc = BlocProvider.of<RegistrationBloc>(context)
      ..stream.listen((state) {
        if (state is RegistrationDone) {
          Navigator.pop(context);
        }
        if (state is LoginDone) {
          Navigator.pop(context);
          Navigator.pushNamed(context, "/watchlist");
        }
      });
  }

  @override
  void dispose() {
    super.dispose();
    SmsVerification.stopListening();
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.grey),
      borderRadius: BorderRadius.circular(10.0),
    );
  }

  /// get signature code
  _getSignatureCode() async {
    String? signature = await SmsVerification.getAppSignature();
    log("signature $signature");
  }

  /// listen sms
  _startListeningSms() {
    SmsVerification.startListeningSms().then((message) {
      log("listen");
      setState(() {
        _otpCode = SmsVerification.getCode(message, intRegex);
        log(_otpCode);
        textEditingController.text = _otpCode;
        _onOtpCallBack(_otpCode, true);
      });
    });
  }

  /*  _onSubmitOtp() {
    setState(() {
      isLoadingButton = !isLoadingButton;
      _verifyOtpCode();
    });
  } */

/*  s */

  _onOtpCallBack(String otpCode, bool isAutofill) {
    setState(() {
      _otpCode = otpCode;
      if (otpCode.length == otpCodeLength && !isAutofill) {
        enableButton = true;
        isLoadingButton = false;
        _verifyOtpCode();
      } else {
        enableButton = false;
      }
    });
  }

  _verifyOtpCode() {
    FocusScope.of(context).requestFocus(FocusNode());
    Timer(const Duration(milliseconds: 4000), () {
      setState(() {
        isLoadingButton = false;
        enableButton = false;
      });
      final scaffoldKey = GlobalKey<ScaffoldState>();
      scaffoldKey.currentState?.showSnackBar(
          SnackBar(content: Text("Verification OTP Code $_otpCode Success")));

      context.read<RegistrationBloc>().add(LoginRequestEvent(LoginRequest(
          request: Request(
              data: Data(
                  mobNo: "+918248121331", otp: _otpCode, userType: "virtual"),
              appID: "45370504ab27eed7327a1df46403a30a"))));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Appscaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: TextWidget(
              "OTP Verification",
              size: 25,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 7),
            child: TextWidget(
              "OTP will be automatically verified",
              color: Colors.grey,
              size: 18,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: TextFieldPin(
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
                  LoaderWidget().showLoader(context, text: "Please wait..");
                  _onOtpCallBack(code, false);
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Center(
                child: TextButton(
                    onPressed: () {
                      LoaderWidget().showLoader(context, text: "Please wait..");
                      context.read<RegistrationBloc>().add(
                          RegistrationRequestEvent(reg.RegistrationRequest(
                              request: reg.Request(
                                  data: reg.Data(mobNo: "+918248121331"),
                                  appID: "f79f65f1b98e116f40633dbb46fd5e21"))));
                    },
                    child: const TextWidget(
                      "Resend OTP",
                      size: 19,
                      color: Colors.blue,
                    ))),
          )
        ],
      ),
    ));
  }
}
