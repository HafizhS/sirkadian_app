import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/model/food_model/food_recommendation_response_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../controller/hexcolor_controller.dart';
import '../../../../controller/food_controller.dart';
import '../../../../model/obejctbox_model.dart/food_exercise_model.dart';
import '../../../../widget/food_widget/necessity_gauge.dart';
import '../../../../widget/food_widget/other_food_tile.dart';

class FoodDetailScreen extends StatefulWidget {
  const FoodDetailScreen({
    Key? key,
    required this.food,
    required this.color,
    required this.foodController,
    required this.session,
  }) : super(key: key);

  final DataFoodRecommendationResponse food;
  final String session;

  final FoodController foodController;
  final ColorConstantController color;

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  ScrollController scrollController = ScrollController();
  bool isOnBottom = false;
  bool isBahanOpen = false;
  bool isLangkahOpen = false;

  void initState() {
    super.initState();

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
        () => widget.foodController.isLoadingOtherFoodRecommendation.isTrue
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
                                  child: widget.food.imageFilename == ''
                                      ? Icon(Icons.image_not_supported_rounded)
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.network(
                                            widget.food.imageFilename!,
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
                                    child: NeumorphicButton(
                                      onPressed: () {},
                                      style: NeumorphicStyle(
                                        depth: 0,
                                        shape: NeumorphicShape.flat,
                                        boxShape: NeumorphicBoxShape.circle(),
                                        color: widget.color.primaryColor,
                                      ),
                                      padding: EdgeInsets.all(14.sp),
                                      child: FaIcon(
                                        FontAwesomeIcons.solidHeart,
                                        size: 20.sp,
                                        color: widget.color.secondaryTextColor,
                                      ),
                                    ),
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
                                      Container(
                                        width: 300.w,
                                        child: Text(
                                          widget.food.foodName!,
                                          style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                color: widget
                                                    .color.primaryTextColor,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.fireAlt,
                                        size: 14.sp,
                                        color: widget.color.tersierTextColor,
                                      ),
                                      Text(
                                          ' ' +
                                              (widget.food.energy!)
                                                  .toStringAsFixed(0) +
                                              ' kkal',
                                          style: GoogleFonts.inter(
                                            textStyle: TextStyle(
                                                color: widget
                                                    .color.tersierTextColor,
                                                fontSize: 14,
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
                                              widget.food.duration!
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
                                        (widget.food.serving!)
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
                                      SizedBox(width: 20.w),
                                      Text(widget.food.foodTypes!.first,
                                          style: GoogleFonts.inter(
                                            textStyle: TextStyle(
                                                color: widget
                                                    .color.tersierTextColor,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.normal),
                                          )),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(children: [
                                    FaIcon(
                                      FontAwesomeIcons.solidStar,
                                      color: Colors.yellow.shade600,
                                      size: 16.sp,
                                    ),
                                    SizedBox(width: 5.w),
                                    Text(
                                      widget.food.recommendationScore!
                                          .toStringAsFixed(2),
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color:
                                                widget.color.primaryTextColor,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    SizedBox(width: 20.w),
                                    Text(
                                      ' By : Abiyyuda Naufal P.',
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
                                          Text(
                                            'Informasi Nutrisi',
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  color: widget
                                                      .color.secondaryTextColor,
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w600),
                                            ),
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
                                        onPressed: () {},
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
                                              percentage: (widget.food.energy! /
                                                      widget.food.serving!) /
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
                                            (widget.food.energy! /
                                                        widget.food.serving!)
                                                    .toStringAsFixed(0) +
                                                // 'kkal' +
                                                ' (${(((widget.food.energy! / widget.food.serving!) / (widget.foodController.necessity.value.energy!.breakfast! + widget.foodController.necessity.value.energy!.lunch! + widget.foodController.necessity.value.energy!.dinner!)) * 100).round()}%)',
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
                                                          .food.protein! /
                                                      widget.food.serving!) /
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
                                            (widget.food.protein! /
                                                        widget.food.serving!)
                                                    .toStringAsFixed(0) +
                                                'g' +
                                                ' (${(((widget.food.protein! / widget.food.serving!) / (widget.foodController.necessity.value.macro!.breakfast!.protein! + widget.foodController.necessity.value.macro!.lunch!.protein! + widget.foodController.necessity.value.macro!.dinner!.protein!)) * 100).round()}%)',
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
                                                          .food.carbohydrate! /
                                                      widget.food.serving!) /
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
                                            (widget.food.carbohydrate! /
                                                        widget.food.serving!)
                                                    .toStringAsFixed(0) +
                                                'g' +
                                                ' (${(((widget.food.carbohydrate! / widget.food.serving!) / (widget.foodController.necessity.value.macro!.breakfast!.carbohydrate! + widget.foodController.necessity.value.macro!.lunch!.carbohydrate! + widget.foodController.necessity.value.macro!.dinner!.carbohydrate!)) * 100).round()}%)',
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
                                                          .food.fat! /
                                                      widget.food.serving!) /
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
                                            (widget.food.fat! /
                                                        widget.food.serving!)
                                                    .toStringAsFixed(0) +
                                                'g' +
                                                ' (${(((widget.food.fat! / widget.food.serving!) / (widget.foodController.necessity.value.macro!.breakfast!.fat! + widget.foodController.necessity.value.macro!.lunch!.fat! + widget.foodController.necessity.value.macro!.dinner!.fat!)) * 100).round()}%)',
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
                            Text(
                              'Rekomendasi Sejenis',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: widget.color.secondaryTextColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              height: 200.h,
                              width: 360.w,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    widget.foodController.listOtherFood.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.all(10.sp),
                                    child: OtherFoodRecommendationTile(
                                      productOld: widget.food,
                                      session: widget.session,
                                      foodController: widget.foodController,
                                      product: widget
                                          .foodController.listOtherFood[index],
                                      color: widget.color,
                                    ),
                                  );
                                },
                              ),
                            ),
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
                                            children:
                                                widget.food.foodIngredientInfo!
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
                                                              child: e.ingredientDescription ==
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
                                                                                      Padding(
                                                                                        padding: EdgeInsets.only(left: 10.w),
                                                                                        child: Text(
                                                                                          '${e.ingredientDescription}.',
                                                                                          softWrap: true,
                                                                                          textAlign: TextAlign.justify,
                                                                                          style: GoogleFonts.inter(
                                                                                            textStyle: TextStyle(color: widget.color.primaryTextColor, fontSize: 14.sp, fontWeight: FontWeight.normal),
                                                                                          ),
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
                                                                          Text(
                                                                        '${e.ingredientDescription}.',
                                                                        softWrap:
                                                                            true,
                                                                        textAlign:
                                                                            TextAlign.justify,
                                                                        style: GoogleFonts
                                                                            .inter(
                                                                          textStyle: TextStyle(
                                                                              color: widget.color.primaryTextColor,
                                                                              fontSize: 14.sp,
                                                                              fontWeight: FontWeight.normal),
                                                                        ),
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
                                              widget.food.foodInstructionInfo!
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
                                                                                    Container(
                                                                                        height: 150.h,
                                                                                        width: 360.w,
                                                                                        margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                                                                                        child: widget.food.imageFilename == ''
                                                                                            ? Icon(Icons.image_not_supported_rounded)
                                                                                            : ClipRRect(
                                                                                                borderRadius: BorderRadius.circular(20),
                                                                                                child: Image.network(
                                                                                                  widget.food.imageFilename!,
                                                                                                  fit: BoxFit.cover,
                                                                                                ),
                                                                                              )),
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
                                                            e.instruction ==
                                                                    null
                                                                ? Container()
                                                                : Container(
                                                                    height:
                                                                        150.h,
                                                                    width:
                                                                        360.w,
                                                                    margin: EdgeInsets.symmetric(
                                                                        horizontal: 20
                                                                            .w,
                                                                        vertical: 10
                                                                            .h),
                                                                    decoration: BoxDecoration(
                                                                        color: widget
                                                                            .color
                                                                            .hintTextColor,
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                20)),
                                                                    child: widget.food.imageFilename ==
                                                                            ''
                                                                        ? Icon(Icons
                                                                            .image_not_supported_rounded)
                                                                        : ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(20),
                                                                            child: Image.network(
                                                                              widget.food.imageFilename!,
                                                                              fit: BoxFit.cover,
                                                                            ))),
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
                      NeumorphicButton(
                        margin: EdgeInsets.only(right: 10.w, bottom: 10.h),
                        onPressed: () {
                          final food = Food(
                              imageFileName: widget.food.imageFilename,
                              session: widget.session,
                              date:
                                  widget.foodController.selectedDay.toString(),
                              name: widget.food.foodName,
                              calcium: widget.food.calcium,
                              carbohydrate: widget.food.carbohydrate,
                              copper: widget.food.copper,
                              difficulty: widget.food.difficulty,
                              duration: widget.food.duration,
                              energy: widget.food.energy,
                              fat: widget.food.fat,
                              fiber: widget.food.fiber,
                              foodId: widget.food.foodId,
                              foodTypes: widget.food.foodTypes,
                              iron: widget.food.iron,
                              phosphor: widget.food.phosphor,
                              potassium: widget.food.potassium,
                              protein: widget.food.protein,
                              retinol: widget.food.retinol,
                              serving: widget.food.serving,
                              sodium: widget.food.sodium,
                              tags: widget.food.tags,
                              vitaminB1: widget.food.vitaminB1,
                              vitaminB2: widget.food.vitaminB2,
                              vitaminB3: widget.food.vitaminB3,
                              vitaminC: widget.food.vitaminC,
                              water: widget.food.water,
                              zinc: widget.food.zinc,
                              // instruction: foodController
                              //     .listFood[index]
                              //     .foodInstructionInfo!
                              //     .map((e) =>
                              //         e.instruction!)
                              //     .toList(),
                              instruction: [],
                              recommendationScore: widget
                                  .food.recommendationScore!
                                  .toStringAsFixed(2));
                          widget.foodController.foodStore.box<Food>().put(food);

                          Navigator.of(context)
                              .popUntil(ModalRoute.withName("/foodMealScreen"));
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
                      ),
                    ],
                  ),
                ]),
              ),
      ),
    );
  }
}
