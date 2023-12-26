// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spoton/controller/PhaseController.dart';

class MilestonePage extends StatefulWidget {
  const MilestonePage({
    super.key,
  });

  @override
  State<MilestonePage> createState() => _MilestonePageState();
}

class _MilestonePageState extends State<MilestonePage> {
  String? token;
  String id = '1';
  String cardId = '2';
  final PhaseController phaseController = Get.put(PhaseController());
  loadSharedPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString("token");
    phaseController.fetchProjectDetails(
        id.toString(), cardId.toString(), token);
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
                  // Get.to(() => const MilestonePage(), transition: Transition.fade);
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
                        // "Project Name - ${widget.name}",
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
                      "Select Scope to Define Milestone",
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
              Container(
                height: 100 * fem,
                margin:
                    EdgeInsets.only(left: 25 * fem, right: 25 * fem, top: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.0),
                  color: Color(0xffD2E7FF),
                ),
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        "Phase 1",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 17 * fem,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xff282828),
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
                      trailing: Wrap(
                        spacing: -16,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.more_vert),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                            ),
                            onPressed: () {
                              _settingModalBottomSheet(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 40,
                      width: 328,
                      margin: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffFFFFFF),
                        borderRadius: BorderRadius.circular(6 * fem),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                "Start Date: 2 May, 2023 ",
                                style: GoogleFonts.roboto(
                                  fontSize: 10 * fem,
                                  color: const Color(0xff303030),
                                  height: 16 / 14,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            Text(
                              "Target Date: 10 August, 2023",
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 10 * fem,
                                color: const Color(0xff303030),
                                height: 19 / 16,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
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

  _settingModalBottomSheet(
    context,
  ) {
    showModalBottomSheet<dynamic>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          final MediaQueryData mediaQuery = MediaQuery.of(context);
          final double screenWidth = mediaQuery.size.width;
          final double screenHeight = mediaQuery.size.height;
          final double fem = screenWidth / 375.0;
          // Initial Selected Value
          String dropdownvalue = 'Bedroom';
          var items = [
            'Bedroom',
            'Kitchen',
            'Bathroom',
            'Dining',
          ];
          return Wrap(
            children: <Widget>[
              SingleChildScrollView(
                child: Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          // color: colorPrimary,
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(18.0),
                            topRight: Radius.circular(18.0),
                          ),
                        ),
                        child: DefaultTabController(
                          length: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 12),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    height: 100 * fem,
                                    //margin: const EdgeInsets.only(top: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6.0),
                                      color: Color(0xffD2E7FF),
                                    ),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: Text(
                                            "Phase 1",
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
                                            backgroundColor:
                                                const Color(0xffF5F5F5),
                                            child: Image.asset(
                                              "assets/edit-tools.png",
                                              scale: 4,
                                            ),
                                          ),
                                          trailing: Wrap(
                                            spacing: -16,
                                            children: [
                                              IconButton(
                                                icon:
                                                    const Icon(Icons.more_vert),
                                                onPressed: () {},
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.keyboard_arrow_up,
                                                ),
                                                onPressed: () {
                                                  // _settingModalBottomSheet(
                                                  //     context);      icon: const Icon(
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: 40,
                                          width: 328,
                                          margin: const EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xffFFFFFF),
                                            borderRadius:
                                                BorderRadius.circular(6 * fem),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {},
                                                  child: Text(
                                                    "Start Date: 2 May, 2023 ",
                                                    style: GoogleFonts.roboto(
                                                      fontSize: 10 * fem,
                                                      color: const Color(
                                                          0xff303030),
                                                      height: 16 / 14,
                                                    ),
                                                    textAlign: TextAlign.left,
                                                  ),
                                                ),
                                                Text(
                                                  "Target Date: 10 August, 2023",
                                                  style: TextStyle(
                                                    fontFamily: "Roboto",
                                                    fontSize: 10 * fem,
                                                    color:
                                                        const Color(0xff303030),
                                                    height: 19 / 16,
                                                  ),
                                                  textAlign: TextAlign.left,
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10 * fem,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        child: const Text(
                                          "Choose your Milestone",
                                          style: TextStyle(
                                              fontFamily: "Roboto",
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              height: 18 / 20,
                                              color: Color(0xff000000)),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10 * fem,
                                  ),
                                  const TabBar(
                                    tabs: [
                                      Tab(
                                          child: Text(
                                        'By Area',
                                        style:
                                            TextStyle(color: Color(0xff000000)),
                                      )),
                                      Tab(
                                        child: Text(
                                          'By Type',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color(0xff000000)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    child: TabBarView(
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16.0),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height: 40.0,
                                                    width: 244.0,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 10.0),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      border: Border.all(
                                                        color:
                                                            Color(0xff999999),
                                                        style:
                                                            BorderStyle.solid,
                                                      ),
                                                    ),
                                                    child: DropdownButton(
                                                      value: dropdownvalue,
                                                      elevation: 16,
                                                      isExpanded: true,
                                                      style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 20.0),
                                                      icon: const Icon(Icons
                                                          .keyboard_arrow_down),
                                                      items: items
                                                          .map((String items) {
                                                        return DropdownMenuItem(
                                                          value: items,
                                                          child: Text(items),
                                                        );
                                                      }).toList(),
                                                      onChanged:
                                                          (String? newValue) {
                                                        setState(() {
                                                          dropdownvalue =
                                                              newValue!;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  const Wrap(
                                                    spacing: 5,
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 15,
                                                        backgroundColor:
                                                            Color(0xff002A5A),
                                                        child: Icon(
                                                            Icons.remove,
                                                            color: Color(
                                                                0xffFFFFFF)),
                                                      ),
                                                      CircleAvatar(
                                                        radius: 15,
                                                        backgroundColor:
                                                            Color(0xff002A5A),
                                                        child: Icon(
                                                          Icons.add,
                                                          color:
                                                              Color(0xffFFFFFF),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            // Padding(
                                            //   padding: const EdgeInsets.only(
                                            //       left: 16.0),
                                            //   child: Row(
                                            //     children: [
                                            //       Container(
                                            //         height: 40.0,
                                            //         width: 244.0,
                                            //         padding: const EdgeInsets
                                            //             .symmetric(
                                            //             horizontal: 10.0),
                                            //         decoration: BoxDecoration(
                                            //           borderRadius:
                                            //               BorderRadius.circular(
                                            //                   5.0),
                                            //           border: Border.all(
                                            //             color:
                                            //                 Color(0xff999999),
                                            //             style:
                                            //                 BorderStyle.solid,
                                            //           ),
                                            //         ),
                                            //         child: DropdownButton(
                                            //           value: dropdownvalue,
                                            //           elevation: 16,
                                            //           isExpanded: true,
                                            //           style: const TextStyle(
                                            //               color: Colors.black,
                                            //               fontSize: 20.0),
                                            //           icon: const Icon(Icons
                                            //               .keyboard_arrow_down),
                                            //           items: items
                                            //               .map((String items) {
                                            //             return DropdownMenuItem(
                                            //               value: items,
                                            //               child: Text(items),
                                            //             );
                                            //           }).toList(),
                                            //           onChanged:
                                            //               (String? newValue) {
                                            //             setState(() {
                                            //               dropdownvalue =
                                            //                   newValue!;
                                            //             });
                                            //           },
                                            //         ),
                                            //       ),
                                            //       Spacer(),
                                            //       const Wrap(
                                            //         spacing: 5,
                                            //         children: [
                                            //           CircleAvatar(
                                            //             radius: 15,
                                            //             backgroundColor:
                                            //                 Color(0xff002A5A),
                                            //             child: Icon(
                                            //                 Icons.remove,
                                            //                 color: Color(
                                            //                     0xffFFFFFF)),
                                            //           ),
                                            //           CircleAvatar(
                                            //             radius: 15,
                                            //             backgroundColor:
                                            //                 Color(0xff002A5A),
                                            //             child: Icon(
                                            //               Icons.add,
                                            //               color:
                                            //                   Color(0xffFFFFFF),
                                            //             ),
                                            //           ),
                                            //         ],
                                            //       ),
                                            //     ],
                                            //   ),
                                            // ),
                                            // const SizedBox(
                                            //   height: 10,
                                            // ),
                                            GestureDetector(
                                              onTap: () {
                                                // Get.to(() => const addProjectScreen(),
                                                //     transition: Transition.leftToRightWithFade);
                                              },
                                              child: Container(
                                                width: 300 * fem,
                                                height: 40 * fem,
                                                decoration: BoxDecoration(
                                                  border: Border.all(),
                                                  color:
                                                      const Color(0xff002a5a),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6 * fem),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    Text(
                                                      'Add Milestone  +',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: GoogleFonts.roboto(
                                                        fontSize: 14 * fem,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height:
                                                            1.1725 * fem / fem,
                                                        color: const Color(
                                                            0xffffffff),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {},
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 25.0),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Text(
                                                        "Cancel",
                                                        style:
                                                            GoogleFonts.roboto(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: const Color(
                                                              0xff000000),
                                                          height: 16 / 14,
                                                        ),
                                                        textAlign:
                                                            TextAlign.left,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const Spacer(),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 20.0),
                                                  child: TextButton(
                                                    onPressed: () {},
                                                    style: TextButton.styleFrom(
                                                      padding: EdgeInsets.zero,
                                                    ),
                                                    child: Container(
                                                      width: 120 * fem,
                                                      height: 40 * fem,
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xff002a5a),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    8 * fem),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: const Color(
                                                                0x3f303030),
                                                            offset: Offset(
                                                                0 * fem,
                                                                10 * fem),
                                                            blurRadius:
                                                                10 * fem,
                                                          ),
                                                        ],
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          'Save',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: GoogleFonts
                                                              .nunitoSans(
                                                            fontSize: 15 * fem,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            height: 1.3625 *
                                                                fem /
                                                                fem,
                                                            color: const Color(
                                                                0xffffffff),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        const Column(
                                          children: <Widget>[
                                            Text(
                                              'Development in progress',
                                              style: TextStyle(fontSize: 24),
                                            ),
                                            SizedBox(height: 26),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ]),
                          ),
                        ));
                  }),
                ),
              )
            ],
          );
        });
  }
}
