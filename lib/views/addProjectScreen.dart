import 'package:flutter/material.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spoton/controller/ProperTypeController.dart';
import 'package:spoton/model/PropertyTypeModel.dart';
import 'package:spoton/views/projectListingScreen.dart';
import 'package:spoton/views/welcomeScreen.dart';

class addProjectScreen extends StatefulWidget {
  const addProjectScreen({Key? key}) : super(key: key);

  @override
  State<addProjectScreen> createState() => _addProjectScreenState();
}

class _addProjectScreenState extends State<addProjectScreen> {
  String? selectedPropertyType, token;
  bool flag = false;
  bool flag1 = false;

  final nameController = TextEditingController();
  var selectedId;

  DateTime selectedDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  final DateFormat _dateFormat = DateFormat('dd-MM-yyyy');

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
    propertyTypeController.fetchPropertyTypes(token);
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
    return WillPopScope(
      onWillPop: () async {
        Get.to(() => const welcomeScreen());
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xfff5f5f5),
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            height: screenHeight,
            child: Column(
              children: [
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
                // Container(
                //   alignment: Alignment.centerLeft,
                //   margin: EdgeInsets.only(
                //       top: 50 * fem, left: 20 * fem, right: 20 * fem),
                //   child: ElevatedButton(
                //     onPressed: () async {
                //       final SharedPreferences sharedPreferences =
                //       await SharedPreferences.getInstance();
                //       sharedPreferences.clear();
                //       Get.off(()=> const welcomeScreen());
                //     },
                //     style: ElevatedButton.styleFrom(minimumSize: Size(50 * fem, 30 * fem),
                //       primary: Colors.white,
                //       onPrimary: Colors.black,
                //       textStyle: GoogleFonts.poppins(
                //         fontSize: 12 * fem,
                //         fontWeight: FontWeight.w500,
                //       ),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(5),
                //       ),
                //       padding: const EdgeInsets.symmetric(
                //         horizontal: 10,),
                //         ),
                //         child: const Text("Log Out"),
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: 20 * fem,
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
                  height: 50 * fem,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Project Name',
                      hintStyle: GoogleFonts.roboto(
                        fontSize: 16 * fem,
                        fontWeight: FontWeight.w400,
                        height: 1.8 * fem / fem,
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
                SizedBox(
                  height: 20 * fem,
                ),
                Row(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(left: 20.0 * fem, right: 18 * fem),
                      child: GestureDetector(
                        onTap: () => _selectDate(context),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: 60 * fem,
                            width: (screenWidth / 2 - 47) * fem,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8 * fem),
                              border: Border.all(
                                color: const Color(0x4c002a5a),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  flag == false
                                      ? 'Start Date'
                                      : _dateFormat
                                          .format(selectedDate.toLocal())
                                          .split(' ')[0],
                                  style: GoogleFonts.roboto(
                                    fontSize: 15 * fem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.1725 * fem / fem,
                                    color: flag == false
                                        ? const Color(0xff999999)
                                        : Colors.black,
                                  ),
                                ),
                                const Icon(
                                  Icons.calendar_today,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 20 * fem),
                      child: GestureDetector(
                        onTap: () => _selectEndDate(context),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: 60 * fem,
                            width: (screenWidth / 2 - 47.5) * fem,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8 * fem),
                              border: Border.all(
                                color: const Color(0x4c002a5a),
                                width: 1,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  flag1 == false
                                      ? 'END DATE'
                                      : _dateFormat
                                          .format(selectedEndDate.toLocal())
                                          .split(' ')[0],
                                  style: GoogleFonts.roboto(
                                    fontSize: 15 * fem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.1725 * fem / fem,
                                    color: flag1 == false
                                        ? const Color(0xff999999)
                                        : Colors.black,
                                  ),
                                ),
                                const Icon(
                                  Icons.calendar_today,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20 * fem,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Container(
                    height: 60 * fem,
                    width: screenWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8 * fem),
                      border: Border.all(
                        color: const Color(0x4c002a5a),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Obx(() {
                        if (propertyTypeController.propertyTypes.isEmpty) {
                          return const CircularProgressIndicator(); // Display loading indicator
                        } else {
                          return DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: selectedPropertyType,
                              hint: Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Text(
                                  'Type of Property',
                                  style: TextStyle(
                                    fontSize: 16 * fem,
                                    fontWeight: FontWeight.w400,
                                    height: 1.2000000477 * fem / fem,
                                    color: const Color(0xff808080),
                                  ),
                                ),
                              ),
                              isExpanded: true,
                              onChanged: (String? newValue) {
                                if (newValue == "Others") {
                                  // Show a custom dialog for "others" option
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      String otherText =
                                          ""; // Store the user's input text

                                      return AlertDialog(
                                        title:
                                            const Text("Other Property Type"),
                                        content: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            TextField(
                                              onChanged: (text) {
                                                otherText = text;
                                              },
                                              decoration: const InputDecoration(
                                                hintText:
                                                    "Enter other property type",
                                              ),
                                            ),
                                          ],
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text("Cancel"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          TextButton(
                                            child: const Text("Submit"),
                                            onPressed: () {
                                              // Add the value entered by the user to the property type list
                                              propertyTypeController
                                                  .propertyTypes
                                                  .add(
                                                PropertyTypeModel(
                                                    pkTypeId: 1,
                                                    propertyTypeEntity:
                                                        otherText,
                                                    status: 'success',
                                                    createdAt: DateTime.now()
                                                        .toString()),
                                              );
                                              setState(() {
                                                selectedPropertyType =
                                                    otherText;
                                                selectedId = 1;
                                              });
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  PropertyTypeModel selectedModel =
                                      propertyTypeController.propertyTypes
                                          .firstWhere((model) =>
                                              model.propertyTypeEntity ==
                                              newValue);

                                  setState(() {
                                    selectedPropertyType = newValue;
                                    selectedId = selectedModel.pkTypeId;
                                  });
                                }
                              },
                              items: propertyTypeController.propertyTypes
                                  .map<DropdownMenuItem<String>>(
                                (PropertyTypeModel value) {
                                  return DropdownMenuItem<String>(
                                    value: value.propertyTypeEntity,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text(
                                        value.propertyTypeEntity,
                                        style: TextStyle(
                                          fontSize: 16 * fem,
                                          fontWeight: FontWeight.w400,
                                          height: 1.2000000477 * fem / fem,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),
                            ),
                          );
                        }
                      }),
                    ),
                  ),
                ),
                SizedBox(
                  height: 180 * fem,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const projectListingScreen(),
                            transition: Transition.fadeIn);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 25.0),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "View Projects",
                            style: GoogleFonts.roboto(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff000000),
                              height: 16 / 14,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: TextButton(
                          onPressed: () {
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
                                propertyTypeController.addProject(
                                  nameController.text.toString(),
                                  selectedDate
                                      .toLocal()
                                      .toString()
                                      .split(' ')[0],
                                  selectedEndDate
                                      .toLocal()
                                      .toString()
                                      .split(' ')[0],
                                  selectedId.toString() ?? "1",
                                  token,
                                );
                              }
                            }
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
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
                              child: propertyTypeController.isDataLoading.value
                                  ? const CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(0xffffffff),
                                      ),
                                    )
                                  : Text(
                                      'Save',
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
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
