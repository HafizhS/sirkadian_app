import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/constant/hex_color.dart';

class SettingsVolumeScreen extends StatelessWidget {
  final vibrateOnNotification = false.obs;
  final vibrateOnSilent = false.obs;
  final volume = 50.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Volume".toUpperCase(),
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(
                  "Getar",
                  style: GoogleFonts.poppins(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      color: HexColor.fromHex("4E5749")),
                ),
              ),
              const SizedBox(height: 5),
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
                            "Getaran untuk notifikasi",
                            style: GoogleFonts.poppins(fontSize: 16),
                          ),
                          Switch(
                            activeColor: Colors.white,
                            activeTrackColor: HexColor.fromHex("73C639"),
                            value: vibrateOnNotification.value,
                            onChanged: (value) {
                              vibrateOnNotification.value = value;
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
                            "Getaran pada mode diam",
                            style: GoogleFonts.poppins(fontSize: 16),
                          ),
                          Switch(
                            activeColor: Colors.white,
                            activeTrackColor: HexColor.fromHex("73C639"),
                            value: vibrateOnSilent.value,
                            onChanged: (value) {
                              vibrateOnSilent.value = value;
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.only(left: 4.0),
                child: Text(
                  "Dering dan Peringatan",
                  style: GoogleFonts.poppins(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      color: HexColor.fromHex("4E5749")),
                ),
              ),
              Row(
                children: [
                  Icon(Icons.volume_down_outlined,
                      color: HexColor.fromHex("73C639")),
                  Obx(
                    () => Expanded(
                        flex: 1,
                        child: Slider(
                          activeColor: HexColor.fromHex("73C639"),
                          thumbColor: Colors.white,
                          max: 100,
                          min: 0,
                          value: volume.value.toDouble(),
                          divisions: 100,
                          onChanged: (double value) {
                            volume.value = value.toInt();
                          },
                        )),
                  ),
                  Icon(Icons.volume_up_outlined,
                      color: HexColor.fromHex("73C639")),
                ],
              ),
              const SizedBox(height: 15),
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: SizedBox(
                  height: 50.h,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Sirkadiet",
                            style: GoogleFonts.poppins(fontSize: 16),
                          ),

                          Row(
                            children: [
                              Text("Star",style: GoogleFonts.poppins(fontSize: 15,color: Colors.grey)),
                              Icon(Icons.arrow_right, color: Colors.grey),
                            ],
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Sirkafluid",
                          style: GoogleFonts.poppins(fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Row(
                            children: [
                              Text("Harp",style: GoogleFonts.poppins(fontSize: 15,color: Colors.grey)),
                              Icon(Icons.arrow_right, color: Colors.grey),
                            ],
                          ),
                        )
                      ],
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
