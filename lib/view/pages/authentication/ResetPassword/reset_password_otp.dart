// ignore_for_file: non_constant_identifier_names, unused_import

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduate_gtudiesV2/view/pages/authentication/ResetPassword/reset_password_pass.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../Services/session.dart';
import '../../../../theme.dart';
import '../../DialogsWindows/DilogCostom.dart';
import '../../DialogsWindows/loading_dialog.dart';
import 'controllers/reset_password_controller.dart';

class ResetPasswordOTP extends StatefulWidget {
  const ResetPasswordOTP({super.key});

  @override
  State<ResetPasswordOTP> createState() => _OTPState();
}

class _OTPState extends State<ResetPasswordOTP> {
  String? currentText;
  Timer? _timer;
  final RxInt _secondsRemaining = RxInt(0);
  final ResetPasswordController controller = Get.put(ResetPasswordController());
  final TextEditingController _otpController = TextEditingController();
  
  @override
  void dispose() {
    _otpController.dispose();
    controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _startTimer();

    return FutureBuilder<Map<String, String>>(
      future: getSession(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }

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
                        key: ValueKey('background_logo'),
                        image: ExactAssetImage("assets/icons/Logo.png"),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Logo(key: ValueKey('header_logo')),
                          _buildOtpForm(),
                        ],
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

  Widget _buildOtpForm() {
    return Column(
      children: [
        const Text(
          "تأكيد الحساب",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w900,
            fontFamily: "Cairo",
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'تم إرسال رمز التحقق إلى بريدك الإلكتروني',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            fontFamily: "Cairo",
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        Directionality(
          textDirection: TextDirection.ltr,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: PinCodeTextField(
              controller: _otpController,
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
                borderWidth: 2,
                activeFillColor: Colors.transparent,
              ),
              animationDuration: const Duration(milliseconds: 300),
              backgroundColor: Colors.transparent,
              enableActiveFill: true,
              onCompleted: (value) async {
                var code = await controller.otpChecker(value);
                if (code?.code == 200) {
                  saveSession(code!.accessToken!, code.uuid!);
                  Get.off(() => ResetPasswordPass());
                } else {
                  _showErrorDialog('كود التحقق غير صحيح');
                }
              },
              onChanged: (value) {
                currentText = value;
              },
              beforeTextPaste: (text) => true,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Obx(
          () => _secondsRemaining.value > 0
              ? Text(
                  'انتظر ${_secondsRemaining.value} ثانية قبل إعادة إرسال الرمز',
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                  textAlign: TextAlign.center,
                )
              : _buildResendButton(),
        ),
      ],
    );
  }

  Widget _buildResendButton() {
    return Builder(
      builder: (BuildContext context) {
        return TextButton(
          onPressed: _handleResendOtp,
          child: Text(
            'إعادة إرسال الرمز',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }

  Future<void> _handleResendOtp() async {
    if (_secondsRemaining.value > 0) {
      _showErrorDialog('يرجى الانتظار قبل إعادة الإرسال');
      return;
    }

    LoadingDialog.showLoadingDialog(message: 'جاري إعادة الإرسال...');
    try {
      final code = await controller.passwordResetCheck(controller.email);
      Get.back(); // Close loading dialog

      if (code == 200) {
        _showSuccessDialog('تم إرسال رمز التحقق بنجاح');
        _startTimer();
      } else {
        _showErrorDialog('فشل في إرسال الرمز، يرجى المحاولة مرة أخرى');
      }
    } catch (e) {
      Get.back(); // Close loading dialog on error
      _showErrorDialog('حدث خطأ غير متوقع');
    }
  }

  void _startTimer() {
    const int secondsToWait = 120; // 2 minutes
    _timer?.cancel();
    _secondsRemaining.value = secondsToWait;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining.value > 0) {
        _secondsRemaining.value--;
      } else {
        _timer?.cancel();
      }
    });
  }

  void _showErrorDialog(String message) {
    if (context.mounted) {
      DilogCostom.dilogSecss(
        context,
        title: message,
        icons: Icons.error_outline,
        color: Colors.red,
        isErorr: true,
      );
    }
  }

  void _showSuccessDialog(String message) {
    if (context.mounted) {
      DilogCostom.dilogSecss(
        context,
        title: message,
        icons: Icons.check_circle_outline,
        color: Colors.green,
        isErorr: false,
      );
    }
  }
}

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            constraints: const BoxConstraints(maxHeight: 100),
            child: const Image(
              image: ExactAssetImage("assets/icons/Logo.png"),
            ),
          ),
          Container(
            constraints: const BoxConstraints(maxHeight: 100),
            child: const Image(
              image: ExactAssetImage("assets/icons/ministry.png"),
            ),
          ),
        ],
      ),
    );
  }
}
