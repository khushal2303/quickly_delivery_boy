import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quickly_delivery/constants/constants.dart';
import 'package:quickly_delivery/constants/field_error.dart';
import 'package:quickly_delivery/constants/strings.dart';
import 'package:quickly_delivery/data/app_dio.dart';
import 'package:quickly_delivery/data/authenticate/auth_datasource.dart';
import 'package:quickly_delivery/data/authenticate/authentication_repository.dart';
import 'package:quickly_delivery/screens/login/bloc/login_bloc.dart';
import 'package:quickly_delivery/screens/login/styles/login_styles.dart';
import 'package:quickly_delivery/screens/personal_detail/personal_detail_page.dart';
import 'package:quickly_delivery/styles/colors.dart';
import 'package:quickly_delivery/utils/helpers.dart';
import 'package:sms_autofill/sms_autofill.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginScreen());
  }

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final String imagePath = "assets/images/welcome_image.png";
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController otpController = TextEditingController();

  static const double containerHeight = 300.0;
  double clipHeight = containerHeight * 0.35;
  TermCheck _termCheck = TermCheck.uncheck;
  bool isOTPWidget = false;
  String currentCode = "";
  bool termAndConError = false;
  int timeCounter = 0;
  bool timeUpFlag = false;

  LoginBloc loginBloc = LoginBloc(
      authenticationRepository: AuthenticationRepository(
          authDataSource: AuthDataSource(dio: AppDio.getInstance())));

  @override
  void initState() {
    super.initState();
  }

  _timerUpdate() {
    Timer(const Duration(seconds: 1), () async {
      setState(() {
        timeCounter--;
      });
      if (timeCounter != 0) {
        _timerUpdate();
      } else {
        timeUpFlag = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      bloc: loginBloc,
      listener: (context, state) {
        if (state is OtpSendSuccess) {
          setState(() {
            isOTPWidget = true;
            timeUpFlag = false;
            timeCounter = 60;
          });
          Future.delayed(const Duration(milliseconds: 500))
              .then((value) => setState(() => _timerUpdate()));
        }

        if (state is UserVerifySuccess) {
          onGetStartedClicked(context);
        }

        if (state is OtpSendFailure) {
          Helpers.showSnackbar(context, state.error, true);
        }

        if (state is UserVerifyFailure) {
          Helpers.showSnackbar(context, state.error, true);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        bloc: loginBloc,
        builder: (context, state) {
          return buildLoginForm();
        },
      ),
    );
  }

  Widget buildLoginForm() {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              child: SvgPicture.asset(
                ConstantImages.loginIcon,
              ),
              // Image.asset(
              //   ConstantImages.loginIcon,
              //   fit: BoxFit.cover,
              // ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.35,
                decoration: const BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: (isOTPWidget) ? otpWidgets() : loginWidgets(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget loginWidgets() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24, top: 0),
          child: Text(
            Strings.enter_your_mobile_number,
            style: LoginTextStyles.enterMobileText(),
          ),
        ),
        mobileNumberField(),
        if (loginBloc.state.isBusy == true) ...[
          const SizedBox(
            height: 5,
          ),
          Helpers.loadingWidget(),
        ] else
          getButton(context),
        const SizedBox(
          height: 5,
        ),
        termAndCondition(),
        if (termAndConError)
          const Padding(
            padding: EdgeInsets.only(left: 30),
            child: Text(
              "Please accept the term and condition",
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          )
      ],
    );
  }

  Widget otpWidgets() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 24, top: 0),
          child: Row(
            children: [
              InkWell(
                child: const Icon(
                  Icons.keyboard_arrow_left,
                  color: AppColors.buttonColor,
                ),
                onTap: () {
                  setState(() {
                    isOTPWidget = false;
                    currentCode = "";
                  });
                },
              ),
              Text(
                Strings.otp_sent,
                style: LoginTextStyles.enterMobileText(),
              ),
            ],
          ),
        ),
        getOtpFields(),
        const SizedBox(
          height: 2,
        ),
        if (_otpErrorText(loginBloc.state.otpError) != null)
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Text(
              _otpErrorText(loginBloc.state.otpError)!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
        if (loginBloc.state.isBusy == true) ...[
          const SizedBox(
            height: 5,
          ),
          Helpers.loadingWidget(),
        ] else
          getButton(context),
        const SizedBox(
          height: 6,
        ),
        otpSendToText(),
        const SizedBox(
          height: 6,
        ),
        resendOtpText(),
      ],
    );
  }

  Widget mobileNumberField() {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 12),
      child: TextFormField(
        controller: mobileNumber,
        keyboardType: TextInputType.number,
        style: LoginTextStyles.mobileNumberText(),
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.mobileTextField,
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.mobileTextField,
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColors.mobileTextField,
              )),
          filled: true,
          fillColor: AppColors.mobileTextField,
          contentPadding: const EdgeInsets.only(left: 5),
          hintText: "+91 7600243539",
          hintStyle: LoginTextStyles.mobileNumberHintText(),
          prefixIcon: mobileCode(),
          counterText: "",
          errorText: _emailErrorText(loginBloc.state.mobileNumberError),
        ),
        cursorColor: Colors.black.withOpacity(0.5),
        maxLength: 10,
      ),
    );
  }

  String? _emailErrorText(FieldError? error) {
    switch (error) {
      case FieldError.Empty:
        return Strings.emptyMobileError;
      case FieldError.Invalid:
        return Strings.invalidMobileError;
      default:
        return null;
    }
  }

  String? _otpErrorText(FieldError? error) {
    switch (error) {
      case FieldError.Empty:
        return Strings.emptyOtpError;
      case FieldError.Invalid:
        return Strings.invalidOtpError;
      default:
        return null;
    }
  }

  Widget mobileCode() {
    return Container(
      width: 40,
      margin: const EdgeInsets.only(right: 10),
      child: const Center(
        child: Icon(
          Icons.phone,
          color: AppColors.hintColor,
        ),
      ),
    );
  }

  Widget termAndCondition() {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Row(
        children: [
          Radio(
            toggleable: true,
            activeColor: AppColors.buttonColor,
            focusColor: AppColors.buttonColor.withOpacity(0.5),
            hoverColor: AppColors.buttonColor.withOpacity(0.5),
            value: TermCheck.check,
            groupValue: _termCheck,
            onChanged: (TermCheck? value) {
              if (value != null) {
                if (_termCheck == TermCheck.check) {
                  setState(() {
                    _termCheck = TermCheck.uncheck;
                  });
                } else {
                  setState(() {
                    _termCheck = TermCheck.check;
                  });
                }
              }
            },
          ),
          RichText(
            text: TextSpan(
              text: Strings.I_accept_the,
              style: LoginTextStyles.termText(AppColors.termColor),
              children: [
                TextSpan(
                  text: " " + Strings.Term_and_Conditions,
                  style: LoginTextStyles.termText(AppColors.buttonColor),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget getOtpFields() {
    return Padding(
      padding: const EdgeInsets.only(left: 44, right: 44, top: 12),
      child: PinFieldAutoFill(
        textInputAction: TextInputAction.done,
        enableInteractiveSelection: true,
        controller: otpController,
        decoration: BoxLooseDecoration(
          hintTextStyle:
              LoginTextStyles.otpText(AppColors.termColor.withOpacity(0.5)),
          strokeColorBuilder:
              const FixedColorBuilder(AppColors.mobileTextField),
          bgColorBuilder: const FixedColorBuilder(AppColors.mobileTextField),
          textStyle: LoginTextStyles.otpText(AppColors.termColor),
          hintText: "----",
        ),
        onCodeSubmitted: (code) {},
        currentCode: currentCode,
        codeLength: 4,
        onCodeChanged: (String? code) {
          if (code != null) {
            setState(() {
              currentCode = code;
            });
          }
          if (code!.length == 4) {
            FocusScope.of(context).requestFocus(FocusNode());
          }
        },
        keyboardType: TextInputType.number,
        cursor: Cursor(
          width: 2,
          color: AppColors.termColor,
          radius: const Radius.circular(1),
          enabled: true,
        ),
      ),
    );
  }

  Widget otpSendToText() {
    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: RichText(
        text: TextSpan(
          text: Strings.otpSendTo,
          style: LoginTextStyles.termText(AppColors.termColor),
          children: [
            TextSpan(
              text: " " + mobileNumber.text,
              style: LoginTextStyles.termText(AppColors.buttonColor),
            )
          ],
        ),
      ),
    );
  }

  Widget resendOtpText() {
    return Padding(
      padding: const EdgeInsets.only(left: 24),
      child: RichText(
        text: (timeUpFlag == false)
            ? TextSpan(
                text: "Resend OTP in ",
                style: LoginTextStyles.resendOTPText(AppColors.termColor),
                children: [
                  TextSpan(
                    text: timeCounter.toString(),
                    style: LoginTextStyles.resendOTPText(AppColors.termColor),
                  ),
                  TextSpan(
                    text: " sec",
                    style: LoginTextStyles.resendOTPText(AppColors.termColor),
                  ),
                ],
              )
            : TextSpan(
                text: "Resend OTP",
                style: LoginTextStyles.termText(AppColors.primaryColor),
                recognizer: TapGestureRecognizer()
                  ..onTap =
                      () => loginBloc.add(ResendOtpEvent(mobileNumber.text)),
              ),
      ),
    );
  }

  Widget getButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 12),
      child: SizedBox(
        width: double.maxFinite,
        child: RaisedButton(
          visualDensity: VisualDensity.compact,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          color: AppColors.buttonColor,
          textColor: Colors.white,
          elevation: 0.0,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
          child: Stack(
            fit: StackFit.passthrough,
            children: <Widget>[
              Center(
                child: Text(
                  (isOTPWidget) ? Strings.continueText : Strings.get_otp,
                  textAlign: TextAlign.center,
                  style: LoginTextStyles.mobileNumberHintText(
                      color: AppColors.whiteColor),
                ),
              ),
            ],
          ),
          onPressed: () {
            if (isOTPWidget == true) {
              loginBloc.add(VerifyOtpEvent(mobileNumber.text, currentCode));
              // onGetStartedClicked(context);
            } else {
              setState(() {
                termAndConError = false;
              });
              if (_termCheck == TermCheck.check) {
                loginBloc.add(LoginSubmitted(mobileNumber.text));
              } else {
                setState(() {
                  termAndConError = true;
                });
              }
            }
            // onGetStartedClicked(context);
          },
        ),
      ),
    );
  }

  void onGetStartedClicked(BuildContext context) {
    Navigator.pushNamed(context, PersonalDetailPage.routeName);
    // Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(
    //         builder: (BuildContext context) => const AlmostDoneScreen()),
    //     ModalRoute.withName('/'));
  }
}

enum TermCheck { check, uncheck }
