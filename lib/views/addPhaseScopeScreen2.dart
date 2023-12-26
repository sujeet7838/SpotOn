// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spoton/controller/PhaseController.dart';
import 'package:spoton/views/addPhaseScreen2.dart';
import 'package:spoton/views/addPhaseScreen3.dart';

class addPhaseScopeScreen2 extends StatefulWidget {
  const addPhaseScopeScreen2(
      {super.key, required this.name, required this.id, required this.cardId});

  final String name;
  final int id;
  final int cardId;

  @override
  State<addPhaseScopeScreen2> createState() => _addPhaseScopeScreen2State();
}

class _addPhaseScopeScreen2State extends State<addPhaseScopeScreen2> {
  final PhaseController phaseController = Get.put(PhaseController());

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double screenHeight = mediaQuery.size.height;
    final double fem = screenWidth / 375.0;
    return Scaffold(
      endDrawerEnableOpenDragGesture: true,
      backgroundColor: const Color(0xffF5F5F5),
      body: SizedBox(
        height: screenHeight,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: (screenHeight * 0.3) * fem,
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
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        SizedBox(
                          width: 15 * fem,
                        ),
                        const Text(
                          "Company Name",
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            height: 22 / 18,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        SizedBox(
                          width: 60 * fem,
                        ),
                        const Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 25,
                        ),
                        SizedBox(
                          width: 10 * fem,
                        ),
                        const Icon(
                          Icons.notifications_none_sharp,
                          color: Colors.white,
                          size: 25,
                        ),
                        SizedBox(
                          width: 10 * fem,
                        ),
                        const Icon(
                          Icons.settings,
                          color: Colors.white,
                          size: 22,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 60 * fem,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0 * fem),
                      child: Text(
                        "Project Name - ${widget.name}",
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
                      height: 10 * fem,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                        "Apartment",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 16 * fem,
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
                    margin: EdgeInsets.only(left: 20 * fem),
                    child: Text(
                      "Choose Your Scope (Phase-2)",
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 20 * fem,
                        fontWeight: FontWeight.w500,
                        height: 18 / 20,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30 * fem,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 30 * fem),
                        child: Container(
                          height: 30 * fem,
                          width: 30 * fem,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xff002A5A),
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Center(
                            child: Text('1'),
                          ),
                        ),
                      ),
                      Container(
                        height: 1 * fem,
                        width: 105 * fem,
                        color: Colors.grey,
                      ),
                      Container(
                        height: 30 * fem,
                        width: 30 * fem,
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff002A5A)),
                            borderRadius: BorderRadius.circular(30)),
                        child: const Center(child: Text('2')),
                      ),
                      Container(
                        height: 1 * fem,
                        width: 100 * fem,
                        color: Colors.grey,
                      ),
                      Container(
                        height: 30 * fem,
                        width: 30 * fem,
                        decoration: BoxDecoration(
                            border: Border.all(color: const Color(0xff002A5A)),
                            borderRadius: BorderRadius.circular(30)),
                        child: const Center(child: Text('3')),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10 * fem,
                  ),
                  Row(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.only(
                          left: 20 * fem,
                          top: 5 * fem,
                        ),
                        child: Text(
                          "Phase-1",
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 12 * fem,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff818181),
                            height: 12 / 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(top: 5 * fem),
                        child: Text(
                          "Phase-2",
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 12 * fem,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff000000),
                            height: 12 / 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        alignment: Alignment.topRight,
                        margin: EdgeInsets.only(top: 5 * fem, right: 37 * fem),
                        child: Text(
                          "Phase-3",
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 12 * fem,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff818181),
                            height: 12 / 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Obx(
                () => phaseController.isDataLoading.value
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: phaseController.scopeList.value!.data.length,
                        itemBuilder: (context, index) {
                          return Container(
                            color: Colors.white,
                            margin: EdgeInsets.only(
                                left: 15 * fem, right: 15 * fem, top: 10),
                            height: 55 * fem,
                            child: ListTile(
                              title: Text(
                                phaseController
                                    .scopeList.value!.data[index].scopeEntity,
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 17 * fem,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff282828),
                                  height: 18 / 15,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              leading: Image.asset(
                                "assets/edit-tools.png",
                                scale: 3.5,
                              ),
                            ),
                          );
                        }),
              ),
              SizedBox(
                height: 15 * fem,
              ),
              Container(
                alignment: Alignment.bottomRight,
                margin: EdgeInsets.only(right: 15 * fem, bottom: 30 * fem),
                child: SizedBox(
                  width: 90 * fem,
                  height: 40 * fem,
                  child: ElevatedButton(
                    //style:
                    onPressed: () {
                      Get.to(
                        () => addPhaseScreen3(
                          name: widget.name,
                          id: widget.id,
                          cardId: widget.cardId,
                        ),
                        transition: Transition.fade,
                      );
                    },
                    // ignore: sort_child_properties_last
                    child: Text(
                      "Next",
                      style: TextStyle(
                        fontFamily: "Nunito Sans",
                        fontSize: 16 * fem,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xffFFFFFF),
                        height: 20 / 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    style: ElevatedButton.styleFrom(
                      elevation: 15 * fem,
                      backgroundColor: const Color(0xff002A5A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
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
