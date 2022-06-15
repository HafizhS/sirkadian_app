import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/model/food_model/food_recommendation_response_model.dart';
import '../../../../controller/hexcolor_controller.dart';
import '../../../../controller/auth_controller.dart';
import '../../../../controller/food_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../model/obejctbox_model.dart/food_exercise_model.dart';
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
  ScrollController _scrollController = ScrollController();
  List<DataFoodRecommendationResponse> _searchResult = [];

  @override
  void initState() {
    super.initState();
    foodController.getFoodRecommendation(widget.session);

    _scrollController.addListener(_scrollListener);
  }

  _scrollListener() async {
    if (_scrollController.position.maxScrollExtent ==
            _scrollController.position.pixels &&
        foodController.isLoadingNewPage == false) {
      await foodController.getFoodRecommendationNewPage(widget.session);
      // _scrollTriggerLimit = _scrollController.position.maxScrollExtent - 700;
      print('next page');
    }
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    foodController.listFood.forEach((food) {
      if (food.foodName!.toUpperCase().contains(text.toUpperCase()))
        _searchResult.add(food);
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      initialIndex: 0,
      child: Container(
          decoration: BoxDecoration(color: color.bgColor),
          child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                  backgroundColor: color.bgColor,
                  body: Obx(
                    () => foodController.isLoadingFoodRecommendation.isTrue
                        ? Center(
                            child: CircularProgressIndicator(
                              color: color.secondaryColor,
                            ),
                          )
                        : SafeArea(
                            child: Container(
                              padding: EdgeInsets.only(top: 20.h),
                              height: 800.h,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 20.w),
                                          child: NeumorphicButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              foodController.page.value = 1;
                                            },
                                            style: NeumorphicStyle(
                                              shape: NeumorphicShape.flat,
                                              boxShape:
                                                  NeumorphicBoxShape.circle(),
                                              color: color.bgColor,
                                            ),
                                            padding: EdgeInsets.all(16.sp),
                                            child: FaIcon(
                                              FontAwesomeIcons.chevronLeft,
                                              size: 16.sp,
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
                                                left: 20.w, right: 10.w),
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 20.w),
                                            child: TextFormField(
                                              controller: _searchTextController,
                                              onChanged: (text) {
                                                onSearchTextChanged(text);
                                              },
                                              decoration: InputDecoration(
                                                icon: FaIcon(
                                                  FontAwesomeIcons.search,
                                                  size: 16.sp,
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
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                                suffixIcon: IconButton(
                                                  onPressed: () {
                                                    _searchTextController
                                                        .clear();
                                                    _searchResult.clear();
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
                                                    size: 16.sp,
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
                                      height: 28.h,
                                    ),
                                    //segment 2
                                    Container(
                                        height: 30.h,
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
                                                width: 50.w,
                                                child: Center(
                                                  child: Text(
                                                    'Semua',
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 50.w,
                                                child: Center(
                                                  child: Text(
                                                    'Pokok',
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 50.w,
                                                child: Center(
                                                  child: Text(
                                                    'Lauk',
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 50.w,
                                                child: Center(
                                                  child: Text(
                                                    'Sayur',
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 50.w,
                                                child: Center(
                                                  child: Text(
                                                    'Snack',
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 50.w,
                                                child: Center(
                                                  child: Text(
                                                    'Minum',
                                                  ),
                                                ),
                                              ),
                                            ])),
                                    SizedBox(
                                      height: 18.h,
                                    ),
                                    //segment 3
                                    Expanded(
                                      child: TabBarView(children: [
                                        tabBarItemSemuaMakanan(),
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

  Widget tabBarItemSemuaMakanan() {
    return Container(
      child: _searchTextController.text.isNotEmpty
          ? Obx(
              () => ListView.builder(
                  // controller: _scrollController,
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  itemCount: _searchResult.length,
                  itemBuilder: (context, index) {
                    return FoodTile(
                      depth: 4,
                      containerButton: () {
                        foodController.getOtherFoodRecommendation(
                            _searchResult[index].foodId, widget.session);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FoodDetailScreen(
                                      session: widget.session,
                                      foodController: foodController,
                                      color: color,
                                      recommendationScore: _searchResult[index]
                                          .recommendationScore!
                                          .toStringAsFixed(2),
                                      foodId: _searchResult[index].foodId!,
                                    )));
                      },
                      iconButton: () {
                        final food = Food(
                            imageFileName: _searchResult[index].imageFilename,
                            session: widget.session,
                            date: foodController.selectedDay.toString(),
                            name: _searchResult[index].foodName,
                            calcium: _searchResult[index].calcium,
                            carbohydrate: _searchResult[index].carbohydrate,
                            copper: _searchResult[index].copper,
                            difficulty: _searchResult[index].difficulty,
                            duration: _searchResult[index].duration,
                            energy: _searchResult[index].energy,
                            fat: _searchResult[index].fat,
                            fiber: _searchResult[index].fiber,
                            foodId: _searchResult[index].foodId,
                            foodTypes: _searchResult[index].foodTypes,
                            iron: _searchResult[index].iron,
                            phosphor: _searchResult[index].phosphor,
                            potassium: _searchResult[index].potassium,
                            protein: _searchResult[index].protein,
                            retinol: _searchResult[index].retinol,
                            serving: _searchResult[index].serving,
                            sodium: _searchResult[index].sodium,
                            tags: _searchResult[index].tags,
                            vitaminB1: _searchResult[index].vitaminB1,
                            vitaminB2: _searchResult[index].vitaminB2,
                            vitaminB3: _searchResult[index].vitaminB3,
                            vitaminC: _searchResult[index].vitaminC,
                            water: _searchResult[index].water,
                            zinc: _searchResult[index].zinc,
                            instruction: [],
                            recommendationScore: foodController
                                .listFood[index].recommendationScore!
                                .toStringAsFixed(2));
                        foodController.foodStore.box<Food>().put(food);

                        Navigator.pop(context);
                      },
                      icon: FontAwesomeIcons.plus,
                      color: color,
                      imageFilename: _searchResult[index].imageFilename! == ''
                          ? ''
                          : _searchResult[index].imageFilename!,
                      name: _searchResult[index].foodName!,
                      necessity:
                          (_searchResult[index].energy!).toStringAsFixed(0),
                      serving:
                          (_searchResult[index].serving!).toStringAsFixed(0),
                      recommendationScore: _searchResult[index]
                          .recommendationScore!
                          .toStringAsFixed(2),
                      duration:
                          _searchResult[index].duration!.toStringAsFixed(0),
                    );
                  }),
            )
          : Obx(
              () => ListView.builder(
                  controller: _scrollController,
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  itemCount: foodController.listFood.length,
                  itemBuilder: (context, index) {
                    return FoodTile(
                      depth: 4,
                      containerButton: () {
                        foodController.getOtherFoodRecommendation(
                            foodController.listFood[index].foodId,
                            widget.session);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FoodDetailScreen(
                                      session: widget.session,
                                      foodController: foodController,
                                      color: color,
                                      recommendationScore: foodController
                                          .listFood[index].recommendationScore!
                                          .toStringAsFixed(2),
                                      foodId: foodController
                                          .listFood[index].foodId!,
                                    )));
                      },
                      iconButton: () {
                        final food = Food(
                          imageFileName:
                              foodController.listFood[index].imageFilename,
                          session: widget.session,
                          date: foodController.selectedDay.toString(),
                          name: foodController.listFood[index].foodName,
                          calcium: foodController.listFood[index].calcium,
                          carbohydrate:
                              foodController.listFood[index].carbohydrate,
                          copper: foodController.listFood[index].copper,
                          difficulty: foodController.listFood[index].difficulty,
                          duration: foodController.listFood[index].duration,
                          energy: foodController.listFood[index].energy,
                          fat: foodController.listFood[index].fat,
                          fiber: foodController.listFood[index].fiber,
                          foodId: foodController.listFood[index].foodId,
                          foodTypes: foodController.listFood[index].foodTypes,
                          iron: foodController.listFood[index].iron,
                          phosphor: foodController.listFood[index].phosphor,
                          potassium: foodController.listFood[index].potassium,
                          protein: foodController.listFood[index].protein,
                          retinol: foodController.listFood[index].retinol,
                          serving: foodController.listFood[index].serving,
                          sodium: foodController.listFood[index].sodium,
                          tags: foodController.listFood[index].tags,
                          vitaminB1: foodController.listFood[index].vitaminB1,
                          vitaminB2: foodController.listFood[index].vitaminB2,
                          vitaminB3: foodController.listFood[index].vitaminB3,
                          vitaminC: foodController.listFood[index].vitaminC,
                          water: foodController.listFood[index].water,
                          zinc: foodController.listFood[index].zinc,
                          // instruction: foodController
                          //     .listFood[index]
                          //     .foodInstructionInfo!
                          //     .map((e) =>
                          //         e.instruction!)
                          //     .toList(),

                          instruction: [],
                          recommendationScore: foodController
                              .listFood[index].recommendationScore!
                              .toStringAsFixed(2),
                        );

                        foodController.foodStore.box<Food>().put(food);

                        Navigator.pop(context);
                      },
                      icon: FontAwesomeIcons.plus,
                      color: color,
                      imageFilename:
                          foodController.listFood[index].imageFilename! == ''
                              ? ''
                              : foodController.listFood[index].imageFilename!,
                      name: foodController.listFood[index].foodName!,
                      necessity: (foodController.listFood[index].energy!)
                          .toStringAsFixed(0),
                      serving: (foodController.listFood[index].serving!)
                          .toStringAsFixed(0),
                      recommendationScore: foodController
                          .listFood[index].recommendationScore!
                          .toStringAsFixed(2),
                      duration: foodController.listFood[index].duration!
                          .toStringAsFixed(0),
                    );
                  }),
            ),
    );
  }
}
