import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/constant/hex_color.dart';

class SettingsNotificationScreen extends StatelessWidget {
  final sirkadiet = false.obs;
  final sirkafluid = false.obs;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Notifikasi".toUpperCase(),
          style: GoogleFonts.poppins(
              fontSize: 18.sp,
              color: Colors.white,
              fontWeight: FontWeight.w600,
              letterSpacing: 2),
        ),
        backgroundColor: HexColor.fromHex("73C639"),
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: SizedBox(
                  height: 50.h,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Sirkadiet",
                            style: GoogleFonts.poppins(fontSize: 16),
                          ),
                          Switch(
                            activeColor: Colors.white,
                            activeTrackColor: HexColor.fromHex("73C639"),
                            value: sirkadiet.value,
                            onChanged: (value) {
                              sirkadiet.value = value;
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: SizedBox(
                  height: 50.h,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(
                      () => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Sirkafluid",
                            style: GoogleFonts.poppins(fontSize: 16),
                          ),
                          Switch(
                            activeColor: Colors.white,
                            activeTrackColor: HexColor.fromHex("73C639"),
                            value: sirkafluid.value,
                            onChanged: (value) {
                              sirkafluid.value = value;
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
