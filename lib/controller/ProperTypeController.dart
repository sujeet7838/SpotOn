import 'dart:convert';

import 'package:get/get.dart';
import 'package:spoton/model/ProjectModel.dart';
import 'package:spoton/model/PropertyTypeModel.dart';
import 'package:spoton/utils/AppConstants.dart';
import 'package:http/http.dart' as http;
import 'package:spoton/utils/SnackbarUtils.dart';
import 'package:spoton/views/projectListingScreen.dart';

class PropertyTypeController extends GetxController {
  RxList<PropertyTypeModel> propertyTypes = <PropertyTypeModel>[].obs;
  RxBool isDataLoading = false.obs;
  var projects = <ProjectModel>[].obs;

  Future<void> fetchPropertyTypes(token) async {
    final response = await http.get(Uri.parse(AppConstants.PROPERTY_TYPE),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      propertyTypes.value = data['data']
          .map<PropertyTypeModel>((item) => PropertyTypeModel.fromJson(item))
          .toList();
    } else {
      throw Exception('Failed to load property types');
    }
  }

  void addProject(
      String projectName, String startDate, String endDate, id, token) async {
    try {
      isDataLoading.value = true;
      var response =
          await http.post(Uri.parse(AppConstants.ADD_PROJECT), body: {
        'PROJECT_NAME': projectName,
        'PROJECT_START': startDate,
        'PROJECT_END': endDate,
        'FK_TYPE_ID': id
      }, headers: {
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode == 200) {
        Get.to(() => const projectListingScreen(),
            transition: Transition.fadeIn);
        SnackbarUtils.showFloatingSnackbar(
            "Project Status", "Project Added Successfully");
      } else {
        SnackbarUtils.showFloatingSnackbar("Project Status",
            "Project Addition Failed. Please fill all the details");
        print('API call failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    } finally {
      isDataLoading.value = false;
    }
  }

  void getProjects(token) async {
    try {
      final response =
          await http.get(Uri.parse(AppConstants.PROJECT_LIST), headers: {
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final projectDataList = jsonData['data'] as List<dynamic>;
        projects.value =
            projectDataList.map((data) => ProjectModel.fromJson(data)).toList();
      } else {
        print("failed to get project, ${response.statusCode}");
      }
    } catch (error) {
      print('error occurred :$error');
    }
  }
}
