import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hizmet_bull_beta/core/controllers/auth_controller.dart';
import 'package:hizmet_bull_beta/core/controllers/form_controller.dart';
import 'package:hizmet_bull_beta/ui/widgets/register_custom_button.dart';
import 'package:hizmet_bull_beta/ui/widgets/register_custom_formfield.dart';

class LoginView extends GetWidget<FirebaseAuthController> {
  GetxController formcont = Get.put(FormController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back_ios)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: mainBody(formcont, controller),
      ),
    );
  }

  Widget mainBody(
      FormController formcontroller, FirebaseAuthController authController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Üye Girişi",
          style: TextStyle(fontSize: 36, fontFamily: "Comfortaa"),
        ),
        SizedBox(
          height: 40,
        ),
        CustomTextFormField(
          hintText: "jane@example.com",
          isObscure: false,
          formcontroller: formcontroller.usernameController,
        ),
        SizedBox(
          height: 10,
        ),
        CustomTextFormField(
          isObscure: true,
          hintText: "*********",
          formcontroller: formcontroller.passwordController,
        ),
        SizedBox(
          height: 10,
        ),
        Center(
            child: Container(
                width: Get.width,
                child: RegisterCustomButton(
                    buttonText: "GİRİŞ YAP",
                    callback: () => authController.loginFirebase(
                        formcontroller.usernameController.text,
                        formcontroller.passwordController.text)))),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Hesabınız Yok Mu ?"),
            SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed("/registerView");
              },
              child: Text(
                "Şimdi Kaydolun",
                style: TextStyle(color: Colors.blue),
              ),
            )
          ],
        )
      ],
    );
  }
}
