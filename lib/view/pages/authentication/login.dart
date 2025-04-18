import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:graduate_gtudiesV2/view/pages/authentication/ResetPassword/reset_Password_email.dart';
import '../../../Services/DilogCostom.dart';
import '../../../Services/Session.dart';
import '../../../Services/base_route.dart';
import '../../../UserProfileInformaition/HashPassword.dart';
import '../../../ValidatorFunction/password_validator.dart';
import '../../../ValidatorFunction/text_validator.dart';
import '../../../controller/user_login_controller.dart';
import '../../../theme.dart';
import '../../widget/buttonsyle.dart';
import '../../widget/titleandtextstyle.dart';
import '../DialogsWindows/loading_dialog.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // _emailController.text = 'ahmed.mahdi.ah@uokerbala.edu.iq';
    // _passwordController.text = '12345678';
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
            child: Stack(
              children: [
                const Opacity(
                  opacity: 0.05,
                  child: Center(
                    child:
                        Image(image: ExactAssetImage("assets/icons/Logo.png")),
                  ),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [logo(), userAndPassword(context)],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Form userAndPassword(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: Column(
          children: [
            const Text(
              "تسجيل الدخول ",
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                  fontFamily: "Cairo"),
            ),
            const SizedBox(height: 20),
            TitleAndTextStyle(
              textStyle: authinticationColorText.copyWith(color: KTextColor),
              width: double.infinity,
              title: "البريد الالكتروني",
              controller: _emailController,
              validator: (value) => isEmailValid(value),
            ),
            const SizedBox(height: 20),
            TitleAndTextStyle(
              textStyle: authinticationColorText.copyWith(color: KTextColor),
              obscureText: true,
              width: double.infinity,
              title: "كلمة المرور",
              controller: _passwordController,
              onEnter: () async => await login(),
              validator: (String? value) =>
                  passwordValidator(_passwordController.text),
            ),
            const SizedBox(height: 50),
            Column(
              children: [
                ButtonStyleS(
                  style: authinticationColorText,
                  SelectedbackgroundColorafter: KBorderColor,
                  aliment: Alignment.center,
                  title: "تسجيل الدخول",
                  onTap: () async => await login(),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("اذ لم يكن لديك حساب قم ",
                        style: authinticationColorText.copyWith(
                            color: KTextColor)),
                    const SizedBox(width: 10),
                    InkWell(
                      child: Text(
                        "بالتسجيل",
                        style: authinticationColorText.copyWith(
                            color: Colors.blueAccent),
                      ),
                      onTap: () => Get.offNamed('/SignUp'),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () => Get.to(ResetPasswordEmail()),
                  child: Text("نسيت كلمة المرور",
                      style: authinticationColorText.copyWith(
                          fontSize: 10, color: Colors.blueAccent)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    LoadingDialog.showLoadingDialog(message: loadingText);

    try {
      var login = UserLogin(
        email: _emailController.text,
        password: hashPasswordWithoutSalt(_passwordController.text),
      );

      var value = await login.login();

      if (value?.accessToken != null) {
        // await clearSession();
        var userProfile = await login.getUserProfile(value!);
        await saveSession(value.accessToken!, userProfile.studentuuid!,
            studentName: userProfile.fullName);

        Get.back();
        Get.offNamed('/LoadingPage');
      } else {
        Get.back();
        Get.back();
        DilogCostom.dilogSecss(
          isErorr: true,
          title: "يوجد خطأ في الايميل او كلمة المرور",
          icons: Icons.close,
          color: Colors.redAccent,
        );
      }
    } catch (e) {
      Get.back();
      Get.back();
      DilogCostom.dilogSecss(
        isErorr: true,
        title: "حدث خطأ غير متوقع، يرجى المحاولة مرة أخرى",
        icons: Icons.error,
        color: Colors.redAccent,
      );
    }
  }

  Container logo() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            constraints: const BoxConstraints(maxHeight: 100),
            child: const Image(image: ExactAssetImage("assets/icons/Logo.png")),
          ),
          Container(
            constraints: const BoxConstraints(maxHeight: 100),
            child: const Image(
                image: ExactAssetImage("assets/icons/ministry.png")),
          )
        ],
      ),
    );
  }
}
