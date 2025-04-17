// ignore_for_file: non_constant_identifier_names

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Services/DilogCostom.dart';
import '../../../Services/Session.dart';
import '../../../Services/base_route.dart';
import '../../../UserProfileInformaition/CreateUUID.dart';
import '../../../UserProfileInformaition/HashPassword.dart';
import '../../../ValidatorFunction/password_validator.dart';
import '../../../ValidatorFunction/text_validator.dart';

import '../../../controller/user_register_controller.dart';
import '../../../theme.dart';
import '../../widget/buttonsyle.dart';
import '../../widget/titleandtextstyle.dart';
import '../DialogsWindows/loading_dialog.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool password_hash_trigger = false;

  late TextEditingController _passwordController = TextEditingController(),
      _confirmPasswordController = TextEditingController(),
      _fullNameController = TextEditingController(),
      _emailControlle = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: KSecondryColor,
        body: Center(
          child: Container(
            height: double.infinity,
            constraints: const BoxConstraints(maxWidth: 500),
            decoration: BoxDecorationForAuthintication,
            margin: const EdgeInsets.symmetric(
                //vertical: size.width < 500 ? 0 : size.height * 0.05,
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
                    children: [Logo(), UserAndPassword()],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  Form UserAndPassword() {
    final formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,
      child: Column(
        children: [
          const Text(
            "انشاء حساب",
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.w900, fontFamily: "Cairo"),
          ),
          sizedboxForeSpace,
          TitleAndTextStyle(
            textStyle: authinticationColorText.copyWith(color: KTextColor),
            width: double.infinity,
            title: "الاسم",
            validator: (value) => isTextValid(value!, 3),
            controller: _fullNameController,
          ),
          sizedboxForeSpace,
          TitleAndTextStyle(
            textStyle: authinticationColorText.copyWith(color: KTextColor),
            width: double.infinity,
            title: "البريد الالكتروني",
            controller: _emailControlle,
            validator: (value) => isEmailValid(value),
          ),
          sizedboxForeSpace,
          TitleAndTextStyle(
            textStyle: authinticationColorText.copyWith(color: KTextColor),
            width: double.infinity,
            title: "كلمة المرور",
            obscureText: true,
            controller: _passwordController,
            validator: (String? Value) =>
                passwordValidator(_passwordController.text),
          ),
          sizedboxForeSpace,
          TitleAndTextStyle(
            textStyle: authinticationColorText.copyWith(color: KTextColor),
            width: double.infinity,
            title: "تأكيد كلمة المرور",
            obscureText: true,
            controller: _confirmPasswordController,
            validator: (value) => confirmPasswordValidator(
                _passwordController.text, _confirmPasswordController.text),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: [
              ButtonStyleS(
                style: authinticationColorText,
                SelectedbackgroundColorafter: KBorderColor,
                aliment: Alignment.center,
                title: "انشاء حساب",
                onTap: () async {
                  if (!formKey.currentState!.validate()) {
                    return;
                  } else {
                    formKey.currentState!.save();

                    // Show loading dialog using AwesomeDialog
                    LoadingDialog.showLoadingDialog(message: loadingText);

                    try {
                      UserRegisterController user = UserRegisterController(
                        fullName: _fullNameController.text,
                        uUID: uUID(),
                        email: _emailControlle.text,
                        password:
                            hashPasswordWithoutSalt(_passwordController.text),
                      );

                      // Attempt to upload data
                      var token = await user.uploadData();

                      // Hide loading dialog
                      Get.back();

                      if (token != null) {
                        // Save session
                        await saveSession(token, user.uUID!);

                        // Navigate to OTP page
                        Get.toNamed('/OTP', arguments: {'token': token});
                      } else {
                        // Show error dialog
                        await DilogCostom.dilogSecss(
                          isErorr: true,
                          title: "فشل التسجيل، يرجى المحاولة مرة أخرى",
                          icons: Icons.close,
                          color: Colors.redAccent,
                        );
                        Get.back();
                      }
                    } catch (e) {
                      // Hide loading dialog

                      // Handle exception by showing error dialog
                      DilogCostom.dilogSecss(
                        isErorr: true,
                        title: "حدث خطأ غير متوقع، يرجى المحاولة مرة أخرى",
                        icons: Icons.error,
                        color: Colors.redAccent,
                      );
                    }
                  }
                },
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("هل لديك حساب قم",
                      style:
                          authinticationColorText.copyWith(color: KTextColor)),
                  const SizedBox(
                    width: 16,
                  ),
                  InkWell(
                    child: Text(
                      "بتسجيل االدخول",
                      style: authinticationColorText.copyWith(
                          color: Colors.blueAccent),
                    ),
                    onTap: () async {
                      await clearSession();
                      Get.offNamed('/');
                    },
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Container Logo() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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

SizedBox get sizedboxForeSpace => const SizedBox(
      height: 15,
    );
