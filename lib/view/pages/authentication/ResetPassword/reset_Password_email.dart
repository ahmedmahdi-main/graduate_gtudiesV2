import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graduate_gtudiesV2/view/pages/authentication/ResetPassword/reset_password_otp.dart';

import '../../../../Services/base_route.dart';
import '../../../../ValidatorFunction/text_validator.dart';
import '../../../../theme.dart';
import '../../../widget/buttonsyle.dart';
import '../../../widget/titleandtextstyle.dart';
import '../../DialogsWindows/DilogCostom.dart';
import '../../DialogsWindows/loading_dialog.dart';
import 'controllers/reset_password_controller.dart';

class ResetPasswordEmail extends StatelessWidget {
  ResetPasswordEmail({super.key});

  TextEditingController emailTextEditingController = TextEditingController();
  ResetPasswordController controller = Get.put(ResetPasswordController());
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
                            child: TitleAndTextStyle(
                              textStyle: authinticationColorText.copyWith(
                                  color: KTextColor),
                              width: double.infinity,
                              title: 'ادخل البريد الالكتروني',
                              validator: (value) => isEmailValid(value),
                              controller: emailTextEditingController,
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          ButtonStyleS(
                              style: authinticationColorText,
                              SelectedbackgroundColorafter: KBorderColor,
                              aliment: Alignment.center,
                              title: "  تم  ",
                              onTap: () async {
                                if (!formKey.currentState!.validate()) {
                                  return;
                                }
                                LoadingDialog.showLoadingDialog(
                                    message: loadingText);
                                controller.email =
                                    emailTextEditingController.text;
                                var code = await controller.passwordResetCheck(
                                    emailTextEditingController.text);
                                Get.back();
                                if (code == 200) {
                                  Get.to(ResetPasswordOTP());
                                } else {
                                  DilogCostom.dilogSecss(Get.overlayContext!,
                                      title: 'الايميل غير صحيح',
                                      icons: Icons.warning_amber_rounded,
                                      color: Colors.amber,
                                      isErorr: true);
                                }

                                // Get.to(ResetPasswordPass());
                                // var code = await controller
                                //     .passwordResetCheck(emailTextEditingController.text);
                                // if (code == 200) {
                                //   controller.email = emailTextEditingController.text;
                                //   controller.changePage(ResetPasswordOTP.indexpage);
                                // } else {
                                //   DilogCostom.dilogSecss(context,
                                //       title: 'الايميل غير صحيح',
                                //       icons: Icons.warning_amber_rounded,
                                //       color: Colors.amber);
                                // }
                                // //go to Otp
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
