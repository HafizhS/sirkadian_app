import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/model/auth_model/register_request_model.dart';

import '../../constant/color.dart';
import '../../controller/auth_controller.dart';
import '../../controller/text_controller.dart';
import '../list_screen.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final registerText = Get.find<RegisterTextC>();
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
        backgroundColor: color.primaryColor,
        body: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.only(top: 15),
              height: size.height,
              width: double.infinity,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          margin:
                              EdgeInsets.symmetric(vertical: 5, horizontal: 20),
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
                          'Buat Akun',
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
                              controller: registerText.usernameC,
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
                            'E-mail',
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
                            child: Form(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              child: TextFormField(
                                controller: registerText.emailC,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    focusedBorder: InputBorder.none,
                                    border: InputBorder.none,
                                    icon: FaIcon(
                                      FontAwesomeIcons.solidEnvelope,
                                      size: 20,
                                      color: color.hintTextColor,
                                    ),
                                    hintText: 'email',
                                    hintStyle: TextStyle(
                                        color: color.hintTextColor,
                                        fontSize: size.width * 0.04)),
                              ),
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
                              obscureText: registerText.hidden.value,
                              controller: registerText.passwordC,
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
                                        registerText.hidden.toggle();
                                      });
                                    },
                                    icon: registerText.hidden.isTrue
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
                              final registerRequest = RegisterRequest(
                                  username: registerText.usernameC.text,
                                  password: registerText.passwordC.text,
                                  email: registerText.emailC.text);

                              authController.postRegister(registerRequest);
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
                              "Daftar",
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
                            Get.offNamed(RouteScreens.login);
                          },
                          child: RichText(
                            text: TextSpan(
                              text: 'Sudah punya akun? ',
                              style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                color: color.primaryTextColor,
                                fontSize: 14,
                              )),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Masuk',
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
                        ),
                        SizedBox(height: 20),
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
