import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/constant/hex_color.dart';

import '../../widget/custom_widget/custom_calendar_bar_widget.dart';
import '../settings/settings_general_screen_2.dart';
import 'activities_kalori_screen.dart';
import 'activities_nutrisi_screen.dart';

class ActivitiesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ActivitiesState();
}

class ActivitiesState extends State<ActivitiesScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingsGeneralScreen2(),));
                    },
                    icon: Icon(Icons.settings, color: Colors.white))
              ],
              backgroundColor: HexColor.fromHex("#73C639"),
              title: Text(
                "Aktivitas".toUpperCase(),
                style: GoogleFonts.poppins(
                    fontSize: 20.sp,
                    letterSpacing: 3.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.w700),
              ),
              bottom: TabBar(
                onTap: (value) {

                },
                indicatorColor: Colors.white,
                labelColor: Colors.white,
                tabs: [
                  Tab(text: "Kalori"),
                  Tab(text: "Nutrisi"),
                ],
              )),
          body: Column(
            children: [
              // ActivitiesCalendarNavWidget(),
              Expanded(
                flex: 1,
                child: TabBarView(
                  children: [
                    Navigator(
                      onGenerateRoute: (settings) => PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) =>
                              ActivitiesKaloriScreen()),
                    ),
                    ActivitiesNutrisiScreen(),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
