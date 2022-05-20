import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/model/food_model/food_recommendation_response_model.dart';

import '../../../../controller/hexcolor_controller.dart';
import '../../../../controller/food_controller.dart';
import '../../../../widget/food_widget/necessity_gauge.dart';

class FoodDetailScreen extends StatefulWidget {
  const FoodDetailScreen({
    Key? key,
    required this.food,
    required this.color,
    required this.foodController,
  }) : super(key: key);

  final DataFoodRecommendationResponse food;

  final FoodController foodController;
  final ColorConstantController color;

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  ScrollController scrollController = ScrollController();
  bool isOnBottom = false;

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
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Stack(alignment: Alignment.bottomRight, children: [
          SingleChildScrollView(
            controller: scrollController,
            child: Container(
              padding: EdgeInsets.all(20),
              color: widget.color.backgroundColor,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(children: [
                      Container(
                          height: size.height * 0.3,
                          width: size.width,
                          decoration: BoxDecoration(
                              color: widget.color.primaryColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: widget.food.imageFilename == ''
                              ? Icon(Icons.image_not_supported_rounded)
                              : Image.network(widget.food.imageFilename!)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 5),
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
                              padding: const EdgeInsets.all(16.0),
                              child: FaIcon(
                                FontAwesomeIcons.chevronLeft,
                                size: 16,
                                color: widget.color.secondaryTextColor,
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(right: 5),
                            child: NeumorphicButton(
                              onPressed: () {},
                              style: NeumorphicStyle(
                                depth: 0,
                                shape: NeumorphicShape.flat,
                                boxShape: NeumorphicBoxShape.circle(),
                                color: widget.color.primaryColor,
                              ),
                              padding: const EdgeInsets.all(14.0),
                              child: FaIcon(
                                FontAwesomeIcons.solidHeart,
                                size: 16,
                                color: widget.color.secondaryTextColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ]),
                    SizedBox(height: size.height * 0.01),
                    Neumorphic(
                      padding: EdgeInsets.all(10),
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        color: widget.color.primaryColor,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(20)),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                widget.food.foodName!,
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: widget.color.primaryTextColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              SizedBox(width: size.width * 0.05),
                              Text(
                                (widget.food.serving! / widget.food.serving!)
                                        .toStringAsFixed(0) +
                                    ' Porsi (300 g)',
                                style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      color: widget.color.primaryTextColor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.01),
                          Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.clock,
                                size: 14,
                                color: widget.color.tersierTextColor,
                              ),
                              Text(
                                  ' ' +
                                      widget.food.duration!.toStringAsFixed(0) +
                                      ' Min',
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        color: widget.color.tersierTextColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  )),
                              SizedBox(width: size.width * 0.02),
                              FaIcon(
                                FontAwesomeIcons.fireAlt,
                                size: 14,
                                color: widget.color.tersierTextColor,
                              ),
                              Text(
                                  (widget.food.energy! / widget.food.serving!)
                                          .toStringAsFixed(0) +
                                      ' kkal',
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        color: widget.color.tersierTextColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  )),
                            ],
                          ),
                          SizedBox(height: size.height * 0.02),
                          Row(children: [
                            FaIcon(
                              FontAwesomeIcons.solidStar,
                              color: Colors.yellow.shade600,
                              size: 16,
                            ),
                            SizedBox(width: size.width * 0.02),
                            Text(
                              '4.5',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: widget.color.primaryTextColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            SizedBox(width: size.width * 0.02),
                            Text(
                              '(30+)',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: widget.color.secondaryTextColor
                                        .withOpacity(0.6),
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            SizedBox(width: size.width * 0.03),
                            Text(
                              'Lihat Ulasan',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    decoration: TextDecoration.underline,
                                    color: widget.color.secondaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ]),
                        ],
                      ),
                    ),
                    Neumorphic(
                      padding: EdgeInsets.all(10),
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        color: widget.color.primaryColor,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(20)),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Informasi Nutrisi',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color:
                                              widget.color.secondaryTextColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  SizedBox(width: size.width * 0.02),
                                  Row(
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.solidCheckCircle,
                                        size: 14,
                                        color: widget.color.blueColor,
                                      ),
                                      Text(
                                        ' Verified by Sirkadian',
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color:
                                                  widget.color.tersierTextColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              NeumorphicButton(
                                margin: EdgeInsets.all(10),
                                onPressed: () {},
                                style: NeumorphicStyle(
                                  shape: NeumorphicShape.flat,
                                  boxShape: NeumorphicBoxShape.circle(),
                                  color: widget.color.primaryColor,
                                ),
                                padding: const EdgeInsets.all(8.0),
                                child: FaIcon(
                                  FontAwesomeIcons.ellipsisH,
                                  size: 16,
                                  color: widget.color.secondaryColor,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: size.height * 0.02),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Kalori',
                                    style: GoogleFonts.inter(
                                      textStyle: TextStyle(
                                          color: widget.color.primaryTextColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  CustomPaint(
                                    child: Container(
                                      height: size.width * 0.2,
                                      width: size.width * 0.2,
                                    ),
                                    foregroundPainter: CircleProgressBarPainter(
                                      foregroundColor:
                                          widget.color.secondaryColor,
                                      backgroundColor: widget
                                          .color.secondaryTextColor
                                          .withOpacity(0.3),
                                      percentage: (widget.food.energy! /
                                              widget.food.serving!) /
                                          (widget.foodController.necessity.value
                                                  .energy!.breakfast! +
                                              widget.foodController.necessity
                                                  .value.energy!.lunch! +
                                              widget.foodController.necessity
                                                  .value.energy!.dinner!),
                                      sizeContainer: Size(
                                          size.width * 0.2, size.width * 0.2),
                                    ),
                                  ),
                                  Text(
                                    (widget.food.energy! / widget.food.serving!)
                                            .toStringAsFixed(0) +
                                        // 'kkal' +
                                        ' (${(((widget.food.energy! / widget.food.serving!) / (widget.foodController.necessity.value.energy!.breakfast! + widget.foodController.necessity.value.energy!.lunch! + widget.foodController.necessity.value.energy!.dinner!)) * 100).round()}%)',
                                    style: GoogleFonts.inter(
                                      textStyle: TextStyle(
                                          color: widget.color.primaryTextColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal),
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
                                          color: widget.color.primaryTextColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  CustomPaint(
                                    child: Container(
                                      height: size.width * 0.2,
                                      width: size.width * 0.2,
                                    ),
                                    foregroundPainter: CircleProgressBarPainter(
                                      foregroundColor:
                                          widget.color.secondaryColor,
                                      backgroundColor: widget
                                          .color.secondaryTextColor
                                          .withOpacity(0.3),
                                      percentage:
                                          (widget
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
                                      sizeContainer: Size(
                                          size.width * 0.2, size.width * 0.2),
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
                                          color: widget.color.primaryTextColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal),
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
                                          color: widget.color.primaryTextColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  CustomPaint(
                                    child: Container(
                                      height: size.width * 0.2,
                                      width: size.width * 0.2,
                                    ),
                                    foregroundPainter: CircleProgressBarPainter(
                                      foregroundColor:
                                          widget.color.secondaryColor,
                                      backgroundColor: widget
                                          .color.secondaryTextColor
                                          .withOpacity(0.3),
                                      percentage: (widget.food.carbohydrate! /
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
                                      sizeContainer: Size(
                                          size.width * 0.2, size.width * 0.2),
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
                                          color: widget.color.primaryTextColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal),
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
                                          color: widget.color.primaryTextColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  CustomPaint(
                                    child: Container(
                                      height: size.width * 0.2,
                                      width: size.width * 0.2,
                                    ),
                                    foregroundPainter: CircleProgressBarPainter(
                                      foregroundColor:
                                          widget.color.secondaryColor,
                                      backgroundColor: widget
                                          .color.secondaryTextColor
                                          .withOpacity(0.3),
                                      percentage: (widget.food.fat! /
                                              widget.food.serving!) /
                                          (widget.foodController.necessity.value
                                                  .macro!.breakfast!.fat! +
                                              widget.foodController.necessity
                                                  .value.macro!.lunch!.fat! +
                                              widget.foodController.necessity
                                                  .value.macro!.dinner!.fat!),
                                      sizeContainer: Size(
                                          size.width * 0.2, size.width * 0.2),
                                    ),
                                  ),
                                  Text(
                                    (widget.food.fat! / widget.food.serving!)
                                            .toStringAsFixed(0) +
                                        'g' +
                                        ' (${(((widget.food.fat! / widget.food.serving!) / (widget.foodController.necessity.value.macro!.breakfast!.fat! + widget.foodController.necessity.value.macro!.lunch!.fat! + widget.foodController.necessity.value.macro!.dinner!.fat!)) * 100).round()}%)',
                                    style: GoogleFonts.inter(
                                      textStyle: TextStyle(
                                          color: widget.color.primaryTextColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Neumorphic(
                        padding: EdgeInsets.all(10),
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.flat,
                          color: widget.color.primaryColor,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(20)),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Bahan-bahan',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: widget.color.secondaryTextColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Column(
                                children: widget.food.foodIngredientInfo!
                                    .map(
                                      (e) => Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              alignment: Alignment.bottomCenter,
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 10),
                                              child: FaIcon(
                                                FontAwesomeIcons.solidCircle,
                                                size: 8,
                                              )),
                                          Expanded(
                                              child:
                                                  e.ingredientDescription ==
                                                          null
                                                      ? Container(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 20),
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 5),
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                '${e.ingredientGroupName}.',
                                                                softWrap: true,
                                                                textAlign:
                                                                    TextAlign
                                                                        .justify,
                                                                style:
                                                                    GoogleFonts
                                                                        .inter(
                                                                  textStyle: TextStyle(
                                                                      color: widget
                                                                          .color
                                                                          .primaryTextColor,
                                                                      fontSize:
                                                                          14,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal),
                                                                ),
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: e
                                                                    .ingredientsGroup!
                                                                    .map(
                                                                      (e) =>
                                                                          Row(
                                                                        children: [
                                                                          Container(
                                                                              alignment: Alignment.bottomCenter,
                                                                              padding: const EdgeInsets.only(right: 5, top: 5),
                                                                              margin: EdgeInsets.symmetric(vertical: 5),
                                                                              child: FaIcon(
                                                                                FontAwesomeIcons.circle,
                                                                                size: 8,
                                                                              )),
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(left: 10),
                                                                            child:
                                                                                Text(
                                                                              '${e.ingredientDescription}.',
                                                                              softWrap: true,
                                                                              textAlign: TextAlign.justify,
                                                                              style: GoogleFonts.inter(
                                                                                textStyle: TextStyle(color: widget.color.primaryTextColor, fontSize: 14, fontWeight: FontWeight.normal),
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
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 20),
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 5),
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            '${e.ingredientDescription}.',
                                                            softWrap: true,
                                                            textAlign: TextAlign
                                                                .justify,
                                                            style: GoogleFonts
                                                                .inter(
                                                              textStyle: TextStyle(
                                                                  color: widget
                                                                      .color
                                                                      .primaryTextColor,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                          ),
                                                        ))
                                        ],
                                      ),
                                    )
                                    .toList()),

                            ///
                          ],
                        )),
                    Neumorphic(
                        padding: EdgeInsets.all(10),
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.flat,
                          color: widget.color.primaryColor,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(20)),
                        ),
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Langkah-langkah',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: widget.color.secondaryTextColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                            Column(
                              children: widget.food.foodInstructionInfo!
                                  .map(
                                    (e) => Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text('${e.step}.',
                                              style: GoogleFonts.inter(
                                                textStyle: TextStyle(
                                                    color: widget
                                                        .color.primaryTextColor,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              )),
                                        ),
                                        Expanded(
                                            child: Column(
                                          children: [
                                            e.instruction == null
                                                ? Container(
                                                    padding: EdgeInsets.only(
                                                        left: 10),
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          '${e.title}.',
                                                          softWrap: true,
                                                          textAlign:
                                                              TextAlign.justify,
                                                          style:
                                                              GoogleFonts.inter(
                                                            textStyle: TextStyle(
                                                                color: widget
                                                                    .color
                                                                    .primaryTextColor,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          ),
                                                        ),
                                                        Column(
                                                          children: e
                                                              .instructionsGroup!
                                                              .map(
                                                                (e) => Column(
                                                                  children: [
                                                                    Row(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Container(
                                                                          margin:
                                                                              EdgeInsets.symmetric(vertical: 10),
                                                                          child:
                                                                              Text(
                                                                            '${e.step}.',
                                                                            softWrap:
                                                                                true,
                                                                            textAlign:
                                                                                TextAlign.justify,
                                                                            style:
                                                                                GoogleFonts.inter(
                                                                              textStyle: TextStyle(color: widget.color.primaryTextColor, fontSize: 14, fontWeight: FontWeight.normal),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Expanded(
                                                                          child:
                                                                              Container(
                                                                            padding:
                                                                                EdgeInsets.only(left: 10),
                                                                            margin:
                                                                                EdgeInsets.symmetric(vertical: 10),
                                                                            child:
                                                                                Text(
                                                                              '${e.instruction}.',
                                                                              softWrap: true,
                                                                              textAlign: TextAlign.justify,
                                                                              style: GoogleFonts.inter(
                                                                                textStyle: TextStyle(color: widget.color.primaryTextColor, fontSize: 14, fontWeight: FontWeight.normal),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Container(
                                                                        height: size.height *
                                                                            0.2,
                                                                        width: size
                                                                            .width,
                                                                        margin: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                20,
                                                                            vertical:
                                                                                10),
                                                                        decoration: BoxDecoration(
                                                                            color: widget
                                                                                .color.hintTextColor,
                                                                            borderRadius: BorderRadius.circular(
                                                                                20)),
                                                                        child: widget.food.imageFilename ==
                                                                                ''
                                                                            ? Icon(Icons.image_not_supported_rounded)
                                                                            : Image.network(widget.food.imageFilename!)),
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
                                                        left: 10),
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10),
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      '${e.instruction}.',
                                                      softWrap: true,
                                                      textAlign:
                                                          TextAlign.justify,
                                                      style: GoogleFonts.inter(
                                                        textStyle: TextStyle(
                                                            color: widget.color
                                                                .primaryTextColor,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                      ),
                                                    ),
                                                  ),
                                            e.instruction == null
                                                ? Container()
                                                : Container(
                                                    height: size.height * 0.2,
                                                    width: size.width,
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20,
                                                            vertical: 10),
                                                    decoration: BoxDecoration(
                                                        color: widget.color
                                                            .hintTextColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    child: widget.food
                                                                .imageFilename ==
                                                            ''
                                                        ? Icon(Icons
                                                            .image_not_supported_rounded)
                                                        : Image.network(widget
                                                            .food
                                                            .imageFilename!)),
                                          ],
                                        ))
                                      ],
                                    ),
                                  )
                                  .toList(),
                            ),
                          ],
                        )),
                    Center(
                      child: NeumorphicButton(
                          margin: EdgeInsets.only(top: 12),
                          onPressed: () {},
                          style: NeumorphicStyle(
                              color: widget.color.secondaryColor,
                              shape: NeumorphicShape.flat,
                              boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(20),
                              )
                              //border: NeumorphicBorder()
                              ),
                          padding: EdgeInsets.symmetric(
                              vertical: 12, horizontal: size.width * 0.3),
                          child: Text(
                            "Selesai",
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  color: widget.color.primaryColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                          )),
                    ),
                  ]),
            ),
          ),
          IconButton(
            iconSize: 24,
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
            icon: isOnBottom
                ? FaIcon(FontAwesomeIcons.chevronCircleUp,
                    color: widget.color.secondaryColor, size: 24)
                : Container(),
          ),
        ]),
      ),
    );
  }
}
