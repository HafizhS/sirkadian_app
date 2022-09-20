import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/screen/auth/reset_screen.dart';

import '../../constant/hex_color.dart';
import '../../controller/hexcolor_controller.dart';

class ForgetScreen extends StatelessWidget {
  final color = Get.find<ColorConstantController>();

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
                'Lupa Password',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: color.primaryTextColor,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(height: 38.h),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                    "Kami akan mengirimkan link ubah password ke alamat e-mail kamu!",
                    style: GoogleFonts.inter(),
                    textAlign: TextAlign.center),
              ),
              SizedBox(height: 20.h),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text("Email"),
                    const SizedBox(height: 5),
                    TextField(
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: HexColor.fromHex("73C639"), width: 2)),
                          hintText: "Email"),
                    ),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .push(PageRouteBuilder(pageBuilder: (_, __, ___) {
                          return ResetScreen();
                        }));
                      },
                      child: Text("Kirim",
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
