// ignore_for_file: prefer_const_constructors, camel_case_types
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spoton/controller/WorkerController.dart';


class addWorker extends StatefulWidget {
  const addWorker({super.key});
  @override
  State<addWorker> createState() => _addWorkerState();
}

class _addWorkerState extends State<addWorker> {
  final WorkerController workerController = Get.put(WorkerController());
  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double screenHeight = mediaQuery.size.height;
    final double fem = screenWidth / 375.0;
    return Scaffold(
      backgroundColor: const Color(0xffF1F3F2),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          height: screenHeight,
          child: Padding(
            padding: EdgeInsets.all(20.0 * fem),
            child: Column(
              children: [
                SizedBox(
                  height: 35 * fem,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: 28,
                      ),
                    ),
                    SizedBox(
                      width: 20 * fem,
                    ),
                    Text(
                      "Add Worker",
                      style: TextStyle(
                        fontFamily: "Lato",
                        fontSize: 20 * fem,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff282828),
                        height: 22 / 18,
                      ),
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
                SizedBox(
                  height: 25 * fem,
                ),
                GestureDetector(
                  onTap: () async {
                    var contactStatus = await Permission.contacts.request();
                    if (contactStatus.isGranted) {
                      final contact = await ContactsService.openDeviceContactPicker();
                      if (contact != null) {
                        workerController.updateContact(contact);
                      }
                    } else {
                      print("Permissions not granted.");
                    }
                  },
                  child: Container(
                    width: screenWidth * fem,
                    height: 50 * fem,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        "Select Worker/Labor in Your Contact",
                        style: TextStyle(
                          fontFamily: "Lato",
                          fontSize: 14 * fem,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff999999),
                          height: 17 / 14,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15 * fem,
                ),
                Obx(() =>
                    Visibility(
                      visible: workerController.selectedContact.value != null,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.contacts_rounded),
                              SizedBox(
                                width: 15 * fem,
                              ),
                              Text(
                                workerController.selectedContact.value?.displayName ?? 'No contact selected',
                                style: TextStyle(
                                  fontFamily: "Lato",
                                  fontSize: 14 * fem,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xff282828),
                                  height: 17 / 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ),
                SizedBox(
                  height: 25 * fem,
                ),
                Row(
                  children: [
                    Text(
                      "Workforce (2)",
                      style: TextStyle(
                        fontFamily: "Lato",
                        fontSize: 14 * fem,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff000000),
                        height: 17 / 14,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Spacer(),
                    Container(
                      height: 40 * fem,
                      padding: EdgeInsets.only(
                          left: 5 * fem,
                          right: 5 * fem,
                          top: 5 * fem,
                          bottom: 5 * fem),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(33 * fem),
                          color: Colors.white),
                      child: Row(
                        children: [
                          Icon(
                            Icons.add_circle_outline,
                            size: 20 * fem,
                          ),
                          Text(
                            " Add Workforce",
                            style: TextStyle(
                              fontSize: 14 * fem,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15 * fem,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Worker Type",
                    style: TextStyle(
                      fontFamily: "Lato",
                      fontSize: 15 * fem,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff303030),
                      height: 17 / 14,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  height: 10 * fem,
                ),
                Container(
                  width: screenWidth * fem,
                  height: 40 * fem,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4 * fem),
                      color: Color(0xffFFFFFF)),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(
                  height: 15 * fem,
                ),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Salary",
                          style: TextStyle(
                            fontSize: 14 * fem,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 8 * fem,
                        ),
                        Container(
                          width: 150 * fem,
                          height: 40 * fem,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4 * fem),
                              color: Colors.white),
                          child: TextFormField(
                            decoration:
                                InputDecoration(border: InputBorder.none),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hours per shift",
                          style: TextStyle(
                            fontSize: 14 * fem,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 8 * fem,
                        ),
                        Container(
                          width: 150 * fem,
                          height: 40 * fem,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4 * fem),
                            color: Colors.white,
                          ),
                          child: TextFormField(
                            decoration:
                                InputDecoration(border: InputBorder.none),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width: 320,
                    height: 46,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Color(0xff002a5a),
                    ),
                    child: Center(
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
                SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
