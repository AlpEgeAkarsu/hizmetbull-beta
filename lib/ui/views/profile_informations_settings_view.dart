import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hizmet_bull_beta/core/controllers/form_controller.dart';
import 'package:hizmet_bull_beta/core/controllers/profile_settings_controller.dart';
import 'package:hizmet_bull_beta/models/suggestion.dart';
import 'package:hizmet_bull_beta/ui/widgets/register_custom_button.dart';
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
                                },
                                child: Text("Güncelle"))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: searchTextField(formcont, "HİZMET SEÇ"),
                        //     ),
                        //     SizedBox(
                        //       width: 20,
                        //     ),
                        //     ElevatedButton(
                        //         onPressed: () {

                        //         }, child: Text("Güncelle"))
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: searchTextField(formcont, "ŞEHİR SEÇ"),
                        //     ),
                        //     SizedBox(
                        //       width: 20,
                        //     ),
                        //     ElevatedButton(
                        //         onPressed: () {}, child: Text("Güncelle"))
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        Row(
                          children: [
                            Expanded(
                              child: CustomTextFormField(
                                isObscure: false,
                                hintText: "ÜNİVERSİTE",
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
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            ElevatedButton(
                                onPressed: () {}, child: Text("Güncelle"))
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
                                hintText: "TELEFON NUMARASI",
                                formcontroller:
                                    formcont.settingsPhoneController,
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
                                          "phone",
                                          formcont
                                              .settingsPhoneController.text);
                                },
                                child: Text("Güncelle"))
                          ],
                        ),
                        RegisterCustomButton(
                          buttonText: "DEĞİŞTİR",
                        )
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
                                    .changeSingleField(
                                        box.read("userUID"),
                                        "description",
                                        formcont.settingsDescriptionController
                                            .text);
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
                              hintText: "TELEFON NUMARASI",
                              formcontroller: formcont.settingsPhoneController,
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
            ? formController.settingsJobController.text = suggestion
            : formController.settingsCityController.text = suggestion;
      },
    );
  }
}
