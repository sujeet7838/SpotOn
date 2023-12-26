// ignore_for_file: camel_case_types

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class addTaskScreen extends StatefulWidget {
  const addTaskScreen({super.key});

  @override
  State<addTaskScreen> createState() => _addTaskScreenState();
}

class _addTaskScreenState extends State<addTaskScreen> {
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();

  @override
  void initState() {
    startDate.text = "Start Date";
    super.initState();
    endDate.text = "End Date";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double screenHeight = mediaQuery.size.height;
    final double fem = screenWidth / 375.0;
    return Scaffold(
      backgroundColor: const Color(0xFFF1F3F2),
      body: SizedBox(
        width: double.infinity,
        height: screenHeight,
        child: Padding(
          padding: EdgeInsets.all(20.0 * fem),
          child: Column(
            children: [
              SizedBox(
                height: 10 * fem,
              ),
              Row(
                children: [
                  SizedBox(
                    height: 80 * fem,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(Icons.arrow_back),
                  ),
                  SizedBox(
                    width: 10 * fem,
                  ),
                  Text(
                    "\t\tAdd New Task",
                    style: TextStyle(
                      fontSize: 18 * fem,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15 * fem,
              ),
              Container(
                padding: EdgeInsets.only(left: 15 * fem, right: 15 * fem),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4 * fem),
                ),
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none, hintText: "Task Name"),
                ),
              ),
              SizedBox(
                height: 25 * fem,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2101),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: Color(0xFF3A2BBE), // <-- SEE HERE
                                onPrimary: Colors.white, // <-- SEE HERE
                                onSurface: Colors.blueAccent, // <-- SEE HERE
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  primary: const Color(
                                      0xFF3A2BBE), // button text color
                                ),
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (pickedDate != null) {
                        String formattedDate = DateFormat(
                          'dd/MM/yyyy',
                        ).format(pickedDate);
                        setState(() {
                          startDate.text = formattedDate;
                        });
                      } else {}
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 10 * fem, right: 10 * fem),
                      width: screenWidth / 2.2 * fem,
                      height: 45 * fem,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4 * fem),
                          color: Colors.white),
                      child: Padding(
                        padding: EdgeInsets.all(5.0 * fem),
                        child: Row(
                          children: [
                            Text(
                              startDate.text.toString(),
                              style: TextStyle(
                                fontSize: 15 * fem,
                                fontWeight: FontWeight.w400,
                                color: Colors.black45,
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: EdgeInsets.all(5.0 * fem),
                              child: Container(
                                width: 1 * fem,
                                color: const Color(0xFF565656),
                                height: 28 * fem,
                              ),
                            ),
                            Icon(
                              CupertinoIcons.calendar,
                              size: 20 * fem,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2101),
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: const ColorScheme.light(
                                primary: Color(0xFF3A2BBE), // <-- SEE HERE
                                onPrimary: Colors.white, // <-- SEE HERE
                                onSurface: Colors.blueAccent, // <-- SEE HERE
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  primary: const Color(
                                      0xFF3A2BBE), // button text color
                                ),
                              ),
                            ),
                            child: child!,
                          );
                        },
                      );
                      if (pickedDate != null) {
                        String formattedDate = DateFormat(
                          'dd/MM/yyyy',
                        ).format(pickedDate);
                        setState(
                          () {
                            endDate.text = formattedDate;
                          },
                        );
                      } else {}
                    },
                    child: Container(
                      padding: EdgeInsets.only(left: 10 * fem, right: 10 * fem),
                      width: screenWidth / 2.2 * fem,
                      height: 45 * fem,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4 * fem),
                          color: Colors.white),
                      child: Padding(
                        padding: EdgeInsets.all(5.0 * fem),
                        child: Row(
                          children: [
                            Text(
                              endDate.text.toString(),
                              style: TextStyle(
                                fontSize: 15 * fem,
                                fontWeight: FontWeight.w400,
                                color: Colors.black45,
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: EdgeInsets.all(5.0 * fem),
                              child: Container(
                                width: 1 * fem,
                                color: const Color(0xFF565656),
                                height: 28 * fem,
                              ),
                            ),
                            Icon(
                              CupertinoIcons.calendar,
                              size: 20 * fem,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  width: 320,
                  height: 46,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: const Color(0xff002a5a),
                  ),
                  child: const Center(
                    child: Text(
                      "Done",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
