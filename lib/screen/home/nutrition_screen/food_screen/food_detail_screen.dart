import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../controller/hexcolor_controller.dart';
import '../../../../controller/food_controller.dart';
import '../../../../model/obejctbox_model.dart/food_fluid_exercise_model.dart';
import '../../../../widget/food_widget/necessity_gauge.dart';
import '../../../../widget/food_widget/other_food_tile.dart';

class FoodDetailScreen extends StatefulWidget {
  const FoodDetailScreen({
    Key? key,
    // required this.food,
    required this.color,
    required this.foodController,
    required this.session,
    required this.foodId,
    required this.recommendationScore,
    required this.isFromFoodMeal,
  }) : super(key: key);

  // final DataFoodRecommendationResponse food;
  final String session;
  final String foodId;
  final FoodController foodController;
  final ColorConstantController color;
  final String recommendationScore;
  final bool isFromFoodMeal;

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  final data = GetStorage('myData');
  ScrollController scrollController = ScrollController();
  bool isOnBottom = false;
  bool isBahanOpen = false;
  bool isLangkahOpen = false;

  void initState() {
    // widget.foodController.getFoodItem(widget.foodId);
    scrollController.addListener(() {
      if (scrollController.offset > 1000) {
        setState(() {
          isOnBottom = true;
        });
      } else {
        setState(() {
          isOnBottom = false;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => widget.foodController.isLoadingOtherFoodRecommendation.isTrue ||
                widget.foodController.isLoadingFoodItem.isTrue
            ? Center(
                child: CircularProgressIndicator(
                  color: widget.color.secondaryColor,
                ),
              )
            : SafeArea(
                child: Stack(alignment: Alignment.bottomRight, children: [
                  SingleChildScrollView(
                    controller: scrollController,
                    child: Container(
                      padding: EdgeInsets.all(20.sp),
                      color: widget.color.bgColor,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(children: [
                              Container(
                                  height: 200.h,
                                  width: 360.w,
                                  decoration: BoxDecoration(
                                      color: widget.color.primaryColor,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: widget.foodController.foodItemResponse
                                              .value.imageFilename ==
                                          ''
                                      ? Icon(Icons.image_not_supported_rounded)
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.network(
                                            widget
                                                .foodController
                                                .foodItemResponse
                                                .value
                                                .imageFilename!,
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 5.w),
                                    child: NeumorphicButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      style: NeumorphicStyle(
                                        shape: NeumorphicShape.flat,
                                        depth: 0,
                                        boxShape: NeumorphicBoxShape.circle(),
                                        color: widget.color.primaryColor,
                                      ),
                                      padding: EdgeInsets.all(16.sp),
                                      child: FaIcon(
                                        FontAwesomeIcons.chevronLeft,
                                        size: 20.sp,
                                        color: widget.color.secondaryTextColor,
                                      ),
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(right: 5.w),
                                      child: SizedBox()
                                      //  NeumorphicButton(
                                      //   onPressed: () {},
                                      //   style: NeumorphicStyle(
                                      //     depth: 0,
                                      //     shape: NeumorphicShape.flat,
                                      //     boxShape: NeumorphicBoxShape.circle(),
                                      //     color: widget.color.primaryColor,
                                      //   ),
                                      //   padding: EdgeInsets.all(14.sp),
                                      //   child: FaIcon(
                                      //     FontAwesomeIcons.solidHeart,
                                      //     size: 20.sp,
                                      //     color: widget.color.secondaryTextColor,
                                      //   ),
                                      // ),
                                      ),
                                ],
                              ),
                            ]),
                            SizedBox(height: 10.h),
                            Neumorphic(
                              padding: EdgeInsets.all(15.sp),
                              style: NeumorphicStyle(
                                shape: NeumorphicShape.flat,
                                color: widget.color.primaryColor,
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(20)),
                              ),
                              margin: EdgeInsets.symmetric(vertical: 10.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Container(
                                          // width: 300.w,
                                          child: Text(
                                            widget
                                                .foodController
                                                .foodItemResponse
                                                .value
                                                .foodName!,
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  color: widget
                                                      .color.primaryTextColor,
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5.h),
                                  Row(
                                      children: widget.foodController
                                          .foodItemResponse.value.foodTypes!
                                          .map((e) => Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: widget
                                                        .color.secondaryColor),
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20.w,
                                                    vertical: 5.h),
                                                margin: EdgeInsets.only(
                                                    right: 10.w, bottom: 5.h),
                                                child: Text(e,
                                                    style: GoogleFonts.inter(
                                                      textStyle: TextStyle(
                                                          color: widget.color
                                                              .primaryColor,
                                                          fontSize: 14.sp,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    )),
                                              ))
                                          .toList()),
                                  SizedBox(height: 5.h),
                                  Row(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.fireAlt,
                                        size: 14.sp,
                                        color: widget.color.tersierTextColor,
                                      ),
                                      Text(
                                          ' ' +
                                              (widget
                                                      .foodController
                                                      .foodItemResponse
                                                      .value
                                                      .energy!)
                                                  .toStringAsFixed(0) +
                                              ' kkal',
                                          style: GoogleFonts.inter(
                                            textStyle: TextStyle(
                                                color: widget
                                                    .color.tersierTextColor,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.normal),
                                          )),
                                      SizedBox(width: 20.w),
                                      FaIcon(
                                        FontAwesomeIcons.clock,
                                        size: 14.sp,
                                        color: widget.color.tersierTextColor,
                                      ),
                                      Text(
                                          ' ' +
                                              (widget
                                                          .foodController
                                                          .foodItemResponse
                                                          .value
                                                          .duration! /
                                                      60)
                                                  .toStringAsFixed(0) +
                                              ' min',
                                          style: GoogleFonts.inter(
                                            textStyle: TextStyle(
                                                color: widget
                                                    .color.tersierTextColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal),
                                          )),
                                      SizedBox(width: 20.w),
                                      Text(
                                        (widget.foodController.foodItemResponse
                                                    .value.serving!)
                                                .toStringAsFixed(0) +
                                            ' Porsi',
                                        style: GoogleFonts.inter(
                                          textStyle: TextStyle(
                                              color:
                                                  widget.color.tersierTextColor,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(children: [
                                    widget.recommendationScore == '0.00'
                                        ? Container()
                                        : Row(
                                            children: [
                                              FaIcon(
                                                FontAwesomeIcons.solidStar,
                                                color: Colors.yellow.shade600,
                                                size: 16.sp,
                                              ),
                                              SizedBox(width: 5.w),
                                              Text(
                                                // widget.foodController.foodItemResponse.value.recommendationScore!
                                                // .toStringAsFixed(2) ??,
                                                widget.recommendationScore,
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: widget.color
                                                          .primaryTextColor,
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              SizedBox(width: 20.w),
                                            ],
                                          ),
                                    Text(
                                      widget.foodController.foodItemResponse
                                              .value.creatorName ??
                                          '',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: widget.color.tersierColor
                                                .withOpacity(0.6),
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ]),
                                ],
                              ),
                            ),
                            Neumorphic(
                              padding: EdgeInsets.all(15.sp),
                              style: NeumorphicStyle(
                                shape: NeumorphicShape.flat,
                                color: widget.color.primaryColor,
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(20)),
                              ),
                              margin: EdgeInsets.symmetric(vertical: 10.h),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Informasi Nutrisi',
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: widget.color
                                                          .secondaryTextColor,
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              Text(
                                                ' (1 Porsi)',
                                                style: GoogleFonts.inter(
                                                  textStyle: TextStyle(
                                                      color: widget.color
                                                          .secondaryTextColor,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 20.w),
                                          Row(
                                            children: [
                                              FaIcon(
                                                FontAwesomeIcons
                                                    .solidCheckCircle,
                                                size: 14.sp,
                                                color: widget.color.blueColor,
                                              ),
                                              Text(
                                                ' Verified by Sirkadian',
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: widget.color
                                                          .tersierTextColor,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      NeumorphicButton(
                                        margin: EdgeInsets.all(10.sp),
                                        onPressed: () {
                                          Get.bottomSheet(Container(
                                            decoration: BoxDecoration(
                                                color:
                                                    widget.color.primaryColor,
                                                borderRadius: BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20))),
                                            height: 400.h,
                                            width: 360.w,
                                            padding: EdgeInsets.all(10),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'Pemenuhan Nutrisi Harian',
                                                    style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          color: widget.color
                                                              .tersierTextColor,
                                                          fontSize: 18.sp,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                  ),
                                                  bottomSheetNecesityChild(
                                                      'Serat',
                                                      (widget
                                                                  .foodController
                                                                  .foodItemResponse
                                                                  .value
                                                                  .fiber! /
                                                              widget
                                                                  .foodController
                                                                  .foodItemResponse
                                                                  .value
                                                                  .serving!) /
                                                          (widget
                                                                  .foodController
                                                                  .necessity
                                                                  .value
                                                                  .macro!
                                                                  .breakfast!
                                                                  .fiber! +
                                                              widget
                                                                  .foodController
                                                                  .necessity
                                                                  .value
                                                                  .macro!
                                                                  .lunch!
                                                                  .fiber! +
                                                              widget
                                                                  .foodController
                                                                  .necessity
                                                                  .value
                                                                  .macro!
                                                                  .dinner!
                                                                  .fiber!)),
                                                  bottomSheetNecesityChild(
                                                      'Kalsium',
                                                      (widget
                                                                  .foodController
                                                                  .foodItemResponse
                                                                  .value
                                                                  .calcium! /
                                                              widget
                                                                  .foodController
                                                                  .foodItemResponse
                                                                  .value
                                                                  .serving!) /
                                                          (widget
                                                              .foodController
                                                              .necessity
                                                              .value
                                                              .micro!
                                                              .calcium!)),
                                                  bottomSheetNecesityChild(
                                                      'Zat Besi',
                                                      (widget
                                                                  .foodController
                                                                  .foodItemResponse
                                                                  .value
                                                                  .iron! /
                                                              widget
                                                                  .foodController
                                                                  .foodItemResponse
                                                                  .value
                                                                  .serving!) /
                                                          (widget
                                                              .foodController
                                                              .necessity
                                                              .value
                                                              .micro!
                                                              .iron!)),
                                                  bottomSheetNecesityChild(
                                                      'zinc',
                                                      (widget
                                                                  .foodController
                                                                  .foodItemResponse
                                                                  .value
                                                                  .zinc! /
                                                              widget
                                                                  .foodController
                                                                  .foodItemResponse
                                                                  .value
                                                                  .serving!) /
                                                          (widget
                                                              .foodController
                                                              .necessity
                                                              .value
                                                              .micro!
                                                              .zinc!)),
                                                  bottomSheetNecesityChild(
                                                      'Copper',
                                                      (widget
                                                                  .foodController
                                                                  .foodItemResponse
                                                                  .value
                                                                  .copper! /
                                                              widget
                                                                  .foodController
                                                                  .foodItemResponse
                                                                  .value
                                                                  .serving!) /
                                                          (widget
                                                              .foodController
                                                              .necessity
                                                              .value
                                                              .micro!
                                                              .copper!)),
                                                  bottomSheetNecesityChild(
                                                      'Vitamin C',
                                                      (widget
                                                                  .foodController
                                                                  .foodItemResponse
                                                                  .value
                                                                  .vitaminC! /
                                                              widget
                                                                  .foodController
                                                                  .foodItemResponse
                                                                  .value
                                                                  .serving!) /
                                                          (widget
                                                              .foodController
                                                              .necessity
                                                              .value
                                                              .micro!
                                                              .vitaminC!)),
                                                  bottomSheetNecesityChild(
                                                      'Vitamin B1',
                                                      (widget
                                                                  .foodController
                                                                  .foodItemResponse
                                                                  .value
                                                                  .vitaminB1! /
                                                              widget
                                                                  .foodController
                                                                  .foodItemResponse
                                                                  .value
                                                                  .serving!) /
                                                          (widget
                                                              .foodController
                                                              .necessity
                                                              .value
                                                              .micro!
                                                              .vitaminB1!)),
                                                  bottomSheetNecesityChild(
                                                      'Vitamin B2',
                                                      (widget
                                                                  .foodController
                                                                  .foodItemResponse
                                                                  .value
                                                                  .vitaminB2! /
                                                              widget
                                                                  .foodController
                                                                  .foodItemResponse
                                                                  .value
                                                                  .serving!) /
                                                          (widget
                                                              .foodController
                                                              .necessity
                                                              .value
                                                              .micro!
                                                              .vitaminB2!)),
                                                  bottomSheetNecesityChild(
                                                      'Vitamin B3',
                                                      (widget
                                                                  .foodController
                                                                  .foodItemResponse
                                                                  .value
                                                                  .vitaminB3! /
                                                              widget
                                                                  .foodController
                                                                  .foodItemResponse
                                                                  .value
                                                                  .serving!) /
                                                          (widget
                                                              .foodController
                                                              .necessity
                                                              .value
                                                              .micro!
                                                              .vitaminB3!)),
                                                  bottomSheetNecesityChild(
                                                      'Retinol',
                                                      (widget
                                                                  .foodController
                                                                  .foodItemResponse
                                                                  .value
                                                                  .retinol! /
                                                              widget
                                                                  .foodController
                                                                  .foodItemResponse
                                                                  .value
                                                                  .serving!) /
                                                          (widget
                                                              .foodController
                                                              .necessity
                                                              .value
                                                              .micro!
                                                              .retinol!)),
                                                  bottomSheetNecesityChild(
                                                      'Cairan',
                                                      (widget
                                                                  .foodController
                                                                  .foodItemResponse
                                                                  .value
                                                                  .water! /
                                                              widget
                                                                  .foodController
                                                                  .foodItemResponse
                                                                  .value
                                                                  .serving!) /
                                                          (widget
                                                              .foodController
                                                              .necessity
                                                              .value
                                                              .water!)),
                                                ],
                                              ),
                                            ),
                                          ));
                                        },
                                        style: NeumorphicStyle(
                                          shape: NeumorphicShape.flat,
                                          boxShape: NeumorphicBoxShape.circle(),
                                          color: widget.color.primaryColor,
                                        ),
                                        padding: EdgeInsets.all(8.sp),
                                        child: FaIcon(
                                          FontAwesomeIcons.ellipsisH,
                                          size: 16.sp,
                                          color: widget.color.secondaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 18.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            'Kalori',
                                            style: GoogleFonts.inter(
                                              textStyle: TextStyle(
                                                  color: widget
                                                      .color.primaryTextColor,
                                                  fontSize: 14.sp,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                          CustomPaint(
                                            child: Container(
                                              height: 70.h,
                                              width: 60.w,
                                            ),
                                            foregroundPainter:
                                                CircleProgressBarPainter(
                                              foregroundColor:
                                                  widget.color.secondaryColor,
                                              backgroundColor: widget
                                                  .color.secondaryTextColor
                                                  .withOpacity(0.3),
                                              percentage: (widget
                                                          .foodController
                                                          .foodItemResponse
                                                          .value
                                                          .energy! /
                                                      widget
                                                          .foodController
                                                          .foodItemResponse
                                                          .value
                                                          .serving!) /
                                                  (widget
                                                          .foodController
                                                          .necessity
                                                          .value
                                                          .energy!
                                                          .breakfast! +
                                                      widget
                                                          .foodController
                                                          .necessity
                                                          .value
                                                          .energy!
                                                          .lunch! +
                                                      widget
                                                          .foodController
                                                          .necessity
                                                          .value
                                                          .energy!
                                                          .dinner!),
                                              sizeContainer: Size(60.w, 60.h),
                                            ),
                                          ),
                                          Text(
                                            (widget
                                                            .foodController
                                                            .foodItemResponse
                                                            .value
                                                            .energy! /
                                                        widget
                                                            .foodController
                                                            .foodItemResponse
                                                            .value
                                                            .serving!)
                                                    .toStringAsFixed(0) +
                                                // 'kkal' +
                                                '(${(((widget.foodController.foodItemResponse.value.energy! / widget.foodController.foodItemResponse.value.serving!) / (widget.foodController.necessity.value.energy!.breakfast! + widget.foodController.necessity.value.energy!.lunch! + widget.foodController.necessity.value.energy!.dinner!)) * 100).round()}%)',
                                            style: GoogleFonts.inter(
                                              textStyle: TextStyle(
                                                  color: widget
                                                      .color.primaryTextColor,
                                                  fontSize: 14.sp,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Protein',
                                            style: GoogleFonts.inter(
                                              textStyle: TextStyle(
                                                  color: widget
                                                      .color.primaryTextColor,
                                                  fontSize: 14.sp,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                          CustomPaint(
                                            child: Container(
                                              height: 70.h,
                                              width: 60.w,
                                            ),
                                            foregroundPainter:
                                                CircleProgressBarPainter(
                                              foregroundColor:
                                                  widget.color.secondaryColor,
                                              backgroundColor: widget
                                                  .color.secondaryTextColor
                                                  .withOpacity(0.3),
                                              percentage: (widget
                                                          .foodController
                                                          .foodItemResponse
                                                          .value
                                                          .protein! /
                                                      widget
                                                          .foodController
                                                          .foodItemResponse
                                                          .value
                                                          .serving!) /
                                                  (widget
                                                          .foodController
                                                          .necessity
                                                          .value
                                                          .macro!
                                                          .breakfast!
                                                          .protein! +
                                                      widget
                                                          .foodController
                                                          .necessity
                                                          .value
                                                          .macro!
                                                          .lunch!
                                                          .protein! +
                                                      widget
                                                          .foodController
                                                          .necessity
                                                          .value
                                                          .macro!
                                                          .dinner!
                                                          .protein!),
                                              sizeContainer: Size(60.w, 60.h),
                                            ),
                                          ),
                                          Text(
                                            (widget
                                                            .foodController
                                                            .foodItemResponse
                                                            .value
                                                            .protein! /
                                                        widget
                                                            .foodController
                                                            .foodItemResponse
                                                            .value
                                                            .serving!)
                                                    .toStringAsFixed(0) +
                                                'g' +
                                                '(${(((widget.foodController.foodItemResponse.value.protein! / widget.foodController.foodItemResponse.value.serving!) / (widget.foodController.necessity.value.macro!.breakfast!.protein! + widget.foodController.necessity.value.macro!.lunch!.protein! + widget.foodController.necessity.value.macro!.dinner!.protein!)) * 100).round()}%)',
                                            style: GoogleFonts.inter(
                                              textStyle: TextStyle(
                                                  color: widget
                                                      .color.primaryTextColor,
                                                  fontSize: 14.sp,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Karbohidrat',
                                            style: GoogleFonts.inter(
                                              textStyle: TextStyle(
                                                  color: widget
                                                      .color.primaryTextColor,
                                                  fontSize: 14.sp,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                          CustomPaint(
                                            child: Container(
                                              height: 70.h,
                                              width: 60.w,
                                            ),
                                            foregroundPainter:
                                                CircleProgressBarPainter(
                                              foregroundColor:
                                                  widget.color.secondaryColor,
                                              backgroundColor: widget
                                                  .color.secondaryTextColor
                                                  .withOpacity(0.3),
                                              percentage: (widget
                                                          .foodController
                                                          .foodItemResponse
                                                          .value
                                                          .carbohydrate! /
                                                      widget
                                                          .foodController
                                                          .foodItemResponse
                                                          .value
                                                          .serving!) /
                                                  (widget
                                                          .foodController
                                                          .necessity
                                                          .value
                                                          .macro!
                                                          .breakfast!
                                                          .carbohydrate! +
                                                      widget
                                                          .foodController
                                                          .necessity
                                                          .value
                                                          .macro!
                                                          .lunch!
                                                          .carbohydrate! +
                                                      widget
                                                          .foodController
                                                          .necessity
                                                          .value
                                                          .macro!
                                                          .dinner!
                                                          .carbohydrate!),
                                              sizeContainer: Size(60.w, 60.h),
                                            ),
                                          ),
                                          Text(
                                            (widget
                                                            .foodController
                                                            .foodItemResponse
                                                            .value
                                                            .carbohydrate! /
                                                        widget
                                                            .foodController
                                                            .foodItemResponse
                                                            .value
                                                            .serving!)
                                                    .toStringAsFixed(0) +
                                                'g' +
                                                '(${(((widget.foodController.foodItemResponse.value.carbohydrate! / widget.foodController.foodItemResponse.value.serving!) / (widget.foodController.necessity.value.macro!.breakfast!.carbohydrate! + widget.foodController.necessity.value.macro!.lunch!.carbohydrate! + widget.foodController.necessity.value.macro!.dinner!.carbohydrate!)) * 100).round()}%)',
                                            style: GoogleFonts.inter(
                                              textStyle: TextStyle(
                                                  color: widget
                                                      .color.primaryTextColor,
                                                  fontSize: 14.sp,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            'Lemak',
                                            style: GoogleFonts.inter(
                                              textStyle: TextStyle(
                                                  color: widget
                                                      .color.primaryTextColor,
                                                  fontSize: 14.sp,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                          CustomPaint(
                                            child: Container(
                                              height: 70.h,
                                              width: 60.w,
                                            ),
                                            foregroundPainter:
                                                CircleProgressBarPainter(
                                              foregroundColor:
                                                  widget.color.secondaryColor,
                                              backgroundColor: widget
                                                  .color.secondaryTextColor
                                                  .withOpacity(0.3),
                                              percentage: (widget
                                                          .foodController
                                                          .foodItemResponse
                                                          .value
                                                          .fat! /
                                                      widget
                                                          .foodController
                                                          .foodItemResponse
                                                          .value
                                                          .serving!) /
                                                  (widget
                                                          .foodController
                                                          .necessity
                                                          .value
                                                          .macro!
                                                          .breakfast!
                                                          .fat! +
                                                      widget
                                                          .foodController
                                                          .necessity
                                                          .value
                                                          .macro!
                                                          .lunch!
                                                          .fat! +
                                                      widget
                                                          .foodController
                                                          .necessity
                                                          .value
                                                          .macro!
                                                          .dinner!
                                                          .fat!),
                                              sizeContainer: Size(60.w, 60.h),
                                            ),
                                          ),
                                          Text(
                                            (widget
                                                            .foodController
                                                            .foodItemResponse
                                                            .value
                                                            .fat! /
                                                        widget
                                                            .foodController
                                                            .foodItemResponse
                                                            .value
                                                            .serving!)
                                                    .toStringAsFixed(0) +
                                                'g' +
                                                '(${(((widget.foodController.foodItemResponse.value.fat! / widget.foodController.foodItemResponse.value.serving!) / (widget.foodController.necessity.value.macro!.breakfast!.fat! + widget.foodController.necessity.value.macro!.lunch!.fat! + widget.foodController.necessity.value.macro!.dinner!.fat!)) * 100).round()}%)',
                                            style: GoogleFonts.inter(
                                              textStyle: TextStyle(
                                                  color: widget
                                                      .color.primaryTextColor,
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
                            ),

                            /// disini ditambahin other food recommendation
                            !widget.isFromFoodMeal
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Rekomendasi Sejenis',
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: widget
                                                  .color.secondaryTextColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      widget.foodController.listOtherFood
                                              .isNotEmpty
                                          ? Container(
                                              height: 200.h,
                                              width: 360.w,
                                              child: ListView.builder(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: widget.foodController
                                                    .listOtherFood.length,
                                                itemBuilder: (context, index) {
                                                  return Container(
                                                    margin:
                                                        EdgeInsets.all(10.sp),
                                                    child:
                                                        OtherFoodRecommendationTile(
                                                      isFromFoodMeal:
                                                          widget.isFromFoodMeal,
                                                      productOld: widget
                                                          .foodController
                                                          .foodItemResponse
                                                          .value,
                                                      session: widget.session,
                                                      foodController:
                                                          widget.foodController,
                                                      product: widget
                                                          .foodController
                                                          .listOtherFood[index],
                                                      color: widget.color,
                                                    ),
                                                  );
                                                },
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  )
                                : Container(),

                            isBahanOpen
                                ? Neumorphic(
                                    padding: EdgeInsets.all(10),
                                    style: NeumorphicStyle(
                                      shape: NeumorphicShape.flat,
                                      color: widget.color.primaryColor,
                                      boxShape: NeumorphicBoxShape.roundRect(
                                          BorderRadius.circular(20)),
                                    ),
                                    margin:
                                        EdgeInsets.symmetric(vertical: 10.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              // width: size.width,
                                              child: Text(
                                                'Bahan-bahan',
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: widget.color
                                                          .secondaryTextColor,
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                            NeumorphicButton(
                                              margin: EdgeInsets.all(10.sp),
                                              onPressed: () {
                                                setState(() {
                                                  isBahanOpen = false;
                                                });
                                              },
                                              style: NeumorphicStyle(
                                                // depth: 0,
                                                shape: NeumorphicShape.flat,
                                                boxShape:
                                                    NeumorphicBoxShape.circle(),
                                                color:
                                                    widget.color.primaryColor,
                                              ),
                                              padding: EdgeInsets.all(10.sp),
                                              child: FaIcon(
                                                FontAwesomeIcons.chevronUp,
                                                size: 16.sp,
                                                color:
                                                    widget.color.secondaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                            children: widget
                                                .foodController
                                                .foodItemResponse
                                                .value
                                                .foodIngredientInfo!
                                                .map(
                                                  (e) => Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                          alignment: Alignment
                                                              .bottomCenter,
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      10.h),
                                                          child: FaIcon(
                                                            FontAwesomeIcons
                                                                .solidCircle,
                                                            size: 8.sp,
                                                          )),
                                                      Expanded(
                                                          child:
                                                              e.ingredientDescription ==
                                                                      null
                                                                  ? Container(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              20.w),
                                                                      margin: EdgeInsets.symmetric(
                                                                          vertical:
                                                                              5.h),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            '${e.ingredientGroupName}.',
                                                                            softWrap:
                                                                                true,
                                                                            textAlign:
                                                                                TextAlign.justify,
                                                                            style:
                                                                                GoogleFonts.inter(
                                                                              textStyle: TextStyle(color: widget.color.primaryTextColor, fontSize: 14.sp, fontWeight: FontWeight.normal),
                                                                            ),
                                                                          ),
                                                                          Column(
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: e.ingredientsGroup!
                                                                                .map(
                                                                                  (e) => Row(
                                                                                    children: [
                                                                                      Container(
                                                                                          alignment: Alignment.bottomCenter,
                                                                                          padding: EdgeInsets.only(top: 5.h),
                                                                                          margin: EdgeInsets.symmetric(vertical: 5.h),
                                                                                          child: FaIcon(
                                                                                            FontAwesomeIcons.circle,
                                                                                            size: 8.sp,
                                                                                          )),
                                                                                      Container(
                                                                                        width: 260.w,
                                                                                        padding: EdgeInsets.only(left: 10.w),
                                                                                        child: Row(
                                                                                          children: [
                                                                                            Flexible(
                                                                                              child: FittedBox(
                                                                                                child: Text(
                                                                                                  '${e.ingredientDescription} ',
                                                                                                  maxLines: 1,
                                                                                                  softWrap: true,
                                                                                                  textAlign: TextAlign.justify,
                                                                                                  style: GoogleFonts.inter(
                                                                                                    textStyle: TextStyle(color: widget.color.primaryTextColor, fontSize: 14.sp, fontWeight: FontWeight.normal),
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            e.measurementDescription != null
                                                                                                ? Text(
                                                                                                    '${e.measurementDescription}.',
                                                                                                    softWrap: true,
                                                                                                    textAlign: TextAlign.justify,
                                                                                                    style: GoogleFonts.inter(
                                                                                                      textStyle: TextStyle(color: widget.color.primaryTextColor, fontSize: 14.sp, fontWeight: FontWeight.normal),
                                                                                                    ),
                                                                                                  )
                                                                                                : SizedBox()
                                                                                          ],
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                )
                                                                                .toList(),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )
                                                                  : Container(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              20.w),
                                                                      margin: EdgeInsets.symmetric(
                                                                          vertical:
                                                                              5.h),
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft,
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Flexible(
                                                                            child:
                                                                                FittedBox(
                                                                              child: Text(
                                                                                '${e.ingredientDescription} ',
                                                                                softWrap: true,
                                                                                textAlign: TextAlign.justify,
                                                                                style: GoogleFonts.inter(
                                                                                  textStyle: TextStyle(color: widget.color.primaryTextColor, fontSize: 14.sp, fontWeight: FontWeight.normal),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            '${e.measurementDescription}.',
                                                                            softWrap:
                                                                                true,
                                                                            textAlign:
                                                                                TextAlign.justify,
                                                                            style:
                                                                                GoogleFonts.inter(
                                                                              textStyle: TextStyle(color: widget.color.primaryTextColor, fontSize: 14.sp, fontWeight: FontWeight.normal),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ))
                                                    ],
                                                  ),
                                                )
                                                .toList()),

                                        ///
                                      ],
                                    ))
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isBahanOpen = true;
                                      });
                                    },
                                    child: Neumorphic(
                                        padding: EdgeInsets.all(10.sp),
                                        style: NeumorphicStyle(
                                          shape: NeumorphicShape.flat,
                                          color: widget.color.primaryColor,
                                          boxShape:
                                              NeumorphicBoxShape.roundRect(
                                                  BorderRadius.circular(20)),
                                        ),
                                        margin: EdgeInsets.symmetric(
                                            vertical: 10.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Text(
                                                'Bahan-bahan',
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: widget.color
                                                          .secondaryTextColor,
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                            NeumorphicButton(
                                              margin: EdgeInsets.all(10.sp),
                                              onPressed: () {
                                                setState(() {
                                                  isBahanOpen = true;
                                                });
                                              },
                                              style: NeumorphicStyle(
                                                depth: 0,
                                                shape: NeumorphicShape.flat,
                                                boxShape:
                                                    NeumorphicBoxShape.circle(),
                                                color:
                                                    widget.color.primaryColor,
                                              ),
                                              padding: EdgeInsets.all(8.sp),
                                              child: FaIcon(
                                                FontAwesomeIcons.chevronDown,
                                                size: 16.sp,
                                                color:
                                                    widget.color.secondaryColor,
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                            isLangkahOpen
                                ? Neumorphic(
                                    padding: EdgeInsets.all(10.sp),
                                    style: NeumorphicStyle(
                                      shape: NeumorphicShape.flat,
                                      color: widget.color.primaryColor,
                                      boxShape: NeumorphicBoxShape.roundRect(
                                          BorderRadius.circular(20)),
                                    ),
                                    margin:
                                        EdgeInsets.symmetric(vertical: 10.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Text(
                                                'Langkah-langkah',
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: widget.color
                                                          .secondaryTextColor,
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                            NeumorphicButton(
                                              margin: EdgeInsets.all(10.sp),
                                              onPressed: () {
                                                setState(() {
                                                  isLangkahOpen = false;
                                                });
                                              },
                                              style: NeumorphicStyle(
                                                // depth: 0,
                                                shape: NeumorphicShape.flat,
                                                boxShape:
                                                    NeumorphicBoxShape.circle(),
                                                color:
                                                    widget.color.primaryColor,
                                              ),
                                              padding: EdgeInsets.all(10.sp),
                                              child: FaIcon(
                                                FontAwesomeIcons.chevronUp,
                                                size: 16.sp,
                                                color:
                                                    widget.color.secondaryColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children:
                                              widget
                                                  .foodController
                                                  .foodItemResponse
                                                  .value
                                                  .foodInstructionInfo!
                                                  .map(
                                                    (e) => Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      10.h),
                                                          child: Text(
                                                              '${e.step}.',
                                                              style: GoogleFonts
                                                                  .inter(
                                                                textStyle: TextStyle(
                                                                    color: widget
                                                                        .color
                                                                        .primaryTextColor,
                                                                    fontSize:
                                                                        14.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal),
                                                              )),
                                                        ),
                                                        Expanded(
                                                            child: Column(
                                                          children: [
                                                            e.instruction ==
                                                                    null
                                                                ? Container(
                                                                    padding: EdgeInsets.only(
                                                                        left: 10
                                                                            .w),
                                                                    margin: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            10.h),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          '${e.title}.',
                                                                          softWrap:
                                                                              true,
                                                                          textAlign:
                                                                              TextAlign.justify,
                                                                          style:
                                                                              GoogleFonts.inter(
                                                                            textStyle: TextStyle(
                                                                                color: widget.color.primaryTextColor,
                                                                                fontSize: 14.sp,
                                                                                fontWeight: FontWeight.normal),
                                                                          ),
                                                                        ),
                                                                        Column(
                                                                          children: e
                                                                              .instructionsGroup!
                                                                              .map(
                                                                                (e) => Column(
                                                                                  children: [
                                                                                    Row(
                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                      children: [
                                                                                        Container(
                                                                                          margin: EdgeInsets.symmetric(vertical: 10.h),
                                                                                          child: Text(
                                                                                            '${e.step}.',
                                                                                            softWrap: true,
                                                                                            textAlign: TextAlign.justify,
                                                                                            style: GoogleFonts.inter(
                                                                                              textStyle: TextStyle(color: widget.color.primaryTextColor, fontSize: 14.sp, fontWeight: FontWeight.normal),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        Expanded(
                                                                                          child: Container(
                                                                                            padding: EdgeInsets.only(left: 10.w),
                                                                                            margin: EdgeInsets.symmetric(vertical: 10.h),
                                                                                            child: Text(
                                                                                              '${e.instruction}.',
                                                                                              softWrap: true,
                                                                                              textAlign: TextAlign.justify,
                                                                                              style: GoogleFonts.inter(
                                                                                                textStyle: TextStyle(color: widget.color.primaryTextColor, fontSize: 14.sp, fontWeight: FontWeight.normal),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                    // Container(
                                                                                    //     height: 150.h,
                                                                                    //     width: 360.w,
                                                                                    //     margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                                                                                    //     child: widget.foodController.foodItemResponse.value.imageFilename == ''
                                                                                    //         ? Icon(Icons.image_not_supported_rounded)
                                                                                    //         : ClipRRect(
                                                                                    //             borderRadius: BorderRadius.circular(20),
                                                                                    //             child: Image.network(
                                                                                    //               widget.foodController.foodItemResponse.value.imageFilename!,
                                                                                    //               fit: BoxFit.cover,
                                                                                    //             ),
                                                                                    //           )),
                                                                                  ],
                                                                                ),
                                                                              )
                                                                              .toList(),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )
                                                                : Container(
                                                                    padding: EdgeInsets.only(
                                                                        left: 10
                                                                            .w),
                                                                    margin: EdgeInsets.symmetric(
                                                                        vertical:
                                                                            10.h),
                                                                    alignment:
                                                                        Alignment
                                                                            .centerLeft,
                                                                    child: Text(
                                                                      '${e.instruction}.',
                                                                      softWrap:
                                                                          true,
                                                                      textAlign:
                                                                          TextAlign
                                                                              .justify,
                                                                      style: GoogleFonts
                                                                          .inter(
                                                                        textStyle: TextStyle(
                                                                            color:
                                                                                widget.color.primaryTextColor,
                                                                            fontSize: 14.sp,
                                                                            fontWeight: FontWeight.normal),
                                                                      ),
                                                                    ),
                                                                  ),
                                                            // e.instruction ==
                                                            //         null
                                                            //     ? Container()
                                                            //     : Container(
                                                            //         height:
                                                            //             150.h,
                                                            //         width:
                                                            //             360.w,
                                                            //         margin: EdgeInsets.symmetric(
                                                            //             horizontal: 20
                                                            //                 .w,
                                                            //             vertical: 10
                                                            //                 .h),
                                                            //         decoration: BoxDecoration(
                                                            //             color: widget
                                                            //                 .color
                                                            //                 .hintTextColor,
                                                            //             borderRadius:
                                                            //                 BorderRadius.circular(
                                                            //                     20)),
                                                            //         child: widget.foodController.foodItemResponse.value.imageFilename ==
                                                            //                 ''
                                                            //             ? Icon(Icons
                                                            //                 .image_not_supported_rounded)
                                                            //             : ClipRRect(
                                                            //                 borderRadius:
                                                            //                     BorderRadius.circular(20),
                                                            //                 child: Image.network(
                                                            //                   widget.foodController.foodItemResponse.value.imageFilename!,
                                                            //                   fit: BoxFit.cover,
                                                            //                 ))),
                                                          ],
                                                        ))
                                                      ],
                                                    ),
                                                  )
                                                  .toList(),
                                        ),
                                      ],
                                    ))
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isLangkahOpen = true;
                                      });
                                    },
                                    child: Neumorphic(
                                        padding: EdgeInsets.all(10.sp),
                                        style: NeumorphicStyle(
                                          shape: NeumorphicShape.flat,
                                          color: widget.color.primaryColor,
                                          boxShape:
                                              NeumorphicBoxShape.roundRect(
                                                  BorderRadius.circular(20)),
                                        ),
                                        margin: EdgeInsets.symmetric(
                                            vertical: 10.h),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Text(
                                                'Langkah-langkah',
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: widget.color
                                                          .secondaryTextColor,
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                            NeumorphicButton(
                                              margin: EdgeInsets.all(10.sp),
                                              onPressed: () {
                                                setState(() {
                                                  isLangkahOpen = true;
                                                });
                                              },
                                              style: NeumorphicStyle(
                                                depth: 0,
                                                shape: NeumorphicShape.flat,
                                                boxShape:
                                                    NeumorphicBoxShape.circle(),
                                                color:
                                                    widget.color.primaryColor,
                                              ),
                                              padding: EdgeInsets.all(8.sp),
                                              child: FaIcon(
                                                FontAwesomeIcons.chevronDown,
                                                size: 16.sp,
                                                color:
                                                    widget.color.secondaryColor,
                                              ),
                                            ),
                                          ],
                                        )),
                                  ),
                          ]),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      isOnBottom
                          ? NeumorphicButton(
                              margin:
                                  EdgeInsets.only(right: 10.w, bottom: 10.h),
                              onPressed: () {
                                //1800an offsetnya

                                setState(() {
                                  scrollController
                                    ..animateTo(
                                      0.0,
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.easeInOutQuart,
                                    );
                                });
                              },
                              style: NeumorphicStyle(
                                depth: 0,
                                shape: NeumorphicShape.flat,
                                boxShape: NeumorphicBoxShape.circle(),
                                color: widget.color.secondaryColor,
                              ),
                              padding: EdgeInsets.all(12.sp),
                              child: FaIcon(
                                FontAwesomeIcons.chevronUp,
                                size: 16.sp,
                                color: widget.color.primaryColor,
                              ),
                            )
                          : Container(),
                      !widget.isFromFoodMeal
                          ? NeumorphicButton(
                              margin:
                                  EdgeInsets.only(right: 10.w, bottom: 10.h),
                              onPressed: () {
                                final food = Food(
                                    imageFileName: widget.foodController
                                        .foodItemResponse.value.imageFilename,
                                    session: widget.session,
                                    date: widget.foodController.selectedDay
                                        .toString(),
                                    name: widget.foodController.foodItemResponse
                                        .value.foodName,
                                    calcium: widget.foodController
                                        .foodItemResponse.value.calcium,
                                    carbohydrate: widget.foodController
                                        .foodItemResponse.value.carbohydrate,
                                    copper: widget.foodController
                                        .foodItemResponse.value.copper,
                                    difficulty: widget.foodController
                                        .foodItemResponse.value.difficulty,
                                    duration: widget.foodController
                                        .foodItemResponse.value.duration,
                                    energy: widget.foodController
                                        .foodItemResponse.value.energy,
                                    fat: widget.foodController.foodItemResponse
                                        .value.fat,
                                    fiber: widget.foodController
                                        .foodItemResponse.value.fiber,
                                    foodId: widget.foodController
                                        .foodItemResponse.value.foodId,
                                    foodTypes: widget.foodController
                                        .foodItemResponse.value.foodTypes,
                                    iron: widget.foodController.foodItemResponse.value.iron,
                                    phosphor: widget.foodController.foodItemResponse.value.phosphor,
                                    potassium: widget.foodController.foodItemResponse.value.potassium,
                                    protein: widget.foodController.foodItemResponse.value.protein,
                                    retinol: widget.foodController.foodItemResponse.value.retinol,
                                    serving: widget.foodController.foodItemResponse.value.serving,
                                    sodium: widget.foodController.foodItemResponse.value.sodium,
                                    tags: widget.foodController.foodItemResponse.value.tags,
                                    vitaminB1: widget.foodController.foodItemResponse.value.vitaminB1,
                                    vitaminB2: widget.foodController.foodItemResponse.value.vitaminB2,
                                    vitaminB3: widget.foodController.foodItemResponse.value.vitaminB3,
                                    vitaminC: widget.foodController.foodItemResponse.value.vitaminC,
                                    water: widget.foodController.foodItemResponse.value.water,
                                    zinc: widget.foodController.foodItemResponse.value.zinc,
                                    // instruction: foodController
                                    //     .listFood[index]
                                    //     .foodInstructionInfo!
                                    //     .map((e) =>
                                    //         e.instruction!)
                                    //     .toList(),
                                    // itemFood: 'widget.foodController.foodItemResponse.toJson()',
                                    itemFood: '',
                                    recommendationScore: widget.foodController.foodItemResponse.value.recommendationScore != null ? widget.foodController.foodItemResponse.value.recommendationScore!.toStringAsFixed(2) : '');
                                widget.foodController.foodStore
                                    .box<Food>()
                                    .put(food);

                                Navigator.of(context).popUntil(
                                    ModalRoute.withName("/foodMealScreen"));
                              },
                              style: NeumorphicStyle(
                                depth: 0,
                                shape: NeumorphicShape.flat,
                                boxShape: NeumorphicBoxShape.circle(),
                                color: widget.color.secondaryColor,
                              ),
                              padding: EdgeInsets.all(12.sp),
                              child: FaIcon(
                                FontAwesomeIcons.plus,
                                size: 16.sp,
                                color: widget.color.primaryColor,
                              ),
                            )
                          : Container()
                    ],
                  ),
                ]),
              ),
      ),
    );
  }

  Widget bottomSheetNecesityChild(String title, double value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.w, top: 10.h, bottom: 10.h),
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        color: widget.color.secondaryTextColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20.w, top: 10.h, bottom: 10.h),
                child: Text(
                  '${((value) * 100).round().toString()}%',
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
                      color: widget.color.secondaryColor,
                      borderRadius: BorderRadius.circular(20)),
                  height: 18.h,
                  width: 360.w * value,
                ),
              ])),
        ],
      ),
    );
  }
}
