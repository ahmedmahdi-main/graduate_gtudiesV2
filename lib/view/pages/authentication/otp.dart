// ignore_for_file: non_constant_identifier_names

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../Services/DilogCostom.dart';
import '../../../Services/Session.dart';
import '../../../Services/base_route.dart';

import '../../../controller/user_register_controller.dart';
import '../../../theme.dart';
import '../DialogsWindows/loading_dialog.dart';

class OTP extends StatefulWidget {
  static String OTp = "/OTP";

  const OTP({super.key});

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {

  // var receivedData = Get.arguments;

  String? currentText;
  Timer? _timer;
  final RxInt _secondsRemaining = RxInt(0);


  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _startTimer();

    return FutureBuilder<Map<String, String>>(
      future: getSession(),
      builder: (context, snapshot) {
        // Handle loading state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        // Handle error state
        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }

        // Extract token from the Map
        final String? token = snapshot.data?['token'];

        if (token == null) {
          return const Text("No token found");
        }

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
                              image: ExactAssetImage("assets/icons/Logo.png")
                          )
                      )
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Logo(), otp(token)],
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
        );
      },
    );
  }
  Widget otp(String token) {
    return GetBuilder<UserRegisterController>(
        init: UserRegisterController(),
        builder: (controller) {
          return Column(children: [
            const Text(
              "تأكيد الحساب",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  fontFamily: "Cairo"),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              'تم إرسال رمز التحقق عن طريق البريد الإلكتروني',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  fontFamily: "Cairo"),
            ),
            const SizedBox(
              height: 80,
            ),
            Directionality(
              textDirection: TextDirection.ltr,
              child: PinCodeTextField(
                appContext: context,
                length: 6,
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
                animationDuration: const Duration(milliseconds: 300),
                backgroundColor: Colors.transparent,
                enableActiveFill: true,
                // errorAnimationController: errorController,
                // controller: textEditingController,
                onCompleted: (v) async {
                  // debugPrint(v);
                  var code = await controller.verifyEmail(v.toString(), token);
                  if (code == 200) {
                    Get.offNamed('/DesktopHomePage');
                  } else {
                    DilogCostom.dilogSecss(
                        title: 'حدث خطا غير معروف',
                        icons: Icons.warning_amber_rounded,
                        color: Colors.amber,
                        isErorr: true);
                  }
                },
                onChanged: (value) {
                  currentText = value;
                },
                beforeTextPaste: (text) {
                  debugPrint("Allowing to paste $text");

                  return true;
                },
                // appContext: Get.overlayContext!,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
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
                          await resendOtp(token);
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
          ]);
        });
  }

  void showMessage() {
    // debugPrint(
    //     '--------------------------------------------------- ${_secondsRemaining.value}');
    DilogCostom.dilogSecss(
        title: 'يرجى انتظار انتهاء الوقت',
        icons: Icons.warning_amber_rounded,
        color: Colors.amber,
        isErorr: true);
  }

  Future<void> resendOtp(String token) async {
    var code = await UserRegisterController.resendVerifyEmail(token);
    if (code == 200) {
      DilogCostom.dilogSecss(
          title: 'تم ارسال رمز التحقق',
          icons: Icons.done,
          color: Colors.green,
          isErorr: true);
    } else {
      DilogCostom.dilogSecss(
          title: 'حدث خطا غير معروف',
          icons: Icons.warning_amber_rounded,
          color: Colors.amber,
          isErorr: true);
    }
    _startTimer();
  }

  void _startTimer() {
    const int secondsToWait = 120; // 1 minute
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
