import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: color.primaryColor,
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: SafeArea(
            child: Container(
              // padding: EdgeInsets.only(top: 10),
              height: size.height,
              width: double.infinity,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.symmetric(horizontal: 20),
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
                              size: 16,
                              color: color.primaryTextColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        Image.asset('assets/images/sirkadianlogo.png',
                            fit: BoxFit.fitHeight,
                            height: size.height * 0.07,
                            width: size.width * 0.15),
                        Text(
                          'Masuk Ke Sirkadian',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: color.primaryTextColor,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),

                    //segmen 2
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Username',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: color.primaryTextColor,
                                  fontSize: 14,
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
                                    size: 18,
                                    color: color.hintTextColor,
                                  ),
                                  hintText: 'username',
                                  hintStyle: TextStyle(
                                      color: color.hintTextColor,
                                      fontSize: size.width * 0.04)),
                            ),
                          ),
                          Text(
                            'Password',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: color.primaryTextColor,
                                  fontSize: 14,
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
                                    size: 20,
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
                                            size: 18,
                                            color: Colors.grey,
                                          )
                                        : FaIcon(
                                            FontAwesomeIcons.eye,
                                            size: 18,
                                            color: Colors.green.shade700,
                                          ),
                                  ),
                                  hintStyle: TextStyle(
                                      color: color.hintTextColor,
                                      fontSize: size.width * 0.04)),
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
                            margin: EdgeInsets.only(top: 12),
                            onPressed: () {
                              final loginRequest = LoginRequest(
                                  username: loginText.usernameC.text,
                                  password: loginText.passwordC.text);
                              authController.postLogin(
                                  loginRequest: loginRequest);
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
                                vertical: 12, horizontal: size.width * 0.3),
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
                          height: size.height * 0.02,
                        ),
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
                                fontSize: 14,
                              )),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Daftar',
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        color: color.primaryTextColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
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
