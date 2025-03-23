import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../Services/base_route.dart';
import '../../../../ValidatorFunction/password_validator.dart';

import '../../../../theme.dart';
import '../../../widget/buttonsyle.dart';
import '../../../widget/titleandtextstyle.dart';
import '../../DialogsWindows/DilogCostom.dart';
import '../../DialogsWindows/loading_dialog.dart';
import 'controllers/reset_password_controller.dart';

class ResetPasswordPass extends StatelessWidget {
  ResetPasswordPass({super.key});

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  ResetPasswordController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    Size size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: KSecondryColor,
        body: Form(
          key: formKey,
          child: Center(
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
                        Form(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30),
                            child: Column(
                              children: [
                                const Text(
                                  "تغيير كلمة المرور",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w900,
                                      fontFamily: "Cairo"),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TitleAndTextStyle(
                                  textStyle: authinticationColorText.copyWith(
                                      color: KTextColor),
                                  width: double.infinity,
                                  title: "كلمة المرور",
                                  validator: (value) => passwordValidator(value!),
                                  controller: _passwordController,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TitleAndTextStyle(
                                  textStyle: authinticationColorText.copyWith(
                                      color: KTextColor),
                                  obscureText: true,
                                  width: double.infinity,
                                  title: "اعادة كلمة المرور ",
                                  controller: _confirmPasswordController,
                                  validator: (value) => confirmPasswordValidator(
                                      _passwordController.text,
                                      _confirmPasswordController.text),
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                Column(
                                  children: [
                                    ButtonStyleS(
                                      style: authinticationColorText,
                                      SelectedbackgroundColorafter: KBorderColor,
                                      aliment: Alignment.center,
                                      title: " تم ",
                                      onTap: () async {
                                        if (!formKey.currentState!.validate()) {
                                          return;
                                        }
                                        LoadingDialog.showLoadingDialog(
                                            message: loadingText);
                                        var result =
                                            await controller.passwordReset(
                                                _passwordController.text);
                                        Get.back();
                                        Get.back();
                                        if (result) {
                                          Get.offNamed('/DesktopHomePage');
                                        } else {

                                          DilogCostom.dilogSecss(
                                              Get.overlayContext!,
                                              title: 'حدث خطا غير معروف',
                                              icons: Icons.warning_amber_rounded,
                                              color: Colors.amber,
                                              isErorr: true);
                                        }
                                        //_controller.
                                      },
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
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
