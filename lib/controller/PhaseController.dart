// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:spoton/model/PhaseModel.dart';
import 'package:spoton/model/RegionModel.dart';
import 'package:spoton/model/ScopeModel.dart';
import 'package:spoton/utils/AppConstants.dart';
import 'package:spoton/utils/SnackbarUtils.dart';

class PhaseController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isDataLoading = false.obs;
  final regionDetails = Rx<RegionResponse?>(null);
  final phaselistData = Rx<PhaseModel?>(null);
  final scopeList = Rx<ScopeModel?>(null);
  RxBool noob = false.obs;

  Future<void> fetchProjectDetails(id, cardId, token) async {
    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse(AppConstants.GET_REGION + "/" + id + "/" + cardId),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        regionDetails.value = RegionResponse.fromJson(jsonResponse);
      } else {
        noob(true);
        print('API call failed with status code ${response.statusCode}');
      }
    } catch (error) {
      print('Error while fetching project details: $error');
    } finally {
      isLoading(false);
    }
  }

  Future<void> addRegion(REGION_NAME, FK_PROJECT_ID, FK_CARD_ID, token) async {
    try {
      isLoading(true);
      var response = await http.post(Uri.parse(AppConstants.ADD_REGION), body: {
        'REGION_NAME': REGION_NAME,
        'FK_PROJECT_ID': FK_PROJECT_ID,
        'FK_CARD_ID': FK_CARD_ID,
      }, headers: {
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        noob(false);
        fetchProjectDetails(FK_PROJECT_ID, FK_CARD_ID, token);
        Get.back();
        SnackbarUtils.showFloatingSnackbar(
            "Region Added", "Region Added Successfully");
      } else {
        print('API call failed with status code ${response.statusCode}');
      }
    } catch (error) {
      print('Error while posting phase: $error');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchScopeDetails(token) async {
    try {
      isDataLoading(true);
      var response = await http.get(
        Uri.parse(AppConstants.GET_SCOPE),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        scopeList.value = ScopeModel.fromJson(jsonResponse);
      } else {
        print('API call failed with status code ${response.statusCode}');
      }
    } catch (error) {
      print('Error while fetching project details: $error');
    } finally {
      isDataLoading(false);
    }
  }

  Future<void> getPhaseList(id, token) async {
    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse(AppConstants.PHASE_LIST + id),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        phaselistData.value = PhaseModel.fromJson(jsonResponse);
      } else {
        noob(true);
        print('API call failed with status code ${response.statusCode}');
      }
    } catch (error) {
      print('Error while fetching project details: $error');
    } finally {
      isLoading(false);
    }
  }
}
