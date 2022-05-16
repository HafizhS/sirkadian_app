import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../constant/color.dart';
import '../../../../controller/auth_controller.dart';
import '../../../../controller/food_controller.dart';

import '../../../../model/obejctbox_model.dart/food_model.dart';
import '../../../../widget/food_widget/food_tile.dart';
import 'food_detail_screen.dart';

class FoodRecommendationScreen extends StatefulWidget {
  const FoodRecommendationScreen({
    Key? key,
    required this.session,
  }) : super(key: key);

  final String session;

  @override
  State<FoodRecommendationScreen> createState() =>
      _FoodRecommendationScreenState();
}

class _FoodRecommendationScreenState extends State<FoodRecommendationScreen> {
  final authController = Get.find<AuthController>();
  final foodController = Get.find<FoodController>();
  final color = Get.find<ColorConstantController>();
  TextEditingController _searchTextController = TextEditingController();
  @override
  void initState() {
    super.initState();
    foodController.getFoodAll();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 6,
      initialIndex: 0,
      child: Container(
          decoration: BoxDecoration(color: color.primaryColor),
          child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                  backgroundColor: color.primaryColor,
                  body: Obx(
                    () => foodController.listFood.isEmpty
                        ? Center(
                            child: CircularProgressIndicator(
                              color: color.secondaryColor,
                            ),
                          )
                        : SafeArea(
                            child: Container(
                              padding: EdgeInsets.only(top: 20),
                              height: size.height,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 20),
                                          child: NeumorphicButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            style: NeumorphicStyle(
                                              shape: NeumorphicShape.flat,
                                              boxShape:
                                                  NeumorphicBoxShape.circle(),
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
                                        Expanded(
                                          child: Neumorphic(
                                            style: NeumorphicStyle(
                                                depth: -2,
                                                color: color.secondaryTextColor
                                                    .withOpacity(0.1),
                                                boxShape: NeumorphicBoxShape
                                                    .roundRect(
                                                  BorderRadius.circular(30),
                                                )),
                                            padding: EdgeInsets.only(
                                                left: 20, right: 10),
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: TextFormField(
                                              controller: _searchTextController,
                                              decoration: InputDecoration(
                                                icon: FaIcon(
                                                  FontAwesomeIcons.search,
                                                  size: 16,
                                                  color:
                                                      color.secondaryTextColor,
                                                ),
                                                focusedBorder: InputBorder.none,
                                                border: InputBorder.none,
                                                hintText:
                                                    'Cari ${widget.session}',
                                                hintStyle: GoogleFonts.inter(
                                                  textStyle: TextStyle(
                                                      color: color
                                                          .secondaryTextColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                                suffixIcon: IconButton(
                                                  onPressed: () {
                                                    _searchTextController
                                                        .clear();
                                                    FocusScopeNode
                                                        currentFocus =
                                                        FocusScope.of(context);

                                                    if (!currentFocus
                                                        .hasPrimaryFocus) {
                                                      currentFocus.unfocus();
                                                    }
                                                  },
                                                  icon: FaIcon(
                                                    FontAwesomeIcons.times,
                                                    size: 16,
                                                    color: color
                                                        .secondaryTextColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(
                                      height: size.height * 0.03,
                                    ),
                                    //segment 2
                                    Container(
                                        height: 30,
                                        child: TabBar(
                                            indicatorColor:
                                                color.secondaryColor,
                                            indicatorSize:
                                                TabBarIndicatorSize.label,
                                            indicatorWeight: 4,
                                            isScrollable: true,
                                            onTap: (index) {
                                              // setState(() {
                                              //   textDisease.clear();
                                              //   onSearchTextChanged('');
                                              // });
                                            },
                                            tabs: [
                                              SizedBox(
                                                width: size.width * 0.15,
                                                child: Center(
                                                  child: Text(
                                                    'Semua',
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: size.width * 0.15,
                                                child: Center(
                                                  child: Text(
                                                    'Pokok',
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: size.width * 0.15,
                                                child: Center(
                                                  child: Text(
                                                    'Lauk',
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: size.width * 0.15,
                                                child: Center(
                                                  child: Text(
                                                    'Sayur',
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: size.width * 0.15,
                                                child: Center(
                                                  child: Text(
                                                    'Snack',
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: size.width * 0.15,
                                                child: Center(
                                                  child: Text(
                                                    'Minum',
                                                  ),
                                                ),
                                              ),
                                            ])),
                                    SizedBox(
                                      height: size.height * 0.02,
                                    ),
                                    //segment 3
                                    Expanded(
                                      child: TabBarView(children: [
                                        Container(
                                          child: ListView.builder(
                                              keyboardDismissBehavior:
                                                  ScrollViewKeyboardDismissBehavior
                                                      .onDrag,
                                              itemCount: foodController
                                                  .listFood.length,
                                              itemBuilder: (context, index) {
                                                return FoodTile(
                                                  containerButton: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                FoodDetailScreen(
                                                                  foodController:
                                                                      foodController,
                                                                  color: color,
                                                                  food: foodController
                                                                          .listFood[
                                                                      index],
                                                                )));
                                                  },
                                                  iconButton: () {
                                                    final food = Food(
                                                      imageFileName:
                                                          foodController
                                                              .listFood[index]
                                                              .imageFilename,
                                                      session: widget.session,
                                                      date: foodController
                                                          .selectedDay
                                                          .toString(),
                                                      name: foodController
                                                          .listFood[index]
                                                          .foodName,
                                                      calcium: foodController
                                                          .listFood[index]
                                                          .calcium,
                                                      carbohydrate:
                                                          foodController
                                                              .listFood[index]
                                                              .carbohydrate,
                                                      copper: foodController
                                                          .listFood[index]
                                                          .copper,
                                                      difficulty: foodController
                                                          .listFood[index]
                                                          .difficulty,
                                                      duration: foodController
                                                          .listFood[index]
                                                          .duration,
                                                      energy: foodController
                                                          .listFood[index]
                                                          .energy,
                                                      fat: foodController
                                                          .listFood[index].fat,
                                                      fiber: foodController
                                                          .listFood[index]
                                                          .fiber,
                                                      foodId: foodController
                                                          .listFood[index]
                                                          .foodId,
                                                      foodTypes: foodController
                                                          .listFood[index]
                                                          .foodTypes,
                                                      iron: foodController
                                                          .listFood[index].iron,
                                                      phosphor: foodController
                                                          .listFood[index]
                                                          .phosphor,
                                                      potassium: foodController
                                                          .listFood[index]
                                                          .potassium,
                                                      protein: foodController
                                                          .listFood[index]
                                                          .protein,
                                                      retinol: foodController
                                                          .listFood[index]
                                                          .retinol,
                                                      serving: foodController
                                                          .listFood[index]
                                                          .serving,
                                                      sodium: foodController
                                                          .listFood[index]
                                                          .sodium,
                                                      tags: foodController
                                                          .listFood[index].tags,
                                                      vitaminB1: foodController
                                                          .listFood[index]
                                                          .vitaminB1,
                                                      vitaminB2: foodController
                                                          .listFood[index]
                                                          .vitaminB2,
                                                      vitaminB3: foodController
                                                          .listFood[index]
                                                          .vitaminB3,
                                                      vitaminC: foodController
                                                          .listFood[index]
                                                          .vitaminC,
                                                      water: foodController
                                                          .listFood[index]
                                                          .water,
                                                      zinc: foodController
                                                          .listFood[index].zinc,
                                                      // instruction: foodController
                                                      //     .listFood[index]
                                                      //     .foodInstructionInfo!
                                                      //     .map((e) =>
                                                      //         e.instruction!)
                                                      //     .toList(),
                                                      instruction: [],
                                                    );
                                                    foodController.foodStore
                                                        .box<Food>()
                                                        .put(food);

                                                    Navigator.pop(context);
                                                  },
                                                  icon: FontAwesomeIcons.plus,
                                                  size: size,
                                                  color: color,
                                                  imageFilename: foodController
                                                              .listFood[index]
                                                              .imageFilename! ==
                                                          ''
                                                      ? ''
                                                      : foodController
                                                          .listFood[index]
                                                          .imageFilename!,
                                                  name: foodController
                                                      .listFood[index]
                                                      .foodName!,
                                                  necessity: (foodController
                                                              .listFood[index]
                                                              .energy! /
                                                          foodController
                                                              .listFood[index]
                                                              .serving!)
                                                      .toStringAsFixed(0),
                                                  serving: (foodController
                                                              .listFood[index]
                                                              .serving! /
                                                          foodController
                                                              .listFood[index]
                                                              .serving!)
                                                      .toStringAsFixed(0),
                                                );
                                              }),
                                        ),
                                        Center(
                                          child: Text('Pokok'),
                                        ),
                                        Center(
                                          child: Text('Lauk'),
                                        ),
                                        Center(
                                          child: Text('Sayur'),
                                        ),
                                        Center(
                                          child: Text('Snack'),
                                        ),
                                        Center(
                                          child: Text('Minum'),
                                        ),
                                      ]),
                                    ),
                                  ]),
                            ),
                          ),
                  )))),
    );
  }
}
