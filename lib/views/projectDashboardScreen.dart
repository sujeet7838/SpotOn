// ignore_for_file: camel_case_types, unrelated_type_equality_checks, list_remove_unrelated_type

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spoton/controller/ProjectDetailsController.dart';
import 'package:spoton/model/ProjectDetailsModel.dart';
import 'package:spoton/views/addMaterialScreen.dart';
import 'package:spoton/views/addPhaseScreen.dart';
import 'package:http_parser/http_parser.dart';
import 'package:spoton/views/addTaskScreen.dart';
import 'package:spoton/views/addWorkerScreen.dart';
import 'package:spoton/views/paymentOutScreen.dart';
import 'package:spoton/views/welcomeScreen.dart';
import 'package:spoton/views/zoomablePhotoScreen.dart';
import '../controller/PartyController.dart';

class projectDashboardScreen extends StatefulWidget {
  const projectDashboardScreen(
      {super.key, required this.id, required this.projectName});

  final int id;
  final String projectName;

  @override
  State<projectDashboardScreen> createState() => _projectDashboardScreenState();
}

class _projectDashboardScreenState extends State<projectDashboardScreen>
    with SingleTickerProviderStateMixin {
  String? token;
  final ScrollController _scrollController = ScrollController();

  final PartyController partyController = Get.put(PartyController());
  final ProjectDetailsController projectDetailsController =
      Get.put(ProjectDetailsController());
  late TabController _tabController;

  final commentController = TextEditingController();

  final List<File> selectedImages = [];
  final List<File> selectedDocuments = [];
  List<XFile> _selectedImages = [];

  void _selectDocuments(List<XFile> documents) {
    selectedDocuments.clear();
    selectedDocuments.addAll(documents.map((document) => File(document.path)));
  }

  void _selectMessageImages(List<XFile> images) {
    setState(() {
      _selectedImages.addAll(images);
    });
  }

  void _removeMessageImages(XFile image) {
    setState(() {
      _selectedImages.remove(image);
    });
  }

  void _selectImages(List<XFile> images) {
    selectedImages.clear();
    selectedImages.addAll(images.map((image) => File(image.path)));
    _uploadImages();
    projectDetailsController.update();
  }

  void _uploadImages() {
    if (selectedImages.isNotEmpty) {
      final imageFiles = selectedImages.map((file) {
        return http.MultipartFile.fromBytes(
          'files[]', // Field name in the API
          file.readAsBytesSync(),
          filename: file.path.split('/').last,
        );
      }).toList();

      projectDetailsController.uploadImages(
          imageFiles, token!, widget.id.toString());
    }
  }

  void scrollToLastItem() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration:
          const Duration(milliseconds: 500), // adjust the duration as needed
      curve: Curves.easeInOut,
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
    _tabController.addListener(_handleTabChange);
    loadSharedPreferences();
  }

  void _handleTabChange() {
    print("Tab index changed: ${_tabController.index}");
    setState(() {});
  }

  loadSharedPreferences() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString("token");
    projectDetailsController.fetchProjectDetails(widget.id.toString(), token);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double screenHeight = mediaQuery.size.height;
    final double fem = screenWidth / 375.0;
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          height: screenHeight,
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: (screenHeight * 0.36) * fem,
                    color: const Color(0xff002A5A),
                    child: Column(
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
                              width: _tabController.index == 0
                                  ? 30 * fem
                                  : 50 * fem,
                            ),
                            Visibility(
                              visible: _tabController.index == 0,
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                            SizedBox(
                              width: 10 * fem,
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
                        Container(
                          alignment: Alignment.centerRight,
                          margin:
                              EdgeInsets.only(top: 5 * fem, right: 20 * fem),
                          child: ElevatedButton(
                            onPressed: () async {
                              final SharedPreferences sharedPreferences =
                                  await SharedPreferences.getInstance();
                              sharedPreferences.clear();
                              Get.off(() => const welcomeScreen());
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(50 * fem, 30 * fem),
                              primary: Colors.white,
                              onPrimary: Colors.black,
                              textStyle: GoogleFonts.poppins(
                                fontSize: 12 * fem,
                                fontWeight: FontWeight.w500,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                            ),
                            child: const Text("Log Out"),
                          ),
                        ),
                        TabBar(
                          isScrollable: true,
                          controller: _tabController,
                          indicatorWeight: 1,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: Colors.white,
                          indicatorPadding: const EdgeInsets.only(top: 2),
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.white.withOpacity(0.6),
                          labelStyle: GoogleFonts.poppins(
                            fontSize: 12 * fem,
                            fontWeight: FontWeight.w500,
                          ),
                          unselectedLabelStyle: GoogleFonts.poppins(
                            fontSize: 12 * fem,
                            fontWeight: FontWeight.w500,
                          ),
                          tabs: const [
                            Tab(text: "Project"),
                            Tab(text: "Party"),
                            Tab(text: "Transactions"),
                            Tab(text: "Attendance"),
                            Tab(text: "Material"),
                            Tab(text: "Task"),
                            Tab(text: "Photo"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 160,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  color: const Color(0xffF5F5F5),
                  child: TabBarView(controller: _tabController, children: [
                    tab1(),
                    tab2(),
                    tab3(),
                    tab4(),
                    tab5(),
                    tab6(),
                    tab7(),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget tab1() {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double screenHeight = mediaQuery.size.height;
    final double fem = screenWidth / 375.0;
    return Obx(
      () => projectDetailsController.projectDetails.value == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: (screenHeight * 0.15) * fem,
                    color: const Color(0xff002A5A),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 25 * fem,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 280 * fem,
                              child: Padding(
                                padding: EdgeInsets.only(left: 20.0 * fem),
                                child: Text(
                                  "Project Name - ${widget.projectName}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 16 * fem,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                    height: 19 / 16,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "Phase -1",
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 16 * fem,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                height: 25 / 16,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              width: 20 * fem,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10 * fem,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.0 * fem),
                          child: Text(
                            "Property - House",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 12 * fem,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              height: 20 / 12,
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
                  Padding(
                    padding: EdgeInsets.only(left: 20.0 * fem),
                    child: Text(
                      "Knowing Client Preference",
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 18 * fem,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff282828),
                        height: 19 / 16,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    height: 20 * fem,
                  ),
                  Container(
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.only(top: 5.0 * fem, left: 50 * fem),
                          child: Text(
                            projectDetailsController
                                .projectDetails.value!.projectStart,
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 15 * fem,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff303030),
                              height: 20 / 14,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(width: 15 * fem),
                            const Icon(
                              Icons.access_time,
                              color: Color(0xff002A5A),
                            ),
                            SizedBox(width: 10 * fem),
                            Container(
                              height: 0.5,
                              color: Colors.grey,
                              width: screenWidth * 0.8,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 50 * fem,
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 10.0 * fem),
                                child: Text(
                                  projectDetailsController
                                      .projectDetails.value!.projectEnd,
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 14 * fem,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff303030),
                                    height: 20 / 14,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: EdgeInsets.only(right: 8.0 * fem),
                              child: SizedBox(
                                height: 20,
                                child: Checkbox(
                                  value: false,
                                  onChanged: (value) {},
                                  activeColor: const Color(0xff002A5A),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15 * fem,
                  ),
                  Container(
                    color: Colors.white,
                    child: Row(
                      children: [
                        SizedBox(width: 20 * fem),
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.grey[200],
                          child: const Icon(
                            Icons.add,
                            color: Color(0xff002A5A),
                            size: 18,
                          ),
                        ),
                        SizedBox(width: 20 * fem),
                        Flexible(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Add card description",
                              hintStyle: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 14 * fem,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey,
                                height: 20 / 14,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15 * fem,
                  ),
                  Container(
                    color: Colors.white,
                    child: Container(
                      margin: EdgeInsets.only(top: 10 * fem, bottom: 10 * fem),
                      child: Row(
                        children: [
                          SizedBox(width: 20 * fem),
                          CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.grey[200],
                            child: const Icon(
                              Icons.add,
                              color: Color(0xff002A5A),
                              size: 18,
                            ),
                          ),
                          SizedBox(width: 20 * fem),
                          Text(
                            "Invite Members",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 14 * fem,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff303030),
                              height: 20 / 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15 * fem,
                  ),
                  GestureDetector(
                    onTap: () async {
                      List<XFile> images = await ImagePicker().pickMultiImage();
                      if (images.isNotEmpty) {
                        _selectImages(images);
                      }
                    },
                    child: Container(
                      color: Colors.white,
                      child: Container(
                        margin:
                            EdgeInsets.only(top: 10 * fem, bottom: 10 * fem),
                        child: Row(
                          children: [
                            SizedBox(width: 20 * fem),
                            CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.grey[200],
                              child: const Icon(
                                Icons.add,
                                color: Color(0xff002A5A),
                                size: 18,
                              ),
                            ),
                            SizedBox(width: 20 * fem),
                            Text(
                              "Add Images",
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 14 * fem,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff303030),
                                height: 20 / 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15 * fem,
                  ),
                  Visibility(
                    visible: projectDetailsController
                        .projectDetails.value!.images.isNotEmpty,
                    child: Container(
                      height: 40 * fem,
                      margin: EdgeInsets.only(left: 20 * fem),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: projectDetailsController
                            .projectDetails.value!.images.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => ZoomablePhoto(
                                    imageUrl: projectDetailsController
                                        .projectDetails
                                        .value!
                                        .images[index]
                                        .mediaUrl));
                              },
                              child: Image.network(projectDetailsController
                                  .projectDetails
                                  .value!
                                  .images[index]
                                  .mediaUrl),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15 * fem,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          final TextEditingController _phaseController =
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
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 5),
                                      child: TextField(
                                        controller: _phaseController,
                                        decoration: const InputDecoration(
                                          hintText: 'Enter Phase',
                                        ),
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      projectDetailsController.addPhase(
                                          _phaseController.text.toString(),
                                          widget.id.toString(),
                                          "0",
                                          '',
                                          '',
                                          token);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF033056),
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
                      color: Colors.white,
                      child: Container(
                        margin:
                            EdgeInsets.only(top: 10 * fem, bottom: 10 * fem),
                        child: Row(
                          children: [
                            SizedBox(width: 20 * fem),
                            CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.grey[200],
                              child: const Icon(
                                Icons.add,
                                color: Color(0xff002A5A),
                                size: 18,
                              ),
                            ),
                            SizedBox(width: 20 * fem),
                            Text(
                              "Add Phase",
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 14 * fem,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff303030),
                                height: 20 / 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15 * fem,
                  ),
                  MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: projectDetailsController
                            .projectDetails.value!.cards.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                                left: 20.0 * fem,
                                right: 20.0 * fem,
                                bottom: 10 * fem),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(() => addPhaseScreen(
                                      name: projectDetailsController
                                          .projectDetails
                                          .value!
                                          .cards[index]
                                          .cardName
                                          .toString(),
                                      id: widget.id,
                                      cardId: projectDetailsController
                                          .projectDetails
                                          .value!
                                          .cards[index]
                                          .cardId,
                                    ));
                              },
                              child: Container(
                                color: Colors.white,
                                child: Container(
                                  margin: EdgeInsets.only(
                                      top: 10 * fem, bottom: 10 * fem),
                                  child: Row(
                                    children: [
                                      SizedBox(width: 20 * fem),
                                      Text(
                                        projectDetailsController.projectDetails
                                            .value!.cards[index].cardName
                                            .toString(),
                                        style: TextStyle(
                                          fontFamily: "Roboto",
                                          fontSize: 14 * fem,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xff303030),
                                          height: 20 / 14,
                                        ),
                                      ),
                                      const Spacer(),
                                      Visibility(
                                        visible: projectDetailsController
                                                .projectDetails
                                                .value!
                                                .cards[index]
                                                .cardName !=
                                            "Phase 1",
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          size: 14 * fem,
                                          color: const Color(0xff282828),
                                        ),
                                      ),
                                      Visibility(
                                        visible: projectDetailsController
                                                .projectDetails
                                                .value!
                                                .cards[index]
                                                .cardName ==
                                            "Phase 1",
                                        child: Text(
                                          "Completed",
                                          style: TextStyle(
                                            fontFamily: "Roboto",
                                            fontSize: 14 * fem,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.green,
                                            height: 20 / 14,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 20 * fem),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 15 * fem,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 20.0 * fem),
                        child: Text(
                          "Activity",
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 20 * fem,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff303030),
                            height: 20 / 16,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.edit,
                        size: 20 * fem,
                        color: const Color(0xff282828),
                      ),
                      SizedBox(
                        width: 10 * fem,
                      ),
                      Icon(
                        Icons.delete_sharp,
                        size: 20 * fem,
                        color: const Color(0xff282828),
                      ),
                      SizedBox(
                        width: 20 * fem,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10 * fem,
                  ),
                  Obx(
                    () => Visibility(
                      visible: projectDetailsController
                          .projectDetails.value!.activities.isNotEmpty,
                      child: SizedBox(
                        height: (screenHeight * 0.5) * fem,
                        child: ListView.builder(
                          controller: _scrollController,
                          shrinkWrap: true,
                          itemCount: projectDetailsController
                              .projectDetails.value!.activities.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(bottom: 10.0 * fem),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 25 * fem,
                                  ),
                                  CircleAvatar(
                                    backgroundColor: const Color(0xff0093ED),
                                    backgroundImage: NetworkImage(
                                        projectDetailsController
                                            .projectDetails
                                            .value!
                                            .activities[index]
                                            .profileImage
                                            .toString()),
                                  ),
                                  SizedBox(
                                    width: 10 * fem,
                                  ),
                                  Container(
                                    width: screenWidth * 0.7,
                                    color: Colors.white,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10 * fem,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.only(left: 10.0 * fem),
                                          child: Text(
                                            projectDetailsController
                                                .projectDetails
                                                .value!
                                                .activities[index]
                                                .username
                                                .toString(),
                                            style: TextStyle(
                                              fontFamily: "Roboto",
                                              fontSize: 16 * fem,
                                              fontWeight: FontWeight.w500,
                                              color: const Color(0xff000000),
                                              height: 20 / 14,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10 * fem,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Text(
                                            projectDetailsController
                                                .projectDetails
                                                .value!
                                                .activities[index]
                                                .comment
                                                .toString(),
                                            style: TextStyle(
                                              fontFamily: "Roboto",
                                              fontSize: 14 * fem,
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xff999999),
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10 * fem,
                                        ),
                                        Visibility(
                                            visible: projectDetailsController
                                                    .projectDetails
                                                    .value!
                                                    .activities[index]
                                                    .images
                                                    .isEmpty
                                                ? false
                                                : true,
                                            child: SizedBox(
                                              height: 30 * fem,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount:
                                                    projectDetailsController
                                                        .projectDetails
                                                        .value!
                                                        .activities[index]
                                                        .images
                                                        .length,
                                                itemBuilder:
                                                    (context, imageindex) {
                                                  return Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 10.0 * fem),
                                                    child: CircleAvatar(
                                                      backgroundImage:
                                                          NetworkImage(
                                                        projectDetailsController
                                                            .projectDetails
                                                            .value!
                                                            .activities[index]
                                                            .images[imageindex]
                                                            .toString(),
                                                      ),
                                                      radius: 15,
                                                    ),
                                                  );
                                                },
                                              ),
                                            )),
                                        SizedBox(
                                          height: 10 * fem,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Text(
                                            "Today at 3:45pm",
                                            style: TextStyle(
                                              fontFamily: "Roboto",
                                              fontSize: 12 * fem,
                                              fontWeight: FontWeight.w400,
                                              color: const Color(0xff303030),
                                              height: 20 / 12,
                                            ),
                                            textAlign: TextAlign.left,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20 * fem,
                  ),
                  Container(
                    width: screenWidth,
                    color: Colors.white,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 20 * fem,
                        ),
                        Container(
                          margin:
                              EdgeInsets.only(top: 10 * fem, bottom: 10 * fem),
                          child: CircleAvatar(
                            backgroundColor: const Color(0xff0093ED),
                            backgroundImage: NetworkImage(
                                projectDetailsController.projectDetails.value!
                                        .activities.isEmpty
                                    ? ""
                                    : projectDetailsController.projectDetails
                                        .value!.activities[0].profileImage
                                        .toString()),
                          ),
                        ),
                        SizedBox(
                          width: 10 * fem,
                        ),
                        SizedBox(
                          width: screenWidth * 0.6,
                          child: TextField(
                            controller: commentController,
                            decoration: InputDecoration(
                              hintText: "Add a comment",
                              hintStyle: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 16 * fem,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff999999),
                                height: 20 / 16,
                              ),
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10 * fem,
                        ),
                        GestureDetector(
                          onTap: () async {
                            List<XFile> selectedImages = _selectedImages;
                            if (commentController.text.isEmpty &&
                                selectedImages.isEmpty) {
                              // No text and no photos, do nothing or show an error message
                              return;
                            }

                            List<http.MultipartFile> imageFiles = [];
                            for (var image in selectedImages) {
                              File file = File(image.path);
                              http.MultipartFile multipartFile =
                                  http.MultipartFile.fromBytes(
                                'files[]', // Field name
                                await file.readAsBytes(),
                                filename: file.path.split('/').last,
                                contentType: MediaType('image',
                                    'jpg'), // Adjust the media type accordingly
                              );
                              imageFiles.add(multipartFile);
                            }

                            String comment = commentController.text.toString();

                            projectDetailsController.postCommentWithFiles(
                              widget.id,
                              comment,
                              imageFiles,
                              token.toString(),
                            );

                            commentController.clear();
                            setState(() {
                              _selectedImages.clear();
                            });
                          },
                          child: Icon(
                            Icons.send_sharp,
                            size: 20 * fem,
                            color: const Color(0xff282828),
                          ),
                        ),
                        SizedBox(
                          width: 10 * fem,
                        ),
                        GestureDetector(
                          onTap: () async {
                            List<XFile> images =
                                await ImagePicker().pickMultiImage();
                            if (images.isNotEmpty) {
                              _selectDocuments(images);
                              _selectMessageImages(images);
                            }
                          },
                          child: Icon(
                            Icons.attach_file_sharp,
                            size: 20 * fem,
                            color: const Color(0xff282828),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30 * fem,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _selectedImages.map((image) {
                        File imageFile = File(image.path);
                        return Stack(
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                image: DecorationImage(
                                  image: FileImage(imageFile),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () => _removeMessageImages(image),
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget tab2() {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double screenHeight = mediaQuery.size.height;
    final double fem = screenWidth / 375.0;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: (screenHeight * 0.15) * fem,
            color: const Color(0xff002A5A),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 25 * fem,
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20.0 * fem),
                      child: Text(
                        "project - Gitanjali",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 18 * fem,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          height: 21 / 18,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "Manage Access",
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 11 * fem,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        height: 20 / 10,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10 * fem,
                    ),
                  ],
                ),
                SizedBox(
                  height: 10 * fem,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0 * fem),
                  child: Text(
                    "Apartment",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 14 * fem,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      height: 20 / 14,
                    ),
                    textAlign: TextAlign.left,
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 18.0 * fem, left: 20 * fem),
                child: Text(
                  "Manager : 1 ",
                  style: TextStyle(
                    fontSize: 16 * fem,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff303030),
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(top: 18.0 * fem, right: 20 * fem),
                child: Text(
                  "Workers : 12 ",
                  style: TextStyle(
                    fontSize: 16 * fem,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff303030),
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20 * fem,
          ),
          Container(
            width: screenWidth,
            height: 0.5,
            color: Colors.grey,
          ),
          SizedBox(
            height: 20 * fem,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: (screenHeight * 0.15) * fem,
                width: (screenHeight * 0.20) * fem,
                color: const Color(0xffE6EAEF),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 13 * fem,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0 * fem),
                      child: Text(
                        "Total Material Cost",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 14 * fem,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          height: 20 / 14,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: 5 * fem,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 13.0 * fem),
                      child: Text(
                        "₹2,000",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 14 * fem,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          height: 20 / 14,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: 20 * fem,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10 * fem,
                        ),
                        CircleAvatar(
                          radius: 10 * fem,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.add,
                            size: 15 * fem,
                          ),
                        ),
                        SizedBox(
                          width: 10 * fem,
                        ),
                        Text(
                          "Add Material",
                          style: TextStyle(
                            fontFamily: "Nunito Sans",
                            fontSize: 12 * fem,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff999999),
                            height: 17 / 12,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: (screenHeight * 0.15) * fem,
                width: (screenHeight * 0.20) * fem,
                color: const Color(0xffE6EAEF),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 13 * fem,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10.0 * fem),
                      child: Text(
                        "Total Salary Cost",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 14 * fem,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          height: 20 / 14,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: 5 * fem,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 13.0 * fem),
                      child: Text(
                        "₹0",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 14 * fem,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          height: 20 / 14,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      height: 20 * fem,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10 * fem,
                        ),
                        CircleAvatar(
                          radius: 10 * fem,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.add,
                            size: 15 * fem,
                          ),
                        ),
                        SizedBox(
                          width: 10 * fem,
                        ),
                        Text(
                          "Add Attendance",
                          style: TextStyle(
                            fontFamily: "Nunito Sans",
                            fontSize: 12 * fem,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xff999999),
                            height: 17 / 12,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20 * fem,
          ),
          Obx(
            () => Row(
              children: [
                SizedBox(
                  width: 25 * fem,
                ),
                GestureDetector(
                  onTap: () {
                    partyController.changeIndex(0);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: partyController.index == 0
                          ? Colors.white
                          : Colors.transparent,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 10.0 * fem,
                          right: 10 * fem,
                          top: 2 * fem,
                          bottom: 2 * fem),
                      child: Text(
                        "Active Party",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 15 * fem,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff232323),
                          height: 24 / 12,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10 * fem,
                ),
                GestureDetector(
                  onTap: () {
                    partyController.changeIndex(1);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(color: Colors.white),
                      color: partyController.index == 1
                          ? Colors.white
                          : Colors.transparent,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: 10.0 * fem,
                          right: 10 * fem,
                          top: 2 * fem,
                          bottom: 2 * fem),
                      child: Text(
                        "Hidden Party",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 15 * fem,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                          height: 24 / 12,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  "Balance",
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontSize: 14 * fem,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff999999),
                    height: 24 / 12,
                  ),
                  textAlign: TextAlign.right,
                ),
                SizedBox(
                  width: 20 * fem,
                ),
              ],
            ),
          ),
          Obx(
            () => Visibility(
              visible: partyController.index == 0 ? true : false,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 4.0 * fem),
                    child: Container(
                      height: (screenHeight * 0.1) * fem,
                      width: screenWidth,
                      color: Colors.white,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 25 * fem,
                            ),
                            CircleAvatar(
                              backgroundColor: const Color(0xff002A5A),
                              child: Text(
                                "KR",
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 18 * fem,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  height: 21 / 18,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(
                              width: 20 * fem,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 12 * fem,
                                ),
                                Text(
                                  "Kakali Roy",
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 14 * fem,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff282828),
                                    height: 24 / 14,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  "9876543210",
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 13 * fem,
                                    fontWeight: FontWeight.w300,
                                    color: const Color(0xff565656),
                                    height: 24 / 13,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "₹00",
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 14 * fem,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.green,
                                    height: 24 / 14,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 15 * fem,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 30 * fem,
                            ),
                          ]),
                    ),
                  );
                },
              ),
            ),
          ),
          Obx(
            () => Visibility(
              visible: partyController.index == 1 ? true : false,
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 4.0 * fem),
                    child: Container(
                      height: (screenHeight * 0.1) * fem,
                      width: screenWidth,
                      color: Colors.white,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 25 * fem,
                            ),
                            CircleAvatar(
                              backgroundColor: const Color(0xff002A5A),
                              child: Text(
                                "KR",
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 18 * fem,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  height: 21 / 18,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(
                              width: 20 * fem,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 12 * fem,
                                ),
                                Text(
                                  "Kakali Roy",
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 14 * fem,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff282828),
                                    height: 24 / 14,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  "9876543210",
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 13 * fem,
                                    fontWeight: FontWeight.w300,
                                    color: const Color(0xff565656),
                                    height: 24 / 13,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "₹00",
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 14 * fem,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.green,
                                    height: 24 / 14,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  size: 15 * fem,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 30 * fem,
                            ),
                          ]),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget tab3() {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double screenHeight = mediaQuery.size.height;
    final double fem = screenWidth / 375.0;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 260 * fem,
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: (screenHeight * 0.20) * fem,
                      width: screenWidth,
                      color: const Color(0xff002A5A),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 25 * fem,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20.0 * fem),
                            child: Text(
                              "project - Gitanjali",
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 18 * fem,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                height: 21 / 18,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(
                            height: 10 * fem,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20.0 * fem),
                            child: Text(
                              "Apartment",
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 14 * fem,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                height: 20 / 14,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      top: 100 * fem,
                      left: 20 * fem,
                      right: 20 * fem,
                      child: SizedBox(
                        height: 150 * fem,
                        width: screenWidth * fem,
                        child: Material(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0 * fem)),
                          elevation: 2 * fem,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 30, bottom: 10),
                                child: Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Balance",
                                          style: TextStyle(
                                            fontFamily: "Roboto",
                                            fontSize: 16 * fem,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xff999999),
                                            height: 17 / 14,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        SizedBox(
                                          height: 6 * fem,
                                        ),
                                        Text(
                                          "₹ 20",
                                          style: TextStyle(
                                            fontFamily: "Roboto",
                                            fontSize: 14 * fem,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xff565656),
                                            height: 15 / 13,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    Container(
                                      width: 2 * fem,
                                      height: 40 * fem,
                                      color: const Color(0x66DAD8D8),
                                    ),
                                    const Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Total In',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: const Color(0xFF999999),
                                            fontSize: 16 * fem,
                                            fontFamily: 'Nunito Sans',
                                            fontWeight: FontWeight.w600,
                                            height: 1.20 * fem,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5 * fem,
                                        ),
                                        Text(
                                          '₹ 20',
                                          style: TextStyle(
                                            color: const Color(0xFF02B242),
                                            fontSize: 14 * fem,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )
                                      ],
                                    ),
                                    const Spacer(),
                                    Container(
                                      width: 2 * fem,
                                      height: 40 * fem,
                                      color: const Color(0x66DAD8D8),
                                    ),
                                    const Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Total Out',
                                          textAlign: TextAlign.right,
                                          style: TextStyle(
                                            color: const Color(0xFF999999),
                                            fontSize: 16 * fem,
                                            fontFamily: 'Nunito Sans',
                                            fontWeight: FontWeight.w600,
                                            height: 1.20 * fem,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5 * fem,
                                        ),
                                        Text(
                                          '₹ 20',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: const Color(0xFFF6151E),
                                            fontSize: 14 * fem,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: 305 * fem,
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                      width: 0.50 * fem,
                                      strokeAlign: BorderSide.strokeAlignCenter,
                                      color: const Color(0x66DAD8D8),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 15, top: 10, bottom: 5),
                                child: Row(
                                  children: [
                                    Text(
                                      'Total Expenses',
                                      style: TextStyle(
                                        color: const Color(0xFF303030),
                                        fontSize: 15 * fem,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '₹ 20',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: const Color(0xFF282828),
                                        fontSize: 15 * fem,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 85 * fem,
                  height: 30 * fem,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                          width: 0.50 * fem, color: const Color(0x33C1C7D0)),
                      borderRadius: BorderRadius.circular(33 * fem),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.filter_list,
                        size: 17 * fem,
                      ),
                      Text(
                        ' Filter',
                        style: TextStyle(
                          color: const Color(0xFF232323),
                          fontSize: 15 * fem,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      enableDrag: true,
                      //elevation: 10,
                      context: context,
                      // isScrollControlled: true,
                      //backgroundColor: Colors.transparent,
                      builder: (ctx) => Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            SizedBox(
                              width: screenWidth * fem,
                              child: Row(
                                children: [
                                  Text(
                                    'Add Transaction',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20 * fem,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Icon(
                                    Icons.south_west,
                                    //Icons.north_east,
                                    size: 18 * fem, weight: 5,
                                    color: const Color(0xFF059000),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Icon(
                                      Icons.close,
                                      //Icons.north_east,
                                      size: 25 * fem,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10 * fem,
                            ),
                            Container(
                              width: 335 * fem,
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 0.50 * fem,
                                    strokeAlign: BorderSide.strokeAlignCenter,
                                    color: Colors.black
                                        .withOpacity(0.10000000149011612),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10 * fem,
                            ),
                            SizedBox(
                              height: 325,
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  itemCount: 15,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 5, top: 5),
                                      child: Container(
                                        width: 335 * fem,
                                        height: 43 * fem,
                                        decoration: ShapeDecoration(
                                          color: const Color(0x1EFD0000),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      4 * fem)),
                                        ),
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 10 * fem,
                                            ),
                                            Container(
                                              width: 26,
                                              height: 26,
                                              decoration: const ShapeDecoration(
                                                color: Colors.white,
                                                shape: OvalBorder(),
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "₹",
                                                    style: TextStyle(
                                                      fontSize: 12 * fem,
                                                      color: const Color(
                                                          0xFF059000),
                                                    ),
                                                  ),
                                                  Icon(
                                                    Icons.south_west,
                                                    //Icons.north_east,
                                                    size: 10 * fem,
                                                    color:
                                                        const Color(0xFF059000),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10 * fem,
                                            ),
                                            Text(
                                              'Payment Out',
                                              style: TextStyle(
                                                color: const Color(0xFFFD0000),
                                                fontSize: 15 * fem,
                                                fontFamily: 'Roboto',
                                                fontWeight: FontWeight.w400,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: 150 * fem,
                    height: 30 * fem,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 0.50 * fem, color: const Color(0x33C1C7D0)),
                        borderRadius: BorderRadius.circular(33 * fem),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_circle_outline,
                          size: 15 * fem,
                        ),
                        Text(
                          ' Add Transaction',
                          style: TextStyle(
                            color: const Color(0xFF232323),
                            fontSize: 15 * fem,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                            height: 2 * fem,
                            letterSpacing: 0.24 * fem,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      width: 335 * fem,
                      height: 80 * fem,
                      decoration: const BoxDecoration(color: Colors.white),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10 * fem,
                          ),
                          Container(
                            width: 50 * fem,
                            height: 50 * fem,
                            decoration: const ShapeDecoration(
                              color: Color(0xFFCDE9CC),
                              shape: OvalBorder(),
                            ),
                            child: Center(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "₹",
                                    style: TextStyle(
                                      fontSize: 20 * fem,
                                      color: const Color(0xFF059000),
                                    ),
                                  ),
                                  Icon(
                                    Icons.south_west,
                                    //Icons.north_east,
                                    size: 15 * fem,
                                    color: const Color(0xFF059000),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 12 * fem,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '23 May, Payment In',
                                    style: TextStyle(
                                      color: const Color(0xFF808080),
                                      fontSize: 12 * fem,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w400,
                                      height: 1.67 * fem,
                                      letterSpacing: 0.24 * fem,
                                    ),
                                  ),
                                  Icon(
                                    Icons.south_west,
                                    //Icons.north_east,
                                    size: 15 * fem,
                                    color: const Color(0xFF059000),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: (screenWidth - 97) * fem,
                                child: Row(
                                  children: [
                                    Text(
                                      'Others',
                                      style: TextStyle(
                                        color: const Color(0xFF303030),
                                        fontSize: 14 * fem,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        height: 1.43 * fem,
                                        letterSpacing: 0.28 * fem,
                                      ),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '₹00',
                                      style: TextStyle(
                                        color: const Color(0xFF059000),
                                        fontSize: 14 * fem,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10 * fem,
                                    )
                                  ],
                                ),
                              ),
                              Text(
                                'Sent',
                                style: TextStyle(
                                  color: const Color(0xFF808080),
                                  fontSize: 12 * fem,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  height: 1.67 * fem,
                                  letterSpacing: 0.24 * fem,
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
          SizedBox(
            height: 15 * fem,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(() => const addMaterial());
                  },
                  child: Container(
                    height: 40 * fem,
                    width: 160 * fem,
                    decoration: ShapeDecoration(
                      color: const Color(0xFF002A5A),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5 * fem)),
                    ),
                    child: Center(
                      child: Text(
                        'Material Purchase',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15 * fem,
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const paymentOutScreen());
                  },
                  child: Container(
                    height: 40 * fem,
                    width: 160 * fem,
                    decoration: ShapeDecoration(
                      color: const Color(0xFFFD0000),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5 * fem)),
                    ),
                    child: Center(
                      child: Text(
                        'Payment Out',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15 * fem,
                          fontFamily: 'Nunito Sans',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget tab4() {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double screenHeight = mediaQuery.size.height;
    final double fem = screenWidth / 375.0;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: (screenHeight * 0.20) * fem,
            color: const Color(0xff002A5A),
            child: SizedBox(
              height: 260 * fem,
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: (screenHeight * 0.20) * fem,
                        width: screenWidth,
                        color: const Color(0xff002A5A),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 15 * fem,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 20.0 * fem),
                                  child: Text(
                                    "project - Gitanjali",
                                    style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 18 * fem,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                      height: 21 / 18,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                const Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => const addWorker(),
                                        transition: Transition.rightToLeft);
                                  },
                                  child: Container(
                                    height: 40 * fem,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.circular(20 * fem),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 8 * fem,
                                        ),
                                        const Icon(
                                          Icons.add_circle_outline_sharp,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                        SizedBox(
                                          width: 10 * fem,
                                        ),
                                        Text(
                                          "Add Worker",
                                          style: TextStyle(
                                            fontFamily: "Roboto",
                                            fontSize: 11 * fem,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white,
                                            height: 24 / 11,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        SizedBox(
                                          width: 10 * fem,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20.0 * fem),
                              child: Text(
                                "Apartment",
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 14 * fem,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                  height: 20 / 14,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        top: 100 * fem,
                        left: 20 * fem,
                        right: 20 * fem,
                        child: SizedBox(
                          height: 135 * fem,
                          width: screenWidth * fem,
                          child: Material(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(10.0 * fem)),
                            elevation: 2 * fem,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(width: 30 * fem),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        size: 20 * fem,
                                      ),
                                    ),
                                    SizedBox(width: 70 * fem),
                                    Padding(
                                      padding: EdgeInsets.only(top: 20.0 * fem),
                                      child: Text(
                                        "24 May, Wed",
                                        style: TextStyle(
                                          fontFamily: "Lato",
                                          fontSize: 18 * fem,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xff303030),
                                          height: 17 / 14,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20.0),
                                      child: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 20 * fem,
                                      ),
                                    ),
                                    SizedBox(width: 20 * fem),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.0 * fem,
                                      right: 20 * fem,
                                      top: 20 * fem),
                                  child: const Divider(),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(children: [
                                      Text(
                                        "Present",
                                        style: TextStyle(
                                          fontFamily: "Lato",
                                          fontSize: 15 * fem,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xff999999),
                                          height: 16 / 13,
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      SizedBox(height: 5 * fem),
                                      Text(
                                        "1",
                                        style: TextStyle(
                                          fontFamily: "Roboto",
                                          fontSize: 15 * fem,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xff059100),
                                          height: 15 / 13,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ]),
                                    Container(
                                      width: 0.5,
                                      height: 40,
                                      color: Colors.grey,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Absent",
                                          style: TextStyle(
                                            fontFamily: "Lato",
                                            fontSize: 15 * fem,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xff999999),
                                            height: 16 / 13,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        SizedBox(height: 5 * fem),
                                        Text(
                                          "1",
                                          style: TextStyle(
                                            fontFamily: "Roboto",
                                            fontSize: 15 * fem,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xfffe0000),
                                            height: 15 / 13,
                                          ),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                    Container(
                                      width: 0.5,
                                      height: 40,
                                      color: Colors.grey,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Day's Salary",
                                          style: TextStyle(
                                            fontFamily: "Lato",
                                            fontSize: 15 * fem,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xff999999),
                                            height: 16 / 13,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        SizedBox(height: 5 * fem),
                                        Text(
                                          "₹ 1000",
                                          style: TextStyle(
                                            fontFamily: "Lato",
                                            fontSize: 15 * fem,
                                            fontWeight: FontWeight.w400,
                                            color: const Color(0xff000000),
                                            height: 16 / 13,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 80 * fem),
          ListView.builder(
            shrinkWrap: true,
            itemCount: 5,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(left: 20.0 * fem, right: 20 * fem),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 18.0 * fem, left: 20 * fem),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Biraj Das I Labor",
                                  style: TextStyle(
                                    fontFamily: "Lato",
                                    fontSize: 16 * fem,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff303030),
                                    height: 20 / 14,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  "₹500 per day",
                                  style: TextStyle(
                                    fontFamily: "Lato",
                                    fontSize: 13 * fem,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff818181),
                                    height: 20 / 12,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(height: 10 * fem),
                                Row(
                                  children: [
                                    Container(
                                      width: 60 * fem,
                                      height: 30 * fem,
                                      decoration: BoxDecoration(
                                        color: index == 1
                                            ? Colors.green[800]
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 0.5,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Present",
                                          style: TextStyle(
                                            fontFamily: "Lato",
                                            fontSize: 12 * fem,
                                            fontWeight: FontWeight.w400,
                                            color: index == 1
                                                ? Colors.white
                                                : const Color(0xff303030),
                                            height: 20 / 12,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10 * fem),
                                    Container(
                                      width: 60 * fem,
                                      height: 30 * fem,
                                      decoration: BoxDecoration(
                                        color: index == 2
                                            ? Colors.red[800]
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 0.5,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "Absent",
                                          style: TextStyle(
                                            fontFamily: "Lato",
                                            fontSize: 12 * fem,
                                            fontWeight: FontWeight.w400,
                                            color: index == 2
                                                ? Colors.white
                                                : const Color(0xff303030),
                                            height: 20 / 12,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10 * fem),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Column(
                            children: [
                              SizedBox(height: 15 * fem),
                              Text(
                                "₹0",
                                style: TextStyle(
                                  fontFamily: "Lato",
                                  fontSize: 16 * fem,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff818181),
                                  height: 20 / 14,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                "1 shift",
                                style: TextStyle(
                                  fontFamily: "Lato",
                                  fontSize: 14 * fem,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff818181),
                                  height: 20 / 14,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              SizedBox(height: 10 * fem),
                              CircleAvatar(
                                backgroundColor: const Color(0xffF4FAFF),
                                radius: 10 * fem,
                                child: Icon(Icons.add,
                                    color: const Color(0xff002A5A),
                                    size: 20 * fem),
                              ),
                            ],
                          ),
                          SizedBox(width: 20 * fem),
                        ],
                      ),
                      SizedBox(height: 10 * fem),
                      Padding(
                        padding:
                            EdgeInsets.only(left: 10.0 * fem, right: 10 * fem),
                        child: const Divider(),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 20 * fem),
        ],
      ),
    );
  }

  Widget tab5() {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double screenHeight = mediaQuery.size.height;
    final double fem = screenWidth / 375.0;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: (screenHeight * 0.15) * fem,
            color: const Color(0xff002A5A),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15 * fem,
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20.0 * fem),
                      child: Text(
                        "project - Gitanjali",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 18 * fem,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          height: 21 / 18,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const addMaterial());
                      },
                      child: Container(
                        height: 40 * fem,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20 * fem),
                          border: Border.all(
                            color: Colors.white,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 8 * fem,
                            ),
                            const Icon(
                              Icons.add_circle_outline_sharp,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10 * fem,
                            ),
                            Text(
                              "Add Material",
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 11 * fem,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                height: 24 / 11,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(
                              width: 10 * fem,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5 * fem,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0 * fem),
                  child: Text(
                    "Apartment",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 14 * fem,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      height: 20 / 14,
                    ),
                    textAlign: TextAlign.left,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 30 * fem,
          ),
          Material(
            color: Colors.transparent,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 30.0 * fem),
                  child: Text(
                    "Materials",
                    style: TextStyle(
                      fontFamily: "Lato",
                      fontSize: 16 * fem,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff303030),
                      height: 20 / 14,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  width: 60 * fem,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Qty",
                        style: TextStyle(
                          fontFamily: "Lato",
                          fontSize: 16 * fem,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff282828),
                          height: 20 / 12,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(width: 20 * fem),
                      Text(
                        "Price",
                        style: TextStyle(
                          fontFamily: "Lato",
                          fontSize: 16 * fem,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff282828),
                          height: 20 / 12,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(width: 20 * fem),
                      Text(
                        "Delivery Date",
                        style: TextStyle(
                          fontFamily: "Lato",
                          fontSize: 16 * fem,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff282828),
                          height: 20 / 12,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(width: 10 * fem),
                    ]),
              ],
            ),
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 15.0 * fem),
                child: SizedBox(
                  height: 50 * fem,
                  child: Material(
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 30.0 * fem),
                          child: Text(
                            "Windows",
                            style: TextStyle(
                              fontFamily: "Lato",
                              fontSize: 16 * fem,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff303030),
                              height: 20 / 14,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        SizedBox(
                          width: 70 * fem,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "5",
                              style: TextStyle(
                                fontFamily: "Lato",
                                fontSize: 16 * fem,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff282828),
                                height: 20 / 12,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(width: 20 * fem),
                            Text(
                              "₹2000",
                              style: TextStyle(
                                fontFamily: "Lato",
                                fontSize: 16 * fem,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff282828),
                                height: 20 / 12,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(width: 20 * fem),
                            Text(
                              "16-Jun-2023",
                              style: TextStyle(
                                fontFamily: "Lato",
                                fontSize: 16 * fem,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff282828),
                                height: 20 / 12,
                              ),
                              textAlign: TextAlign.left,
                            ),
                            SizedBox(width: 10 * fem),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget tab6() {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double screenHeight = mediaQuery.size.height;
    final double fem = screenWidth / 375.0;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 200 * fem,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: (screenHeight * 0.15) * fem,
                  color: const Color(0xff002A5A),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15 * fem,
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 20.0 * fem),
                            child: Text(
                              "project - Gitanjali",
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 18 * fem,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                                height: 21 / 18,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {
                              Get.to(
                                () => const addTaskScreen(),
                              );
                            },
                            child: Container(
                              height: 40 * fem,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20 * fem),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 8 * fem,
                                  ),
                                  const Icon(
                                    Icons.add_circle_outline_sharp,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 10 * fem,
                                  ),
                                  Text(
                                    "Add Task",
                                    style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 11 * fem,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                      height: 24 / 11,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(
                                    width: 10 * fem,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20 * fem,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5 * fem,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0 * fem),
                        child: Text(
                          "Apartment",
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 14 * fem,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            height: 20 / 14,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      )
                    ],
                  ),
                ),
                Positioned(
                  top: 100 * fem,
                  left: 20 * fem,
                  right: 20 * fem,
                  child: SizedBox(
                    height: 88 * fem,
                    width: screenWidth * fem,
                    child: Material(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0 * fem)),
                      elevation: 2 * fem,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 30, bottom: 10),
                            child: Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Delayed',
                                      style: TextStyle(
                                        color: const Color(0xFF999999),
                                        fontSize: 15 * fem,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w600,
                                        height: 1.20 * fem,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '1',
                                      style: TextStyle(
                                        color: const Color(0xFF02B242),
                                        fontSize: 15 * fem,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  ],
                                ),
                                const Spacer(),
                                Container(
                                  width: 2 * fem,
                                  height: 40 * fem,
                                  color: const Color(0x66DAD8D8),
                                ),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'On Track',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: const Color(0xFF999999),
                                        fontSize: 16 * fem,
                                        fontFamily: 'Nunito Sans',
                                        fontWeight: FontWeight.w600,
                                        height: 1.20 * fem,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '1',
                                      style: TextStyle(
                                        color: const Color(0xFFfe0000),
                                        fontSize: 13 * fem,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Container(
                                  width: 2 * fem,
                                  height: 40 * fem,
                                  color: const Color(0x66DAD8D8),
                                ),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Completed',
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                        color: const Color(0xFF999999),
                                        fontSize: 14 * fem,
                                        fontFamily: 'Nunito Sans',
                                        fontWeight: FontWeight.w600,
                                        height: 1.20 * fem,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5 * fem,
                                    ),
                                    Text(
                                      '0',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 13 * fem,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15.0 * fem),
            child: Row(
              children: [
                Text(
                  "Starts",
                  style: TextStyle(
                    fontSize: 15 * fem,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Text(
                  "Task name",
                  style: TextStyle(
                    fontSize: 15 * fem,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Text(
                  "Ends",
                  style: TextStyle(
                    fontSize: 15 * fem,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Text(
                  "Progress",
                  style: TextStyle(
                    fontSize: 15 * fem,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 1 * fem,
            width: screenWidth * fem,
            color: Colors.grey[400],
          ),
          SizedBox(
            height: 15 * fem,
          ),
          MediaQuery.removeViewPadding(
            context: context,
            removeTop: true,
            // alignment: Alignment.topCenter,
            // height: 350 * fem,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: 50,
                physics: const ClampingScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                    child: Row(
                      children: [
                        Container(
                          width: screenWidth - 110,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            color: const Color(0x33059000),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              children: [
                                Text(
                                  "24 May",
                                  style: TextStyle(
                                    fontSize: 15 * fem,
                                    color: const Color(0XFF069000),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  "Floor Lighting",
                                  style: TextStyle(
                                    fontSize: 15 * fem,
                                    color: const Color(0XFF069000),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  "25 May",
                                  style: TextStyle(
                                    fontSize: 15 * fem,
                                    color: const Color(0XFF069000),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        Container(
                          width: screenWidth - 280 * fem,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5 * fem),
                            color: const Color(0x33059000),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(15.0 * fem),
                            child: Center(
                              child: Text(
                                "10",
                                style: TextStyle(
                                  fontSize: 15 * fem,
                                  color: const Color(0XFF069000),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget tab7() {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double screenHeight = mediaQuery.size.height;
    final double fem = screenWidth / 375.0;
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: (screenHeight * 0.15) * fem,
            color: const Color(0xff002A5A),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15 * fem,
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20.0 * fem),
                      child: Text(
                        "project - Gitanjali",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 18 * fem,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          height: 21 / 18,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: 40 * fem,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20 * fem),
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 8 * fem,
                          ),
                          const Icon(
                            Icons.add_circle_outline_sharp,
                            color: Colors.white,
                            size: 20,
                          ),
                          SizedBox(
                            width: 10 * fem,
                          ),
                          Text(
                            "Create Album",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 11 * fem,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              height: 24 / 11,
                            ),
                            textAlign: TextAlign.left,
                          ),
                          SizedBox(
                            width: 10 * fem,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5 * fem,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0 * fem),
                  child: Text(
                    "Apartment",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 14 * fem,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                      height: 20 / 14,
                    ),
                    textAlign: TextAlign.left,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 10),
            height: 78 * fem,
            width: screenWidth * fem,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: 12,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10 * fem, left: 10 * fem),
                        height: screenHeight / 10 * fem,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5 * fem),
                          child: Container(
                            decoration: const BoxDecoration(
                                // borderRadius: BorderRadius.circular(20),
                                ),
                            width: screenWidth / 5 * fem,
                            child: Image.network(
                              'https://thumbor.forbes.com/thumbor/fit-in/x/https://www.forbes.com/home-improvement/wp-content/uploads/2022/07/download-23.jpg',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 15,
            ),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: 100 * fem,
                height: 30 * fem,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(33 * fem),
                  color: const Color(0xff002a5a),
                ),
                child: Center(
                  child: Text("View All",
                      style: TextStyle(
                        fontSize: 14 * fem,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      )),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10 * fem,
          ),
          SizedBox(
            height: 260 * fem,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Material(
                    elevation: 0.1 * fem,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5 * fem,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: 10 * fem,
                          ),
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Showing Reference Images",
                            style: TextStyle(
                              fontSize: 16 * fem,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 10),
                          height: 80 * fem,
                          width: screenWidth * fem,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 12,
                              itemBuilder: (BuildContext context, int index) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 10 * fem, left: 10 * fem),
                                      height: screenHeight / 10 * fem,
                                      width:
                                          MediaQuery.of(context).size.width / 5,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(5 * fem),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5 * fem),
                                          ),
                                          child: Image.network(
                                            'https://www.mydomaine.com/thmb/bepet4VMGUG70sCLFNQRdZm9bbg=/2048x0/filters:no_upscale():strip_icc()/SuCasaDesign-Modern-9335be77ca0446c7883c5cf8d974e47c.jpg',
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        ),
                        SizedBox(
                          height: 10 * fem,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10 * fem,
                  ),
                  Material(
                    elevation: 0.1 * fem,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5 * fem,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: 16 * fem,
                          ),
                          alignment: Alignment.bottomLeft,
                          child: Text(
                            "Con Approv",
                            style: TextStyle(
                              fontSize: 14 * fem,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 10 * fem),
                          height: 80 * fem,
                          width: screenWidth * fem,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const ClampingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 12,
                              itemBuilder: (BuildContext context, int index) {
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 10 * fem, left: 10 * fem),
                                      height: screenHeight / 10 * fem,
                                      width: screenWidth / 5 * fem,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(5 * fem),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5 * fem),
                                          ),
                                          child: Image.network(
                                            'https://www.mydomaine.com/thmb/bepet4VMGUG70sCLFNQRdZm9bbg=/2048x0/filters:no_upscale():strip_icc()/SuCasaDesign-Modern-9335be77ca0446c7883c5cf8d974e47c.jpg',
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                        ),
                        SizedBox(
                          height: 10 * fem,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10 * fem,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 40 * fem,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10 * fem, right: 10 * fem),
                height: 40 * fem,
                width: 40 * fem,
                child: Image.network(
                    'https://t4.ftcdn.net/jpg/01/07/57/91/360_F_107579101_QVlTG43Fwg9Q6ggwF436MPIBTVpaKKtb.jpg'),
              ),
              Container(
                width: 1 * fem,
                height: 35 * fem,
                color: Colors.black,
              ),
              Container(
                margin: EdgeInsets.only(
                  left: 10 * fem,
                ),
                height: 30 * fem,
                width: 40 * fem,
                child: Image.network(
                    'https://cdn.icon-icons.com/icons2/2440/PNG/512/gallery_icon_148533.png'),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.only(right: 10 * fem),
                child: Container(
                  width: 129 * fem,
                  height: 40 * fem,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xff002a5a),
                  ),
                  child: Center(
                    child: Text(
                      "Save",
                      style: TextStyle(
                          fontSize: 15 * fem,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
