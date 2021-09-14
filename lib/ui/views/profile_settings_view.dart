import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hizmet_bull_beta/core/controllers/auth_controller.dart';
import 'package:hizmet_bull_beta/core/controllers/form_controller.dart';
import 'package:hizmet_bull_beta/core/controllers/map_controller.dart';
import 'package:hizmet_bull_beta/core/controllers/profile_settings_controller.dart';
import 'package:hizmet_bull_beta/models/suggestion.dart';
import 'package:hizmet_bull_beta/ui/widgets/register_custom_button.dart';
import 'package:hizmet_bull_beta/ui/widgets/register_custom_formfield.dart';

class ProfileSettingsView extends GetWidget<FirebaseAuthController> {
  var formcont = Get.put(FormController());
  final box = GetStorage();
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

                // PASSWORD SETTINGS
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
                                isObscure: true,
                                hintText: "Eski Şifre",
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              CustomTextFormField(
                                isObscure: true,
                                hintText: "Yeni Şifre",
                                formcontroller:
                                    formcont.settingsPasswordController,
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    Get.put(ProfileSettingsController())
                                        .changePassword(formcont
                                            .settingsPasswordController.text);
                                    formcont.settingsPasswordController.clear();
                                  },
                                  child: Text("DEĞİŞTİR"))
                            ],
                          ),
                        );
                      },
                    ));
                  },
                  title: Text(
                    "Şifre Değiştirme",
                  ),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_right),
                  ),
                ),

                // USER PROFILE INFORMATIONS
                ListTile(
                  tileColor: Colors.white,
                  onTap: () {
                    Get.toNamed("/profileInformationsSettings");
                  },
                  title: Text(
                    "Kullanıcı Bilgilerini Değiştirme",
                  ),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.arrow_right),
                  ),
                ),

                // LOCATION INFORMATIONS
                ListTile(
                  tileColor: Colors.white,
                  onTap: () async {
                    await Get.put(MapController())
                        .userLocation(box.read("userUID"));
                    Get.defaultDialog(
                        title: "Konumuz Güncellendi",
                        middleText:
                            "Güncel Konumunuza Göre Konum Bilgileriniz Güncellendi");
                  },
                  title: Text("Konum Bilgilerini Otomatik Olarak Ayarlama"),
                  trailing: IconButton(
                    onPressed: () async {
                      await Get.put(MapController())
                          .userLocation(box.read("userUID"));
                      Get.defaultDialog(
                          title: "Konumuz Güncellendi",
                          middleText:
                              "Güncel Konumunuza Göre Konum Bilgileriniz Güncellendi");
                    },
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
