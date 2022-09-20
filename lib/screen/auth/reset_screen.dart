import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/screen/auth/login_screen.dart';

import '../../constant/hex_color.dart';
import '../../controller/hexcolor_controller.dart';
import '../list_screen.dart';

class ResetScreen extends StatelessWidget {
  final color = Get.find<ColorConstantController>();
  final isPasswordVisible = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.primaryColor,
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Back Button
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
              SizedBox(height: 20.h),

              // Logo
              Image.asset('assets/images/sirkadianlogo.png',
                  fit: BoxFit.fitHeight, height: 53.h, width: 98.w),
              const SizedBox(height: 5),
              Text(
                'Masukkan Password Baru',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: color.primaryTextColor,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(height: 38.h),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("Password Baru"),
                    const SizedBox(height: 5),
                    Obx(
                      () => TextField(
                        obscureText: !isPasswordVisible.value,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                isPasswordVisible.value =
                                    !isPasswordVisible.value;
                              },
                              icon: !isPasswordVisible.value
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
                            hintText: "Password Baru"),
                      ),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {
                        Get.until(
                            (route) => Get.currentRoute == RouteScreens.login);
                      },
                      child: Text("Simpan",
                          style: GoogleFonts.inter(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: HexColor.fromHex("73C639")),
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
