import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hizmet_bull_beta/core/controllers/form_controller.dart';
import 'package:hizmet_bull_beta/core/controllers/profile_settings_controller.dart';
import 'package:hizmet_bull_beta/models/suggestion.dart';
import 'package:hizmet_bull_beta/ui/widgets/register_custom_formfield.dart';

class ProfileInformationsSettingsView extends StatelessWidget {
  var formcont = Get.put(FormController());
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Kullanıcı Bilgilerini Değiştir"),
        ),
        body: box.read("userType") == 2
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextFormField(
                                formcontroller: formcont.settingsNameController,
                                isObscure: false,
                                hintText: "AD",
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  Get.put(ProfileSettingsController())
                                      .changeSingleField(
                                          box.read("userUID"),
                                          "name",
                                          formcont.settingsNameController.text);
                                  formcont.settingsNameController.clear();
                                },
                                child: Text("Güncelle"))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextFormField(
                                isObscure: false,
                                hintText: "SOYAD",
                                formcontroller:
                                    formcont.settingsSurnameController,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  Get.put(ProfileSettingsController())
                                      .changeSingleField(
                                          box.read("userUID"),
                                          "surname",
                                          formcont
                                              .settingsSurnameController.text);
                                  formcont.settingsSurnameController.clear();
                                },
                                child: Text("Güncelle"))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextFormField(
                                isObscure: false,
                                formcontroller:
                                    formcont.settingsDescriptionController,
                                hintText: "AÇIKLAMALAR (Meslek Detayları v.b)",
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  Get.put(ProfileSettingsController())
                                      .changeSingleField(
                                          box.read("userUID"),
                                          "description",
                                          formcont.settingsDescriptionController
                                              .text);
                                  formcont.settingsDescriptionController
                                      .clear();
                                },
                                child: Text("Güncelle"))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: searchTextField(formcont, "HİZMET"),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  await Get.put(ProfileSettingsController())
                                      .changeJob(box.read("userUID"),
                                          formcont.settingsJobController.text);
                                },
                                child: Text("Güncelle"))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: searchTextField(formcont, "ŞEHİR"),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  await Get.put(ProfileSettingsController())
                                      .changeCity(box.read("userUID"),
                                          formcont.settingsCityController.text);
                                },
                                child: Text("Güncelle"))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextFormField(
                                isObscure: false,
                                hintText: "ÜNİVERSİTE",
                                formcontroller:
                                    formcont.settingsUniversityController,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  Get.put(ProfileSettingsController())
                                      .changeSingleField(
                                          box.read("userUID"),
                                          "university",
                                          formcont.settingsUniversityController
                                              .text);
                                  formcont.settingsUniversityController.clear();
                                },
                                child: Text("Güncelle"))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextFormField(
                                isObscure: false,
                                hintText: "LİSANS DERECESİ",
                                formcontroller:
                                    formcont.settingsLicenseController,
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  try {
                                    Get.put(ProfileSettingsController())
                                        .changeSingleField(
                                            box.read("userUID"),
                                            "licensedegree",
                                            formcont.settingsLicenseController
                                                .text);
                                    formcont.settingsLicenseController.clear();
                                  } catch (e) {}
                                },
                                child: Text("Güncelle"))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: TextFormField(
                              controller: formcont.settingsPhoneController,
                              keyboardType: TextInputType.phone,
                              maxLength: 11,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                enabledBorder: OutlineInputBorder(),
                                hintText: "TELEFON NUMARASI",
                                hintStyle: TextStyle(color: Colors.black),
                                focusColor: Colors.black,
                              ),
                            )),
                            SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  Get.put(ProfileSettingsController())
                                      .changeSingleField(
                                          box.read("userUID"),
                                          "phoneNum",
                                          formcont
                                              .settingsPhoneController.text);
                                  formcont.settingsPhoneController.clear();
                                },
                                child: Text("Güncelle"))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 45.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: CustomTextFormField(
                              formcontroller: formcont.settingsEmailController,
                              isObscure: false,
                              hintText: "EMAIL",
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Get.put(ProfileSettingsController())
                                    .changeEmail(
                                        formcont.settingsEmailController.text);
                              },
                              child: Text("Güncelle"))
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: TextFormField(
                            controller: formcont.settingsPhoneController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              enabledBorder: OutlineInputBorder(),
                              hintText: "TELEFON NUMARASI",
                              focusColor: Colors.black,
                            ),
                          )),
                          SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                Get.put(ProfileSettingsController())
                                    .changeSingleField(
                                        box.read("userUID"),
                                        "phone",
                                        formcont.settingsPhoneController.text);
                              },
                              child: Text("Güncelle"))
                        ],
                      ),
                    ],
                  ),
                ),
              ));
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
          controller: hintTxt == "HİZMET"
              ? formController.settingsJobController
              : formController.settingsCityController,
          decoration:
              InputDecoration(border: OutlineInputBorder(), hintText: hintTxt)),
      suggestionsCallback: (pattern) {
        return hintTxt == "HİZMET"
            ? SuggestionData.getSuggestions(pattern)
            : SuggestionData.getCitySuggestions(pattern);
      },
      itemBuilder: (context, itemData) {
        return ListTile(
          title: Text(itemData),
        );
      },
      onSuggestionSelected: (suggestion) {
        hintTxt == "HİZMET"
            ? formController.settingsJobController.text = suggestion
            : formController.settingsCityController.text = suggestion;
      },
    );
  }
}
