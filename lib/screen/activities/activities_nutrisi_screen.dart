import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sirkadian_app/constant/hex_color.dart';

import '../../widget/custom_widget/custom_calendar_bar_widget.dart';
import '../../widget/custom_widget/custom_linear_bar_widget.dart';

class ActivitiesNutrisiScreen extends StatelessWidget {
  ActivitiesNutrisiScreen({Key? key}) : super(key: key);

  // Dummy Data for Macro Nutrition
  var macroData = Map.of({
    "kalori": {
      "current": 1250,
      "total": 2500,
      "color": HexColor.fromHex("73C639")
    },
    "karbohidrat": {
      "current": 700,
      "total": 800,
      "color": HexColor.fromHex("EAC648")
    },
    "protein": {
      "current": 200,
      "total": 1000,
      "color": HexColor.fromHex("D95978")
    },
    "lemak": {
      "current": 100,
      "total": 200,
      "color": HexColor.fromHex("8B60D2")
    },
  });

  double _getMacroPercentage(String keys) {
    return (_getMacroCurrent(keys) / _getMacroTotal(keys)).clamp(0, 1);
  }

  int _getMacroCurrent(String keys) {
    return macroData[keys]!["current"] as int;
  }

  int _getMacroTotal(String keys) {
    return macroData[keys]!["total"] as int;
  }

  Color _getMacroColor(String keys) {
    return macroData[keys]!["color"] as Color;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomCalenderBarWidget(
            centerWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Day view",
                        style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 13.sp)),
                    Icon(Icons.arrow_drop_down, color: Colors.white),
                  ],
                ),
                Text("Hari ini",
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.w500)),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom,
                left: 10,
                right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Makro nutrisi
                _buildMakroCard(),

                const SizedBox(height: 10),

                // Mikro nutrisi
                _buildMikroCard(),
              ],
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }

  Card _buildMakroCard() {
    return Card(
      elevation: 5,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
              left: Radius.circular(35), right: Radius.circular(35))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Makro Nutrisi",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: HexColor.fromHex("#4E5749"))),
            Text("Kalori",
                style: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: HexColor.fromHex("#4E5749"))),
            CustomLinearBarWidget(
              isIndicatorVisible: true,
              topLeadingText: "0",
              topTrailingText: "${_getMacroTotal("kalori")}kal",
              percent: .5,
              minPercentHoldIndicator: .14,
              maxPercentHoldIndicator: .80,
              indicatorText: "${_getMacroCurrent("kalori")}",
              barColor: _getMacroColor("kalori"),
              height: 25,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...macroData.keys.map((key) => key != "kalori"
                    ? Column(
                  children: [
                    Text(key,
                        style: GoogleFonts.poppins(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    _buildCircularIndicator(
                        _getMacroPercentage(key), _getMacroColor(key)),
                    Text(
                        "${_getMacroCurrent(key)}g (${(_getMacroPercentage(key) * 100).round()}%)"),
                  ],
                )
                    : Container())
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Card _buildMikroCard() {
    return Card(
      elevation: 5,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(
              left: Radius.circular(35), right: Radius.circular(35))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Mikro Nutrisi",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: 20.sp, fontWeight: FontWeight.w600)),
            const SizedBox(height: 10),
            ...List.filled(6, null).map(
              (e) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomLinearBarWidget(
                    topLeadingText: "Vitamin X",
                    topTrailingText: "100g",
                    indicatorFontSize: 17,
                    isIndicatorVisible: true,
                    indicatorText: "100",
                    minPercentHoldIndicator: 0.2,
                    barColor: Colors.grey,
                    height: 25,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Stack _buildCircularIndicator(percent, Color color) {
    return Stack(alignment: Alignment.center, children: [
      CircularPercentIndicator(
        radius: 40,
        lineWidth: 5,
        percent: 0,
      ),
      CircularPercentIndicator(
        radius: 42,
        lineWidth: 10,
        percent: percent,
        backgroundColor: Colors.transparent,
        progressColor: color,
      ),
    ]);
  }
}
