import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spoton/controller/ProperTypeController.dart';
import 'package:spoton/views/addPhase/addPhase.dart';
import 'package:spoton/views/addProjectScreen.dart';
import 'package:spoton/views/projectDashboardScreen.dart';
import 'package:spoton/views/welcomeScreen.dart';

class projectListingScreen extends StatefulWidget {
  const projectListingScreen({super.key});

  @override
  State<projectListingScreen> createState() => _projectListingScreenState();
}

class _projectListingScreenState extends State<projectListingScreen> {
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
      backgroundColor: const Color(0xfff5f5f5),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          height: screenHeight,
          child: Column(children: [
            Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(
                    top: 50 * fem, left: 20 * fem, right: 20 * fem),
                child: GestureDetector(
                  onTap: () async {
                    final SharedPreferences sharedPreferences =
                        await SharedPreferences.getInstance();
                    sharedPreferences.clear();
                    Get.off(() => const welcomeScreen());
                  },
                  child: const Icon(
                    Icons.logout,
                    size: 18,
                    color: Color(0xff262525),
                  ),
                )),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Container(
            //       alignment: Alignment.centerLeft,
            //       margin: EdgeInsets.only(
            //           top: 50 * fem, left: 20 * fem, right: 20 * fem),
            //       child: GestureDetector(
            //         onTap: () {
            //           Get.back();
            //         },
            //         child: const Icon(
            //           Icons.arrow_back,
            //           size: 30,
            //           color: Colors.black,
            //         ),
            //       ),
            //     ),
            //     Container(
            //       alignment: Alignment.centerLeft,
            //       margin: EdgeInsets.only(
            //           top: 50 * fem, left: 20 * fem, right: 20 * fem),
            //       child: ElevatedButton(
            //         onPressed: () async {
            //           final SharedPreferences sharedPreferences =
            //               await SharedPreferences.getInstance();
            //           sharedPreferences.clear();
            //           Get.off(() => const welcomeScreen());
            //         },
            //         style: ElevatedButton.styleFrom(
            //           minimumSize: Size(50 * fem, 30 * fem),
            //           primary: Colors.white,
            //           onPrimary: Colors.black,
            //           textStyle: GoogleFonts.poppins(
            //             fontSize: 12 * fem,
            //             fontWeight: FontWeight.w500,
            //           ),
            //           shape: RoundedRectangleBorder(
            //             borderRadius: BorderRadius.circular(5),
            //           ),
            //           padding: const EdgeInsets.symmetric(
            //             horizontal: 10,
            //           ),
            //         ),
            //         child: const Text("Log Out"),
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(
              height: 30 * fem,
            ),
            Text(
              'Your Project',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: 24 * fem,
                fontWeight: FontWeight.w500,
                height: 1.2000000477 * fem / fem,
                color: const Color(0xff282828),
              ),
            ),
            SizedBox(
              height: 15 * fem,
            ),
            Text(
              'What’s something your team is currently working on?',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: 14 * fem,
                fontWeight: FontWeight.w400,
                height: 1.2000000817 * fem / fem,
                color: const Color(0xff282828),
              ),
            ),
            SizedBox(
              height: 20 * fem,
            ),
            SizedBox(
                height: 400 * fem,
                child: Obx(
                  () => propertyTypeController.projects.isEmpty
                      ? const Center(
                          child: Text(
                            "No Projects Added",
                            style: TextStyle(fontSize: 20),
                          ),
                        )
                      : ListView.builder(
                          itemCount: propertyTypeController.projects.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Get.to(
                                    () => projectDashboardScreen(
                                        id: propertyTypeController
                                            .projects[index].pkProjectId,
                                        projectName: propertyTypeController
                                            .projects[index].projectName
                                            .toString()),
                                    transition: Transition.fade);
                                // Get.to(
                                //     () => addPhase(
                                //         id: propertyTypeController
                                //             .projects[index].pkProjectId,
                                //         projectName: propertyTypeController
                                //             .projects[index].projectName
                                //             .toString()),
                                //     transition: Transition.fade);
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20),
                                child: Card(
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.grey[300],
                                      child: Image.asset(
                                        "assets/construction.png",
                                        scale: 4,
                                      ),
                                    ),
                                    title: Text(
                                      propertyTypeController
                                          .projects[index].projectName
                                          .toString(),
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.roboto(
                                        fontSize: 18 * fem,
                                        fontWeight: FontWeight.w500,
                                        height: 1.1725 * fem / fem,
                                        color: const Color(0xff282828),
                                      ),
                                    ),
                                    trailing: const Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 15,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                )),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => const addProjectScreen(),
                    transition: Transition.leftToRightWithFade);
              },
              child: Container(
                width: 320 * fem,
                height: 46 * fem,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: const Color(0xff002a5a),
                  borderRadius: BorderRadius.circular(6 * fem),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.add_circle_outline_sharp,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Add Project',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.roboto(
                        fontSize: 18 * fem,
                        fontWeight: FontWeight.w500,
                        height: 1.1725 * fem / fem,
                        color: const Color(0xffffffff),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
