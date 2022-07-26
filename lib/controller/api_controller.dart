import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_jsonplaceholder/model/model.dart';
import 'package:http/http.dart' as http;

class ApiController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchSpecialityData();
  }

  var box = GetStorage();

  var specialityList = <SpecialityModel>[].obs;

  var isLoading = true.obs;

  Future fetchSpecialityData() async {
    final response = await http
        .get(Uri.parse("https://hospione.com/demo/api/patientapi/speciality"));

    if (response.statusCode == 200) {
      //to save data offline in shared preferences.
      box.write('specialityList', response.body);

      //to populate data in variable.
      SpecialityModel specialitymodel =
          SpecialityModel.fromJson(jsonDecode(box.read('specialityList')));

      //to add data in list [].
      specialityList.add(SpecialityModel(
          data: specialitymodel.data, status: specialitymodel.status));

      //to toggle the state.
      isLoading.value = false;

      //to update everything in this function.
      update();
    } else {
      Get.snackbar('Error Loading data!',
          'Sever responded: ${response.statusCode}:${response.reasonPhrase.toString()}');
    }
  }
}
