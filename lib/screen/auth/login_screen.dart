import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/controller/auth_controller.dart';
import 'package:sirkadian_app/controller/text_controller.dart';

import '../../controller/hexcolor_controller.dart';

import '../../model/auth_model/login_request_model.dart';
import '../list_screen.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginText = Get.find<LoginTextC>();
  final authController = Get.find<AuthController>();
  final color = Get.find<ColorConstantController>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: color.primaryColor,
        body: SafeArea(
          child: Container(
            height: 800.h,
            width: 360.w,
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Column(children: [
                Column(
                  children: [
                    SizedBox(height: 18.h),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.symmetric(horizontal: 20.w),
                      child: NeumorphicButton(
                        onPressed: () {
                          Get.back();
                        },
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.circle(),
                          color: color.backgroundColor,
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: FaIcon(
                          FontAwesomeIcons.chevronLeft,
                          size: 16.sp,
                          color: color.primaryTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    SizedBox(height: 28.h),
                    Image.asset('assets/images/sirkadianlogo.png',
                        fit: BoxFit.fitHeight, height: 53.h, width: 98.w),
                    Text(
                      'Masuk Ke Sirkadian',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: color.primaryTextColor,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 38.h),
                  ],
                ),
                //segmen 2
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Username',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: color.primaryTextColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      Neumorphic(
                        style: NeumorphicStyle(
                            depth: -5, color: color.backgroundColor),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        margin: EdgeInsets.only(bottom: 30),
                        child: TextFormField(
                          controller: loginText.usernameC,
                          decoration: InputDecoration(
                              focusedBorder: InputBorder.none,
                              border: InputBorder.none,
                              icon: FaIcon(
                                FontAwesomeIcons.userAlt,
                                size: 18.sp,
                                color: color.hintTextColor,
                              ),
                              hintText: 'username',
                              hintStyle: TextStyle(
                                  color: color.hintTextColor, fontSize: 14.sp)),
                        ),
                      ),
                      Text(
                        'Password',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: color.primaryTextColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      Neumorphic(
                        style: NeumorphicStyle(
                            depth: -5, color: color.backgroundColor),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        margin: EdgeInsets.only(bottom: 30),
                        child: TextFormField(
                          obscureText: loginText.hidden.value,
                          controller: loginText.passwordC,
                          decoration: InputDecoration(
                              icon: FaIcon(
                                FontAwesomeIcons.lock,
                                size: 20.sp,
                                color: color.hintTextColor,
                              ),
                              focusedBorder: InputBorder.none,
                              border: InputBorder.none,
                              hintText: 'password',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    loginText.hidden.toggle();
                                  });
                                },
                                icon: loginText.hidden.isTrue
                                    ? FaIcon(
                                        FontAwesomeIcons.eyeSlash,
                                        size: 18.sp,
                                        color: color.tersierTextColor,
                                      )
                                    : FaIcon(
                                        FontAwesomeIcons.eye,
                                        size: 18.sp,
                                        color: color.tersierColor,
                                      ),
                              ),
                              hintStyle: TextStyle(
                                  color: color.hintTextColor, fontSize: 14.sp)),
                        ),
                      ),
                    ],
                  ),
                ),

                //segmen 3
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    NeumorphicButton(
                        onPressed: () {
                          final loginRequest = LoginRequest(
                              username: loginText.usernameC.text,
                              password: loginText.passwordC.text);
                          authController.postLogin(loginRequest: loginRequest);
                        },
                        style: NeumorphicStyle(
                            color: color.secondaryColor,
                            shape: NeumorphicShape.flat,
                            boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(20),
                            )
                            //border: NeumorphicBorder()
                            ),
                        padding: EdgeInsets.symmetric(
                            vertical: 12, horizontal: 120.w),
                        child: Text(
                          "Masuk",
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                color: color.primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.normal),
                          ),
                        )),
                    SizedBox(
                      height: 18.h,
                    ),
                    TextButton(
                      style: ButtonStyle(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent)),
                      onPressed: () {
                        Get.offNamed(RouteScreens.register);
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Belum punya akun? ',
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                            color: color.primaryTextColor,
                            fontSize: 14.sp,
                          )),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Daftar',
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    color: color.primaryTextColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
