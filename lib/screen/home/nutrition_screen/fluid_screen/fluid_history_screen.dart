import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sirkadian_app/controller/fluid_controller.dart';
import '../../../../controller/hexcolor_controller.dart';
import '../../../../controller/information_controller.dart';
import '../../../../model/obejctbox_model.dart/food_fluid_exercise_model.dart';

class FluidHistoryScreen extends StatefulWidget {
  FluidHistoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<FluidHistoryScreen> createState() => _FluidHistoryScreenState();
}

class _FluidHistoryScreenState extends State<FluidHistoryScreen> {
  // final foodController = Get.find<FoodController>();
  final fluidController = Get.find<FluidController>();
  final informationController = Get.find<InformationController>();
  final color = Get.find<ColorConstantController>();
  late Stream<List<Fluid>> _fluidStreamAll;
  var hasbeeninitialized = false;
  List<Fluid> _searchResult = [];
  String selectedDate = '0000-00-00';
  String convertDate(DateTime dateTime) {
    return selectedDate = DateFormat('yyyy-MM-dd').format(dateTime);
  }

  @override
  void initState() {
    setState(() {
      _fluidStreamAll = fluidController.fluidStore
          .box<Fluid>()
          .query()
          .watch(triggerImmediately: true)
          .map((query) => query.find());
      hasbeeninitialized = true;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: color.bgColor,
        body: !hasbeeninitialized
            ? SafeArea(
                child: CircularProgressIndicator(
                  color: color.secondaryColor,
                ),
              )
            : StreamBuilder<List<Fluid>>(
                stream: _fluidStreamAll,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(
                          color: color.secondaryColor,
                        ),
                      );
                    case ConnectionState.active:
                      return SafeArea(
                          child: childWidget(context, snapshot.data!));
                    case ConnectionState.done:
                      return SafeArea(
                        child: childWidget(context, snapshot.data!),
                      );
                  }
                }));
  }

  SafeArea childWidget(BuildContext context, List<Fluid> fluidAll) {
    print(fluidAll.length);
    return SafeArea(
        child: Column(children: [
      //segment 1
      Padding(
        padding: EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20),
              child: NeumorphicButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: NeumorphicStyle(
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.circle(),
                  color: color.bgColor,
                ),
                padding: const EdgeInsets.all(16.0),
                child: FaIcon(
                  FontAwesomeIcons.chevronLeft,
                  size: 16,
                  color: color.secondaryTextColor,
                ),
              ),
            ),
            Text(
              'Riwayat Minum',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: color.primaryTextColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 20),
              child: NeumorphicButton(
                onPressed: () {
                  if (_searchResult.isNotEmpty) {
                    setState(() {
                      _searchResult.clear();
                    });
                  } else {
                    DatePicker.showDatePicker(context,
                        showTitleActions: true,
                        theme: DatePickerTheme(
                          headerColor: color.secondaryColor,
                          cancelStyle: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: color.primaryColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.normal),
                          ),
                          itemStyle: GoogleFonts.inter(
                            textStyle: TextStyle(
                                color: color.secondaryTextColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.normal),
                          ),
                          doneStyle: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: color.primaryColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        minTime: DateTime(2020, 1, 1),
                        maxTime: DateTime(DateTime.now().year,
                            DateTime.now().month, DateTime.now().day),
                        onChanged: (date) {}, onConfirm: (date) {
                      setState(() {
                        convertDate(date);
                      });
                      fluidAll.forEach((element) {
                        if (element.date == convertDate(date)) {
                          _searchResult.add(element);
                        }
                      });
                      if (_searchResult.isEmpty) {
                        informationController.snackBarError(
                            'Data Tidak Ditemukan',
                            'Tidak ada riwayat minum pada tanggal tersebut.');
                      }
                    }, currentTime: DateTime.now(), locale: LocaleType.id);
                  }
                },
                style: NeumorphicStyle(
                  depth: _searchResult.isNotEmpty ? -4 : 4,
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.circle(),
                  color: color.bgColor,
                ),
                padding: const EdgeInsets.all(16.0),
                child: FaIcon(
                  FontAwesomeIcons.search,
                  size: 16,
                  color: _searchResult.isNotEmpty
                      ? color.secondaryColor
                      : color.secondaryTextColor,
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 18.h),
      //segment 2
      _searchResult.isNotEmpty
          ? historyListWidget(sourceList: _searchResult)
          : historyListWidget(sourceList: fluidAll)
    ]));
  }

  Widget historyListWidget({List<Fluid>? sourceList}) {
    return sourceList!.isEmpty
        ? Expanded(
            child: Center(
              child: Text(
                'Belum ada Riwayat Minum.',
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                      color: color.secondaryTextColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
          )
        : Expanded(
            child: ListView.builder(
                itemCount: sourceList.length,
                itemBuilder: (context, index) {
                  return Neumorphic(
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.w, vertical: 10.h),
                      style: NeumorphicStyle(
                        depth: 4,
                        shape: NeumorphicShape.flat,
                        color: color.primaryColor,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(20)),
                      ),
                      margin: EdgeInsets.symmetric(
                          horizontal: 30.w, vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              FaIcon(FontAwesomeIcons.clock),
                              SizedBox(width: 30.w),
                              Column(
                                children: [
                                  Text(
                                    sourceList[index]
                                        .fluidTime!
                                        .substring(0, 8),
                                    style: GoogleFonts.inter(
                                      textStyle: TextStyle(
                                          color: color.secondaryTextColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  Text(
                                    sourceList[index].sum!.toStringAsFixed(0) +
                                        ' Gelas',
                                    style: GoogleFonts.inter(
                                      textStyle: TextStyle(
                                          color: color.secondaryTextColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                sourceList[index]
                                        .amountWater!
                                        .toStringAsFixed(0) +
                                    ' ml',
                                style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      color: color.secondaryTextColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              Text(
                                sourceList[index].date!.substring(0, 10),
                                style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      color: color.secondaryTextColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ],
                          )
                        ],
                      ));
                }));
  }
}
