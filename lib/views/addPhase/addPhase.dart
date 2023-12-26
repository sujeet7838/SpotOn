// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spoton/controller/ProjectDetailsController.dart';
import 'package:spoton/views/addPhase/phaseList.dart';

class addPhase extends StatefulWidget {
  const addPhase({super.key, required this.id, required this.projectName});
  final int id;
  final String projectName;

  @override
  State<addPhase> createState() => _addPhaseState();
}

class _addPhaseState extends State<addPhase> {
  String? token;

  bool flag = false;
  bool flag1 = false;
  final nameController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  final DateFormat _dateFormat = DateFormat('dd-MM-yyyy');
  final ProjectDetailsController projectDetailsController =
      Get.put(ProjectDetailsController());

  @override
  void initState() {
    loadSharedPreferences();
    super.initState();
  }

  loadSharedPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString("token");
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        flag = true;
      });
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedEndDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedEndDate = picked;
        flag1 = true;
      });
    }
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
                  Get.to(() => const PhaseList(), transition: Transition.fade);
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
                        // "Project - Gitanjali",
                        "Project Name - ${widget.projectName}",
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
              Container(
                  height: 240 * fem,
                  width: 325 * fem,
                  alignment: Alignment.topLeft,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            margin:
                                EdgeInsets.only(left: 20 * fem, top: 20 * fem),
                            child: Text(
                              "Phase Name",
                              style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 14 * fem,
                                  fontWeight: FontWeight.w500,
                                  height: 18 / 20,
                                  color: const Color(0xff000000)),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10 * fem,
                      ),
                      SizedBox(
                        width: 300 * fem,
                        height: 40 * fem,
                        child: TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            hintText: 'Phase Name',
                            hintStyle: GoogleFonts.roboto(
                              fontSize: 16 * fem,
                              fontWeight: FontWeight.w400,
                              height: 1.5 * fem / fem,
                              color: const Color(0xff808080),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8 * fem),
                              borderSide: const BorderSide(
                                color: Color(0x4c002a5a),
                                width: 1,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8 * fem),
                              borderSide: const BorderSide(
                                color: Color(0x4c002a5a),
                                width: 1,
                              ),
                            ),
                            contentPadding: EdgeInsets.only(
                              left: 16 * fem,
                              top: 14 * fem,
                              bottom: 14 * fem,
                            ),
                          ),
                          style: GoogleFonts.roboto(
                            fontSize: 16 * fem,
                            fontWeight: FontWeight.w400,
                            height: 1.2000000477 * fem / fem,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 20 * fem),
                                child: Text(
                                  "Add Start Date",
                                  style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 14 * fem,
                                      fontWeight: FontWeight.w500,
                                      height: 18 / 20,
                                      color: const Color(0xff000000)),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.only(right: 18 * fem),
                            child: GestureDetector(
                              onTap: () => _selectDate(context),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: SizedBox(
                                  height: 50 * fem,
                                  width: (screenWidth / 2 - 47) * fem,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        flag == false
                                            ? 'Date'
                                            : _dateFormat
                                                .format(selectedDate.toLocal())
                                                .split(' ')[0],
                                        style: GoogleFonts.roboto(
                                          fontSize: 14 * fem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.1725 * fem / fem,
                                          color: flag == false
                                              ? const Color(0xff999999)
                                              : Colors.black,
                                        ),
                                      ),
                                      // const VerticalDivider(
                                      //   thickness: 1,
                                      //   color: Color(0xfff000000),
                                      // ),
                                      const Icon(
                                        Icons.calendar_today,
                                        color: Colors.grey,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  left: 20 * fem,
                                ),
                                child: Text(
                                  "Add Target Date",
                                  style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 14 * fem,
                                      fontWeight: FontWeight.w500,
                                      height: 18 / 20,
                                      color: const Color(0xff000000)),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.only(right: 18 * fem),
                            child: GestureDetector(
                              onTap: () => _selectEndDate(context),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  height: 20 * fem,
                                  width: (screenWidth / 2 - 47.5) * fem,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        flag1 == false
                                            ? 'Date'
                                            : _dateFormat
                                                .format(
                                                    selectedEndDate.toLocal())
                                                .split(' ')[0],
                                        style: GoogleFonts.roboto(
                                          fontSize: 14 * fem,
                                          fontWeight: FontWeight.w400,
                                          //height: 1.1725 * fem / fem,
                                          color: flag1 == false
                                              ? const Color(0xff999999)
                                              : Colors.black,
                                        ),
                                      ),
                                      const Icon(
                                        Icons.calendar_today,
                                        color: Colors.grey,
                                        size: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(top: 30 * fem, right: 20 * fem),
                        child: GestureDetector(
                          onTap: () {
                            // projectDetailsController.addPhase(
                            //     nameController.text.toString(),
                            //     '55',
                            //     '0',
                            //     selectedDate.toLocal().toString().split(' ')[0],
                            //     selectedEndDate
                            //         .toLocal()
                            //         .toString()
                            //         .split(' ')[0],
                            //     token);

                            if (flag == false) {
                              Get.snackbar('Error', 'Please select start date');
                            } else {
                              if (selectedEndDate
                                  .toLocal()
                                  .isBefore(selectedDate.toLocal())) {
                                Get.snackbar('Error',
                                    'End Date should be after Start Date',
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: Colors.blueGrey[800],
                                    colorText: Colors.white);
                              } else {
                                projectDetailsController.addPhase(
                                  nameController.text.toString(),
                                  '${widget.id}',
                                  '0',
                                  selectedDate
                                      .toLocal()
                                      .toString()
                                      .split(' ')[0],
                                  selectedEndDate
                                      .toLocal()
                                      .toString()
                                      .split(' ')[0],
                                  token,
                                );
                              }
                            }
                          },
                          child: Container(
                            width: 80 * fem,
                            height: 32 * fem,
                            decoration: BoxDecoration(
                              border: Border.all(),
                              color: const Color(0xff002A5A),
                              borderRadius: BorderRadius.circular(3 * fem),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                'Create',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  fontSize: 14 * fem,
                                  height: 1.1725 * fem / fem,
                                  color: const Color(0xffffffff),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
