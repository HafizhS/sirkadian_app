import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/controller/auth_controller.dart';
import 'package:sirkadian_app/controller/text_controller.dart';

import '../../constant/hex_color.dart';
import '../../controller/hexcolor_controller.dart';
import '../../model/auth_model/login_request_model.dart';
import '../list_screen.dart';
import 'forget_screen.dart';

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
              child: Column(
                children: [
                  Column(
                    children: [
                      SizedBox(height: 18.h),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.symmetric(horizontal: 20.w),
                        child: IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: FaIcon(
                            FontAwesomeIcons.arrowLeft,
                            size: 25.sp,
                            color: color.primaryTextColor,
                          ),
                          padding: const EdgeInsets.all(10.0),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      SizedBox(height: 20.h),
                      Image.asset('assets/images/sirkadianlogo.png',
                          fit: BoxFit.fitHeight, height: 53.h, width: 98.w),
                      const SizedBox(height: 5),
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
                        TextField(
                          controller: loginText.usernameC,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: HexColor.fromHex("73C639"),
                                      width: 2)),
                              hintText: "Username"),
                        ),

                        // Neumorphic(
                        //   style: NeumorphicStyle(
                        //       depth: -5, color: color.backgroundColor),
                        //   padding: EdgeInsets.symmetric(horizontal: 10),
                        //   margin: EdgeInsets.only(bottom: 30),
                        //   child: TextFormField(
                        //     controller: loginText.usernameC,
                        //     decoration: InputDecoration(
                        //         focusedBorder: InputBorder.none,
                        //         border: InputBorder.none,
                        //         icon: FaIcon(
                        //           FontAwesomeIcons.userAlt,
                        //           size: 18.sp,
                        //           color: color.hintTextColor,
                        //         ),
                        //         hintText: 'username',
                        //         hintStyle: TextStyle(
                        //             color: color.hintTextColor, fontSize: 14.sp)),
                        //   ),
                        // ),

                        const SizedBox(height: 7),
                        Text(
                          'Password',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: color.primaryTextColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal),
                          ),
                        ),

                        TextField(
                          obscureText: loginText.hidden.value,
                          controller: loginText.passwordC,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    loginText.hidden.toggle();
                                  });
                                },
                                icon: loginText.hidden.isTrue
                                    ? Icon(
                                        FontAwesomeIcons.eyeSlash,
                                        size: 18.sp,
                                        color: color.tersierTextColor,
                                      )
                                    : Icon(
                                        FontAwesomeIcons.eye,
                                        size: 18.sp,
                                        color: color.tersierColor,
                                      ),
                              ),
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: HexColor.fromHex("73C639"),
                                      width: 2)),
                              hintText: "Password"),
                        ),

                        // Neumorphic(
                        //   style: NeumorphicStyle(
                        //       depth: -5, color: color.backgroundColor),
                        //   padding: EdgeInsets.symmetric(horizontal: 10),
                        //   margin: EdgeInsets.only(bottom: 30),
                        //   child: TextFormField(
                        //     obscureText: loginText.hidden.value,
                        //     controller: loginText.passwordC,
                        //     decoration: InputDecoration(
                        //         icon: FaIcon(
                        //           FontAwesomeIcons.lock,
                        //           size: 20.sp,
                        //           color: color.hintTextColor,
                        //         ),
                        //         focusedBorder: InputBorder.none,
                        //         border: InputBorder.none,
                        //         hintText: 'password',
                        //         suffixIcon: IconButton(
                        //           onPressed: () {
                        //             setState(() {
                        //               loginText.hidden.toggle();
                        //             });
                        //           },
                        //           icon: loginText.hidden.isTrue
                        //               ? FaIcon(
                        //                   FontAwesomeIcons.eyeSlash,
                        //                   size: 18.sp,
                        //                   color: color.tersierTextColor,
                        //                 )
                        //               : FaIcon(
                        //                   FontAwesomeIcons.eye,
                        //                   size: 18.sp,
                        //                   color: color.tersierColor,
                        //                 ),
                        //         ),
                        //         hintStyle: TextStyle(
                        //             color: color.hintTextColor, fontSize: 14.sp)),
                        //   ),
                        // ),
                        SizedBox(
                          width: double.infinity,
                          child: Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: TextButton(
                              child: Text("Lupa Password?",
                                  style: TextStyle(
                                      color: HexColor.fromHex("73C639"))),
                              onPressed: () {
                                Navigator.of(context).push(PageRouteBuilder(pageBuilder: (_, __, ___) {
                                  return ForgetScreen();
                                }));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 5),

                  //segmen 3
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            final loginRequest = LoginRequest(
                                username: loginText.usernameC.text,
                                password: loginText.passwordC.text);
                            authController.postLogin(
                                loginRequest: loginRequest);
                          },
                          child: Text("Masuk",
                              style: GoogleFonts.inter(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              backgroundColor: HexColor.fromHex("73C639")),
                        ),

                        // NeumorphicButton(
                        //   onPressed: () {
                        //     final loginRequest = LoginRequest(
                        //         username: loginText.usernameC.text,
                        //         password: loginText.passwordC.text);
                        //     authController.postLogin(loginRequest: loginRequest);
                        //   },
                        //   style: NeumorphicStyle(
                        //       color: color.secondaryColor,
                        //       shape: NeumorphicShape.flat,
                        //       boxShape: NeumorphicBoxShape.roundRect(
                        //         BorderRadius.circular(20),
                        //       )
                        //       //border: NeumorphicBorder()
                        //       ),
                        //   padding:
                        //       EdgeInsets.symmetric(vertical: 12, horizontal: 120.w),
                        //   child: Text(
                        //     "Masuk",
                        //     style: GoogleFonts.inter(
                        //       textStyle: TextStyle(
                        //           color: color.primaryColor,
                        //           fontSize: 14,
                        //           fontWeight: FontWeight.normal),
                        //     ),
                        //   ),
                        // ),

                        TextButton(
                          style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all(
                                  Colors.transparent)),
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
                                  text: 'Sign Up',
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        color: HexColor.fromHex("67A626"),
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
                  ),

                  // Atau
                  Row(
                    children: [
                      const Expanded(
                          child: const Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.grey,
                      )),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text("atau",
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey.shade700)),
                      ),
                      const Expanded(
                          child: const Divider(
                        height: 1,
                        thickness: 1,
                        color: Colors.grey,
                      )),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(FontAwesomeIcons.google),
                              const SizedBox(width: 5),
                              Text("Masuk Dengan Google",
                                  style: GoogleFonts.inter()),
                            ],
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: HexColor.fromHex("F5F5F8"),
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
      ),
    );
  }
}
