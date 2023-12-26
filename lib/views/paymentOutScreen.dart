import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class paymentOutScreen extends StatefulWidget {
  const paymentOutScreen({super.key});

  @override
  State<paymentOutScreen> createState() => _paymentOutScreenState();
}

class _paymentOutScreenState extends State<paymentOutScreen> {
  bool value = true;
  TextEditingController date = TextEditingController();
  @override
  void initState() {
    date.text = "Date";
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
        child: Column(
          children: [
            SizedBox(
              height: 60 * fem,
            ),
            Container(
              margin: EdgeInsets.only(left: 15 * fem),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(Icons.arrow_back),
                  ),
                  Text(
                    "\t\tPayment Out",
                    style: TextStyle(
                      fontSize: 18 * fem,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5 * fem,
            ),
            Padding(
              padding: EdgeInsets.all(20.0 * fem),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.only(left: 10 * fem, right: 10 * fem),
                        width: 215 * fem,
                        height: 50 * fem,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4 * fem),
                            color: Colors.white),
                        child: TextFormField(
                          // controller: nameController,
                          decoration: const InputDecoration(
                            hintText: "Party Name",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
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
                                    onSurface:
                                        Colors.blueAccent, // <-- SEE HERE
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
                              date.text = formattedDate;
                            });
                          } else {}
                        },
                        child: Container(
                          width: 110 * fem,
                          height: 50 * fem,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4 * fem),
                              color: Colors.white),
                          child: Padding(
                            padding: EdgeInsets.all(5.0 * fem),
                            child: Row(
                              children: [
                                const Spacer(),
                                Text(
                                  date.text.toString(),
                                  style: TextStyle(
                                    fontSize: 13 * fem,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black45,
                                  ),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: EdgeInsets.all(3.0 * fem),
                                  child: Container(
                                    width: 1 * fem,
                                    color: const Color(0xFF565656),
                                    height: 28 * fem,
                                  ),
                                ),
                                Icon(Icons.calendar_today_outlined,
                                    color: const Color(0xFF565656),
                                    size: 20 * fem),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15 * fem,
                  ),
                  Container(
                    //  alignment: Alignment.centerLeft,
                    width: screenWidth,
                    height: 50 * fem,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4 * fem),
                        color: Colors.white),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          hintText: "Amount Given *", border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 15 * fem,
                  ),
                  Container(
                    //  alignment: Alignment.centerLeft,
                    width: screenWidth,
                    height: 50 * fem,
                    padding: EdgeInsets.only(left: 10 * fem, right: 10 * fem),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4 * fem),
                        color: Colors.white),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          hintText: "Description *", border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    height: 15 * fem,
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "More Details",
                      style: TextStyle(
                        fontSize: 16 * fem,
                        fontWeight: FontWeight.w600,
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
                            "Category",
                            style: TextStyle(
                              fontSize: 15 * fem,
                              color: Colors.black38,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 10 * fem,
                          ),
                          Container(
                            //  alignment: Alignment.centerLeft,
                            width: screenWidth / 2.3,
                            height: 50 * fem,
                            padding: EdgeInsets.only(
                                left: 10 * fem, right: 10 * fem),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4 * fem),
                                color: Colors.white),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Trade",
                            style: TextStyle(
                              fontSize: 15 * fem,
                              fontWeight: FontWeight.w500,
                              color: Colors.black38,
                            ),
                          ),
                          SizedBox(
                            height: 10 * fem,
                          ),
                          Container(
                            //  alignment: Alignment.centerLeft,
                            width: screenWidth / 2.3 * fem,
                            height: 50 * fem,
                            padding: EdgeInsets.only(
                                left: 10 * fem, right: 10 * fem),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4 * fem),
                                color: Colors.white),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: screenWidth,
              height: 1 * fem,
              decoration: const BoxDecoration(
                color: Color(0xFFD2CFCF),
              ),
            ),
            // SizedBox(
            //   height: 15,
            // ),
            Padding(
              padding: EdgeInsets.only(
                left: 20 * fem,
                right: 20 * fem,
                top: 5 * fem,
                bottom: 5 * fem,
              ),
              child: Row(
                children: [
                  Text(
                    "Cash",
                    style: TextStyle(
                      fontSize: 15 * fem,
                      fontWeight: FontWeight.w500,
                      color: Colors.black38,
                    ),
                  ),
                  Radio(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: 1,
                    groupValue: 2,
                    onChanged: (value) {},
                  ),
                  const Spacer(),
                  Text(
                    "Bank Transfer",
                    style: TextStyle(
                      fontSize: 15 * fem,
                      fontWeight: FontWeight.w500,
                      color: Colors.black38,
                    ),
                  ),
                  Radio(
                    activeColor: const Color(0xFF002A5A),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: 2,
                    groupValue: 2,
                    onChanged: (value) {},
                  ),
                  const Spacer(),
                  Text(
                    "Cheque",
                    style: TextStyle(
                      fontSize: 15 * fem,
                      fontWeight: FontWeight.w500,
                      color: Colors.black38,
                    ),
                  ),
                  Radio(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    value: 1,
                    groupValue: 2,
                    onChanged: (value) {},
                  ),
                ],
              ),
            ),
            Container(
              width: screenWidth,
              height: 1 * fem,
              decoration: const BoxDecoration(
                color: Color(0xFFD2CFCF),
              ),
            ),
            const Spacer(), const Spacer(),
            Padding(
              padding: EdgeInsets.all(10.0 * fem),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10 * fem, right: 10 * fem),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: 40 * fem,
                          width: 40 * fem,
                          child: Icon(
                            CupertinoIcons.camera,
                            color: const Color(0xFF002A5A),
                            size: 35 * fem,
                          ),
                        ),
                        Text(
                          "Camera",
                          style: TextStyle(
                            fontSize: 12 * fem,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 1 * fem,
                    height: 55 * fem,
                    color: Colors.black45,
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      left: 10 * fem,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 40 * fem,
                          width: 40 * fem,
                          alignment: Alignment.center,
                          child: Icon(
                            CupertinoIcons.photo_fill,
                            color: const Color(0xFF002A5A),
                            size: 35 * fem,
                          ),
                        ),
                        Text(
                          "Gallery",
                          style: TextStyle(
                            fontSize: 12 * fem,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.only(right: 10 * fem),
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        width: 129 * fem,
                        height: 40 * fem,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8 * fem),
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
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
