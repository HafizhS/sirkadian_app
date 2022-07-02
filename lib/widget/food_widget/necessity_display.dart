import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controller/hexcolor_controller.dart';
import '../../constant/hex_color.dart';
import '../../controller/food_controller.dart';
import '../../model/obejctbox_model.dart/food_fluid_exercise_model.dart';
import 'necessity_gauge.dart';

class NecessityDisplayWidget extends StatefulWidget {
  const NecessityDisplayWidget({
    Key? key,
    required this.color,
    required this.listMeal,
    required this.listMealSarapan,
    required this.listMealMakanSiang,
    required this.listMealMakanMalam,
    required this.foodController,
  }) : super(key: key);

  final ColorConstantController color;
  final List<Food> listMeal;
  final List<Food> listMealSarapan;
  final List<Food> listMealMakanSiang;
  final List<Food> listMealMakanMalam;
  final FoodController foodController;

  @override
  State<NecessityDisplayWidget> createState() => _NecessityDisplayWidgetState();
}

class _NecessityDisplayWidgetState extends State<NecessityDisplayWidget> {
  @override
  void initState() {
    super.initState();
    getFoodNecessity();
  }

  @override
  void didUpdateWidget(NecessityDisplayWidget oldWidget) {
    getFoodNecessity();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
        height: 530.h,
        width: double.infinity,
        child: GridView(
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            children: [
              NecessityGauge(
                onpress: () {
                  onPressNecessityGauge(
                      title: 'Kalori',
                      necessitySarapan: widget
                          .foodController.necessity.value.energy!.breakfast!,
                      necessityMakanSiang:
                          widget.foodController.necessity.value.energy!.lunch!,
                      necessityMakanMalam:
                          widget.foodController.necessity.value.energy!.dinner!,
                      nutritionTotal: widget.foodController.energy,
                      nutritionSarapan: widget.foodController.energySarapan,
                      nutritionMakanSiang:
                          widget.foodController.energyMakanSiang,
                      nutritionMakanMalam:
                          widget.foodController.energyMakanMalam,
                      unit: ' kkal');
                },
                color: widget.color,
                text: 'Kalori',
                backgroundColor:
                    widget.color.secondaryTextColor.withOpacity(0.3),
                foregroundColor: HexColor.fromHex('#5B9423'),
                value: widget.foodController.energy /
                    (widget.foodController.necessity.value.energy!.breakfast! +
                        widget.foodController.necessity.value.energy!.lunch! +
                        widget.foodController.necessity.value.energy!.dinner!),
                size: Size(100.w, 120.h),
              ),

              NecessityGauge(
                onpress: () {
                  onPressNecessityGauge(
                      title: 'Karbohidrat',
                      necessitySarapan: widget.foodController.necessity.value
                          .macro!.breakfast!.carbohydrate,
                      necessityMakanSiang: widget.foodController.necessity.value
                          .macro!.lunch!.carbohydrate,
                      necessityMakanMalam: widget.foodController.necessity.value
                          .macro!.dinner!.carbohydrate,
                      nutritionTotal: widget.foodController.carbohydrate,
                      nutritionSarapan:
                          widget.foodController.carbohydrateSarapan,
                      nutritionMakanSiang:
                          widget.foodController.carbohydrateMakanSiang,
                      nutritionMakanMalam:
                          widget.foodController.carbohydrateMakanMalam,
                      unit: ' g');
                },
                color: widget.color,
                text: 'Karbohidrat',
                backgroundColor:
                    widget.color.secondaryTextColor.withOpacity(0.3),
                foregroundColor: HexColor.fromHex('#895DD1'),
                value: widget.foodController.carbohydrate /
                    (widget.foodController.necessity.value.macro!.breakfast!
                            .carbohydrate! +
                        widget.foodController.necessity.value.macro!.lunch!
                            .carbohydrate! +
                        widget.foodController.necessity.value.macro!.dinner!
                            .carbohydrate!),
                size: Size(100.w, 120.h),
              ),
              NecessityGauge(
                onpress: () {
                  onPressNecessityGauge(
                      title: 'Protein',
                      necessitySarapan: widget.foodController.necessity.value
                          .macro!.breakfast!.protein,
                      necessityMakanSiang: widget
                          .foodController.necessity.value.macro!.lunch!.protein,
                      necessityMakanMalam: widget.foodController.necessity.value
                          .macro!.dinner!.protein,
                      nutritionTotal: widget.foodController.protein,
                      nutritionSarapan: widget.foodController.proteinSarapan,
                      nutritionMakanSiang:
                          widget.foodController.proteinMakanSiang,
                      nutritionMakanMalam:
                          widget.foodController.proteinMakanMalam,
                      unit: ' g');
                },
                color: widget.color,
                text: 'Protein',
                backgroundColor:
                    widget.color.secondaryTextColor.withOpacity(0.3),
                foregroundColor: HexColor.fromHex('#94223D'),
                value: widget.foodController.protein /
                    (widget.foodController.necessity.value.macro!.breakfast!
                            .protein! +
                        widget.foodController.necessity.value.macro!.lunch!
                            .protein! +
                        widget.foodController.necessity.value.macro!.dinner!
                            .protein!),
                size: Size(100.w, 120.h),
              ),
              NecessityGauge(
                onpress: () {
                  onPressNecessityGauge(
                      title: 'Lemak',
                      necessitySarapan: widget
                          .foodController.necessity.value.macro!.breakfast!.fat,
                      necessityMakanSiang: widget
                          .foodController.necessity.value.macro!.lunch!.fat,
                      necessityMakanMalam: widget
                          .foodController.necessity.value.macro!.dinner!.fat,
                      nutritionTotal: widget.foodController.fat,
                      nutritionSarapan: widget.foodController.fatSarapan,
                      nutritionMakanSiang: widget.foodController.fatMakanSiang,
                      nutritionMakanMalam: widget.foodController.fatMakanMalam,
                      unit: ' g');
                },
                color: widget.color,
                text: 'Lemak',
                backgroundColor:
                    widget.color.secondaryTextColor.withOpacity(0.3),
                foregroundColor: HexColor.fromHex('#D3AA19'),
                value: widget.foodController.fat /
                    (widget.foodController.necessity.value.macro!.breakfast!
                            .fat! +
                        widget
                            .foodController.necessity.value.macro!.lunch!.fat! +
                        widget.foodController.necessity.value.macro!.dinner!
                            .fat!),
                size: Size(100.w, 120.h),
              ),
              NecessityGauge(
                onpress: () {
                  onPressNecessityGauge(
                      title: 'Serat',
                      necessitySarapan: widget.foodController.necessity.value
                          .macro!.breakfast!.fiber,
                      necessityMakanSiang: widget
                          .foodController.necessity.value.macro!.lunch!.fiber,
                      necessityMakanMalam: widget
                          .foodController.necessity.value.macro!.dinner!.fiber,
                      nutritionTotal: widget.foodController.fiber,
                      nutritionSarapan: widget.foodController.fiberSarapan,
                      nutritionMakanSiang:
                          widget.foodController.fiberMakanSiang,
                      nutritionMakanMalam:
                          widget.foodController.fiberMakanMalam,
                      unit: ' g');
                },
                color: widget.color,
                text: 'Serat',
                backgroundColor:
                    widget.color.secondaryTextColor.withOpacity(0.3),
                foregroundColor: HexColor.fromHex('#4E5749'),
                value: widget.foodController.fiber /
                    (widget.foodController.necessity.value.macro!.breakfast!
                            .fiber! +
                        widget.foodController.necessity.value.macro!.lunch!
                            .fiber! +
                        widget.foodController.necessity.value.macro!.dinner!
                            .fiber!),
                size: Size(100.w, 120.h),
              ),

              NecessityGauge(
                onpress: () {},
                color: widget.color,
                text: 'Cairan',
                backgroundColor:
                    widget.color.secondaryTextColor.withOpacity(0.3),
                foregroundColor: HexColor.fromHex('#238094'),
                value: widget.foodController.water /
                    widget.foodController.necessity.value.water!,
                size: Size(100.w, 120.h),
              ),

              // NecessityGauge(
              //   color: widget.color,
              //   text: 'Kalsium',
              //   backgroundColor: widget.color.secondaryTextColor.withOpacity(0.3),
              //   foregroundColor: HexColor.fromHex('#238094'),
              //   value: widget.foodController.calcium /
              //       widget.foodController.necessity.calcium!,
              //   size: Size(size.width * 0.32, size.height * 0.2),
              // ),
              // NecessityGauge(
              //   color: widget.color,
              //   text: 'Zat Besi',
              //   backgroundColor: widget.color.secondaryTextColor.withOpacity(0.3),
              //   foregroundColor: HexColor.fromHex('#238094'),
              //   value: widget.foodController.iron /
              //       widget.foodController.necessity.iron!,
              //   size: Size(size.width * 0.32, size.height * 0.2),
              // ),
              // NecessityGauge(
              //   color: widget.color,
              //   text: 'zinc',
              //   backgroundColor: widget.color.secondaryTextColor.withOpacity(0.3),
              //   foregroundColor: HexColor.fromHex('#238094'),
              //   value: widget.foodController.zinc /
              //       widget.foodController.necessity.zinc!,
              //   size: Size(size.width * 0.32, size.height * 0.2),
              // ),
              // NecessityGauge(
              //   color: widget.color,
              //   text: 'copper',
              //   backgroundColor: widget.color.secondaryTextColor.withOpacity(0.3),
              //   foregroundColor: HexColor.fromHex('#238094'),
              //   value: widget.foodController.copper /
              //       widget.foodController.necessity.copper!,
              //   size: Size(size.width * 0.32, size.height * 0.2),
              // ),
              // NecessityGauge(
              //   color: widget.color,
              //   text: 'vitamin C',
              //   backgroundColor: widget.color.secondaryTextColor.withOpacity(0.3),
              //   foregroundColor: HexColor.fromHex('#238094'),
              //   value: widget.foodController.vitaminC /
              //       widget.foodController.necessity.vitaminC!,
              //   size: Size(size.width * 0.32, size.height * 0.2),
              // ),
              // NecessityGauge(
              //   color: widget.color,
              //   text: 'vitamin B1',
              //   backgroundColor: widget.color.secondaryTextColor.withOpacity(0.3),
              //   foregroundColor: HexColor.fromHex('#238094'),
              //   value: widget.foodController.vitaminB1 /
              //       widget.foodController.necessity.vitaminB1!,
              //   size: Size(size.width * 0.32, size.height * 0.2),
              // ),
              // NecessityGauge(
              //   color: widget.color,
              //   text: 'vitamin B2',
              //   backgroundColor: widget.color.secondaryTextColor.withOpacity(0.3),
              //   foregroundColor: HexColor.fromHex('#238094'),
              //   value: widget.foodController.vitaminB2 /
              //       widget.foodController.necessity.vitaminB2!,
              //   size: Size(size.width * 0.32, size.height * 0.2),
              // ),
              // NecessityGauge(
              //   color: widget.color,
              //   text: 'vitamin B3',
              //   backgroundColor: widget.color.secondaryTextColor.withOpacity(0.3),
              //   foregroundColor: HexColor.fromHex('#238094'),
              //   value: widget.foodController.vitaminB3 /
              //       widget.foodController.necessity.vitaminB3!,
              //   size: Size(size.width * 0.32, size.height * 0.2),
              // ),
              // NecessityGauge(
              //   color: widget.color,
              //   text: 'retinol',
              //   backgroundColor: widget.color.secondaryTextColor.withOpacity(0.3),
              //   foregroundColor: HexColor.fromHex('#238094'),
              //   value: widget.foodController.retinol /
              //       widget.foodController.necessity.retinol!,
              //   size: Size(size.width * 0.32, size.height * 0.2),
              // ),
            ]),
      ),
    );
  }

  Future<dynamic> onPressNecessityGauge(
      {String? title,
      double? nutritionTotal,
      double? nutritionSarapan,
      double? nutritionMakanSiang,
      double? nutritionMakanMalam,
      double? necessitySarapan,
      double? necessityMakanSiang,
      double? necessityMakanMalam,
      String? unit}) {
    return Get.bottomSheet(Container(
      decoration: BoxDecoration(
          color: widget.color.primaryColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      height: 360.h,
      width: 360.w,
      padding: EdgeInsets.all(10.sp),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              title!,
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                    color: widget.color.secondaryTextColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 28.h,
            ),
            bottomSheetNecesityChild(
              title: 'Total',
              value: nutritionTotal! /
                  (necessitySarapan! +
                      necessityMakanSiang! +
                      necessityMakanMalam!),
              valueAmount: nutritionTotal.toStringAsFixed(1),
              unit: unit,
              color: widget.color.secondaryColor,
            ),
            bottomSheetNecesityChild(
              title: 'Sarapan',
              value: nutritionSarapan! / necessitySarapan,
              valueAmount: nutritionSarapan.toStringAsFixed(1),
              unit: unit,
              color: widget.color.redColor,
            ),
            bottomSheetNecesityChild(
              title: 'Makan Siang',
              value: nutritionMakanSiang! / necessityMakanSiang,
              valueAmount: nutritionMakanSiang.toStringAsFixed(1),
              unit: unit,
              color: widget.color.purpleColor,
            ),
            bottomSheetNecesityChild(
              title: 'Makan Malam',
              value: nutritionMakanMalam! / necessityMakanMalam,
              valueAmount: nutritionMakanMalam.toStringAsFixed(1),
              unit: unit,
              color: widget.color.blueColor,
            ),
            // bottomSheetNecesityChild(widget.size, 'Snack', 100),
          ],
        ),
      ),
    ));
  }

  Widget bottomSheetNecesityChild({
    String? title,
    double? value,
    String? valueAmount,
    String? unit,
    Color? color,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(left: 20.w, top: 10.h, bottom: 10.h),
                    child: Text(
                      title!,
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            color: widget.color.secondaryTextColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 5.w, top: 10.h, bottom: 10.h),
                    child: Text(
                      '($valueAmount $unit)',
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            color: widget.color.secondaryTextColor,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: 20.w, top: 10.h, bottom: 10.h),
                child: Text(
                  '${((value!) * 100).round().toString()}%',
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        color: widget.color.secondaryTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ],
          ),
          Neumorphic(
              style: NeumorphicStyle(
                  depth: -4,
                  color: widget.color.backgroundColor,
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.circular(20),
                  )),
              child: Stack(alignment: Alignment.centerLeft, children: [
                Container(
                  height: 18.h,
                  width: 360.w,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: color, borderRadius: BorderRadius.circular(20)),
                  height: 18.h,
                  width: 360.w * value,
                ),
              ])),
        ],
      ),
    );
  }

  void getFoodNecessity() {
    widget.foodController.energy = 0;
    widget.foodController.energySarapan = 0;
    widget.foodController.energyMakanSiang = 0;
    widget.foodController.energyMakanMalam = 0;
    widget.foodController.protein = 0;
    widget.foodController.proteinSarapan = 0;
    widget.foodController.proteinMakanSiang = 0;
    widget.foodController.proteinMakanMalam = 0;
    widget.foodController.fat = 0;
    widget.foodController.fatSarapan = 0;
    widget.foodController.fatMakanSiang = 0;
    widget.foodController.fatMakanMalam = 0;
    widget.foodController.carbohydrate = 0;
    widget.foodController.carbohydrateSarapan = 0;
    widget.foodController.carbohydrateMakanSiang = 0;
    widget.foodController.carbohydrateMakanMalam = 0;
    widget.foodController.fiber = 0;
    widget.foodController.fiberSarapan = 0;
    widget.foodController.fiberMakanSiang = 0;
    widget.foodController.fiberMakanMalam = 0;
    widget.foodController.water = 0;

    widget.foodController.sodium = 0;
    widget.foodController.calcium = 0;
    widget.foodController.iron = 0;
    widget.foodController.phosphor = 0;
    widget.foodController.potassium = 0;
    widget.foodController.zinc = 0;
    widget.foodController.copper = 0;
    widget.foodController.vitaminC = 0;
    widget.foodController.vitaminB1 = 0;
    widget.foodController.vitaminB2 = 0;
    widget.foodController.vitaminB3 = 0;
    widget.foodController.retinol = 0;

    for (var u = 0; u < widget.listMealSarapan.length; u++) {
      setState(() {
        widget.foodController.energySarapan =
            widget.foodController.energySarapan +
                (widget.listMealSarapan[u].energy! /
                    widget.listMealSarapan[u].serving!);
        widget.foodController.carbohydrateSarapan =
            widget.foodController.carbohydrateSarapan +
                (widget.listMealSarapan[u].carbohydrate! /
                    widget.listMealSarapan[u].serving!);
        widget.foodController.proteinSarapan =
            widget.foodController.proteinSarapan +
                (widget.listMealSarapan[u].protein! /
                    widget.listMealSarapan[u].serving!);
        widget.foodController.fatSarapan = widget.foodController.fatSarapan +
            (widget.listMealSarapan[u].fat! /
                widget.listMealSarapan[u].serving!);
        widget.foodController.fiberSarapan =
            widget.foodController.fiberSarapan +
                (widget.listMealSarapan[u].fiber! /
                    widget.listMealSarapan[u].serving!);
      });
    }
    for (var u = 0; u < widget.listMealMakanSiang.length; u++) {
      setState(() {
        widget.foodController.energyMakanSiang =
            widget.foodController.energyMakanSiang +
                (widget.listMealMakanSiang[u].energy! /
                    widget.listMealMakanSiang[u].serving!);
        widget.foodController.carbohydrateMakanSiang =
            widget.foodController.carbohydrateMakanSiang +
                (widget.listMealMakanSiang[u].carbohydrate! /
                    widget.listMealMakanSiang[u].serving!);
        widget.foodController.proteinMakanSiang =
            widget.foodController.proteinMakanSiang +
                (widget.listMealMakanSiang[u].protein! /
                    widget.listMealMakanSiang[u].serving!);
        widget.foodController.fatMakanSiang =
            widget.foodController.fatMakanSiang +
                (widget.listMealMakanSiang[u].fat! /
                    widget.listMealMakanSiang[u].serving!);
        widget.foodController.fiberMakanSiang =
            widget.foodController.fiberMakanSiang +
                (widget.listMealMakanSiang[u].fiber! /
                    widget.listMealMakanSiang[u].serving!);
      });
    }
    for (var u = 0; u < widget.listMealMakanMalam.length; u++) {
      setState(() {
        widget.foodController.energyMakanMalam =
            widget.foodController.energyMakanMalam +
                (widget.listMealMakanMalam[u].energy! /
                    widget.listMealMakanMalam[u].serving!);
        widget.foodController.carbohydrateMakanMalam =
            widget.foodController.carbohydrateMakanMalam +
                (widget.listMealMakanMalam[u].carbohydrate! /
                    widget.listMealMakanMalam[u].serving!);
        widget.foodController.proteinMakanMalam =
            widget.foodController.proteinMakanMalam +
                (widget.listMealMakanMalam[u].protein! /
                    widget.listMealMakanMalam[u].serving!);
        widget.foodController.fatMakanMalam =
            widget.foodController.fatMakanMalam +
                (widget.listMealMakanMalam[u].fat! /
                    widget.listMealMakanMalam[u].serving!);
        widget.foodController.fiberMakanMalam =
            widget.foodController.fiberMakanMalam +
                (widget.listMealMakanMalam[u].fiber! /
                    widget.listMealMakanMalam[u].serving!);
      });
    }
    for (var i = 0; i < widget.listMeal.length; i++) {
      setState(() {
        widget.foodController.energy = widget.foodController.energy +
            (widget.listMeal[i].energy! / widget.listMeal[i].serving!);
        widget.foodController.protein = widget.foodController.protein +
            (widget.listMeal[i].protein! / widget.listMeal[i].serving!);
        widget.foodController.fat = widget.foodController.fat +
            (widget.listMeal[i].fat! / widget.listMeal[i].serving!);
        widget.foodController.carbohydrate = widget
                .foodController.carbohydrate +
            (widget.listMeal[i].carbohydrate! / widget.listMeal[i].serving!);
        widget.foodController.fiber = widget.foodController.fiber +
            (widget.listMeal[i].fiber! / widget.listMeal[i].serving!);
        widget.foodController.water = widget.foodController.water +
            (widget.listMeal[i].water! / widget.listMeal[i].serving!);

        widget.foodController.calcium = widget.foodController.calcium +
            (widget.listMeal[i].calcium! / widget.listMeal[i].serving!);
        widget.foodController.iron = widget.foodController.iron +
            (widget.listMeal[i].iron! / widget.listMeal[i].serving!);
        widget.foodController.phosphor = widget.foodController.phosphor +
            (widget.listMeal[i].phosphor! / widget.listMeal[i].serving!);
        widget.foodController.potassium = widget.foodController.potassium +
            (widget.listMeal[i].potassium! / widget.listMeal[i].serving!);
        widget.foodController.sodium = widget.foodController.sodium +
            (widget.listMeal[i].sodium! / widget.listMeal[i].serving!);
        widget.foodController.zinc = widget.foodController.zinc +
            (widget.listMeal[i].zinc! / widget.listMeal[i].serving!);
        widget.foodController.copper = widget.foodController.copper +
            (widget.listMeal[i].copper! / widget.listMeal[i].serving!);
        widget.foodController.vitaminC = widget.foodController.vitaminC +
            (widget.listMeal[i].vitaminC! / widget.listMeal[i].serving!);
        widget.foodController.vitaminB1 = widget.foodController.vitaminB1 +
            (widget.listMeal[i].vitaminB1! / widget.listMeal[i].serving!);
        widget.foodController.vitaminB2 = widget.foodController.vitaminB2 +
            (widget.listMeal[i].vitaminB2! / widget.listMeal[i].serving!);
        widget.foodController.vitaminB3 = widget.foodController.vitaminB3 +
            (widget.listMeal[i].vitaminB3! / widget.listMeal[i].serving!);
        widget.foodController.retinol = widget.foodController.retinol +
            (widget.listMeal[i].retinol! / widget.listMeal[i].serving!);
      });
    }
  }
}
