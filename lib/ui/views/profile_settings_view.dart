import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hizmet_bull_beta/core/controllers/auth_controller.dart';
import 'package:hizmet_bull_beta/core/controllers/form_controller.dart';
import 'package:hizmet_bull_beta/ui/widgets/register_custom_button.dart';
import 'package:hizmet_bull_beta/ui/widgets/register_custom_formfield.dart';

class ProfileSettingsView extends GetWidget<FirebaseAuthController> {
  var formcont = Get.put(FormController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Ayarlar",
                    style: TextStyle(fontSize: 36, fontFamily: "Comfortaa"),
                  ),
                ),
                ListTile(
                  tileColor: Colors.white,
                  onTap: () {
                    Get.bottomSheet(BottomSheet(
                      onClosing: () {},
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              CustomTextFormField(
                                hintText: "Eski Şifre",
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomTextFormField(
                                hintText: "Yeni Şifre",
                              ),
                              RegisterCustomButton(
                                buttonText: "DEĞİŞTİR",
                              )
                            ],
                          ),
                        );
                      },
                    ));
                  },
                  title: Text(
                    "Şifre Değiştirme",
                  ),
                  trailing: Icon(Icons.arrow_right),
                ),
                ListTile(
                  tileColor: Colors.white,
                  onTap: () {
                    Get.bottomSheet(BottomSheet(
                      onClosing: () {},
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                children: [
                                  CustomTextFormField(
                                    hintText: "AD",
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CustomTextFormField(
                                    hintText: "SOYAD",
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CustomTextFormField(
                                    hintText: "ŞEHİR",
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CustomTextFormField(
                                    hintText: "MESLEK",
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CustomTextFormField(
                                    hintText: "LİSANS DERECESİ",
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CustomTextFormField(
                                    hintText: "TELEFON NUMARASI",
                                  ),
                                  RegisterCustomButton(
                                    buttonText: "DEĞİŞTİR",
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ));
                  },
                  title: Text(
                    "Kullanıcı Bilgilerini Değiştirme",
                  ),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_right),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      controller.signOut();
                      Get.offAllNamed("/");
                      Get.snackbar("Öneri: ",
                          "Home Butonu ile Ana Sayfayı Yenileyebilirsiniz");
                      controller.currentUserData.erase();
                    },
                    child: Text("ÇIKIŞ YAP"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
