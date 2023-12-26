// ignore_for_file: camel_case_types

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spoton/controller/SignInController.dart';

class otpScreen extends StatefulWidget {
  const otpScreen(
      {super.key,
      required this.id,
      required this.number,
      required this.name,
      required this.otp});

  final int id;
  final String number;
  final String name;
  final String otp;

  @override
  State<otpScreen> createState() => _otpScreenState();
}

class _otpScreenState extends State<otpScreen> {
  bool flag = false;
  final int _duration = 15;
  final CountDownController _controller = CountDownController();
  final SignInController signInController = Get.put(SignInController());
  List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());
  List<TextEditingController> controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

  @override
  void dispose() {
    for (var node in focusNodes) {
      node.dispose();
    }
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void onOtpChanged(int index) {
    if (controllers[index].text.length == 1) {
      if (index < 3) {
        FocusScope.of(context).requestFocus(focusNodes[index + 1]);
      } else {
        focusNodes[index].unfocus();
      }
    } else if (controllers[index].text.isEmpty) {
      if (index > 0) {
        FocusScope.of(context).requestFocus(focusNodes[index - 1]);
      }
    }
  }

  String getOtpFromBoxes() {
    String otp = '';
    for (var controller in controllers) {
      otp += controller.text;
    }
    return otp;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.otp.toString());
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final double screenWidth = mediaQuery.size.width;
    final double screenHeight = mediaQuery.size.height;
    final double fem = screenWidth / 375.0;
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      child: Container(
        width: double.infinity,
        height: screenHeight,
        decoration: const BoxDecoration(
          color: Color(0xffffffff),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 16 * fem, 9 * fem),
                width: 461 * fem,
                height: 187 * fem,
                child: Stack(
                  children: [
                    // Positioned(
                    //   left: 41 * fem,
                    //   top: 131 * fem,
                    //   child: Align(
                    //     child: SizedBox(
                    //       width: 144 * fem,
                    //       height: 36 * fem,
                    //       child: Text(
                    //         'Verification',
                    //         style: GoogleFonts.nunitoSans(
                    //           fontSize: 26 * fem,
                    //           fontWeight: FontWeight.w600,
                    //           height: 1.3625 * fem / fem,
                    //           color: const Color(0xff282828),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Positioned(
                      left: 0 * fem,
                      top: 0 * fem,
                      child: SizedBox(
                        width: 250 * fem,
                        height: 184 * fem,
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/login_topleft.png"),
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Positioned(
                    //   left: 26.7209472656 * fem,
                    //   top: 61.4997558594 * fem,
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       Get.back();
                    //     },
                    //     child: Align(
                    //       child: SizedBox(
                    //         width: 35.22 * fem,
                    //         height: 30.55 * fem,
                    //         child: Image.asset(
                    //           "assets/back.png",
                    //           fit: BoxFit.contain,
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 160 * fem, 0),
                child: Text(
                  'Verification',
                  style: GoogleFonts.nunitoSans(
                    fontSize: 26 * fem,
                    fontWeight: FontWeight.w600,
                    height: 1.3625 * fem / fem,
                    color: const Color(0xff282828),
                  ),
                ),
              ),
              Container(
                margin:
                    EdgeInsets.fromLTRB(0 * fem, 0 * fem, 62 * fem, 25 * fem),
                child: Text(
                  'Enter the OTP code we sent you',
                  style: GoogleFonts.nunitoSans(
                    fontSize: 16 * fem,
                    fontWeight: FontWeight.w400,
                    height: 1.9462193251 * fem / fem,
                    color: const Color(0xffaaaaaa),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(38, 0, 20, 30),
                width: double.infinity,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(4, (index) {
                    return Container(
                      width: 48,
                      height: 61,
                      margin: EdgeInsets.only(right: index < 3 ? 35 : 0),
                      child: TextField(
                        autofillHints: [widget.otp],
                        controller: controllers[index],
                        focusNode: focusNodes[index],
                        onChanged: (value) {
                          onOtpChanged(index);
                        },
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: const Color(0xffe6eaef),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'Resend OTP in ',
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Visibility(
                    visible: flag == true ? true : false,
                    child: InkWell(
                      onTap: () {
                        signInController.signIn(widget.name, widget.number);
                        setState(() {
                          flag = false;
                        });
                      },
                      child: const Text(
                        'Resend',
                        style: TextStyle(
                          color: Color(0xFFf48621),
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: flag == false ? true : false,
                    child: CircularCountDownTimer(
                      isReverse: true,
                      controller: _controller,
                      duration: _duration,
                      initialDuration: 0,
                      ringColor: Colors.grey[300]!,
                      fillColor: Colors.blue,
                      width: 80,
                      height: 40,
                      onComplete: () {
                        setState(() {
                          flag = true;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20 * fem,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        // controllers.clear();
                      },
                      child: Text(
                        'Clear Fields',
                        style: GoogleFonts.nunitoSans(
                          fontSize: 14 * fem,
                          fontWeight: FontWeight.w600,
                          height: 1.3625 * fem / fem,
                          color: const Color(0xff002A5A),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 50 * fem,
              ),
              Container(
                margin:
                    EdgeInsets.fromLTRB(31 * fem, 0 * fem, 0 * fem, 0 * fem),
                width: 583 * fem,
                height: 295 * fem,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0 * fem,
                      top: 0 * fem,
                      child: Align(
                        child: SizedBox(
                          width: 403 * fem,
                          height: 405 * fem,
                          child: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image:
                                    AssetImage("assets/login_bottomright.png"),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0 * fem,
                      top: 73 * fem,
                      child: Obx(
                        () => GestureDetector(
                          onTap: () async {
                            print(getOtpFromBoxes());
                            signInController.validateOTP(
                                widget.id, int.parse(getOtpFromBoxes()));
                          },
                          child: Container(
                            width: 320 * fem,
                            height: 46 * fem,
                            decoration: BoxDecoration(
                              border: Border.all(),
                              color: const Color(0xff002a5a),
                              borderRadius: BorderRadius.circular(6 * fem),
                            ),
                            child: Center(
                              child: signInController.isDataLoading.value
                                  ? const CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(0xffffffff),
                                      ),
                                    )
                                  : Text(
                                      'VERIFY',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.roboto(
                                        fontSize: 18 * fem,
                                        fontWeight: FontWeight.w500,
                                        height: 1.1725 * fem / fem,
                                        color: const Color(0xffffffff),
                                      ),
                                    ),
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
        ),
      ),
    );
  }
}
