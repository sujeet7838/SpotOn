// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spoton/controller/PhaseController.dart';
import 'package:spoton/views/addPhaseScopeScreen.dart';
import 'package:spoton/views/addPhaseScreen2.dart';

class addPhaseScreen extends StatefulWidget {
  const addPhaseScreen({super.key, required this.name, required this.id, required this.cardId});

  final String name;
  final int id;
  final int cardId;

  @override
  State<addPhaseScreen> createState() => _addPhaseScreenState();
}

class _addPhaseScreenState extends State<addPhaseScreen> {
  String? token;
  final PhaseController phaseController = Get.put(PhaseController());

  loadSharedPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString("token");
    phaseController.fetchProjectDetails(widget.id.toString(),widget.cardId.toString(), token);
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
                      "Choose Your Region (Phase-1)",
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
                            color: const Color(0xff000000),
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
                            color: const Color(0xff818181),
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
              Obx(() =>
                phaseController.isLoading.value
                    ?
                    const Center(
                      child: CircularProgressIndicator(),
                    )
                    : phaseController.noob.value == true
                        ? SizedBox(
                  height: 230 * fem,
                          child: Center(
                              child: Text(
                                "No Data Found",
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 18 * fem,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xff282828),
                                  height: 18 / 15,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                        )
                        :
                ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: phaseController.regionDetails.value!.data.length,
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.white,
                        margin: EdgeInsets.only(
                            left: 15 * fem, right: 15 * fem, top: 10),
                        height: 55 * fem,
                        child: ListTile(
                          title: Text(
                            phaseController.regionDetails.value!.data[index].regionName,
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
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      final TextEditingController _controller =
                          TextEditingController();
                      return AlertDialog(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              20.0,
                            ),
                          ),
                        ),
                        contentPadding: const EdgeInsets.only(
                          top: 10.0,
                        ),
                        content: SingleChildScrollView(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.only(left: 5, right: 5),
                                  child: TextField(
                                    controller: _controller,
                                    decoration: const InputDecoration(
                                      hintText: 'Enter Region',
                                    ),
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  phaseController.addRegion(_controller.text.toString(), widget.id.toString(), widget.cardId.toString(), token);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF033056),
                                  // fixedSize: Size(250, 50),
                                ),
                                child: const Text(
                                  "Submit",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(
                    left: 15 * fem,
                    right: 15 * fem,
                  ),
                  height: 47 * fem,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Container(
                    margin: const EdgeInsets.only(left: 18),
                    child: Row(
                      children: [
                        const Icon(Icons.add),
                        Container(
                          margin: EdgeInsets.only(left: 10 * fem),
                          child: Text(
                            "Add New",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 17 * fem,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff282828),
                              height: 18 / 15,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30 * fem,
              ),
              // Spacer(),
              SizedBox(
                height: 25 * fem,
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
                        () => addPhaseScopeScreen(
                          name: widget.name,
                          id: widget.id,
                          token: token!,
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
