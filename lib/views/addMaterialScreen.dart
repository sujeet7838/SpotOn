// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, camel_case_types, file_names, unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class addMaterial extends StatefulWidget {
  const addMaterial({super.key});

  @override
  State<addMaterial> createState() => _addMaterialState();
}

class _addMaterialState extends State<addMaterial> {
  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double screenHeight = mediaQuery.size.height;
    final double fem = screenWidth / 375.0;
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 55 * fem,
            ),
            Container(
              margin: EdgeInsets.only(left: 15 * fem),
              child: Row(
                children: [
                  SizedBox(
                    width: 10 * fem,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back),
                  ),
                  SizedBox(
                    width: 10 * fem,
                  ),
                  Text(
                    "\t\tAdd Material",
                    style: TextStyle(
                      fontSize: 20 * fem,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20 * fem,
            ),
            Padding(
              padding: EdgeInsets.all(12.0 * fem),
              child: Row(
                children: [
                  SizedBox(
                    width: 13 * fem,
                  ),
                  Container(
                    width: 114 * fem,
                    child: Text(
                      "Materials",
                      style: TextStyle(
                        fontSize: 15 * fem,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5 * fem,
                  ),
                  Container(
                    width: 32 * fem,
                    child: Center(
                      child: Text(
                        "Qty",
                        style: TextStyle(
                          fontSize: 15 * fem,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 5 * fem,
                  ),
                  Container(
                    width: 40 * fem,
                    child: Center(
                      child: Text(
                        "Price",
                        style: TextStyle(
                          fontSize: 15 * fem,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5 * fem),
                  Container(
                    width: 95 * fem,
                    child: Center(
                      child: Text(
                        "Delivery Date",
                        style: TextStyle(
                          fontSize: 15 * fem,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Checkbox(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    side: BorderSide(color: Colors.black38),
                    value: false,
                    onChanged: (bool? newValue) {
                      setState(() {});
                    },
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15 * fem),
              child: Container(
                height: 1 * fem,
                width: screenWidth * fem,
                color: Colors.black38,
              ),
            ),
            SizedBox(
              height: 10 * fem,
            ),
            MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                  itemCount: 4,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    if (index != 3) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 8 * fem),
                        child: Container(
                          width: screenWidth * fem,
                          height: 46 * fem,
                          decoration: BoxDecoration(color: Colors.white),
                          child: Row(
                            children: [
                              Container(
                                width: 130 * fem,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Checkbox(
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      side: BorderSide(color: Colors.black38),
                                      value: false,
                                      onChanged: (bool? newValue) {
                                        setState(() {});
                                      },
                                    ),
                                    SizedBox(
                                      width: 85 * fem,
                                      child: Text(
                                        index == 0
                                            ? "Windows"
                                            : index == 1
                                                ? "Waterproofing"
                                                : index == 2
                                                    ? "Termite"
                                                    : "null",
                                        style: TextStyle(
                                          fontSize: 14 * fem,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10 * fem,
                              ),
                              index == 0
                                  ? Container(
                                      width: 34 * fem,
                                      height: 26 * fem,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        color: Color(0xfff1f1f1),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "5",
                                          style: TextStyle(
                                            fontSize: 15 * fem,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width: 34 * fem,
                                      height: 26 * fem,
                                      child: Center(
                                        child: Text("-"),
                                      ),
                                    ),
                              SizedBox(
                                width: 10 * fem,
                              ),
                              index == 0
                                  ? Container(
                                      width: 50 * fem,
                                      height: 26 * fem,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                        color: Color(0xfff1f1f1),
                                      ),
                                      child: Center(
                                        child: Text(
                                          "₹2000",
                                          style: TextStyle(
                                            fontSize: 14 * fem,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      width: 34 * fem,
                                      height: 26 * fem,
                                      child: Center(
                                        child: Text("-"),
                                      ),
                                    ),
                              SizedBox(width: 10 * fem),
                              index == 0 ? Container() : Spacer(),
                              index == 0
                                  ? Container(
                                      width: 120 * fem,
                                      height: 26 * fem,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(2 * fem),
                                        color: Color(0xfff1f1f1),
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(5.0 * fem),
                                            child: Text(
                                              "16-Jun-2023",
                                              style: TextStyle(
                                                fontSize: 14 * fem,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            Icons.calendar_today,
                                            size: 19 * fem,
                                          ),
                                          SizedBox(
                                            width: 5 * fem,
                                          )
                                        ],
                                      ),
                                    )
                                  : Container(
                                      width: 34 * fem,
                                      height: 26 * fem,
                                      child: Center(
                                        child: Text("-"),
                                      ),
                                    ),
                              index == 0 ? Container() : Spacer(),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          Container(
                            width: screenWidth,
                            height: 46 * fem,
                            decoration: BoxDecoration(color: Colors.white),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  side: BorderSide(color: Colors.black38),
                                  value: false,
                                  onChanged: (bool? newValue) {
                                    setState(() {});
                                  },
                                ),
                                Text(
                                  "Gadgets",
                                  style: TextStyle(
                                    fontSize: 12 * fem,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_up_outlined,
                                  size: 25 * fem,
                                )
                              ],
                            ),
                          ),
                          MediaQuery.removePadding(
                            removeTop: true,
                            context: context,
                            child: ListView.builder(
                                itemCount: 3,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(top: 2 * fem),
                                    child: Container(
                                      width: screenWidth * fem,
                                      height: 46 * fem,
                                      decoration:
                                          BoxDecoration(color: Colors.white),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 133 * fem,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Checkbox(
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .shrinkWrap,
                                                  side: BorderSide(
                                                      color: Colors.black38),
                                                  value: false,
                                                  onChanged: (bool? newValue) {
                                                    setState(() {});
                                                  },
                                                ),
                                                SizedBox(
                                                  width: 85 * fem,
                                                  child: Text(
                                                    index == 0
                                                        ? "Air Conditioners"
                                                        : index == 1
                                                            ? "Smart Home"
                                                            : index == 2
                                                                ? "Fire Alert"
                                                                : "null",
                                                    style: TextStyle(
                                                      fontSize: 12 * fem,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10 * fem,
                                          ),
                                          index == 0
                                              ? Container(
                                                  width: 34 * fem,
                                                  height: 26 * fem,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2),
                                                    color: Color(0xfff1f1f1),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "5",
                                                      style: TextStyle(
                                                        fontSize: 15 * fem,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  width: 34 * fem,
                                                  height: 26 * fem,
                                                  child: Center(
                                                    child: Text("-"),
                                                  ),
                                                ),
                                          SizedBox(
                                            width: 10 * fem,
                                          ),
                                          index == 0
                                              ? Container(
                                                  width: 50 * fem,
                                                  height: 26 * fem,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2),
                                                    color: Color(0xfff1f1f1),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "₹2000",
                                                      style: TextStyle(
                                                        fontSize: 14 * fem,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  width: 34 * fem,
                                                  height: 26 * fem,
                                                  child: Center(
                                                    child: Text("-"),
                                                  ),
                                                ),
                                          SizedBox(width: 10 * fem),
                                          index == 0 ? Container() : Spacer(),
                                          index == 0
                                              ? Container(
                                                  width: 120 * fem,
                                                  height: 26 * fem,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2 * fem),
                                                    color: Color(0xfff1f1f1),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.all(
                                                            5.0 * fem),
                                                        child: Text(
                                                          "16-Jun-2023",
                                                          style: TextStyle(
                                                            fontSize: 14 * fem,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                          ),
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons.calendar_today,
                                                        size: 19 * fem,
                                                      ),
                                                      SizedBox(
                                                        width: 5 * fem,
                                                      )
                                                    ],
                                                  ),
                                                )
                                              : Container(
                                                  width: 34 * fem,
                                                  height: 26 * fem,
                                                  child: Center(
                                                    child: Text("-"),
                                                  ),
                                                ),
                                          index == 0 ? Container() : Spacer(),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      );
                    }
                  }),
            ),
            SizedBox(
              height: 10 * fem,
            ),
            Container(
              padding: EdgeInsets.only(left: 10 * fem),
              width: 375 * fem,
              height: 40 * fem,
              decoration: BoxDecoration(color: Colors.white),
              child: Row(
                children: [
                  Container(
                    height: 30 * fem,
                    child: CircleAvatar(
                      backgroundColor: Color(0xffF5F5F5),
                      child: Icon(
                        Icons.add,
                        size: 18 * fem,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10 * fem,
                  ),
                  Text(
                    " Add",
                    style: TextStyle(
                      fontSize: 15 * fem,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
            ),
            Spacer(),
            Container(
              alignment: Alignment.topRight,
              margin: EdgeInsets.only(right: 15 * fem),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(120 * fem, 40 * fem),
                  elevation: 5 * fem,
                  backgroundColor: Color(0xff002a5a),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8 * fem),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  "Next",
                  style: TextStyle(
                    fontSize: 15 * fem,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25 * fem,
            )
          ],
        ),
      ),
    );
  }
}
