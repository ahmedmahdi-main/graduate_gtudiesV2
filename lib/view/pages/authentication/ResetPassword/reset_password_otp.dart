// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduate_gtudiesV2/view/pages/authentication/ResetPassword/reset_password_pass.dart';

import 'package:graduate_gtudiesV2/view/pages/authentication/signup.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../Services/session.dart';
import '../../../../Services/base_route.dart';
import '../../../../theme.dart';
import '../../DialogsWindows/DilogCostom.dart';

import '../../DialogsWindows/loading_dialog.dart';
import 'controllers/reset_password_controller.dart';

class ResetPasswordOTP extends StatefulWidget {
  const ResetPasswordOTP({super.key});

// String email;
  @override
  State<ResetPasswordOTP> createState() => _OTPState();
}

class _OTPState extends State<ResetPasswordOTP> {
  Timer? _timer;
  final RxInt _secondsRemaining = RxInt(0);

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String? currentText;
  ResetPasswordController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    _startTimer();
    Size size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: KSecondryColor,
        body: Center(
          child: Container(
            height: double.infinity,
            constraints: const BoxConstraints(maxWidth: 500),
            decoration: BoxDecorationForAuthintication,
            margin: EdgeInsets.symmetric(
              vertical: (size.width < 500 || size.height < 650)
                  ? 0
                  : size.height * 0.05,
            ),
            child: Stack(children: [
              const Opacity(
                  opacity: 0.05,
                  child: Center(
                      child: Image(
                          image: ExactAssetImage("assets/icons/Logo.png")))),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Logo(),
                      Column(children: [
                        const Text(
                          "تأكيد الحساب",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                              fontFamily: "Cairo"),
                        ),
                        const SizedBox(
                          height: 80,
                        ),
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: PinCodeTextField(
                            length: 8,
                            obscureText: false,
                            animationType: AnimationType.fade,
                            pinTheme: PinTheme(
                              selectedColor: Colors.greenAccent,
                              selectedFillColor: Colors.transparent,
                              inactiveColor: Colors.amberAccent,
                              shape: PinCodeFieldShape.box,
                              activeColor: Colors.greenAccent,
                              inactiveFillColor: Colors.transparent,
                              borderRadius: BorderRadius.circular(5),
                              fieldHeight: 50,
                              fieldWidth: 40,
                              activeFillColor: Colors.transparent,
                            ),
                            animationDuration:
                                const Duration(milliseconds: 300),
                            backgroundColor: Colors.transparent,
                            enableActiveFill: true,
                            onCompleted: (value) async {
                              var code = await controller.otpChecker(value);
                              if (code?.code! == 200) {
                                saveSession(code!.accessToken!, code.uuid!);
                                Get.to(ResetPasswordPass());
                              } else {
                                DilogCostom.dilogSecss(Get.overlayContext!,
                                    title: 'حدث خطا غير معروف',
                                    icons: Icons.warning_amber_rounded,
                                    color: Colors.amber,
                                    isErorr: true);
                                // Get.to(ResetPasswordEmail());
                              }
                            },
                            onChanged: (value) {
                              currentText = value;
                            },
                            beforeTextPaste: (text) {
                              debugPrint("Allowing to paste $text");
                              return true;
                            },
                            appContext: context,
                          ),
                        ),
                        sizedboxForeSpace,
                        Obx(() => _secondsRemaining.value > 0
                            ? Text(
                                'انتظر ${_secondsRemaining.value} ثانية قبل ارسال رمز التحقق مرة اخرى',
                                style: const TextStyle(fontSize: 18),
                              )
                            : Container()),
                        Obx(() {
                          return _secondsRemaining.value == 0
                              ? InkWell(
                                  onTap: () async {
                                    if (_secondsRemaining.value == 0) {
                                      LoadingDialog.showLoadingDialog(
                                          message: loadingText);
                                      await _resendOtp();
                                      Get.back();
                                      Get.back();
                                    } else {
                                      showMessage();
                                    }
                                  },
                                  child: Text("اعادة ارسال رمز التحقق",
                                      style: authinticationColorText.copyWith(
                                          color: Colors.blueAccent)),
                                )
                              : Container();
                        }),
                      ])
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void showMessage() {
    DilogCostom.dilogSecss(Get.overlayContext!,
        title: 'يرجى انتظار انتهاء الوقت',
        icons: Icons.warning_amber_rounded,
        color: Colors.amber,
        isErorr: false);
  }

  Future<void> _resendOtp() async {
    var code = await controller.passwordResetCheck(controller.email);
    if (code == 200) {
      DilogCostom.dilogSecss(Get.overlayContext!,
          title: 'تم ارسال رمز التحقق',
          icons: Icons.done,
          color: Colors.green,
          isErorr: true);
    } else {
      DilogCostom.dilogSecss(Get.overlayContext!,
          title: 'الايميل غير صحيح',
          icons: Icons.warning_amber_rounded,
          color: Colors.amber,
          isErorr: true);
    }
    _startTimer(); // Start the timer after successfully initiating OTP resend
  }

  void _startTimer() {
    const int secondsToWait = 120; // 2 minutes
    _timer?.cancel();
    _secondsRemaining.value = secondsToWait;
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_secondsRemaining.value > 0) {
        _secondsRemaining.value--;
      } else {
        _timer?.cancel();
      }
    });
  }

  Container Logo() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              constraints: const BoxConstraints(maxHeight: 100),
              child:
                  const Image(image: ExactAssetImage("assets/icons/Logo.png"))),
          Container(
              constraints: const BoxConstraints(maxHeight: 100),
              child: const Image(
                  image: ExactAssetImage("assets/icons/ministry.png")))
        ],
      ),
    );
  }
}
