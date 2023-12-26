// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spoton/controller/ProjectDetailsController.dart';
import 'package:spoton/controller/ProperTypeController.dart';
import 'package:spoton/views/addProjectScreen.dart';
import 'package:spoton/views/loginScreen.dart';
import 'package:spoton/views/projectListingScreen.dart';

class welcomeScreen extends StatefulWidget {
  const welcomeScreen({super.key});

  @override
  State<welcomeScreen> createState() => _welcomeScreenState();
}

class _welcomeScreenState extends State<welcomeScreen> {
  String? token;
  final PropertyTypeController propertyTypeController =
      Get.put(PropertyTypeController());

  @override
  void initState() {
    loadSharedPreferences();
    super.initState();
  }

  loadSharedPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString("token");
    propertyTypeController.getProjects(token);
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double screenHeight = mediaQuery.size.height;
    final double fem = screenWidth / 375.0;
    return Scaffold(
      body: SingleChildScrollView(
        child: TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
          ),
          child: Container(
            width: double.infinity,
            height: screenHeight,
            decoration: const BoxDecoration(
              color: Color(0xffE6EAEF),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 0 * fem,
                  top: 0 * fem,
                  child: Container(
                    width: 539.4 * fem,
                    height: 603.4 * fem,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(220),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          left: 20 * fem,
                          top: 0 * fem,
                          child: Align(
                            child: SizedBox(
                              width: 435 * fem,
                              height: 425 * fem,
                              child: Image.asset(
                                "assets/whiteScreen.png",
                                width: 539.4 * fem,
                                height: 603.4 * fem,
                              ),
                            ),
                          ),
                        ),
                        Stack(
                          children: [
                            Positioned(
                              left: 238 * fem,
                              top: 0 * fem,
                              child: Align(
                                child: SizedBox(
                                  width: 71 * fem,
                                  height: 200 * fem,
                                  child: Image.asset("assets/ceilinglamp.png"),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 66 * fem,
                              top: 386 * fem,
                              child: Align(
                                child: SizedBox(
                                  width: 196 * fem,
                                  height: 38 * fem,
                                  child: Image.asset("assets/shadow.png"),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 262 * fem,
                              top: 401 * fem,
                              child: Align(
                                child: SizedBox(
                                  width: 68 * fem,
                                  height: 13 * fem,
                                  child: Image.asset("assets/shortshadow.png"),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 262 * fem,
                              top: 289 * fem,
                              child: Align(
                                child: SizedBox(
                                  width: 73.4 * fem,
                                  height: 111.79 * fem,
                                  child: Image.asset("assets/desk.png"),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 2 * fem,
                              top: 142.7398681641 * fem,
                              child: SizedBox(
                                width: 154 * fem,
                                height: 257.26 * fem,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 30.2658691406 * fem,
                                      top: 243.0173492432 * fem,
                                      child: Align(
                                        child: SizedBox(
                                          width: 45.4 * fem,
                                          height: 14.24 * fem,
                                          child: Image.asset(
                                              "assets/shortestShadow.png"),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0 * fem,
                                      top: 0 * fem,
                                      child: Align(
                                        child: SizedBox(
                                          width: 154 * fem,
                                          height: 247.47 * fem,
                                          child:
                                              Image.asset("assets/Plant.png"),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 60 * fem,
                              top: 236 * fem,
                              child: SizedBox(
                                width: 188 * fem,
                                height: 178 * fem,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 6.1685791016 * fem,
                                      top: 46.7036590576 * fem,
                                      child: Align(
                                        child: SizedBox(
                                          width: 175.08 * fem,
                                          height: 33.65 * fem,
                                          child: Image.asset(
                                              "assets/armchairshadow.png"),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0 * fem,
                                      top: 0 * fem,
                                      child: Align(
                                        child: SizedBox(
                                          width: 188 * fem,
                                          height: 178 * fem,
                                          child: Image.asset(
                                              "assets/Armchair.png"),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 32 * fem,
                  top: 433 * fem,
                  child: SizedBox(
                    width: 311 * fem,
                    height: 336.5 * fem,
                    child: Stack(
                      children: [
                        Positioned(
                          // backgroundYwo (1:389)
                          left: 0 * fem,
                          top: 0 * fem,
                          child: Align(
                            child: SizedBox(
                              width: 311 * fem,
                              height: 332.5 * fem,
                              child: Image.asset(
                                "assets/stylebg.png",
                                width: 311 * fem,
                                height: 332.5 * fem,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 52 * fem,
                          top: 60 * fem,
                          child: Align(
                            child: SizedBox(
                              width: 205 * fem,
                              height: 70 * fem,
                              child: Text(
                                'Make your Home Beautiful',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                  height: 1.4583333333,
                                  color: const Color(0xff282828),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          // bodyKLH (1:393)
                          left: 26 * fem,
                          top: 154 * fem,
                          child: Center(
                            child: Align(
                              child: SizedBox(
                                width: 269 * fem,
                                height: 40 * fem,
                                child: Text(
                                  'Explore World Class Top Furniture\'s as per you Requirements & Choice',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.nunitoSans(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    height: 1.4285714286,
                                    color: const Color(0xff181d2d),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 124 * fem,
                          top: 274.5 * fem,
                          child: Align(
                            child: GestureDetector(
                              onTap: () {
                                if (token == null) {
                                  Get.to(() => const loginScreen(),
                                      transition:
                                          Transition.rightToLeftWithFade);
                                } else {
                                  if (propertyTypeController.projects.isEmpty) {
                                    Get.to(() => const addProjectScreen(),
                                        transition: Transition.fadeIn);
                                  } else {
                                    Get.to(() => const projectListingScreen(),
                                        transition: Transition.fadeIn);
                                  }
                                }
                              },
                              child: SizedBox(
                                width: 62 * fem,
                                height: 62 * fem,
                                child: Image.asset(
                                  "assets/welcomeNext.png",
                                  width: 62 * fem,
                                  height: 62 * fem,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
