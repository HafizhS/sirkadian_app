import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/model/auth_model/register_request_model.dart';

import '../../constant/hex_color.dart';
import '../../controller/auth_controller.dart';
import '../../controller/hexcolor_controller.dart';
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
                    // SizedBox(height: 28.h),
                    Image.asset('assets/images/sirkadianlogo.png',
                        fit: BoxFit.fitHeight, height: 53.h, width: 98.w),
                    Text(
                      'Sign Up',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: color.primaryTextColor,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 25.h),
                  ],
                ),
                //segmen 2
                _buildInputForm(),
                const SizedBox(height: 18),

                //segmen 3
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            final registerRequest = RegisterRequest(
                                username: registerText.usernameC.text,
                                password: registerText.passwordC.text,
                                email: registerText.emailC.text);

                            authController.postRegister(registerRequest);
                          },
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              backgroundColor: HexColor.fromHex("73C639")),
                          child: Text(
                            "Daftar",
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  color: color.primaryColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.normal),
                            ),
                          )),
                      SizedBox(
                        height: 5.h,
                      ),
                      TextButton(
                        style: ButtonStyle(
                            overlayColor:
                                MaterialStateProperty.all(Colors.transparent)),
                        onPressed: () {
                          Get.offNamed(RouteScreens.login);
                        },
                        child: RichText(
                          text: TextSpan(
                            text: 'Sudah punya akun? ',
                            style: GoogleFonts.inter(
                                textStyle: TextStyle(
                              color: color.primaryTextColor,
                              fontSize: 14.sp,
                            )),
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Masuk',
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
                ..._buildWidget()
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Container _buildInputForm() {
    return Container(
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
            controller: registerText.usernameC,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: HexColor.fromHex("73C639"), width: 2)),
                hintText: "Username"),
          ),
          const SizedBox(height: 10),
          Text(
            'E-mail',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  color: color.primaryTextColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal),
            ),
          ),
          Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: TextField(
              controller: registerText.emailC,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: HexColor.fromHex("73C639"), width: 2)),
                  hintText: "Email"),
            ),
          ),
          const SizedBox(height: 10),
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
            obscureText: registerText.hidden.value,
            controller: registerText.passwordC,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      registerText.hidden.toggle();
                    });
                  },
                  icon: registerText.hidden.isTrue
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
                        color: HexColor.fromHex("73C639"), width: 2)),
                hintText: "Password"),
          ),
        ],
      ),
    );
  }

  // Old
  Container _buildOldInputForm() {
    return Container(
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
            style: NeumorphicStyle(depth: -5, color: color.backgroundColor),
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            margin: EdgeInsets.only(bottom: 30.h),
            child: TextFormField(
              controller: registerText.usernameC,
              decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                  icon: FaIcon(
                    FontAwesomeIcons.userAlt,
                    size: 18.sp,
                    color: color.hintTextColor,
                  ),
                  hintText: 'username',
                  hintStyle:
                      TextStyle(color: color.hintTextColor, fontSize: 14.sp)),
            ),
          ),
          Text(
            'E-mail',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                  color: color.primaryTextColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal),
            ),
          ),
          Neumorphic(
            style: NeumorphicStyle(depth: -5, color: color.backgroundColor),
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            margin: EdgeInsets.only(bottom: 30.h),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: TextFormField(
                controller: registerText.emailC,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                    icon: FaIcon(
                      FontAwesomeIcons.solidEnvelope,
                      size: 20.sp,
                      color: color.hintTextColor,
                    ),
                    hintText: 'email',
                    hintStyle:
                        TextStyle(color: color.hintTextColor, fontSize: 14.sp)),
              ),
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
            style: NeumorphicStyle(depth: -5, color: color.backgroundColor),
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            margin: EdgeInsets.only(bottom: 30.h),
            child: TextFormField(
              obscureText: registerText.hidden.value,
              controller: registerText.passwordC,
              decoration: InputDecoration(
                  icon: FaIcon(
                    FontAwesomeIcons.lock,
                    size: 18.sp,
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
                            size: 18.sp,
                            color: Colors.grey,
                          )
                        : FaIcon(
                            FontAwesomeIcons.eye,
                            size: 18.sp,
                            color: Colors.green.shade700,
                          ),
                  ),
                  hintStyle:
                      TextStyle(color: color.hintTextColor, fontSize: 14.sp)),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildWidget() {
    return <Widget>[
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
                style: TextStyle(fontSize: 15, color: Colors.grey.shade700)),
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
                  Text("Daftar Dengan Google", style: GoogleFonts.inter()),
                ],
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: HexColor.fromHex("F5F5F8"),
              ),
            )
          ],
        ),
      ),
    ];
  }
}
