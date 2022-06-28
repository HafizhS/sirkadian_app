import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/controller/information_controller.dart';
import 'package:sirkadian_app/controller/user_controller.dart';
import 'package:sirkadian_app/model/food_model/food_recommendation_response_model.dart';
import '../../../../controller/hexcolor_controller.dart';
import '../../../../controller/auth_controller.dart';
import '../../../../controller/food_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../model/obejctbox_model.dart/food_fluid_exercise_model.dart';
import '../../../../widget/food_widget/food_menu_tile.dart';
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
  final userController = Get.find<UserController>();
  final informationController = Get.find<InformationController>();

  final color = Get.find<ColorConstantController>();
  TextEditingController _searchTextController = TextEditingController();
  ScrollController _scrollControllerRecommendation = ScrollController();
  ScrollController _scrollControllerRecommendationMenu = ScrollController();
  RxList<DataFoodRecommendationResponse> _searchResult =
      <DataFoodRecommendationResponse>[].obs;
  bool onSearch = false;

  bool checkBoxPokok = true;
  bool checkBoxLauk = true;
  bool checkBoxSayur = false;
  bool toggleExactFood = false;

  @override
  void initState() {
    super.initState();
    foodController.getFoodRecommendation(widget.session);
    foodController.getFoodRecommendationMenu(widget.session, checkBoxPokok,
        checkBoxLauk, checkBoxSayur, toggleExactFood);

    _scrollControllerRecommendation.addListener(_scrollListener);
    _scrollControllerRecommendationMenu.addListener(_scrollListenerMenu);
  }

  _scrollListener() async {
    if (_scrollControllerRecommendation.position.maxScrollExtent ==
            _scrollControllerRecommendation.position.pixels &&
        foodController.isLoadingNewPage == false) {
      await foodController.getFoodRecommendationNewPage(widget.session);
      // _scrollTriggerLimit = _scrollController.position.maxScrollExtent - 700;
      print('next page');
    }
  }

  _scrollListenerMenu() async {
    if (_scrollControllerRecommendationMenu.position.maxScrollExtent ==
            _scrollControllerRecommendationMenu.position.pixels &&
        foodController.isLoadingNewPage == false) {
      await foodController.getFoodRecommendationMenuNewPage(widget.session,
          checkBoxPokok, checkBoxLauk, checkBoxSayur, toggleExactFood);
      // _scrollTriggerLimit = _scrollController.position.maxScrollExtent - 700;
      print('next page');
    }
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
    }
    if (text.isNotEmpty) {
      foodController.listFood.forEach((food) {
        if (food.foodName!.toUpperCase().contains(text.toUpperCase()))
          _searchResult.add(food);
      });

      setState(() {});
    }
  }

  @override
  void dispose() {
    _scrollControllerRecommendation.removeListener(_scrollListener);
    _scrollControllerRecommendationMenu.removeListener(_scrollListener);
    _scrollControllerRecommendation.dispose();
    _scrollControllerRecommendationMenu.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Container(
          decoration: BoxDecoration(color: color.bgColor),
          child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                  backgroundColor: color.bgColor,
                  body: SafeArea(
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

                                      setState(() {
                                        foodController.page.value = 1;
                                      });
                                    },
                                    style: NeumorphicStyle(
                                      shape: NeumorphicShape.flat,
                                      boxShape: NeumorphicBoxShape.circle(),
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
                                        boxShape: NeumorphicBoxShape.roundRect(
                                          BorderRadius.circular(30),
                                        )),
                                    padding: EdgeInsets.only(
                                        left: 20.w, right: 10.w),
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20.w),
                                    child: TextFormField(
                                      controller: _searchTextController,
                                      onChanged: (text) {
                                        onSearchTextChanged(text);
                                        setState(() {
                                          onSearch = true;
                                        });
                                      },
                                      decoration: InputDecoration(
                                        icon: FaIcon(
                                          FontAwesomeIcons.search,
                                          size: 16.sp,
                                          color: color.secondaryTextColor,
                                        ),
                                        focusedBorder: InputBorder.none,
                                        border: InputBorder.none,
                                        hintText: 'Cari ${widget.session}',
                                        hintStyle: GoogleFonts.inter(
                                          textStyle: TextStyle(
                                              color: color.secondaryTextColor,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.normal),
                                        ),
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            _searchTextController.clear();
                                            _searchResult.clear();
                                            setState(() {
                                              onSearch = false;
                                            });
                                            FocusScopeNode currentFocus =
                                                FocusScope.of(context);

                                            if (!currentFocus.hasPrimaryFocus) {
                                              currentFocus.unfocus();
                                            }
                                          },
                                          icon: FaIcon(
                                            FontAwesomeIcons.times,
                                            size: 16.sp,
                                            color: color.secondaryTextColor,
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
                                    indicatorColor: onSearch
                                        ? Colors.transparent
                                        : color.secondaryColor,
                                    indicatorSize: TabBarIndicatorSize.label,
                                    indicatorWeight: 4,
                                    isScrollable: true,
                                    onTap: (index) {
                                      _searchTextController.clear();
                                      _searchResult.clear();
                                      setState(() {
                                        onSearch = false;
                                      });

                                      FocusScopeNode currentFocus =
                                          FocusScope.of(context);

                                      if (!currentFocus.hasPrimaryFocus) {
                                        currentFocus.unfocus();
                                      }
                                    },
                                    tabs: [
                                      SizedBox(
                                        width: 150.w,
                                        child: Center(
                                          child: Text(
                                            'Rekomendasi Satuan',
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 140.w,
                                        child: Center(
                                          child: Text(
                                            'Rekomendasi Menu',
                                          ),
                                        ),
                                      ),
                                    ])),
                            SizedBox(
                              height: 18.h,
                            ),
                            //segment 3
                            Expanded(
                              child: onSearch
                                  ? tabBarItemSearchSatuanMakanan()
                                  : TabBarView(children: [
                                      tabBarItemSatuanMakanan(),
                                      tabBarItemMenuMakanan(),
                                    ]),
                            ),
                          ]),
                    ),
                  )))),
    );
  }

  Widget tabBarItemSatuanMakanan() {
    return Container(
        child: Obx(() => foodController.isLoadingFoodRecommendation.isTrue ||
                foodController.isLoadingFoodRecommendationMenu.isTrue
            ? Center(
                child: CircularProgressIndicator(
                  color: color.secondaryColor,
                ),
              )
            : recommendationChild()));
  }

  Widget tabBarItemMenuMakanan() {
    return Container(
        child: Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    'Pokok',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: color.primaryTextColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Checkbox(
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    activeColor: color.secondaryColor,
                    value: checkBoxPokok,
                    onChanged: (val) {
                      setState(() {
                        checkBoxPokok = val!;
                      });
                      foodController.getFoodRecommendationMenu(
                          widget.session,
                          checkBoxPokok,
                          checkBoxLauk,
                          checkBoxSayur,
                          toggleExactFood);
                    },
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Lauk',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: color.primaryTextColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Checkbox(
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    activeColor: color.secondaryColor,
                    value: checkBoxLauk,
                    onChanged: (val) {
                      setState(() {
                        checkBoxLauk = val!;
                      });
                      foodController.getFoodRecommendationMenu(
                          widget.session,
                          checkBoxPokok,
                          checkBoxLauk,
                          checkBoxSayur,
                          toggleExactFood);
                    },
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Sayur',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: color.primaryTextColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Checkbox(
                    visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                    activeColor: color.secondaryColor,
                    value: checkBoxSayur,
                    onChanged: (val) {
                      setState(() {
                        checkBoxSayur = val!;
                      });
                      foodController.getFoodRecommendationMenu(
                          widget.session,
                          checkBoxPokok,
                          checkBoxLauk,
                          checkBoxSayur,
                          toggleExactFood);
                    },
                  ),
                  SizedBox(width: 10.w),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Exact',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: color.primaryTextColor,
                              fontSize: 8.sp,
                              fontWeight: FontWeight.normal))),
                  FlutterSwitch(
                    width: 50.w,
                    height: 20.h,
                    valueFontSize: 8.sp,
                    toggleSize: 12.sp,
                    value: toggleExactFood,
                    activeColor: color.secondaryColor,
                    borderRadius: 30.0,
                    padding: 2.sp,
                    showOnOff: true,
                    onToggle: (val) {
                      setState(() {
                        toggleExactFood = val;
                      });
                      foodController.getFoodRecommendationMenu(
                          widget.session,
                          checkBoxPokok,
                          checkBoxLauk,
                          checkBoxSayur,
                          toggleExactFood);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
        Expanded(
            child: Obx(() =>
                foodController.isLoadingFoodRecommendationMenu.isTrue ||
                        foodController.isLoadingFoodRecommendation.isTrue
                    ? Center(
                        child: CircularProgressIndicator(
                          color: color.secondaryColor,
                        ),
                      )
                    : recommendationMenuChild())),
      ],
    ));
  }

  Widget tabBarItemSearchSatuanMakanan() {
    return Container(
        child: _searchResult.isEmpty
            ? Center(
                child: Text(
                  'Makanan Tidak Ditemukan',
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        color: color.secondaryTextColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              )
            : searchChild());
  }

  Obx recommendationChild() {
    return Obx(
      () => foodController.listFood.isEmpty
          ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Gagal memuat data.',
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                      color: color.secondaryTextColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal),
                ),
              ),
              NeumorphicButton(
                  margin: EdgeInsets.only(top: 12.h),
                  onPressed: () {
                    foodController.getFoodRecommendation(widget.session);
                    foodController.getFoodRecommendationMenu(
                        widget.session, true, true, false, false);
                    setState(() {
                      checkBoxPokok = true;
                      checkBoxLauk = true;
                      checkBoxSayur = false;
                      toggleExactFood = false;
                    });
                  },
                  style: NeumorphicStyle(
                      color: color.secondaryColor,
                      depth: 4,
                      shape: NeumorphicShape.flat,
                      boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(20),
                      )
                      //border: NeumorphicBorder()
                      ),
                  padding:
                      EdgeInsets.symmetric(vertical: 12.h, horizontal: 30.w),
                  child: Text(
                    "Refresh",
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          color: color.primaryColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal),
                    ),
                  )),
            ])
          : ListView.builder(
              controller: _scrollControllerRecommendation,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: foodController.listFood.length + 1,
              itemBuilder: (context, index) {
                if (index < foodController.listFood.length) {
                  return FoodTile(
                    depth: 4,
                    containerButton: () {
                      foodController.getOtherFoodRecommendation(
                          foodController.listFood[index].foodId,
                          widget.session);
                      foodController
                          .getFoodItem(foodController.listFood[index].foodId);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FoodDetailScreen(
                                    isFromFoodMeal: false,
                                    session: widget.session,
                                    foodController: foodController,
                                    color: color,
                                    recommendationScore: foodController
                                        .listFood[index].recommendationScore!
                                        .toStringAsFixed(2),
                                    foodId:
                                        foodController.listFood[index].foodId!,
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

                        itemFood: '',
                        recommendationScore: foodController
                            .listFood[index].recommendationScore!
                            .toStringAsFixed(2),
                      );

                      // if (foodController.listFoodMenu.isNotEmpty) {
                      if (foodController.listFoodName
                          .contains(foodController.listFood[index].foodName)) {
                        informationController.snackBarError(
                            'Makan Sudah Anda Pilih',
                            'Selamat berpola hidup sehat!');
                        Navigator.pop(context);
                      } else {
                        foodController.foodStore.box<Food>().put(food);

                        Navigator.pop(context);
                      }
                      // }
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
                } else {
                  return !foodController.isStopFood
                      ? Center(
                          child: CircularProgressIndicator(
                            color: color.secondaryColor,
                          ),
                        )
                      : Container();
                }
              }),
    );
  }

  Obx recommendationMenuChild() {
    return Obx(
      () => foodController.listFoodMenu.isEmpty
          ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Gagal memuat data atau kombinasi makanan belum/tidak tersedia.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                      color: color.secondaryTextColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal),
                ),
              ),
              NeumorphicButton(
                  margin: EdgeInsets.only(top: 12.h),
                  onPressed: () {
                    foodController.getFoodRecommendation(widget.session);

                    foodController.getFoodRecommendationMenu(
                        widget.session, true, true, false, false);
                    setState(() {
                      checkBoxPokok = true;
                      checkBoxLauk = true;
                      checkBoxSayur = false;
                      toggleExactFood = false;
                    });
                  },
                  style: NeumorphicStyle(
                      color: color.secondaryColor,
                      depth: 4,
                      shape: NeumorphicShape.flat,
                      boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(20),
                      )
                      //border: NeumorphicBorder()
                      ),
                  padding:
                      EdgeInsets.symmetric(vertical: 12.h, horizontal: 30.w),
                  child: Text(
                    "Refresh",
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          color: color.primaryColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal),
                    ),
                  )),
            ])
          : ListView.builder(
              controller: _scrollControllerRecommendationMenu,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              itemCount: foodController.listFoodMenu.length + 1,
              itemBuilder: (context, index) {
                if (index < foodController.listFoodMenu.length) {
                  return Neumorphic(
                    style: NeumorphicStyle(color: color.bgColor),
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    margin: EdgeInsets.only(
                        bottom: 20.h, top: 10.h, left: 10.w, right: 10.w),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 12.h),
                                child: Row(
                                  children: [
                                    Text(
                                      'Skor Rekomendasi: ',
                                      style: GoogleFonts.inter(
                                        textStyle: TextStyle(
                                            color: color.secondaryTextColor,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                    FaIcon(
                                      FontAwesomeIcons.solidStar,
                                      color: color.yellowColor,
                                      size: 12,
                                    ),
                                    Text(
                                      ' ' +
                                          foodController.listFoodMenu[index]
                                              .recommendationScore!
                                              .toStringAsFixed(2),
                                      style: GoogleFonts.inter(
                                        textStyle: TextStyle(
                                            color: color.secondaryTextColor,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 18.w),
                              Container(
                                margin:
                                    EdgeInsets.only(right: 20.w, bottom: 20.h),
                                child: NeumorphicButton(
                                  onPressed: () {
                                    foodController.listFoodMenu[index].foods!
                                        .forEach((element) {
                                      final food = Food(
                                          imageFileName: element.imageFilename,
                                          session: widget.session,
                                          date: foodController.selectedDay
                                              .toString(),
                                          name: element.foodName,
                                          calcium: element.calcium,
                                          carbohydrate: element.carbohydrate,
                                          copper: element.copper,
                                          difficulty: element.difficulty,
                                          duration: element.duration,
                                          energy: element.energy,
                                          fat: element.fat,
                                          fiber: element.fiber,
                                          foodId: element.foodId,
                                          foodTypes: element.foodTypes,
                                          iron: element.iron,
                                          phosphor: element.phosphor,
                                          potassium: element.potassium,
                                          protein: element.protein,
                                          retinol: element.retinol,
                                          serving: element.serving,
                                          sodium: element.sodium,
                                          tags: element.tags,
                                          vitaminB1: element.vitaminB1,
                                          vitaminB2: element.vitaminB2,
                                          vitaminB3: element.vitaminB3,
                                          vitaminC: element.vitaminC,
                                          water: element.water,
                                          zinc: element.zinc,
                                          itemFood: '',
                                          recommendationScore: foodController
                                              .listFoodMenu[index]
                                              .recommendationScore!
                                              .toStringAsFixed(2));

                                      foodController.foodStore
                                          .box<Food>()
                                          .put(food);
                                    });
                                    foodController.listFoodId
                                        .forEach((element) {
                                      foodController.foodStore
                                          .box<Food>()
                                          .remove(element);
                                      print('here');
                                    });
                                    if (foodController.listFoodId.isNotEmpty) {
                                      informationController.snackBarError(
                                          'Menu Makan Anda Sudah Dilengkapi',
                                          'Selamat berpola hidup sehat!');
                                    }

                                    Navigator.pop(context);
                                  },
                                  style: NeumorphicStyle(
                                    depth: 4,
                                    shape: NeumorphicShape.flat,
                                    boxShape: NeumorphicBoxShape.circle(),
                                    color: color.bgColor,
                                  ),
                                  padding: EdgeInsets.all(10.sp),
                                  child: FaIcon(
                                    FontAwesomeIcons.plus,
                                    size: 12.sp,
                                    color: color.secondaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                            children: foodController.listFoodMenu[index].foods!
                                .map((e) => FoodMenuTile(
                                      depth: 4,
                                      containerButton: () {
                                        foodController
                                            .getOtherFoodRecommendation(
                                                e.foodId, widget.session);
                                        foodController.getFoodItem(e.foodId);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    FoodDetailScreen(
                                                      isFromFoodMeal: false,
                                                      session: widget.session,
                                                      foodController:
                                                          foodController,
                                                      color: color,
                                                      recommendationScore:
                                                          foodController
                                                              .listFoodMenu[
                                                                  index]
                                                              .recommendationScore!
                                                              .toStringAsFixed(
                                                                  2),
                                                      foodId: e.foodId!,
                                                    )));
                                      },
                                      color: color,
                                      imageFilename: e.imageFilename! == ''
                                          ? ''
                                          : e.imageFilename!,
                                      name: e.foodName!,
                                      necessity: (e.energy!).toStringAsFixed(0),
                                      serving: (e.serving!).toStringAsFixed(0),
                                      duration: e.duration!.toStringAsFixed(0),
                                    ))
                                .toList()),
                      ],
                    ),
                  );
                } else {
                  return !foodController.isStopFoodMenu
                      ? Center(
                          child: CircularProgressIndicator(
                            color: color.secondaryColor,
                          ),
                        )
                      : Container();
                }
              }),
    );
  }

  Obx searchChild() {
    return Obx(
      () => ListView.builder(
          // controller: _scrollController,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: _searchResult.length,
          itemBuilder: (context, index) {
            return FoodTile(
              depth: 4,
              containerButton: () {
                foodController.getOtherFoodRecommendation(
                    _searchResult[index].foodId, widget.session);
                foodController.getFoodItem(_searchResult[index].foodId);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FoodDetailScreen(
                              isFromFoodMeal: false,
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
                    itemFood: '',
                    recommendationScore: _searchResult[index]
                        .recommendationScore!
                        .toStringAsFixed(2));
                // foodController.foodStore.box<Food>().put(food);

                if (foodController.listFoodName
                    .contains(_searchResult[index].foodName)) {
                  informationController.snackBarError(
                      'Makan Sudah Anda Pilih', 'Selamat berpola hidup sehat!');
                  Navigator.pop(context);
                } else {
                  foodController.foodStore.box<Food>().put(food);

                  Navigator.pop(context);
                }
              },
              icon: FontAwesomeIcons.plus,
              color: color,
              imageFilename: _searchResult[index].imageFilename! == ''
                  ? ''
                  : _searchResult[index].imageFilename!,
              name: _searchResult[index].foodName!,
              necessity: (_searchResult[index].energy!).toStringAsFixed(0),
              serving: (_searchResult[index].serving!).toStringAsFixed(0),
              recommendationScore:
                  _searchResult[index].recommendationScore!.toStringAsFixed(2),
              duration: _searchResult[index].duration!.toStringAsFixed(0),
            );
          }),
    );
  }
}
