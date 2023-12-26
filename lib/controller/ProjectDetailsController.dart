import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:spoton/utils/AppConstants.dart';
import 'package:spoton/utils/SnackbarUtils.dart';
import 'package:spoton/views/addPhase/phaseList.dart';
import '../model/ProjectDetailsModel.dart';

class ProjectDetailsController extends GetxController {
  RxBool isLoading = false.obs;
  final projectDetails = Rx<ProjectDetails?>(null);
  final phaseList = Rx<ProjectDetails?>(null);

  Future<void> fetchProjectDetails(id, token) async {
    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse(AppConstants.PROJECT_DETAILS + id),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        projectDetails.value = ProjectDetails.fromJson(jsonResponse["data"]);
      } else {
        projectDetails.value = null;
        print('API call failed with status code ${response.statusCode}');
      }
    } catch (error) {
      projectDetails.value = null;
      print('Error while fetching project details: $error');
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchPhaseList(id, token) async {
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
        phaseList.value = ProjectDetails.fromJson(jsonResponse["data"]);
      } else {
        phaseList.value = null;
        print('API call failed with status code ${response.statusCode}');
      }
    } catch (error) {
      phaseList.value = null;
      print('Error while fetching project details: $error');
    } finally {
      isLoading(false);
    }
  }

  Future<void> postCommentWithFiles(
    int projectId,
    String comment,
    List<http.MultipartFile>? images,
    String token,
  ) async {
    try {
      isLoading(true);

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(AppConstants.POST_COMMENT),
      );

      request.headers['Authorization'] = 'Bearer $token';

      request.fields['FK_PROJECT_ID'] = projectId.toString();
      if (comment.isNotEmpty) {
        request.fields['COMMENT'] = comment;
      }

      if (images != null && images.isNotEmpty) {
        for (var file in images) {
          request.files.add(file);
        }
      }

      var response = await request.send();
      if (response.statusCode == 200) {
        fetchProjectDetails(projectId.toString(), token);
        SnackbarUtils.showFloatingSnackbar(
            "Message Sent", "Message Sent Successfully");
      } else {
        print('API call failed with status code ${response.statusCode}');
      }
    } catch (error) {
      print('Error while posting comment: $error');
    } finally {
      isLoading(false);
    }
  }

  Future<void> uploadImages(
      List<http.MultipartFile> files, String token, id) async {
    try {
      isLoading(true);
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(AppConstants.ADD_IMAGE + id),
      );

      request.headers['Authorization'] = 'Bearer $token';

      if (files.isNotEmpty) {
        for (var file in files) {
          request.files.add(file);
        }
      }

      var response = await request.send();
      if (response.statusCode == 200) {
        SnackbarUtils.showFloatingSnackbar(
            "Photo Uploaded", "Photo Uploaded Successfully");
        fetchProjectDetails(id, token);
      } else {
        print('API call failed with status code ${response.statusCode}');
      }
    } catch (error) {
      print('Error while uploading images: $error');
    } finally {
      isLoading(false);
    }
  }

//
  Future<void> addPhase(String cardName, fkProjectId, fkCardId,
      String startDate, String endDate, token) async {
    try {
      isLoading(true);
      var response = await http.post(Uri.parse(AppConstants.ADD_PHASE), body: {
        'CARD_NAME': cardName,
        'FK_PROJECT_ID': fkProjectId,
        'PARENT_CARD_ID': fkCardId,
        'ESTIMATE_START_TIME': startDate,
        'ESTIMATE_END_TIME': endDate,
      }, headers: {
        'Authorization': 'Bearer $token',
      });
      if (response.statusCode == 200) {
        fetchProjectDetails(fkProjectId, token);
        //id: fkProjectId, projectName: cardName, cardId: fkCardId
        Get.to(() => PhaseList(), transition: Transition.fade);
        SnackbarUtils.showFloatingSnackbar(
            "Phase Added", "Phase Added Successfully");
      } else {
        print('API call failed with status code ${response.statusCode}');
      }
    } catch (error) {
      print('Error while posting phase: $error');
    } finally {
      isLoading(false);
    }
  }

  // Future<void> addPhase(CARD_NAME, FK_PROJECT_ID, FK_CARD_ID, token) async {
  //   try {
  //     isLoading(true);
  //     var response = await http.post(Uri.parse(AppConstants.ADD_PHASE), body: {
  //       'CARD_NAME': CARD_NAME,
  //       'FK_PROJECT_ID': FK_PROJECT_ID,
  //       'FK_CARD_ID': FK_CARD_ID,
  //     }, headers: {
  //       'Authorization': 'Bearer $token',
  //     });
  //     if (response.statusCode == 200) {
  //       fetchProjectDetails(FK_PROJECT_ID, token);
  //       Get.back();
  //       SnackbarUtils.showFloatingSnackbar(
  //           "Phase Added", "Phase Added Successfully");
  //     } else {
  //       print('API call failed with status code ${response.statusCode}');
  //     }
  //   } catch (error) {
  //     print('Error while posting phase: $error');
  //   } finally {
  //     isLoading(false);
  //   }
  // }
}
