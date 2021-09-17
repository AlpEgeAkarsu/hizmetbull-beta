import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hizmet_bull_beta/core/controllers/common_database_controller.dart';
import 'package:hizmet_bull_beta/models/place.dart';
import 'package:hizmet_bull_beta/models/place_details.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ProfileAddressSettingsView extends StatefulWidget {
  @override
  _ProfileAddressSettingsViewState createState() =>
      _ProfileAddressSettingsViewState();
}

class _ProfileAddressSettingsViewState
    extends State<ProfileAddressSettingsView> {
  List<Prediction> predictions = [];
  var box = GetStorage();
  var key = "AIzaSyC37iMf82X78jsULqbBOhwcpFmN8Q1MU7s";

  void autoCompleteSearch(String value) async {
    var url = Uri.parse(
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input={$value}&types=geocode&components=country:tr&language=tr&key=$key");
    var response = await http.get(url);

    MapResponse mapResponse = MapResponse.fromJson(jsonDecode(response.body));
    setState(() {
      predictions = mapResponse.predictions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Adres Seçiniz")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: TextField(
                decoration: InputDecoration(hintText: "Adres Giriniz"),
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    autoCompleteSearch(value);
                  } else {
                    if (predictions.length > 0 && mounted) {
                      setState(() {
                        predictions = [];
                      });
                    }
                  }
                },
              ),
            ),
            ListView.builder(
              itemCount: predictions.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Icon(
                      Icons.pin_drop,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(predictions[index].description),
                  onTap: () async {
                    var placeId = predictions[index].placeId;
                    if (placeId != null) {
                      var tempurl =
                          "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=$key";
                      var testurl = Uri.parse(tempurl);
                      var response = await http.get(testurl);
                      if (response.statusCode == 200 && response.body != null) {
                        MapResponseDetails responseDetails =
                            MapResponseDetails.fromJson(
                                jsonDecode(response.body));
                        print(responseDetails.result.geometry.location.lat);
                        Map<String, dynamic> location = {
                          "latitude":
                              responseDetails.result.geometry.location.lat,
                          "longitude":
                              responseDetails.result.geometry.location.lng,
                        };
                        var address = responseDetails.result.formattedAddress;
                        Get.put(CommonDatabaseController())
                            .setUserLocationOnDb(location, box.read("userUID"));
                        Get.put(CommonDatabaseController())
                            .setUserAddressOnDb(address, box.read("userUID"));
                        Get.defaultDialog(
                            title: "Başarılı",
                            middleText: "Adresiniz Güncellendi");
                      }
                    } else {
                      Get.defaultDialog(
                          title: "Başarısız", middleText: "Bir Hata Oluştu");
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
