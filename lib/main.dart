import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hizmet_bull_beta/core/bindings/auth_binding.dart';
import 'package:hizmet_bull_beta/ui/views/chatstore_userview.dart';
import 'package:hizmet_bull_beta/ui/views/chatstore_view.dart';
import 'package:hizmet_bull_beta/ui/views/home_view.dart';
import 'package:hizmet_bull_beta/ui/views/login_view.dart';

import 'package:hizmet_bull_beta/ui/views/chatroomstore_view.dart';

import 'package:hizmet_bull_beta/ui/views/profile_customer_view.dart';
import 'package:hizmet_bull_beta/ui/views/profile_informations_settings_view.dart';
import 'package:hizmet_bull_beta/ui/views/profile_settings_view.dart';
import 'package:hizmet_bull_beta/ui/views/profile_view.dart';
import 'package:hizmet_bull_beta/ui/views/register_view.dart';
import 'package:hizmet_bull_beta/ui/views/results_view.dart';
import 'package:hizmet_bull_beta/ui/views/profile_address_settings_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  runApp(GetMaterialApp(
    defaultTransition: Transition.leftToRight,
    debugShowCheckedModeBanner: false,
    initialBinding: AuthBinding(),
    theme: ThemeData(
      primaryColor: Colors.white,
      appBarTheme: AppBarTheme(elevation: 0),
    ),
    getPages: [
      GetPage(name: "/", page: () => HomeView()),
      GetPage(name: "/registerView", page: () => RegisterView()),
      GetPage(name: "/loginView", page: () => LoginView()),
      GetPage(name: "/profileView", page: () => ProfileView()),
      GetPage(name: "/resultsView", page: () => ResultsView()),
      GetPage(name: "/profileSettingsView", page: () => ProfileSettingsView()),
      GetPage(name: "/profileCustomerView", page: () => ProfileCustomerView()),
      GetPage(
          name: "/profileAddressSettings",
          page: () => ProfileAddressSettingsView()),
      GetPage(name: "/chatStoreView", page: () => ChatStoreView()),
      GetPage(name: "/chatStoreUserView", page: () => ChatStoreUserView()),
      GetPage(name: "/chatRoomStoreView", page: () => ChatRoomStoreView()),
      GetPage(
          name: "/profileInformationsSettings",
          page: () => ProfileInformationsSettingsView()),
    ],
    home: HomeView(),
  ));
}


 // GetPage(name: "/messengerView", page: () => MessengerView()),
      // GetPage(name: "/messengerRoomView", page: () => MessengerRoomView()),
      // GetPage(name: "/messengerUserView", page: () => MessengerUserView()),