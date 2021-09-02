import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:hizmet_bull_beta/core/controllers/auth_controller.dart';
import 'package:hizmet_bull_beta/core/controllers/form_controller.dart';
import 'package:hizmet_bull_beta/models/suggestion.dart';
import 'package:hizmet_bull_beta/ui/widgets/register_custom_button.dart';
import 'package:hizmet_bull_beta/ui/widgets/register_custom_formfield.dart';

class RegisterView extends GetWidget<FirebaseAuthController> {
  GetxController formController = Get.put(FormController());
  final viewInsets = EdgeInsets.fromWindowPadding(
      WidgetsBinding.instance.window.viewInsets,
      WidgetsBinding.instance.window.devicePixelRatio);
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            bottom: TabBar(
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: Colors.black),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.black,
              tabs: [
                Container(
                  decoration: BoxDecoration(),
                  child: Tab(
                    text: "Hizmet Alan",
                  ),
                ),
                Tab(
                  text: "Hizmet Veren",
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 24.0, top: 32, bottom: 24.0, right: 24),
                child: firstTabBarView(controller, formController, viewInsets),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: secondTabBarView(controller, formController, viewInsets),
              )
            ],
          )),
    );
  }
}

Widget searchTextField(
  FormController formController,
  String hintTxt,
) {
  return TypeAheadField<String>(
    hideOnEmpty: true,
    suggestionsBoxController: SuggestionsBoxController(),
    suggestionsBoxDecoration: SuggestionsBoxDecoration(
      color: Colors.white,
    ),
    textFieldConfiguration: TextFieldConfiguration(
        controller: hintTxt == "HİZMET SEÇ"
            ? formController.jobController
            : formController.cityController,
        decoration:
            InputDecoration(border: OutlineInputBorder(), hintText: hintTxt)),
    suggestionsCallback: (pattern) {
      return hintTxt == "HİZMET SEÇ"
          ? SuggestionData.getSuggestions(pattern)
          : SuggestionData.getCitySuggestions(pattern);
    },
    itemBuilder: (context, itemData) {
      return ListTile(
        title: Text(itemData),
      );
    },
    onSuggestionSelected: (suggestion) {
      hintTxt == "HİZMET SEÇ"
          ? formController.jobController.text = suggestion
          : formController.cityController.text = suggestion;
    },
  );
}

Widget firstTabBarView(FirebaseAuthController controller,
        FormController formcontroller, EdgeInsets viewInsets) =>
    SingleChildScrollView(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 1),
        height: Get.height + viewInsets.bottom,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Kayıt Ol",
              style: TextStyle(fontSize: 36, fontFamily: "Comfortaa"),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      formcontroller: formcontroller.nameController,
                      hintText: "AD",
                      isObscure: false,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: CustomTextFormField(
                    formcontroller: formcontroller.surnameController,
                    hintText: "SOYAD",
                    isObscure: false,
                  ))
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: CustomTextFormField(
              formcontroller: formcontroller.usernameController,
              hintText: "jane@example.com",
              isObscure: false,
            )),
            Expanded(
                child: CustomTextFormField(
              hintText: "*********",
              isObscure: true,
              formcontroller: formcontroller.passwordController,
            )),
            Center(
                child: Container(
                    width: Get.width,
                    child: RegisterCustomButton(
                      callback: () => controller.createUserTypeOne(
                        formcontroller.nameController.text,
                        formcontroller.surnameController.text,
                        formcontroller.usernameController.text,
                        formcontroller.passwordController.text,
                      ),
                    ))),
            Spacer(
              flex: 3,
            )
          ],
        ),
      ),
    );

Widget secondTabBarView(FirebaseAuthController controller,
        FormController formcontroller, EdgeInsets viewInsets) =>
    SingleChildScrollView(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 1),
        height: Get.height + viewInsets.bottom,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Text(
                "Kayıt Ol",
                style: TextStyle(fontSize: 36, fontFamily: "Comfortaa"),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextFormField(
                      hintText: "AD",
                      isObscure: false,
                      formcontroller: formcontroller.nameController,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                      child: CustomTextFormField(
                    hintText: "SOYAD",
                    isObscure: false,
                    formcontroller: formcontroller.surnameController,
                  ))
                ],
              ),
            ),
            Expanded(
                child: CustomTextFormField(
              hintText: "jane@example.com",
              isObscure: false,
              formcontroller: formcontroller.usernameController,
            )),
            Expanded(
                child: CustomTextFormField(
              hintText: "*********",
              isObscure: true,
              formcontroller: formcontroller.passwordController,
            )),
            Expanded(child: searchTextField(formcontroller, "HİZMET SEÇ")),
            Expanded(child: searchTextField(formcontroller, "ŞEHİR SEÇ")),
            Center(
                child: Container(
                    width: Get.width,
                    child: RegisterCustomButton(
                      callback: () => controller.createUserTypeTwo(
                          formcontroller.usernameController.text,
                          formcontroller.passwordController.text,
                          formcontroller.nameController.text,
                          formcontroller.surnameController.text,
                          formcontroller.cityController.text,
                          formcontroller.jobController.text),
                    ))),
            Spacer()
          ],
        ),
      ),
    );
