import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/controller/auth_controller.dart';
import 'package:sirkadian_app/controller/information_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constant/hex_color.dart';

import '../../controller/hexcolor_controller.dart';
import '../../model/auth_model/activation_request_model.dart';
import '../../model/auth_model/login_request_model.dart';

class GreetingScreen extends StatefulWidget {
  GreetingScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<GreetingScreen> createState() => _GreetingScreenState();
}

class _GreetingScreenState extends State<GreetingScreen>
    with WidgetsBindingObserver {
  final data = GetStorage('myData');
  final authController = Get.find<AuthController>();
  final informationController = Get.find<InformationController>();
  final color = Get.find<ColorConstantController>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.bgColor,
      body: SafeArea(
          child: Container(
        height: 800.h,
        width: 360.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Column(
              children: [
                Text(
                  'Selamat Datang di',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: color.primaryTextColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Text(
                  'Sirkadian',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: color.secondaryColor,
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Image.asset('assets/images/sirkadianlogo.png',
                    fit: BoxFit.fitHeight, height: 53.h, width: 98.w),
              ],
            ),
            NeumorphicButton(
                margin: EdgeInsets.only(top: 12.h, bottom: 40.h),
                onPressed: () {
                  final username = data.read('dataRegister')['username'];
                  final password = data.read('dataRegister')['password'];
                  authController.postLogin(
                      loginRequest:
                          LoginRequest(username: username, password: password));
                },
                style: NeumorphicStyle(
                    color: color.secondaryColor,
                    depth: 4,
                    shape: NeumorphicShape.flat,
                    boxShape: NeumorphicBoxShape.roundRect(
                      BorderRadius.circular(20),
                    )),
                padding:
                    EdgeInsets.symmetric(vertical: 12.h, horizontal: 120.w),
                child: Text(
                  "Selanjutnya",
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        color: color.primaryColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal),
                  ),
                )),
          ],
        ),
      )),
    );
  }
}
