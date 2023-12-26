// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spoton/controller/PhaseController.dart';

import 'package:spoton/model/PhaseModel.dart';
import 'package:spoton/views/addMileStone/addMilestone.dart';

class PhaseList extends StatefulWidget {
  const PhaseList({
    super.key,
  });
  //     required this.id,
  //     required this.projectName,
  //     required this.cardId
  // final int id;
  // final String projectName;
  // final int cardId;

  @override
  State<PhaseList> createState() => _PhaseListState();
}

class _PhaseListState extends State<PhaseList> {
  String? token;
  String id = '55';
  String cardId = '2';
  final PhaseController phaseController = Get.put(PhaseController());
  final phaselistData = Rx<PhaseModel?>(null);
  loadSharedPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString("token");
    phaseController.getPhaseList(id.toString(), token);
  }

  @override
  void initState() {
    super.initState();
    loadSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double screenHeight = mediaQuery.size.height;
    final double fem = screenWidth / 375.0;

    return Scaffold(
      endDrawerEnableOpenDragGesture: true,
      backgroundColor: const Color(0xffF5F5F5),
      bottomSheet: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.to(() => const MilestonePage(),
                      transition: Transition.fade);
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 15 * fem, bottom: 15 * fem),
                  child: Container(
                    width: 120 * fem,
                    height: 40 * fem,
                    decoration: BoxDecoration(
                      color: const Color(0xff002a5a),
                      borderRadius: BorderRadius.circular(8 * fem),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x3f303030),
                          offset: Offset(0 * fem, 10 * fem),
                          blurRadius: 10 * fem,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Next',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.nunitoSans(
                          fontSize: 15 * fem,
                          fontWeight: FontWeight.w600,
                          height: 1.3625 * fem / fem,
                          color: const Color(0xffffffff),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
      body: SizedBox(
        height: screenHeight,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: (screenHeight * 0.25) * fem,
                color: const Color(0xff002A5A),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 45 * fem,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20 * fem,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            color: Color(0xFFFFFFFF),
                            size: 20,
                          ),
                        ),
                        SizedBox(
                          width: 15 * fem,
                        ),
                        SizedBox(
                          width: 60 * fem,
                        ),
                        const Spacer(),
                        const Icon(
                          Icons.search,
                          color: Color(0xFFFFFFFF),
                          size: 20,
                        ),
                        SizedBox(
                          width: 10 * fem,
                        ),
                        const Icon(
                          Icons.notifications_none_sharp,
                          color: Color(0xFFFFFFFF),
                          size: 20,
                        ),
                        SizedBox(
                          width: 10 * fem,
                        ),
                        const Icon(
                          Icons.settings,
                          color: Color(0xFFFFFFFF),
                          size: 20,
                        ),
                        SizedBox(
                          width: 10 * fem,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30 * fem,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0 * fem),
                      child: Text(
                        "Project - Gitanjali",
                        //"Project Name - ${widget.projectName}",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 18 * fem,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          height: 19 / 16,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: 5 * fem,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Apartment",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 14 * fem,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xffFFFFFF),
                          height: 20 / 14,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20 * fem,
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 30 * fem),
                    child: Text(
                      "Define Scope",
                      style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 18 * fem,
                          fontWeight: FontWeight.w500,
                          height: 18 / 20,
                          color: const Color(0xff000000)),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  // Get.to(() => const addProjectScreen(),
                  //     transition: Transition.leftToRightWithFade);
                },
                child: Container(
                  width: 320 * fem,
                  height: 40 * fem,
                  decoration: BoxDecoration(
                    border: Border.all(),
                    color: const Color(0xff002a5a),
                    borderRadius: BorderRadius.circular(6 * fem),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Add Phase  +',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.roboto(
                          fontSize: 14 * fem,
                          fontWeight: FontWeight.w500,
                          height: 1.1725 * fem / fem,
                          color: const Color(0xffffffff),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20 * fem,
              ),

              SizedBox(
                  height: 400 * fem,
                  child: Obx(
                    () => ListView.builder(
                      itemCount:
                          phaseController.phaselistData.value?.data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                            onTap: () {
                              // Get.to(() => projectDashboardScreen(),
                              //     transition: Transition.fade);
                            },
                            child: Container(
                              height: 90 * fem,
                              margin: EdgeInsets.only(
                                  left: 25 * fem, right: 25 * fem, top: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6.0),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text(
                                      phaseController.phaselistData.value!
                                          .data[index].cardName,
                                      style: TextStyle(
                                        fontFamily: "Roboto",
                                        fontSize: 17 * fem,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff282828),
                                        //height: 18 / 15,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    leading: CircleAvatar(
                                      radius: 15,
                                      backgroundColor: const Color(0xffF5F5F5),
                                      child: Image.asset(
                                        "assets/edit-tools.png",
                                        scale: 4,
                                      ),
                                    ),
                                    trailing: PopupMenuButton(
                                      offset: const Offset(0, 40),
                                      elevation: 2,
                                      icon: const Icon(Icons.more_vert),
                                      itemBuilder: (context) {
                                        return [
                                          const PopupMenuItem(
                                              value: 'edit',
                                              child: ListTile(
                                                  leading: Icon(Icons.edit),
                                                  title: Text('Edit'))),
                                          const PopupMenuItem(
                                              value: 'delete',
                                              child: ListTile(
                                                  leading: Icon(Icons.delete),
                                                  title: Text('Delete'))),
                                        ];
                                      },
                                      onSelected: (String value) =>
                                          actionPopUpItemSelected(value),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {},
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20.0),
                                          child: Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: Text(
                                              "Start Date: 2 May, 2023",
                                              style: GoogleFonts.roboto(
                                                fontSize: 10 * fem,
                                                color: const Color(0xff303030),
                                                height: 16 / 14,
                                              ),
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 0.0 * fem, right: 5.0 * fem),
                                        child: Text(
                                          "Target Date: 10 August, 2023",
                                          style: TextStyle(
                                            fontFamily: "Roboto",
                                            fontSize: 10 * fem,
                                            color: const Color(0xff303030),
                                            height: 19 / 16,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ));
                      },
                    ),
                  )),

              // Obx(
              //   () =>
              //       // phaseController.isLoading.value
              //       //     ? const Center(
              //       //         child: CircularProgressIndicator(),
              //       //       )
              //       //     : phaseController.noob.value == true
              //       //         ? SizedBox(
              //       //             height: 230 * fem,
              //       //             child: Center(
              //       //               child: Text(
              //       //                 "No Data Found",
              //       //                 style: TextStyle(
              //       //                   fontFamily: "Roboto",
              //       //                   fontSize: 18 * fem,
              //       //                   fontWeight: FontWeight.w500,
              //       //                   color: const Color(0xff282828),
              //       //                   height: 18 / 15,
              //       //                 ),
              //       //                 textAlign: TextAlign.left,
              //       //               ),
              //       //             ),
              //       //           )
              //       //         :
              //       ListView.builder(
              //           shrinkWrap: true,
              //           scrollDirection: Axis.vertical,
              //           physics: const NeverScrollableScrollPhysics(),
              //           itemCount:
              //               phaseController.phaselistData.value?.data.length,
              //           itemBuilder: (context, index) {
              //             return Container(
              //               height: 90 * fem,
              //               margin: EdgeInsets.only(
              //                   left: 25 * fem, right: 25 * fem, top: 10),
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(6.0),
              //                 color: Colors.white,
              //               ),
              //               child: Column(
              //                 children: [
              //                   ListTile(
              //                     title: Text(
              //                       phaseController.phaselistData.value!
              //                           .data[index].cardName,
              //                       style: TextStyle(
              //                         fontFamily: "Roboto",
              //                         fontSize: 17 * fem,
              //                         fontWeight: FontWeight.w500,
              //                         color: const Color(0xff282828),
              //                         //height: 18 / 15,
              //                       ),
              //                       textAlign: TextAlign.left,
              //                     ),
              //                     leading: CircleAvatar(
              //                       radius: 15,
              //                       backgroundColor: const Color(0xffF5F5F5),
              //                       child: Image.asset(
              //                         "assets/edit-tools.png",
              //                         scale: 4,
              //                       ),
              //                     ),
              //                     trailing: PopupMenuButton(
              //                       offset: const Offset(0, 40),
              //                       elevation: 2,
              //                       icon: const Icon(Icons.more_vert),
              //                       itemBuilder: (context) {
              //                         return [
              //                           const PopupMenuItem(
              //                               value: 'edit',
              //                               child: ListTile(
              //                                   leading: Icon(Icons.edit),
              //                                   title: Text('Edit'))),
              //                           const PopupMenuItem(
              //                               value: 'delete',
              //                               child: ListTile(
              //                                   leading: Icon(Icons.delete),
              //                                   title: Text('Delete'))),
              //                         ];
              //                       },
              //                       onSelected: (String value) =>
              //                           actionPopUpItemSelected(value),
              //                     ),
              //                   ),
              //                   Row(
              //                     children: [
              //                       GestureDetector(
              //                         onTap: () {},
              //                         child: Padding(
              //                           padding:
              //                               const EdgeInsets.only(left: 20.0),
              //                           child: Padding(
              //                             padding: const EdgeInsets.all(0.0),
              //                             child: Text(
              //                               "Start Date: 2 May, 2023",
              //                               style: GoogleFonts.roboto(
              //                                 fontSize: 10 * fem,
              //                                 color: const Color(0xff303030),
              //                                 height: 16 / 14,
              //                               ),
              //                               textAlign: TextAlign.left,
              //                             ),
              //                           ),
              //                         ),
              //                       ),
              //                       const Spacer(),
              //                       Padding(
              //                         padding: EdgeInsets.only(
              //                             left: 0.0 * fem, right: 5.0 * fem),
              //                         child: Text(
              //                           "Target Date: 10 August, 2023",
              //                           style: TextStyle(
              //                             fontFamily: "Roboto",
              //                             fontSize: 10 * fem,
              //                             color: const Color(0xff303030),
              //                             height: 19 / 16,
              //                           ),
              //                           textAlign: TextAlign.left,
              //                         ),
              //                       ),
              //                     ],
              //                   )
              //                 ],
              //               ),
              //             );
              //           }),
              // ),
              SizedBox(
                height: 15 * fem,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void actionPopUpItemSelected(String value) {
    // _scaffoldkey.currentState.hideCurrentSnackBar();
    String message;
    if (value == 'edit') {
      message = 'You selected edit for $value';
      print('name $value');
    } else if (value == 'delete') {
      message = 'You selected delete for $value';
      print('delete $value');
    } else {
      message = 'Not implemented';
      print('implemented $value');
    }
  }
}
