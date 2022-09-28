import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/controller/information_controller.dart';
import 'package:sirkadian_app/controller/user_controller.dart';
import 'package:sirkadian_app/model/food_model/food_recommendation_response_model.dart';

import '../../../../constant/hex_color.dart';
import '../../../../controller/auth_controller.dart';
import '../../../../controller/food_controller.dart';
import '../../../../controller/hexcolor_controller.dart';
import '../../../../model/obejctbox_model.dart/food_fluid_exercise_model.dart';
import '../../../../widget/food_widget/food_menu_tile.dart';
import '../../../../widget/food_widget/food_tile2.dart';
import 'food_detail_screen.dart';

class FoodRecommendationScreen2 extends StatefulWidget {
  const FoodRecommendationScreen2({
    Key? key,
    required this.session,
  }) : super(key: key);

  final String session;

  @override
  State<FoodRecommendationScreen2> createState() =>
      _FoodRecommendationScreen2State();
}

class _FoodRecommendationScreen2State extends State<FoodRecommendationScreen2> {
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
    foodController.getFoodAll();

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
      foodController.listFoodAll.forEach((food) {
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
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 65,
          elevation: 0,
          title: Text(
            "Sarapan".toUpperCase(),
            style: GoogleFonts.poppins(
                fontSize: 20.sp,
                letterSpacing: 3.sp,
                color: Colors.white,
                fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
          backgroundColor: HexColor.fromHex("73C639"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back, size: 35.sp, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          automaticallyImplyLeading: true,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            children: [
              Container(
                color: HexColor.fromHex("73C639"),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: double.infinity,
                        height: 35,
                        decoration: ShapeDecoration(
                            shape: StadiumBorder(
                                side:
                                    BorderSide(color: Colors.white, width: 2))),
                        margin: EdgeInsets.symmetric(horizontal: 18),
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.search,
                              size: 16.sp,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: TextFormField(
                                cursorColor: Colors.white,
                                controller: _searchTextController,
                                onChanged: (text) {
                                  onSearchTextChanged(text);
                                  setState(() {
                                    onSearch = true;
                                  });
                                },
                                decoration: InputDecoration(
                                  focusedBorder: InputBorder.none,
                                  border: InputBorder.none,
                                  hintText: 'Cari ${widget.session}',
                                  hintStyle: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
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
                                color: Colors.white,
                              ),
                            )
                          ],
                        )),
                    const SizedBox(height: 5),
                    Container(
                      color: HexColor.fromHex("73C639"),
                      child: TabBar(indicatorColor: Colors.white, tabs: [
                        Tab(
                          child: Text(
                            "Rekomendasi Satuan",
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        Tab(
                          child: Text(
                            "Rekomendasi Menu",
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: onSearch
                    ? tabBarItemSearchSatuanMakanan()
                    : TabBarView(
                        children: [
                          tabBarItemSatuanMakanan(),
                          tabBarItemMenuMakanan(),
                        ],
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget tabBarItemSatuanMakanan() {
    return Container(
        child: Obx(() => foodController.isLoadingFoodRecommendation.isTrue ||
                foodController.isLoadingFoodRecommendationMenu.isTrue ||
                foodController.isLoadingFoodAll.isTrue
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
        _buildFilterContent(),
        // Padding(
        //   padding: EdgeInsets.symmetric(horizontal: 10.w),
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       Row(
        //         children: [
        //           Text(
        //             'Pokok',
        //             style: GoogleFonts.poppins(
        //               textStyle: TextStyle(
        //                   color: color.primaryTextColor,
        //                   fontSize: 14.sp,
        //                   fontWeight: FontWeight.w600),
        //             ),
        //           ),
        //           Checkbox(
        //             visualDensity: VisualDensity(horizontal: -4, vertical: -4),
        //             activeColor: color.secondaryColor,
        //             value: checkBoxPokok,
        //             onChanged: (val) {
        //               setState(() {
        //                 checkBoxPokok = val!;
        //               });
        //               foodController.getFoodRecommendationMenu(
        //                   widget.session,
        //                   checkBoxPokok,
        //                   checkBoxLauk,
        //                   checkBoxSayur,
        //                   toggleExactFood);
        //             },
        //           ),
        //           SizedBox(width: 10.w),
        //           Text(
        //             'Lauk',
        //             style: GoogleFonts.poppins(
        //               textStyle: TextStyle(
        //                   color: color.primaryTextColor,
        //                   fontSize: 14.sp,
        //                   fontWeight: FontWeight.w600),
        //             ),
        //           ),
        //           Checkbox(
        //             visualDensity: VisualDensity(horizontal: -4, vertical: -4),
        //             activeColor: color.secondaryColor,
        //             value: checkBoxLauk,
        //             onChanged: (val) {
        //               setState(() {
        //                 checkBoxLauk = val!;
        //               });
        //               foodController.getFoodRecommendationMenu(
        //                   widget.session,
        //                   checkBoxPokok,
        //                   checkBoxLauk,
        //                   checkBoxSayur,
        //                   toggleExactFood);
        //             },
        //           ),
        //           SizedBox(width: 10.w),
        //           Text(
        //             'Sayur',
        //             style: GoogleFonts.poppins(
        //               textStyle: TextStyle(
        //                   color: color.primaryTextColor,
        //                   fontSize: 14.sp,
        //                   fontWeight: FontWeight.w600),
        //             ),
        //           ),
        //           Checkbox(
        //             visualDensity: VisualDensity(horizontal: -4, vertical: -4),
        //             activeColor: color.secondaryColor,
        //             value: checkBoxSayur,
        //             onChanged: (val) {
        //               setState(() {
        //                 checkBoxSayur = val!;
        //               });
        //               foodController.getFoodRecommendationMenu(
        //                   widget.session,
        //                   checkBoxPokok,
        //                   checkBoxLauk,
        //                   checkBoxSayur,
        //                   toggleExactFood);
        //             },
        //           ),
        //           SizedBox(width: 10.w),
        //         ],
        //       ),
        //       Column(
        //         mainAxisAlignment: MainAxisAlignment.start,
        //         children: [
        //           Text('Exact',
        //               style: GoogleFonts.poppins(
        //                   textStyle: TextStyle(
        //                       color: color.primaryTextColor,
        //                       fontSize: 8.sp,
        //                       fontWeight: FontWeight.normal))),
        //           FlutterSwitch(
        //             width: 50.w,
        //             height: 20.h,
        //             valueFontSize: 8.sp,
        //             toggleSize: 12.sp,
        //             value: toggleExactFood,
        //             activeColor: color.secondaryColor,
        //             borderRadius: 30.0,
        //             padding: 2.sp,
        //             showOnOff: true,
        //             onToggle: (val) {
        //               setState(() {
        //                 toggleExactFood = val;
        //               });
        //               foodController.getFoodRecommendationMenu(
        //                   widget.session,
        //                   checkBoxPokok,
        //                   checkBoxLauk,
        //                   checkBoxSayur,
        //                   toggleExactFood);
        //             },
        //           ),
        //         ],
        //       )
        //     ],
        //   ),
        // ),
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
          : Column(
              children: [
                _buildFilterContent(),
                Expanded(
                    child: ListView.builder(
                        controller: _scrollControllerRecommendation,
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        itemCount: foodController.listFood.length + 1,
                        itemBuilder: (context, index) {
                          if (index < foodController.listFood.length) {
                            return FoodTile2(
                              depth: 4,
                              containerButton: () {
                                foodController.getOtherFoodRecommendation(
                                    foodController.listFood[index].foodId,
                                    widget.session);
                                foodController.getFoodItem(
                                    foodController.listFood[index].foodId);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FoodDetailScreen(
                                              isFromFoodMeal: false,
                                              session: widget.session,
                                              foodController: foodController,
                                              color: color,
                                              recommendationScore:
                                                  foodController.listFood[index]
                                                      .recommendationScore!
                                                      .toStringAsFixed(2),
                                              foodId: foodController
                                                  .listFood[index].foodId!,
                                            )));
                              },
                              iconButton: () {
                                final food = Food(
                                    imageFileName: foodController
                                        .listFood[index].imageFilename,
                                    session: widget.session,
                                    date: foodController.selectedDay.toString(),
                                    name:
                                        foodController.listFood[index].foodName,
                                    calcium:
                                        foodController.listFood[index].calcium,
                                    carbohydrate: foodController
                                        .listFood[index].carbohydrate,
                                    copper:
                                        foodController.listFood[index].copper,
                                    difficulty: foodController
                                        .listFood[index].difficulty,
                                    duration:
                                        foodController.listFood[index].duration,
                                    energy:
                                        foodController.listFood[index].energy,
                                    fat: foodController.listFood[index].fat,
                                    fiber: foodController.listFood[index].fiber,
                                    foodId:
                                        foodController.listFood[index].foodId,
                                    foodTypes: foodController
                                        .listFood[index].foodTypes,
                                    iron: foodController.listFood[index].iron,
                                    phosphor:
                                        foodController.listFood[index].phosphor,
                                    potassium: foodController
                                        .listFood[index].potassium,
                                    protein:
                                        foodController.listFood[index].protein,
                                    retinol:
                                        foodController.listFood[index].retinol,
                                    serving:
                                        foodController.listFood[index].serving,
                                    sodium:
                                        foodController.listFood[index].sodium,
                                    tags: foodController.listFood[index].tags,
                                    vitaminB1: foodController
                                        .listFood[index].vitaminB1,
                                    vitaminB2: foodController
                                        .listFood[index].vitaminB2,
                                    vitaminB3: foodController
                                        .listFood[index].vitaminB3,
                                    vitaminC:
                                        foodController.listFood[index].vitaminC,
                                    water: foodController.listFood[index].water,
                                    zinc: foodController.listFood[index].zinc,
                                    // instruction: foodController
                                    //     .listFood[index]
                                    //     .foodInstructionInfo!
                                    //     .map((e) =>
                                    //         e.instruction!)
                                    //     .toList(),

                                    itemFood: '',
                                    // recommendationScore: foodController
                                    //     .listFood[index].recommendationScore!
                                    //     .toStringAsFixed(2),
                                    recommendationScore: '');

                                // if (foodController.listFoodMenu.isNotEmpty) {
                                if (foodController.listFoodName.contains(
                                    foodController.listFood[index].foodName)) {
                                  informationController.snackBarError(
                                      'Makan Sudah Anda Pilih',
                                      'Selamat berpola hidup sehat!');
                                  Navigator.pop(context);
                                } else {
                                  foodController.foodStore
                                      .box<Food>()
                                      .put(food);

                                  Navigator.pop(context);
                                }
                                // }
                              },
                              icon: FontAwesomeIcons.plus,
                              color: color,
                              imageFilename: foodController
                                          .listFood[index].imageFilename! ==
                                      ''
                                  ? ''
                                  : foodController
                                      .listFood[index].imageFilename!,
                              name: foodController.listFood[index].foodName!,
                              necessity:
                                  (foodController.listFood[index].energy!)
                                      .toStringAsFixed(0),
                              serving: (foodController.listFood[index].serving!)
                                  .toStringAsFixed(0),
                              recommendationScore: foodController
                                  .listFood[index].recommendationScore!
                                  .toStringAsFixed(2),
                              duration: foodController.listFood[index].duration!
                                  .toStringAsFixed(0),
                              isFromMealPlan: false,
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
                        })),
              ],
            ),
    );
  }

  Padding _buildFilterContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Rekomendasi ${widget.session}",
              style: GoogleFonts.poppins(
                  color: HexColor.fromHex("#313638"),
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp)),
          NeumorphicButton(
            onPressed: () {
              Get.bottomSheet(
                _bottomSheetFilter(),
                persistent: true,
              );
            },
            padding: EdgeInsets.all(6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Sort and Filter",
                  style: GoogleFonts.poppins(
                      height: 1,
                      color: HexColor.fromHex("#313638"),
                      fontWeight: FontWeight.w500,
                      fontSize: 13.sp),
                ),
                Icon(
                  Icons.filter_list_alt,
                  color: HexColor.fromHex("#73C639"),
                ),
              ],
            ),
            minDistance: 0,
            style: NeumorphicStyle(
                depth: 4,
                color: Colors.white,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(15))),
          )
        ],
      ),
    );
  }

  Container _bottomSheetFilter() {
    return Container(
      width: double.infinity,
      height: 350.h,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20), topLeft: Radius.circular(20)),
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              child: IconButton(
                alignment: Alignment.center,
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  FontAwesomeIcons.times,
                  color: HexColor.fromHex("#D95978"),
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(
                  "Filter",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w500, fontSize: 16.sp),
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Tags",
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500, fontSize: 16.sp),
                    ),
                    const SizedBox(height: 10),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 40.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: HexColor.fromHex("#F8F9FB"),
                            border: Border.all(
                              color: HexColor.fromHex("#D9D9D9"),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 13),
                          child: Row(
                            children: [
                              Container(
                                height: 30,
                                margin: EdgeInsets.symmetric(horizontal: 1),
                                decoration: ShapeDecoration(
                                  shape: StadiumBorder(),
                                  color: HexColor.fromHex("#73C639"),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Daging Sapi",
                                          style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13.sp,
                                              color: Colors.white)),
                                      Container(
                                        width: 15,
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            FontAwesomeIcons.times,
                                            color: HexColor.fromHex("#D95978"),
                                            size: 12.sp,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                height: 30,
                                margin: EdgeInsets.symmetric(horizontal: 1),
                                decoration: ShapeDecoration(
                                  shape: StadiumBorder(),
                                  color: HexColor.fromHex("#73C639"),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Daging Sapi",
                                          style: GoogleFonts.inter(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13.sp,
                                              color: Colors.white)),
                                      Container(
                                        width: 15,
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            FontAwesomeIcons.times,
                                            color: HexColor.fromHex("#D95978"),
                                            size: 12.sp,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sort",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w500, fontSize: 16.sp),
                    ),
                    const SizedBox(height: 15),
                    Divider(height: 1, color: Colors.grey),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Score",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w400, fontSize: 16.sp),
                        ),
                        Container(
                          width: 25.w,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_downward,
                              color:
                                  HexColor.fromHex("#313638").withOpacity(.88),
                              size: 27.sp,
                            ),
                          ),
                        ),
                        Container(
                          width: 25.w,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_upward,
                              color:
                                  HexColor.fromHex("#313638").withOpacity(.88),
                              size: 27.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(height: 1, color: Colors.grey),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Kalori",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w400, fontSize: 16.sp),
                        ),
                        Container(
                          width: 25.w,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_downward,
                              color:
                                  HexColor.fromHex("#313638").withOpacity(.88),
                              size: 27.sp,
                            ),
                          ),
                        ),
                        Container(
                          width: 25.w,
                          child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.arrow_upward,
                              color:
                                  HexColor.fromHex("#313638").withOpacity(.88),
                              size: 27.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(height: 1, color: Colors.grey),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor.fromHex("#73C639")),
                  onPressed: () {},
                  child: Text(
                    "Tampilkan Makanan",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ],
      ),
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
                                      style: GoogleFonts.lexend(
                                        textStyle: TextStyle(
                                            color: color.secondaryTextColor,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    FaIcon(
                                      FontAwesomeIcons.solidStar,
                                      color: color.yellowColor,
                                      size: 15,
                                    ),
                                    Text(
                                      ' ' +
                                          foodController.listFoodMenu[index]
                                              .recommendationScore!
                                              .toStringAsFixed(2),
                                      style: GoogleFonts.lexend(
                                        textStyle: TextStyle(
                                            color: color.secondaryTextColor,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400),
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
                                          // recommendationScore: foodController
                                          //     .listFoodMenu[index]
                                          //     .recommendationScore!
                                          //     .toStringAsFixed(2)
                                          recommendationScore: '');

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
            return FoodTile2(
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
                              recommendationScore: 0.toStringAsFixed(2),
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
                    recommendationScore:
                        _searchResult[index].recommendationScore != null
                            ? _searchResult[index]
                                .recommendationScore!
                                .toStringAsFixed(2)
                            : '');
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
              recommendationScore: _searchResult[index].recommendationScore !=
                      null
                  ? _searchResult[index].recommendationScore!.toStringAsFixed(2)
                  : '',
              duration: _searchResult[index].duration!.toStringAsFixed(0),
              isFromMealPlan: false,
            );
          }),
    );
  }
}
