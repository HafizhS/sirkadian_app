import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/constant/hex_color.dart';
import 'package:sirkadian_app/screen/settings/settings_notification_screen.dart';
import 'package:sirkadian_app/screen/settings/settings_volume_screen.dart';

class SettingsGeneralScreen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Pengaturan".toUpperCase(),
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
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        PageRouteBuilder(pageBuilder: (_, __, ___) => SettingsVolumeScreen())
                    );
                  },
                  child: SizedBox(
                    height: 50.h,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.volume_up_outlined,
                              color: HexColor.fromHex("73C639")),
                          const SizedBox(width: 5),
                          Text(
                            "Volume",
                            style: GoogleFonts.poppins(fontSize: 16),
                          ),
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
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(pageBuilder: (_, __, ___) => SettingsNotificationScreen())
                    );
                  },
                  child: SizedBox(
                    height: 50.h,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.notifications_none_outlined,
                              color: HexColor.fromHex("73C639")),
                          const SizedBox(width: 5),
                          Text(
                            "Notifikasi",
                            style: GoogleFonts.poppins(fontSize: 16),
                          ),
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
