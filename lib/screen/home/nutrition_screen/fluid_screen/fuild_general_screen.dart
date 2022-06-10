import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/controller/fluid_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sirkadian_app/screen/home/nutrition_screen/fluid_screen/fluid_history_screen.dart';
import '../../../../controller/hexcolor_controller.dart';
import '../../../../controller/food_controller.dart';
import '../../../../widget/food_widget/necessity_gauge.dart';

class FluidGeneralScreen extends StatefulWidget {
  final Function(int index)? change;

  FluidGeneralScreen({Key? key, this.change}) : super(key: key);

  @override
  _FluidGeneralScreenState createState() => _FluidGeneralScreenState();
}

class _FluidGeneralScreenState extends State<FluidGeneralScreen> {
  final foodController = Get.find<FoodController>();
  final fluidController = Get.find<FluidController>();
  final color = Get.find<ColorConstantController>();
  ScrollController _scrollController = ScrollController();
  bool closeTopContainer = false;

  late String dateTimeView;

  @override
  void initState() {
    _scrollController.addListener(() {
      setState(() {
        if (closeTopContainer == false) {
          print('false');
          closeTopContainer = _scrollController.offset > 50;
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //segment 1
        AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: closeTopContainer ? 0 : 1,
          child: AnimatedContainer(
            height: closeTopContainer ? 0 : 400.h,
            duration: const Duration(milliseconds: 200),
            child: FittedBox(
              fit: BoxFit.fill,
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: 360.w,
                child: (Column(
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
                                    builder: (context) =>
                                        FluidHistoryScreen()));
                          },
                          padding: EdgeInsets.all(5.sp),
                          style: NeumorphicStyle(
                            depth: 2,
                            color: color.bgColor,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(5)),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Neumorphic(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30.w, vertical: 10.h),
                          style: NeumorphicStyle(
                            depth: 4,
                            shape: NeumorphicShape.flat,
                            color: color.bgColor,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(20)),
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
                                    '${((foodController.water / foodController.necessity.value.water!) * 100).round().toString()}%',
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
                                  percentage: foodController.water /
                                      foodController.necessity.value.water!,
                                  sizeContainer: Size(150.h, 130.w),
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: foodController.water.toStringAsFixed(0),
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
                              )
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            NeumorphicButton(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.h, horizontal: 20.w),
                              onPressed: () {},
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
                                    visualDensity: VisualDensity(
                                        horizontal: -4, vertical: -4),
                                    splashRadius: 15.sp,
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.chevron_left,
                                      size: 20.sp,
                                    )),
                                Container(
                                  child: Text(
                                    // sum == 1.0 ||
                                    //         sum == 2.0 ||
                                    //         sum == 3.0 ||
                                    //         sum == 4.0 ||
                                    //         sum == 5.0
                                    //     ? sum.toStringAsFixed(0)
                                    //     : sum
                                    //         .toMixedFraction()
                                    //         .toString(),
                                    '1.0',
                                    style: GoogleFonts.inter(
                                      textStyle: TextStyle(
                                          color: color.secondaryTextColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ),
                                IconButton(
                                    visualDensity: VisualDensity(
                                        horizontal: -4, vertical: -4),
                                    splashRadius: 15.sp,
                                    onPressed: () {},
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
                              padding: EdgeInsets.symmetric(
                                  vertical: 20.h, horizontal: 20.w),
                              onPressed: () {},
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
                    DrinkWaters(
                      color: color,
                      fluidController: fluidController,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                )),
              ),
            ),
          ),
        ),

        //segment 3
        // nanti ini ditaruh yg analisis urin itu aja
      ],
    );
  }
}

class DrinkWaters extends StatelessWidget {
  const DrinkWaters(
      {Key? key, required this.color, required this.fluidController})
      : super(key: key);

  final FluidController fluidController;
  final ColorConstantController color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Minum 8 kali sehari',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: color.secondaryTextColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Container(
            height: 60.h,
            width: 360.w,
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: fluidController.isCheckedDrinkWater.length,
                itemBuilder: (context, index) {
                  return Obx(
                    () => NeumorphicButton(
                        onPressed: () {
                          fluidController.isCheckedDrinkWater[index] =
                              !fluidController.isCheckedDrinkWater[index];
                        },
                        margin: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 5.w),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.h, horizontal: 10.w),
                        style: NeumorphicStyle(
                          depth: fluidController.isCheckedDrinkWater[index]
                              ? -4
                              : 4,
                          color: color.bgColor,
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(20),
                          ),
                        ),
                        child: FaIcon(
                          FontAwesomeIcons.wineGlassAlt,
                          size: 20.sp,
                          color: fluidController.isCheckedDrinkWater[index]
                              ? color.secondaryColor
                              : color.secondaryTextColor,
                        )),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
