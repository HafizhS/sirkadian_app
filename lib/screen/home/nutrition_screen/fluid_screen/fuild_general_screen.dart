import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fraction/fraction.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/controller/fluid_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sirkadian_app/screen/home/nutrition_screen/fluid_screen/fluid_history_screen.dart';
import '../../../../controller/hexcolor_controller.dart';
import '../../../../controller/food_controller.dart';
import '../../../../controller/information_controller.dart';
import '../../../../controller/user_controller.dart';
import '../../../../model/obejctbox_model.dart/food_fluid_exercise_model.dart';
import '../../../../objectbox.g.dart';
import '../../../../widget/food_widget/necessity_gauge.dart';

class FluidGeneralScreen extends StatefulWidget {
  final Function(int index)? change;

  FluidGeneralScreen({Key? key, this.change}) : super(key: key);

  @override
  _FluidGeneralScreenState createState() => _FluidGeneralScreenState();
}

class _FluidGeneralScreenState extends State<FluidGeneralScreen> {
  final data = GetStorage('myData');
  final foodController = Get.find<FoodController>();
  final fluidController = Get.find<FluidController>();
  final userController = Get.find<UserController>();
  final informationController = Get.find<InformationController>();
  final color = Get.find<ColorConstantController>();

  // ScrollController _scrollController = ScrollController();
  bool closeTopContainer = false;
  late Stream<List<Fluid>> _fluidStream;
  late Stream<List<Food>> _necessityStream;
  double nutrition = 0;
  double waterTotal = 0;
  double waterMakan = 0;
  double waterMinum = 0;
  var hasbeeninitialized = false;
  DateTime now = DateTime.now();

  @override
  void initState() {
    // getApplicationDocumentsDirectory().then((dir) {
    //   fluidController.fluidStore =
    //       Store(getObjectBoxModel(), directory: '${dir.path}/fluid');
    // }).then((value) =>
    setState(() {
      _fluidStream = fluidController.fluidStore
          .box<Fluid>()
          .query(Fluid_.date.equals(fluidController.selectedDay.toString()))
          .watch(triggerImmediately: true)
          .map((query) => query.find());

      _necessityStream = foodController.foodStore
          .box<Food>()
          .query(Food_.date.equals(foodController.selectedDay.toString()))
          .watch(triggerImmediately: true)
          .map((query) => query.find());

      hasbeeninitialized = true;
    });
    // );
    super.initState();
  }

  // @override
  // void dispose() {
  //   fluidController.fluidStore.close();
  //   hasbeeninitialized = false;
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return !hasbeeninitialized
        ? SafeArea(
            child: CircularProgressIndicator(
              color: color.secondaryColor,
            ),
          )
        : StreamBuilder2<List<Fluid>, List<Food>>(
            streams: Tuple2(_fluidStream, _necessityStream),
            builder: (context, snapshot) {
              switch (snapshot.item1.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(
                      color: color.secondaryColor,
                    ),
                  );
                case ConnectionState.active:
                  return SafeArea(
                      child: childWidget(
                          context, snapshot.item1.data!, snapshot.item2.data!));
                case ConnectionState.done:
                  return SafeArea(
                    child: childWidget(
                        context, snapshot.item1.data!, snapshot.item2.data!),
                  );
              }
            });
  }

  Widget childWidget(
      BuildContext context, List<Fluid> listFluid, List<Food> listFood) {
    String formattedDate = DateFormat('kk:mm:ss \n EEE d MMM').format(now);
    fluidController.isCheckedDrinkWater.value = [
      false,
      false,
      false,
      false,
      false,
      false,
      false,
      false
    ];
    listFluid.asMap().forEach((idx, a) {
      // totalWater += a.amountWater!;
      if (idx < 8) {
        fluidController.isCheckedDrinkWater[idx] = true;
      }
    });

    waterTotal = 0;
    waterMakan = 0;
    waterMinum = 0;
    listFood.forEach((element) {
      waterTotal += (element.water! / element.serving!);
      waterMakan += (element.water! / element.serving!);
    });
    listFluid.forEach((element) {
      waterTotal += element.amountWater!;
      waterMinum += element.amountWater!;
    });

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20.w),
                child: Text(
                  'Penuhi Kebutuhan Cairanmu',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: color.secondaryTextColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              NeumorphicButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FluidHistoryScreen()));
                  // informationController.snackBarError('Fitur Belum Tersedia',
                  //     'Kami sedang mengerjakan fitur tersebut');
                },
                padding: EdgeInsets.all(5.sp),
                style: NeumorphicStyle(
                  depth: 2,
                  color: color.bgColor,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(5)),
                ),
                margin: EdgeInsets.only(right: 20.w),
                child: FaIcon(
                  FontAwesomeIcons.history,
                  size: 20.sp,
                  color: color.secondaryTextColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 18.h),
          DrinkWaters(
            color: color,
            fluidController: fluidController,
            listFLuid: listFluid,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Neumorphic(
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                style: NeumorphicStyle(
                  depth: 4,
                  shape: NeumorphicShape.flat,
                  color: color.bgColor,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
                ),
                margin: EdgeInsets.all(20.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomPaint(
                      child: Container(
                        alignment: Alignment.center,
                        height: 150.h,
                        width: 130.w,
                        child: Text(
                          '${((waterTotal / foodController.necessity.value.water!) * 100).round().toString()}%',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: color.blueColor,
                                fontSize: 35.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      foregroundPainter: CircleProgressBarPainter(
                        foregroundColor: color.blueColor,
                        backgroundColor:
                            color.secondaryTextColor.withOpacity(0.3),
                        percentage:
                            waterTotal / foodController.necessity.value.water!,
                        sizeContainer: Size(150.h, 130.w),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: '${waterTotal.round().toStringAsFixed(0)}',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: color.primaryTextColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.normal),
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text:
                                  ' / ${foodController.necessity.value.water!.toStringAsFixed(0)}',
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: color.primaryTextColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold))),
                          TextSpan(
                            text: ' ml',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: color.primaryTextColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      'Makan:   ${waterMakan.round().toStringAsFixed(0)} ml',
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            color: color.secondaryTextColor,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Text(
                      'Minum:   ${waterMinum.round().toStringAsFixed(0)} ml',
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            color: color.secondaryTextColor,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  NeumorphicButton(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                    onPressed: () {
                      showDialogX();
                    },
                    style: NeumorphicStyle(
                        color: color.bgColor,
                        shape: NeumorphicShape.flat,
                        boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(20),
                        )),
                    child: FaIcon(FontAwesomeIcons.cog),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          visualDensity:
                              VisualDensity(horizontal: -4, vertical: -4),
                          splashRadius: 15.sp,
                          onPressed: () {
                            if (sum <= 1) {
                              print('dah mentok');
                            } else {
                              setState(() {
                                sum = sum - 0.25;
                              });
                            }
                          },
                          icon: Icon(
                            Icons.chevron_left,
                            size: 20.sp,
                          )),
                      Container(
                        child: Text(
                          sum == 1.0 ||
                                  sum == 2.0 ||
                                  sum == 3.0 ||
                                  sum == 4.0 ||
                                  sum == 5.0
                              ? sum.toStringAsFixed(0)
                              : sum.toMixedFraction().toString(),
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                color: color.secondaryTextColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                      IconButton(
                          visualDensity:
                              VisualDensity(horizontal: -4, vertical: -4),
                          splashRadius: 15.sp,
                          onPressed: () {
                            if (sum >= 5) {
                              print('dah mentok');
                            } else {
                              setState(() {
                                sum = sum + 0.25;
                              });
                            }
                          },
                          icon: Icon(
                            Icons.chevron_right,
                            size: 20.sp,
                          )),
                    ],
                  ),
                  Text(
                    'Gelas',
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          color: color.secondaryTextColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  NeumorphicButton(
                    padding:
                        EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                    onPressed: () {
                      if (u1) {
                        final fluid = Fluid(
                          isChecked: true,
                          size: val1,
                          sum: sum,
                          amountWater: val1 * sum,
                          fluidTime: formattedDate,
                          date: fluidController.selectedDay.toString(),
                        );
                        fluidController.fluidStore.box<Fluid>().put(fluid);
                      } else if (u2) {
                        final fluid = Fluid(
                          isChecked: true,
                          size: val2,
                          sum: sum,
                          amountWater: val2 * sum,
                          fluidTime: formattedDate,
                          date: fluidController.selectedDay.toString(),
                        );
                        fluidController.fluidStore.box<Fluid>().put(fluid);
                      } else if (u3) {
                        final fluid = Fluid(
                          isChecked: true,
                          size: val3,
                          sum: sum,
                          amountWater: val3 * sum,
                          fluidTime: formattedDate,
                          date: fluidController.selectedDay.toString(),
                        );
                        fluidController.fluidStore.box<Fluid>().put(fluid);
                      } else if (u4) {
                        final fluid = Fluid(
                          isChecked: true,
                          size: val4,
                          sum: sum,
                          amountWater: val4 * sum,
                          fluidTime: formattedDate,
                          date: fluidController.selectedDay.toString(),
                        );
                        fluidController.fluidStore.box<Fluid>().put(fluid);
                      } else if (u5) {
                        final fluid = Fluid(
                          isChecked: true,
                          size: val5,
                          sum: sum,
                          amountWater: val5 * sum,
                          fluidTime: formattedDate,
                          date: fluidController.selectedDay.toString(),
                        );
                        fluidController.fluidStore.box<Fluid>().put(fluid);
                      } else if (u6) {
                        final fluid = Fluid(
                          isChecked: true,
                          size: val6,
                          sum: sum,
                          amountWater: val6 * sum,
                          fluidTime: formattedDate,
                          date: fluidController.selectedDay.toString(),
                        );
                        fluidController.fluidStore.box<Fluid>().put(fluid);
                      } else if (u7) {
                        final fluid = Fluid(
                          isChecked: true,
                          size: val7,
                          sum: sum,
                          amountWater: val7 * sum,
                          fluidTime: formattedDate,
                          date: fluidController.selectedDay.toString(),
                        );
                        fluidController.fluidStore.box<Fluid>().put(fluid);
                      }
                    },
                    style: NeumorphicStyle(
                        color: color.bgColor,
                        shape: NeumorphicShape.flat,
                        boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(20),
                        )),
                    child: FaIcon(FontAwesomeIcons.glassWhiskey),
                  ),
                ],
              ),
            ],
          ),
          //segment 2

          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20.w),
                child: Text(
                  'Riwayat minum hari ini  ',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: color.secondaryTextColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Text(
                foodController.dateNoww,
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                      color: color.secondaryTextColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
          Container(
              height: 400.h,
              child: listFluid.isEmpty
                  ? Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.sp),
                        child: Text(
                          'Anda belum minum hari ini, yuk sisihkan waktu untuk minum air putih.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                color: color.secondaryTextColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: listFluid.length,
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
                                          'Pukul : ' +
                                              listFluid[index]
                                                  .fluidTime!
                                                  .substring(0, 8),
                                          style: GoogleFonts.inter(
                                            textStyle: TextStyle(
                                                color: color.secondaryTextColor,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              listFluid[index]
                                                      .sum!
                                                      .toStringAsFixed(0) +
                                                  ' Gelas',
                                              style: GoogleFonts.inter(
                                                textStyle: TextStyle(
                                                    color: color
                                                        .secondaryTextColor,
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                            SizedBox(width: 10.w),
                                            Text(
                                              listFluid[index]
                                                      .amountWater!
                                                      .toStringAsFixed(0) +
                                                  ' ml',
                                              style: GoogleFonts.inter(
                                                textStyle: TextStyle(
                                                    color: color
                                                        .secondaryTextColor,
                                                    fontSize: 14.sp,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.only(
                                      right: 10.w, bottom: 10.h),
                                  child: NeumorphicButton(
                                    onPressed: () {
                                      // setState(() {
                                      fluidController.fluidStore
                                          .box<Fluid>()
                                          .remove(listFluid[index].id);
                                    },
                                    style: NeumorphicStyle(
                                      depth: 4,
                                      shape: NeumorphicShape.flat,
                                      boxShape: NeumorphicBoxShape.circle(),
                                      color: color.bgColor,
                                    ),
                                    padding: EdgeInsets.all(10.sp),
                                    child: FaIcon(
                                      FontAwesomeIcons.trash,
                                      size: 12.sp,
                                      color: color.secondaryColor,
                                    ),
                                  ),
                                )
                              ],
                            ));
                      })),
        ],
      ),
    );
  }

  double sum = 1.0;
  bool u1 = true;
  double val1 = 100;
  bool u2 = false;
  double val2 = 125;
  bool u3 = false;
  double val3 = 150;
  bool u4 = false;
  double val4 = 175;
  bool u5 = false;
  double val5 = 200;
  bool u6 = false;
  double val6 = 300;
  bool u7 = false;
  double val7 = 400;

  void showDialogX() {
    Get.bottomSheet(
      Container(
        height: 300.h,
        width: 360.w,
        // margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        ),
        child: Column(
          children: [
            Text(
              'Ubah Ukuran Gelas',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: color.secondaryTextColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 18.h),
            Container(
              height: 250.h,
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, mainAxisSpacing: 1),
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        u1 = true;
                        u2 = false;
                        u3 = false;
                        u4 = false;
                        u5 = false;
                        u6 = false;
                        u7 = false;
                      });
                      Get.back();
                    },
                    child: GridTile(
                      child: (u1)
                          ? Container(
                              child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/100mlc.png',
                                  height: 30,
                                  width: 30,
                                ),
                                Text(
                                  '100 ml',
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        color: color.secondaryColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            ))
                          : Container(
                              child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/100ml.png',
                                  height: 30,
                                  width: 30,
                                ),
                                Text(
                                  '100 ml',
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        color: color.secondaryTextColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        u1 = false;
                        u2 = true;
                        u3 = false;
                        u4 = false;
                        u5 = false;
                        u6 = false;
                        u7 = false;
                      });
                      Get.back();
                    },
                    child: GridTile(
                      child: (u2)
                          ? Container(
                              child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/125ml.png',
                                  height: 30,
                                  width: 30,
                                ),
                                Text(
                                  '125 ml',
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        color: color.secondaryColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            ))
                          : Container(
                              child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/125ml.png',
                                  height: 30,
                                  width: 30,
                                ),
                                Text(
                                  '125 ml',
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        color: color.secondaryTextColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        u1 = false;
                        u2 = false;
                        u3 = true;
                        u4 = false;
                        u5 = false;
                        u6 = false;
                        u7 = false;
                      });
                      Get.back();
                    },
                    child: GridTile(
                      child: (u3)
                          ? Container(
                              child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/150ml.png',
                                  height: 30,
                                  width: 30,
                                ),
                                Text(
                                  '150 ml',
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        color: color.secondaryColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            ))
                          : Container(
                              child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/150ml.png',
                                  height: 30,
                                  width: 30,
                                ),
                                Text(
                                  '150 ml',
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        color: color.secondaryTextColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        u1 = false;
                        u2 = false;
                        u3 = false;
                        u4 = true;
                        u5 = false;
                        u6 = false;
                        u7 = false;
                      });
                      Get.back();
                    },
                    child: GridTile(
                      child: (u4)
                          ? Container(
                              child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/175mlc.png',
                                  height: 30,
                                  width: 30,
                                ),
                                Text(
                                  '175 ml',
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        color: color.secondaryColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            ))
                          : Container(
                              child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/175ml.png',
                                  height: 30,
                                  width: 30,
                                ),
                                Text(
                                  '175 ml',
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        color: color.secondaryTextColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        u1 = false;
                        u2 = false;
                        u3 = false;
                        u4 = false;
                        u5 = true;
                        u6 = false;
                        u7 = false;
                      });
                      Get.back();
                    },
                    child: GridTile(
                      child: (u5)
                          ? Container(
                              child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/200mlc.png',
                                  height: 30,
                                  width: 30,
                                ),
                                Text(
                                  '200 ml',
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        color: color.secondaryColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            ))
                          : Container(
                              child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/200ml.png',
                                  height: 30,
                                  width: 30,
                                ),
                                Text(
                                  '200 ml',
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        color: color.secondaryTextColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        u1 = false;
                        u2 = false;
                        u3 = false;
                        u4 = false;
                        u5 = false;
                        u6 = true;
                        u7 = false;
                      });
                      Get.back();
                    },
                    child: GridTile(
                      child: (u6)
                          ? Container(
                              child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/300mlc.png',
                                  height: 30,
                                  width: 30,
                                ),
                                Text(
                                  '300 ml',
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        color: color.secondaryColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            ))
                          : Container(
                              child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/300ml.png',
                                  height: 30,
                                  width: 30,
                                ),
                                Text(
                                  '300 ml',
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        color: color.secondaryTextColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        u1 = false;
                        u2 = false;
                        u3 = false;
                        u4 = false;
                        u5 = false;
                        u6 = false;
                        u7 = true;
                      });
                      Get.back();
                    },
                    child: GridTile(
                      child: (u7)
                          ? Container(
                              child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/400mlc.png',
                                  height: 30,
                                  width: 30,
                                ),
                                Text(
                                  '400 ml',
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        color: color.secondaryColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            ))
                          : Container(
                              child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/400ml.png',
                                  height: 30,
                                  width: 30,
                                ),
                                Text(
                                  '400 ml',
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        color: color.secondaryTextColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            )),
                    ),
                  ),
                  GridTile(
                    child: Container(
                        child: Column(
                      children: [
                        Icon(Icons.local_drink),
                        Text(
                          'Kustom',
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                color: color.secondaryTextColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DrinkWaters extends StatefulWidget {
  const DrinkWaters(
      {Key? key,
      required this.color,
      required this.fluidController,
      required this.listFLuid})
      : super(key: key);

  final FluidController fluidController;
  final ColorConstantController color;
  final List<Fluid> listFLuid;

  @override
  State<DrinkWaters> createState() => _DrinkWatersState();
}

class _DrinkWatersState extends State<DrinkWaters> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Text(
            'Minum air putih 8 gelas sehari',
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                  color: widget.color.secondaryTextColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.normal),
            ),
          ),
          Container(
            height: 60.h,
            width: 360.w,
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: widget.fluidController.isCheckedDrinkWater.length,
                itemBuilder: (context, index) {
                  return Obx(
                    () => Neumorphic(
                        margin: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 5.w),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 10.w),
                        style: NeumorphicStyle(
                          depth:
                              widget.fluidController.isCheckedDrinkWater[index]
                                  ? -4
                                  : 4,
                          color: widget.color.bgColor,
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(20),
                          ),
                        ),
                        child: FaIcon(
                          FontAwesomeIcons.wineGlassAlt,
                          size: 16.sp,
                          color:
                              widget.fluidController.isCheckedDrinkWater[index]
                                  ? widget.color.secondaryColor
                                  : widget.color.secondaryTextColor,
                        )),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
