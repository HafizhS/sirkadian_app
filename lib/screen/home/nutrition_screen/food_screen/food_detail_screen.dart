import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/model/food_model/foodAll_response_model.dart';

import '../../../../constant/color.dart';
import '../../../../controller/food_controller.dart';
import '../../../../widget/food_widget/necessity_gauge.dart';

class FoodDetailScreen extends StatelessWidget {
  const FoodDetailScreen({
    Key? key,
    required this.food,
    required this.color,
    required this.foodController,
  }) : super(key: key);

  final DataFoodAllResponse food;

  final FoodController foodController;
  final ColorConstantController color;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(children: [
                    Container(
                      decoration: BoxDecoration(
                          color: color.backupPrimaryColor,
                          borderRadius: BorderRadius.circular(20)),
                      child: CachedNetworkImage(
                        placeholder: (context, url) => FaIcon(Icons.image),
                        imageUrl:
                            food.imageFilename == '' ? '' : food.imageFilename!,
                        fit: BoxFit.cover,
                        height: size.height * 0.3,
                        width: size.width,
                        errorWidget: (context, url, error) =>
                            FaIcon(FontAwesomeIcons.image),
                      ),
                    ),
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
                              color: color.primaryColor,
                            ),
                            padding: const EdgeInsets.all(16.0),
                            child: FaIcon(
                              FontAwesomeIcons.chevronLeft,
                              size: 16,
                              color: color.secondaryTextColor,
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
                              color: color.primaryColor,
                            ),
                            padding: const EdgeInsets.all(14.0),
                            child: FaIcon(
                              FontAwesomeIcons.solidHeart,
                              size: 16,
                              color: color.secondaryTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ]),
                  SizedBox(height: size.height * 0.01),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        food.foodName!,
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: color.primaryTextColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(width: size.width * 0.05),
                      Text(
                        (food.serving! / food.serving!).toStringAsFixed(0) +
                            ' Porsi',
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              color: color.primaryTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
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
                            color: color.primaryTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(width: size.width * 0.02),
                    Text(
                      '(30+)',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: color.secondaryTextColor.withOpacity(0.6),
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
                            color: color.secondaryColor,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ]),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Nutrisi',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: color.secondaryTextColor,
                              fontSize: 20,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                      NeumorphicButton(
                        margin: EdgeInsets.all(10),
                        onPressed: () {},
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.circle(),
                          color: color.primaryColor,
                        ),
                        padding: const EdgeInsets.all(8.0),
                        child: FaIcon(
                          FontAwesomeIcons.ellipsisH,
                          size: 16,
                          color: color.secondaryColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Kalori',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  color: color.primaryTextColor,
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
                              foregroundColor: color.secondaryColor,
                              backgroundColor:
                                  color.secondaryTextColor.withOpacity(0.3),
                              percentage: (food.energy! / food.serving!) /
                                  foodController.necessity.energy!,
                              sizeContainer:
                                  Size(size.width * 0.2, size.width * 0.2),
                            ),
                          ),
                          Text(
                            (food.energy! / food.serving!).toStringAsFixed(0) +
                                // 'kkal' +
                                ' (${(((food.energy! / food.serving!) / foodController.necessity.energy!) * 100).round()}%)',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  color: color.primaryTextColor,
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
                                  color: color.primaryTextColor,
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
                              foregroundColor: color.secondaryColor,
                              backgroundColor:
                                  color.secondaryTextColor.withOpacity(0.3),
                              percentage: (food.protein! / food.serving!) /
                                  foodController.necessity.protein!,
                              sizeContainer:
                                  Size(size.width * 0.2, size.width * 0.2),
                            ),
                          ),
                          Text(
                            (food.protein! / food.serving!).toStringAsFixed(0) +
                                'g' +
                                ' (${(((food.protein! / food.serving!) / foodController.necessity.protein!) * 100).round()}%)',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  color: color.primaryTextColor,
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
                                  color: color.primaryTextColor,
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
                              foregroundColor: color.secondaryColor,
                              backgroundColor:
                                  color.secondaryTextColor.withOpacity(0.3),
                              percentage: (food.carbohydrate! / food.serving!) /
                                  foodController.necessity.carbohydrate!,
                              sizeContainer:
                                  Size(size.width * 0.2, size.width * 0.2),
                            ),
                          ),
                          Text(
                            (food.carbohydrate! / food.serving!)
                                    .toStringAsFixed(0) +
                                'g' +
                                ' (${(((food.carbohydrate! / food.serving!) / foodController.necessity.carbohydrate!) * 100).round()}%)',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  color: color.primaryTextColor,
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
                                  color: color.primaryTextColor,
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
                              foregroundColor: color.secondaryColor,
                              backgroundColor:
                                  color.secondaryTextColor.withOpacity(0.3),
                              percentage: (food.fat! / food.serving!) /
                                  foodController.necessity.fat!,
                              sizeContainer:
                                  Size(size.width * 0.2, size.width * 0.2),
                            ),
                          ),
                          Text(
                            (food.fat! / food.serving!).toStringAsFixed(0) +
                                'g' +
                                ' (${(((food.fat! / food.serving!) / foodController.necessity.fat!) * 100).round()}%)',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                  color: color.primaryTextColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.02),
                  Text(
                    'Resep',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: color.secondaryTextColor,
                          fontSize: 20,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  SizedBox(height: size.height * 0.02),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Bahan',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: color.primaryTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Column(
                          children: food.foodIngredientInfo!
                              .map(
                                (e) => Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                        alignment: Alignment.bottomCenter,
                                        margin:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: FaIcon(
                                          FontAwesomeIcons.solidCircle,
                                          size: 8,
                                        )),
                                    Expanded(
                                        child: e.ingredientDescription == null
                                            ? Container(
                                                padding:
                                                    EdgeInsets.only(left: 20),
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 5),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${e.ingredientGroupName}.',
                                                      softWrap: true,
                                                      textAlign:
                                                          TextAlign.justify,
                                                      style: GoogleFonts.inter(
                                                        textStyle: TextStyle(
                                                            color: color
                                                                .primaryTextColor,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                      ),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children:
                                                          e.ingredientsGroup!
                                                              .map(
                                                                (e) => Row(
                                                                  children: [
                                                                    Container(
                                                                        alignment:
                                                                            Alignment
                                                                                .bottomCenter,
                                                                        padding: const EdgeInsets.only(
                                                                            right:
                                                                                5,
                                                                            top:
                                                                                5),
                                                                        margin: EdgeInsets.symmetric(
                                                                            vertical:
                                                                                5),
                                                                        child:
                                                                            FaIcon(
                                                                          FontAwesomeIcons
                                                                              .circle,
                                                                          size:
                                                                              8,
                                                                        )),
                                                                    Padding(
                                                                      padding: EdgeInsets.only(
                                                                          left:
                                                                              10),
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
                                                                              color: color.primaryTextColor,
                                                                              fontSize: 14,
                                                                              fontWeight: FontWeight.normal),
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
                                                    EdgeInsets.only(left: 20),
                                                margin: EdgeInsets.symmetric(
                                                    vertical: 5),
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  '${e.ingredientDescription}.',
                                                  softWrap: true,
                                                  textAlign: TextAlign.justify,
                                                  style: GoogleFonts.inter(
                                                    textStyle: TextStyle(
                                                        color: color
                                                            .primaryTextColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                ),
                                              ))
                                  ],
                                ),
                              )
                              .toList()),
                      SizedBox(height: size.height * 0.02),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cara Membuat',
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: color.primaryTextColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Column(
                            children: food.foodInstructionInfo!
                                .map(
                                  (e) => Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Text('${e.step}.',
                                            style: GoogleFonts.inter(
                                              textStyle: TextStyle(
                                                  color: color.primaryTextColor,
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
                                                  padding:
                                                      EdgeInsets.only(left: 20),
                                                  margin: EdgeInsets.symmetric(
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
                                                              color: color
                                                                  .primaryTextColor,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                        ),
                                                      ),
                                                      Column(
                                                        children:
                                                            e.instructionsGroup!
                                                                .map(
                                                                  (e) => Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Container(
                                                                        margin: EdgeInsets.symmetric(
                                                                            vertical:
                                                                                10),
                                                                        child:
                                                                            Text(
                                                                          '${e.step}.',
                                                                          softWrap:
                                                                              true,
                                                                          textAlign:
                                                                              TextAlign.justify,
                                                                          style:
                                                                              GoogleFonts.inter(
                                                                            textStyle: TextStyle(
                                                                                color: color.primaryTextColor,
                                                                                fontSize: 14,
                                                                                fontWeight: FontWeight.normal),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            Container(
                                                                          padding:
                                                                              EdgeInsets.only(left: 20),
                                                                          margin:
                                                                              EdgeInsets.symmetric(vertical: 10),
                                                                          child:
                                                                              Text(
                                                                            '${e.instruction}.',
                                                                            softWrap:
                                                                                true,
                                                                            textAlign:
                                                                                TextAlign.justify,
                                                                            style:
                                                                                GoogleFonts.inter(
                                                                              textStyle: TextStyle(color: color.primaryTextColor, fontSize: 14, fontWeight: FontWeight.normal),
                                                                            ),
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
                                                      EdgeInsets.only(left: 20),
                                                  margin: EdgeInsets.symmetric(
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
                                                          color: color
                                                              .primaryTextColor,
                                                          fontSize: 14,
                                                          fontWeight: FontWeight
                                                              .normal),
                                                    ),
                                                  ),
                                                ),
                                        ],
                                      ))
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      )
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
