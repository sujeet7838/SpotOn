import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spoton/controller/ProperTypeController.dart';
import 'package:spoton/utils/AppConstants.dart';
import 'package:spoton/utils/SnackbarUtils.dart';
import 'package:spoton/views/addProjectScreen.dart';
import 'package:spoton/views/otpScreen.dart';
import 'package:spoton/views/projectListingScreen.dart';

class SignInController extends GetxController {
  final String apiUrl = AppConstants.SIGN_IN;
  final String otpUrl = AppConstants.VALIDATE_OTP;
  String? token;
  RxBool isDataLoading = false.obs;
  RxBool isValidated = false.obs;
  RxInt id = 0.obs;

  final PropertyTypeController propertyTypeController =
      Get.put(PropertyTypeController());

  void signIn(String fullName, String phoneNumber) async {
    try {
      isDataLoading.value = true;
      var response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'FULL_NAME': fullName,
          'PHONE_NUMBER': phoneNumber,
        },
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseBody = json.decode(response.body);
        int userId = responseBody['data']['userId'];
        String otp = responseBody['data']['otp'];
        Get.to(
            () => otpScreen(
                id: userId, name: fullName, number: phoneNumber, otp: otp),
            transition: Transition.fadeIn);
        SnackbarUtils.showFloatingSnackbar(
            "Sign In Status", "Your OTP is $otp");
      } else {
        SnackbarUtils.showFloatingSnackbar("Sign In Status", "Sign In Failed");
        print('API call failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    } finally {
      isDataLoading.value = false;
    }
  }

  void validateOTP(userId, otp) async {
    try {
      isDataLoading.value = true;
      var response = await http.post(
        Uri.parse(otpUrl),
        body: {
          'FK_USER_ID': userId.toString(),
          'OTP': otp.toString(),
        },
      );

      if (response.statusCode == 200) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        Map<String, dynamic> responseBody = json.decode(response.body);
        await sharedPreferences.setString(
            "token", responseBody["access_token"]);
        token = sharedPreferences.getString("token");
        if (token != null) {
          propertyTypeController.getProjects(token);
        }
        Future.delayed(const Duration(seconds: 2), () {
          if (propertyTypeController.projects.isEmpty) {
            Get.to(() => const addProjectScreen(),
                transition: Transition.fadeIn);
          } else {
            Get.to(() => const projectListingScreen(),
                transition: Transition.fadeIn);
          }
          SnackbarUtils.showFloatingSnackbar(
              "Sign In Status", "Sign In Successful");
        });
      } else {
        SnackbarUtils.showFloatingSnackbar("Sign In Status", "Sign In Failed");
        print('API call failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    } finally {
      isDataLoading.value = false;
    }
  }

  void validatePhoneNumber(String phoneNumber) {
    if (phoneNumber.length == 10) {
      isValidated.value = true;
    } else {
      isValidated.value = false;
    }
  }
}
