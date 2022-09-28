import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/constant/hex_color.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../widget/custom_widget/custom_calendar_bar_widget.dart';

class ActivitiesKaloriScreen extends StatefulWidget {
  @override
  State<ActivitiesKaloriScreen> createState() => _ActivitiesKaloriScreenState();
}

class _ActivitiesKaloriScreenState extends State<ActivitiesKaloriScreen> {
  // Dummy Data
  List<_DoughnutData> pieData = List.of({
    _DoughnutData("xData", 50, "Data 1", HexColor.fromHex("ABDD88")),
    _DoughnutData("xData", 50, "Data 2", HexColor.fromHex("73C639")),
    _DoughnutData("xData", 20, "Data 3", HexColor.fromHex("8FD161")),
  });

  // Dummy Data
  List<_StackedBarData> weeklyDataSample = List.of({
    _StackedBarData('Senin', 12, 10, 14),
    _StackedBarData('Selasa', 14, 11, 18),
    _StackedBarData('Rabu', 16, 10, 15),
    _StackedBarData('Kamis', 18, 16, 18),
    _StackedBarData('Jumat', 18, 16, 18),
    _StackedBarData('Sabtu', 18, 16, 18),
    _StackedBarData('Minggu', 18, 16, 18),
  });

  var currentTimeline = _KaloriTimeline.DAILY.obs;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomCalenderBarWidget(
            onCenterPressed: () {
              if (currentTimeline.value == _KaloriTimeline.DAILY) {
                currentTimeline.value = _KaloriTimeline.WEEKLY;
                return;
              }

              if (currentTimeline.value == _KaloriTimeline.WEEKLY) {
                currentTimeline.value = _KaloriTimeline.DAILY;
                return;
              }
            },
            centerWidget: Obx( () => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(currentTimeline.value == _KaloriTimeline.DAILY ? "Day view" : "Weekly view",
                          style: GoogleFonts.inter(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 13.sp)),
                      Icon(Icons.arrow_drop_down, color: Colors.white),
                    ],
                  ),
                  Text(currentTimeline.value == _KaloriTimeline.DAILY ? "Hari ini" : "Minggu ini",
                      style: GoogleFonts.inter(
                          color: Colors.white, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Obx(() => currentTimeline.value == _KaloriTimeline.DAILY
                  ? _buildDailyColumn()
                  : _buildWeeklyColumn()))
        ],
      ),
    );
  }

  Column _buildDailyColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(35), right: Radius.circular(35))),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              children: [
                Text(
                  "Total Kalori Harian",
                  style: GoogleFonts.poppins(
                      color: HexColor.fromHex("#4E5749"),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "1800",
                      style: GoogleFonts.poppins(
                          color: HexColor.fromHex("#73C639"),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "/2500cal",
                      style: GoogleFonts.poppins(
                          color: HexColor.fromHex("#4E5749"),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  height: 180.h,
                  child: SfCircularChart(
                    series: [
                      DoughnutSeries<_DoughnutData, String>(
                        dataSource: pieData,
                        innerRadius: "30",
                        dataLabelMapper: (datum, index) => "datum.xData",
                        dataLabelSettings: DataLabelSettings(
                          isVisible: true,
                          builder:
                              (data, point, series, pointIndex, seriesIndex) =>
                                  Text(
                            "label",
                            style: GoogleFonts.inter(color: Colors.white),
                          ),
                        ),
                        pointColorMapper: (datum, index) => datum.color,
                        xValueMapper: (datum, index) => datum.xData,
                        yValueMapper: (datum, index) => datum.yData,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ...pieData.map((e) => Column(
                            children: [
                              Container(
                                height: 18.h,
                                width: 18.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: e.color),
                              ),
                              Text(
                                "Makan Malam",
                                style:
                                    GoogleFonts.roboto(color: Colors.black45),
                              ),
                              SizedBox(height: 3),
                              Text(
                                "1500",
                                style: GoogleFonts.roboto(
                                    color: HexColor.fromHex("4E5749"),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17.sp),
                              ),
                            ],
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(25), right: Radius.circular(25))),
          elevation: 5,
          child: SizedBox(
            height: 150.h,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Text(
                    "Total Kalori Harian",
                    style: GoogleFonts.poppins(
                        color: HexColor.fromHex("#4E5749"),
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "1800",
                        style: GoogleFonts.poppins(
                            color: HexColor.fromHex("#73C639"),
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "/2500cal",
                        style: GoogleFonts.poppins(
                            color: HexColor.fromHex("#4E5749"),
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column _buildWeeklyColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(35), right: Radius.circular(35))),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              children: [
                Text(
                  "Rata - rata Kalori Mingguan",
                  style: GoogleFonts.poppins(
                      color: HexColor.fromHex("#4E5749"),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "1800",
                      style: GoogleFonts.poppins(
                          color: HexColor.fromHex("#73C639"),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "/2500cal",
                      style: GoogleFonts.poppins(
                          color: HexColor.fromHex("#4E5749"),
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  height: 180.h,
                  child: SfCartesianChart(
                    primaryXAxis: CategoryAxis(),
                    series: <ChartSeries>[
                      StackedColumnSeries<_StackedBarData, String>(
                        dataSource: weeklyDataSample,
                        pointColorMapper: (datum, index) =>
                            HexColor.fromHex("73C639"),
                        xValueMapper: (datum, index) => datum.x,
                        yValueMapper: (datum, index) => datum.y1,
                      ),
                      StackedColumnSeries<_StackedBarData, String>(
                        dataSource: weeklyDataSample,
                        pointColorMapper: (datum, index) =>
                            HexColor.fromHex("8FD161"),
                        xValueMapper: (datum, index) => datum.x,
                        yValueMapper: (datum, index) => datum.y2,
                      ),
                      StackedColumnSeries<_StackedBarData, String>(
                        dataSource: weeklyDataSample,
                        pointColorMapper: (datum, index) =>
                            HexColor.fromHex("ABDD88"),
                        xValueMapper: (datum, index) => datum.x,
                        yValueMapper: (datum, index) => datum.y3,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ...pieData.map((e) => Column(
                            children: [
                              Container(
                                height: 18.h,
                                width: 18.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    color: e.color),
                              ),
                              Text(
                                "Makan Malam",
                                style:
                                    GoogleFonts.roboto(color: Colors.black45),
                              ),
                              SizedBox(height: 3),
                              Text(
                                "1500",
                                style: GoogleFonts.roboto(
                                    color: HexColor.fromHex("4E5749"),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17.sp),
                              ),
                            ],
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Card(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(25), right: Radius.circular(25))),
          elevation: 5,
          child: SizedBox(
            height: 150.h,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: [
                  Text(
                    "Rata - rata cairan mingguan",
                    style: GoogleFonts.poppins(
                        color: HexColor.fromHex("#4E5749"),
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "1800",
                        style: GoogleFonts.poppins(
                            color: HexColor.fromHex("#73C639"),
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "/2500cal",
                        style: GoogleFonts.poppins(
                            color: HexColor.fromHex("#4E5749"),
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

// Stack _buildLinearIndicator() {
//   return Stack(
//     children: [
//       cairanPercent < 1
//           ? Container(
//         width: widthCairan * cairanPercent,
//         height: 20,
//         decoration: BoxDecoration(
//             color: Colors.green,
//             borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(300),
//                 bottomLeft: Radius.circular(300),
//                 topRight: Radius.elliptical(0, 0))),
//       )
//           : Container(
//         width: widthCairan,
//         height: 20,
//         decoration: BoxDecoration(
//             color: Colors.green,
//             borderRadius: BorderRadius.all(Radius.circular(50))),
//       ),
//       Container(
//         width: widthCairan,
//         height: 20,
//         decoration: BoxDecoration(
//             color: Colors.transparent,
//             border: Border.all(color: Colors.green),
//             borderRadius: BorderRadius.all(Radius.circular(50))),
//       )
//     ],
//   );
// }
}

enum _KaloriTimeline {
  DAILY,
  WEEKLY,
}

class _StackedBarData {
  _StackedBarData(this.x, this.y1, this.y2, this.y3);

  final String x;
  final int y1;
  final int y2;
  final int y3;
}

class _DoughnutData {
  _DoughnutData(this.xData, this.yData, this.text, this.color);

  final String xData;
  final num yData;
  final String text;
  final Color color;
}
