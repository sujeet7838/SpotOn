// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spoton/controller/SignInController.dart';
import 'package:spoton/utils/SnackbarUtils.dart';
import 'package:spoton/views/signupScreen.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  final SignInController signInController = Get.put(SignInController());
  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double screenHeight = mediaQuery.size.height;
    final double fem = screenWidth / 375.0;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: screenHeight,
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0 * fem,
              top: 0 * fem,
              child: SizedBox(
                width: 500 * fem,
                height: 293 * fem,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0 * fem,
                      top: 0 * fem,
                      child: SizedBox(
                        width: 250 * fem,
                        child: Image.asset(
                          "assets/login_topleft.png",
                        ),
                      ),
                    ),
                    Positioned(
                      left: 30 * fem,
                      top: 150 * fem,
                      child: Align(
                        child: SizedBox(
                          width: 220 * fem,
                          height: 36 * fem,
                          child: Text(
                            'Sign in',
                            style: GoogleFonts.poppins(
                              fontSize: 24 * fem,
                              fontWeight: FontWeight.w500,
                              height: 1.5 * fem / fem,
                              color: const Color(0xff303030),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 30 * fem,
                      top: 200 * fem,
                      child: Align(
                        child: SizedBox(
                          //width: 220 * fem,
                          // height: 36 * fem,
                          child: Text(
                            'Welcome! \nSign in if you already have an account',
                            style: GoogleFonts.poppins(
                              fontSize: 14 * fem,
                              //fontWeight: FontWeight.w500,
                              //height: 1.5 * fem / fem,
                              color: const Color(0xffAAAAAA),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Positioned(
                    //   left: 32.5677490234 * fem,
                    //   top: 62.4996948242 * fem,
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       Get.back();
                    //     },
                    //     child: Align(
                    //       child: SizedBox(
                    //         width: 35.22 * fem,
                    //         height: 30.55 * fem,
                    //         child: Image.asset(
                    //           "assets/back.png",
                    //           fit: BoxFit.contain,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 41 * fem,
              top: 460 * fem,
              child: SizedBox(
                width: 473 * fem,
                height: 428 * fem,
                child: Stack(
                  children: [
                    Positioned(
                      left: 70 * fem,
                      top: 23 * fem,
                      child: Align(
                        child: SizedBox(
                          height: 355 * fem,
                          child: Image.asset(
                            "assets/login_bottomright.png",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 30 * fem,
              top: 256 * fem,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SizedBox(
                  //   height: 28 * fem,
                  //   child: Text(
                  //     'Welcome back',
                  //     style: GoogleFonts.poppins(
                  //       fontSize: 15 * fem,
                  //       fontWeight: FontWeight.w400,
                  //       height: 1.9462193298 * fem / fem,
                  //       color: const Color(0xffaaaaaa),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 50 * fem,
                  ),
                  SizedBox(
                    width: 300.67 * fem,
                    height: 25.5 * fem,
                    child: TextField(
                      controller: fullNameController,
                      showCursor: true,
                      decoration: InputDecoration(
                        hintText: 'Your Full Name',
                        hintStyle: TextStyle(
                          fontSize: 14.0,
                          height: 3 * fem,
                          color: const Color(0xffC1C7D0),
                        ),
                        prefixIcon: Container(
                          margin:
                              EdgeInsets.only(right: 30 * fem, bottom: 7 * fem),
                          child: Transform.scale(
                            scale: 1.3,
                            child: Image.asset(
                              "assets/login_user.png",
                              color: Colors.black,
                            ),
                          ),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40 * fem,
                  ),
                  SizedBox(
                    width: 300.67 * fem,
                    height: 25.5 * fem,
                    child: TextFormField(
                      controller: phoneNumberController,
                      showCursor: true,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      decoration: InputDecoration(
                        hintText: 'Mobile Number',
                        hintStyle: TextStyle(
                          fontSize: 14.0,
                          height: 3 * fem,
                          color: const Color(0xffC1C7D0),
                        ),
                        prefixIcon: Container(
                          margin:
                              EdgeInsets.only(right: 30 * fem, bottom: 7 * fem),
                          child: Transform.scale(
                            scale: 1.2,
                            child: Image.asset(
                              "assets/smartphone.png",
                              color: Colors.black,
                            ),
                          ),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        counterText: '',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 80 * fem,
                  ),
                  Obx(() => GestureDetector(
                        onTap: () {
                          phoneNumberController.text.length == 10
                              ? signInController.signIn(
                                  fullNameController.text.toString(),
                                  phoneNumberController.text.toString(),
                                )
                              : Get.snackbar(
                                  'Error',
                                  'Please enter a valid phone number',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                );
                        },
                        child: Container(
                          width: 315 * fem,
                          height: 46 * fem,
                          decoration: BoxDecoration(
                            border: Border.all(),
                            color: const Color(0xff002a5a),
                            borderRadius: BorderRadius.circular(6 * fem),
                          ),
                          child: Center(
                            child: signInController.isDataLoading.value
                                ? const CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Color(0xffffffff),
                                    ),
                                  )
                                : Text(
                                    'GET OTP',
                                    style: GoogleFonts.roboto(
                                      fontSize: 18 * fem,
                                      fontWeight: FontWeight.w500,
                                      height: 1.1725 * fem / fem,
                                      color: const Color(0xffffffff),
                                    ),
                                  ),
                          ),
                        ),
                      )),

                  // const SizedBox(
                  //   height: 20,
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(26.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          'Didn’t have an account?',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                              color: Color(0xffAAAAAA)),
                        ),
                        TextButton(
                          child: const Text(
                            'Sign UP',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color(0xff002A5A)),
                          ),
                          onPressed: () {
                            //signup screen
                            Get.to(() => const signUpScreen(),
                                transition: Transition.rightToLeftWithFade);
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
