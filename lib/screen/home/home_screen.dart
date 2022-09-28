import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sirkadian_app/controller/article_controller.dart';
import 'package:sirkadian_app/controller/fluid_controller.dart';
import 'package:sirkadian_app/controller/food_controller.dart';
import 'package:sirkadian_app/controller/information_controller.dart';
import 'package:sirkadian_app/controller/integrated_controller.dart';
import 'package:sirkadian_app/screen/home/article_screen/article_detail_screen.dart';
import 'package:sirkadian_app/screen/home/nutrition_screen/new_screen/sirkafluid_screen.dart';
import 'package:sirkadian_app/screen/list_screen.dart';

import '../../constant/hex_color.dart';
import '../../controller/auth_controller.dart';
import '../../controller/hexcolor_controller.dart';
import '../../controller/notification_controller.dart';
import '../../controller/user_controller.dart';
import '../../model/obejctbox_model.dart/food_fluid_exercise_model.dart';
import '../../objectbox.g.dart';
import '../../widget/food_widget/necessity_gauge.dart';
import 'nutrition_screen/nutrition_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final data = GetStorage('myData');
  final authController = Get.find<AuthController>();
  final userController = Get.find<UserController>();
  final articleController = Get.find<ArticleController>();
  final foodController = Get.find<FoodController>();
  final fluidController = Get.find<FluidController>();
  final informationController = Get.find<InformationController>();
  final notificationController = Get.find<NotificationController>();
  final integratedController = Get.find<IntegratedController>();
  final color = Get.find<ColorConstantController>();
  ScrollController scrollController = ScrollController();
  var closeTopContainer = false.obs;
  late Stream<List<Food>> _necessityStream;
  bool hasBeenInitializedFood = false;
  bool hasBeenInitializedFluid = false;
  late Stream<List<Fluid>> _fluidStream;

  double nutrition = 0;
  double water = 0;

  @override
  void initState() {
    // userController.getUserHealthHistoryLatest();
    // userController.getUserInformation();
    integratedController.homeRequestApi();
    // articleController.getArticleAll();
    // foodController.getNecessity();

    getApplicationDocumentsDirectory().then((dir) {
      fluidController.fluidStore =
          Store(getObjectBoxModel(), directory: '${dir.path}/fluid');
    }).then((value) => setState(() {
          _fluidStream = fluidController.fluidStore
              .box<Fluid>()
              .query(Fluid_.date.equals(fluidController.selectedDay.toString()))
              .watch(triggerImmediately: true)
              .map((query) => query.find());

          hasBeenInitializedFluid = true;
        }));
    getApplicationDocumentsDirectory().then((dir) {
      foodController.foodStore = Store(getObjectBoxModel(),
          // directory: join(dir.path, 'foodObjectBox')
          directory: '${dir.path}/food');
    }).then((value) => setState(() {
          _necessityStream = foodController.foodStore
              .box<Food>()
              .query(Food_.date.equals(foodController.selectedDay.toString()))
              .watch(triggerImmediately: true)
              .map((query) => query.find());

          hasBeenInitializedFood = true;
        }));

    scrollController.addListener(() {
      setState(() {
        closeTopContainer.value = scrollController.offset > 50;
      });
    });
    listenNotifications();
    super.initState();
  }

  void listenNotifications() {
    NotificationController().initNotification().then((value) {
      //notification setup
      notificationController.notificationFoodSarapan(
          1, notificationController.isSoundSarapan);
      notificationController.notificationFoodMakanSiang(
          2, notificationController.isSoundMakanSiang);
      notificationController.notificationFoodMakanMalam(
          3, notificationController.isSoundMakanMalam);
      notificationController.notificationFluidMinum1(
          4, notificationController.isSoundMinum1);
      notificationController.notificationFluidMinum2(
          5, notificationController.isSoundMinum2);
      notificationController.notificationFluidMinum3(
          6, notificationController.isSoundMinum3);
      notificationController.notificationFluidMinum4(
          7, notificationController.isSoundMinum4);
    });
    NotificationController.onNotifications.stream.listen(onClickedNotification);
  }

  void onClickedNotification(String? payload) {
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => NutritionScreen(
    //               hasBeenInitializedFood: hasBeenInitializedFood,
    //             )));
    Get.toNamed(RouteScreens.home);
    // Navigator.push(
    // context, MaterialPageRoute(builder: (context) => MainScreen()));
  }

  @override
  void dispose() {
    //print('-------------------------store Closed------------------------');
    foodController.foodStore.close();
    fluidController.fluidStore.close();
    hasBeenInitializedFood = false;
    hasBeenInitializedFluid = false;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => integratedController.isLoadingHomeRequestApi.isTrue
        ? Scaffold(
            body: Container(
                height: 800.h,
                width: 360.w,
                child:
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     userController.isLoadingUserInformation.isTrue ||
                    //             userController
                    //                 .isLoadingUserHealthHistoryLatest.isTrue ||
                    //             articleController.isLoadingArticleAll.isTrue ||
                    //     foodController.isLoadingNecessity.isTrue
                    // ?
                    Center(
                  child: CircularProgressIndicator(
                    color: color.secondaryColor,
                  ),
                )
                //         : NeumorphicButton(
                //             margin: EdgeInsets.only(top: 28.h),
                //             onPressed: () {
                //               userController.getUserHealthHistoryLatest();
                //               userController.getUserInformation();
                //               articleController.getArticleAll();
                //               foodController.getNecessity();
                //             },
                //             style: NeumorphicStyle(
                //                 color: color.secondaryColor,
                //                 depth: 4,
                //                 // shadowDarkColor: HexColor.fromHex('#C3C3C3'),
                //                 // shadowLightColor: HexColor.fromHex('#FFFFFF'),
                //                 shape: NeumorphicShape.flat,
                //                 boxShape: NeumorphicBoxShape.roundRect(
                //                   BorderRadius.circular(20),
                //                 )
                //                 //border: NeumorphicBorder()
                //                 ),
                //             padding: EdgeInsets.symmetric(
                //                 vertical: 12.h, horizontal: 30.w),
                //             child: Text(
                //               "Refresh",
                //               style: GoogleFonts.inter(
                //                 textStyle: TextStyle(
                //                     color: color.primaryColor,
                //                     fontSize: 14.sp,
                //                     fontWeight: FontWeight.normal),
                //               ),
                //             )),
                //   ],
                // ),
                ),
          )
        : !hasBeenInitializedFood || !hasBeenInitializedFluid
            ? Center(
                child: CircularProgressIndicator(
                  color: color.secondaryColor,
                ),
              )
            : StreamBuilder2<List<Food>, List<Fluid>>(
                streams: Tuple2(_necessityStream, _fluidStream),
                builder: (context, snapshot) {
                  switch (snapshot.item1.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return Center(
                        child: CircularProgressIndicator(
                          color: color.secondaryColor,
                        ),
                      );
                    case ConnectionState.active:
                      return scaffoldWidget(
                          context, snapshot.item1.data!, snapshot.item2.data!);
                    case ConnectionState.done:
                      return scaffoldWidget(
                          context, snapshot.item1.data!, snapshot.item2.data!);
                  }
                }));
  }

  Scaffold scaffoldWidget(
      BuildContext context, List<Food> listFood, List<Fluid> listFluid) {
    return Scaffold(
      backgroundColor: color.bgColor,

      // appBar: _buildOldAppBar(context, listFood, listFluid),
      appBar: _buildAppBar(listFood, listFluid),

      //
      body: Container(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          controller: scrollController,
          child: Column(children: [
            //segmen 2

            SizedBox(height: 18.h),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _SirkaHomeWidget(
                      color: color,
                      context: context,
                      title: "Sirkadiet",
                      icon: Icon(
                        FontAwesomeIcons.utensils,
                        size: 35,
                        color: HexColor.fromHex("73C639"),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NutritionScreen(
                              hasBeenInitializedFood: hasBeenInitializedFood,
                            ),
                          ),
                        ).then((_) {
                          setState(() {});
                        });
                      }),
                  _SirkaHomeWidget(
                    color: color,
                    context: context,
                    title: "Sirkafluid",
                    icon: SvgPicture.asset("assets/icons/glass.svg",
                        color: HexColor.fromHex("73C639")),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SirkafluidScreen(),
                        ),
                      );
                    },
                  )
                ],
              ),
              SizedBox(height: 28.h),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      "Artikel Kesehatan Sirkadian",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: color.blackColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  articleChild(),
                  SizedBox(
                    height: 18.h,
                  )
                ],
              ),
              SizedBox(height: 100.h),
            ]),
          ]),
        ),
      ),
    );
  }

  // Old Version App Bar
  PreferredSize _buildOldAppBar(
      BuildContext context, List<Food> listFood, List<Fluid> listFluid) {
    return PreferredSize(
      preferredSize: Size.fromHeight(!closeTopContainer.value ? 290.h : 80.h),
      child: AnimatedCrossFade(
        duration: const Duration(milliseconds: 200),
        crossFadeState: !closeTopContainer.value
            ? CrossFadeState.showFirst
            : CrossFadeState.showSecond,
        firstChild: Container(
          padding: EdgeInsets.only(top: 60.h, right: 20.w, left: 20.w),
          height: 290.h,
          width: double.infinity,
          decoration: BoxDecoration(color: color.secondaryColor,
              // borderRadius:
              //     BorderRadius.vertical(bottom: Radius.circular(30)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: color.blackColor.withOpacity(0.2),
                    blurRadius: 20,
                    spreadRadius: 6)
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: FaIcon(
                      FontAwesomeIcons.bars,
                      color: color.primaryColor,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteScreens.userInformation);
                    },
                    child: Stack(alignment: Alignment.center, children: [
                      CircleAvatar(
                        backgroundColor: color.primaryColor,
                        radius: 22.sp,
                      ),
                      userController.userInformationResponse.value
                                  .imageFilename !=
                              null
                          ? CircleAvatar(
                              backgroundImage: NetworkImage(userController
                                  .userInformationResponse
                                  .value
                                  .imageFilename!),
                              radius: 18.sp,
                            )
                          : CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/user_male.jpg'),
                              radius: 18.sp,
                            ),
                    ]),
                  ),
                ],
              ),
              //

              SizedBox(height: 8.h),

              RichText(
                text: TextSpan(
                  text: 'Hai ',
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                    color: color.primaryTextColor,
                    fontSize: 16.sp,
                  )),
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          '${userController.userInformationResponse.value.displayName ?? authController.data.read('dataUser')['username']},',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: color.primaryTextColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              userLogChild(listFood, listFluid),
            ],
          ),
        ),
        secondChild: Container(
            padding: EdgeInsets.only(top: 60.h, right: 20.w, left: 20.w),
            width: double.infinity,
            decoration: BoxDecoration(
                color: color.secondaryColor,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: color.blackColor.withOpacity(0.2),
                      blurRadius: 20,
                      spreadRadius: 6)
                ]),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Scaffold.of(context).openDrawer();
                    },
                    child: FaIcon(
                      FontAwesomeIcons.bars,
                      color: color.primaryColor,
                    ),
                  ),
                  Stack(alignment: Alignment.center, children: [
                    CircleAvatar(
                      backgroundColor: color.primaryColor,
                      radius: 22.sp,
                    ),
                    userController
                                .userInformationResponse.value.imageFilename !=
                            null
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(userController
                                .userInformationResponse.value.imageFilename!),
                            radius: 18.sp,
                          )
                        : CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/user_male.jpg'),
                            radius: 18.sp,
                          ),
                  ]),
                ],
              ),
            ])),
      ),
    );
  }

  Expanded userLogChild(List<Food> listFood, List<Fluid> listFluid) {
    nutrition = 0;
    water = 0;
    listFood.forEach((element) {
      nutrition += (element.energy! / element.serving!);
      water += (element.water! / element.serving!);
    });
    listFluid.forEach((element) {
      water += element.amountWater!;
    });

    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: color.primaryColor,
            borderRadius: BorderRadius.circular(20),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: color.blackColor.withOpacity(0.2),
                  blurRadius: 20,
                  spreadRadius: 6)
            ]),
        margin: EdgeInsets.only(
          top: 10.h,
          bottom: 10.h,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Log Kesehatan Hari ini',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: color.secondaryTextColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    CustomPaint(
                      child: Container(
                        height: 100.sp,
                        width: 100.sp,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${((nutrition / (foodController.necessity.value.energy!.breakfast! + foodController.necessity.value.energy!.lunch! + foodController.necessity.value.energy!.dinner!) * 100).round().toString())}%',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: color.primaryTextColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              'Nutrisi',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: color.primaryTextColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // foodController.energy /
                      //       (foodController.necessity.value
                      //               .energy!.breakfast! +
                      //           foodController.necessity
                      //               .value.energy!.lunch! +
                      //           foodController.necessity
                      //               .value.energy!.dinner!),
                      foregroundPainter: CircleProgressBarPainter(
                        foregroundColor: color.secondaryColor,
                        backgroundColor:
                            color.secondaryTextColor.withOpacity(0.3),
                        percentage: nutrition /
                            (foodController.necessity.value.energy!.breakfast! +
                                foodController.necessity.value.energy!.lunch! +
                                foodController.necessity.value.energy!.dinner!),
                        sizeContainer: Size(130.sp, 130.sp),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    CustomPaint(
                      child: Container(
                        height: 100.sp,
                        width: 100.sp,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${((0.0) * 100).round().toString()}%',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: color.primaryTextColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              'Olahraga',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: color.primaryTextColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ),
                      foregroundPainter: CircleProgressBarPainter(
                        foregroundColor: color.secondaryColor,
                        backgroundColor:
                            color.secondaryTextColor.withOpacity(0.3),
                        percentage: 0.0,
                        sizeContainer: Size(130.sp, 130.sp),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    CustomPaint(
                      child: Container(
                        height: 100.sp,
                        width: 100.sp,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${((water / foodController.necessity.value.water!) * 100).round().toString()}%',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: color.primaryTextColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              'Cairan',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: color.primaryTextColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ),
                      foregroundPainter: CircleProgressBarPainter(
                        foregroundColor: color.secondaryColor,
                        backgroundColor:
                            color.secondaryTextColor.withOpacity(0.3),
                        percentage:
                            water / foodController.necessity.value.water!,
                        sizeContainer: Size(130.sp, 130.sp),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget articleChild() {
    return articleController.articleAll.isEmpty
        ? Container(
            width: 360.w,
            height: 230.h,
            padding: EdgeInsets.only(bottom: 50.h),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Gagal memuat artikel.',
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          color: color.secondaryTextColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                  // NeumorphicButton(
                  //     margin: EdgeInsets.only(top: 12.h),
                  //     onPressed: () {
                  //       articleController.getArticleAll();
                  //     },
                  //     style: NeumorphicStyle(
                  //         color: color.secondaryColor,
                  //         depth: 4,
                  //         shape: NeumorphicShape.flat,
                  //         boxShape: NeumorphicBoxShape.roundRect(
                  //           BorderRadius.circular(20),
                  //         )
                  //         //border: NeumorphicBorder()
                  //         ),
                  //     padding: EdgeInsets.symmetric(
                  //         vertical: 12.h, horizontal: 30.w),
                  //     child: Text(
                  //       "Refresh",
                  //       style: GoogleFonts.inter(
                  //         textStyle: TextStyle(
                  //             color: color.primaryColor,
                  //             fontSize: 14.sp,
                  //             fontWeight: FontWeight.normal),
                  //       ),
                  //     )),
                ]),
          )
        : Container(
            width: 360.w,
            height: 230.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: articleController.articleAll.length,
              itemBuilder: (context, index) {
                return Stack(alignment: Alignment.topRight, children: [
                  Container(
                    margin: EdgeInsets.all(10.sp),
                    width: 200.w,
                    decoration: BoxDecoration(
                        color: color.primaryColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            height: 120.h,
                            width: 200.w,
                            decoration: BoxDecoration(
                                color: color.backupPrimaryColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20))),
                            child: articleController
                                        .articleAll[index].imageFilename ==
                                    ''
                                ? Icon(Icons.image_not_supported_rounded)
                                : Image.network(
                                    articleController
                                        .articleAll[index].imageFilename!,
                                    fit: BoxFit.contain,
                                  )),
                        SizedBox(height: 10.h),
                        Padding(
                          padding: EdgeInsets.all(10.sp),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(articleController.articleAll[index].title!,
                                  style: GoogleFonts.inter(
                                      textStyle: TextStyle(
                                          color: color.blackColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold))),
                              SizedBox(height: 5.h),
                              Text(
                                  'Diupload pada: ' +
                                      articleController
                                          .articleAll[index].updatedAt!
                                          .substring(0, 10),
                                  style: GoogleFonts.inter(
                                      textStyle: TextStyle(
                                          color: color.blackColor,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.normal))),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  NeumorphicButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ArticleDetailScreen(
                                    articleId: articleController
                                        .articleAll[index].id!)));
                      },
                      margin: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 20.h),
                      style: NeumorphicStyle(
                          color: color.secondaryColor,
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(20),
                          )
                          //border: NeumorphicBorder()
                          ),
                      padding:
                          EdgeInsets.symmetric(vertical: 8.h, horizontal: 20.w),
                      child: Text(
                        "Baca",
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              color: color.primaryColor,
                              fontSize: 10,
                              fontWeight: FontWeight.normal),
                        ),
                      )),
                ]);
              },
            ),
          );
  }

  PreferredSize _buildAppBar(List<Food> listFood, List<Fluid> listFluid) {
    return PreferredSize(
      preferredSize: Size.fromHeight(300),
      child: Container(
        decoration: BoxDecoration(
            color: HexColor.fromHex("73C639"),
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15)),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 15)
            ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Welcome text
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Home".toUpperCase(),
                            style: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 3)),
                        Text(
                            "Welcome, ${userController.userInformationResponse.value.displayName ?? authController.data.read('dataUser')['username']}",
                            style: GoogleFonts.poppins(
                                color: Colors.white.withOpacity(0.6),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2)),
                      ],
                    ),
                    GestureDetector(
                      child: Stack(
                        children: [
                          Icon(Icons.notifications_none_outlined,
                              color: Colors.white, size: 30),
                          Positioned(
                            top: 1,
                            right: 2,
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: ShapeDecoration(
                                  shape: CircleBorder(), color: Colors.red),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Center(
                    child: Text("Log Kesehatan Hari Ini",
                        style: TextStyle(color: Colors.white, fontSize: 15))),
                const SizedBox(height: 50),
                // Circular B
                _buildUserLog(listFood, listFluid),
                // const SizedBox(height: 46),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Expanded(flex: 1, child: Center(child: Text("Test/Test"))),
                //     Expanded(flex: 1, child: Center(child: Text("Test/Test"))),
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row _buildUserLog(List<Food> listFood, List<Fluid> listFluid) {
    nutrition = 0;
    water = 0;
    listFood.forEach((element) {
      nutrition += (element.energy! / element.serving!);
      water += (element.water! / element.serving!);
    });
    listFluid.forEach((element) {
      water += element.amountWater!;
    });

    double circleRadius = 110;

    int nutritionReqTotal = (foodController.necessity.value.energy!.breakfast! +
            foodController.necessity.value.energy!.lunch! +
            foodController.necessity.value.energy!.dinner!)
        .round();
    int waterReqTotal = foodController.necessity.value.water!.round();
    double nutritionPercentage = nutrition / nutritionReqTotal;
    double waterPercentage = water / waterReqTotal;

    String nutritionText = '${(nutritionPercentage * 100).round()}%';
    String waterText = '${(waterPercentage * 100).round()}%';

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Center(
            child: Column(
              children: [
                CustomPaint(
                  size: Size.fromRadius(110),
                  child: SizedBox(
                    width: 120,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.utensils, color: Colors.white),
                        Text(
                          nutritionText,
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Nutrisi terpenuhi",
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  painter: CircleProgressBarPainter(
                      foregroundColor: Colors.white,
                      backgroundColor: HexColor.fromHex("AADD88"),
                      percentage: nutritionPercentage,
                      sizeContainer: Size.fromRadius(circleRadius)),
                ),
                const SizedBox(height: 46),
                Text("Nutrisi\n ${nutrition.round()}/${nutritionReqTotal}",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center)
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Column(
              children: [
                CustomPaint(
                  child: SizedBox(
                    width: 120,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(FontAwesomeIcons.wineGlass, color: Colors.white),
                        Text(
                          waterText,
                          style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "Cairan terpenuhi",
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  painter: CircleProgressBarPainter(
                      foregroundColor: Colors.white,
                      backgroundColor: HexColor.fromHex("AADD88"),
                      percentage: waterPercentage,
                      sizeContainer: Size.fromRadius(circleRadius)),
                ),
                const SizedBox(height: 46),
                Text("Cairan\n ${water.round()}/${waterReqTotal}ml",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center)
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SirkaHomeWidget extends StatelessWidget {
  const _SirkaHomeWidget({
    Key? key,
    required this.color,
    required this.context,
    required this.title,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final ColorConstantController color;
  final BuildContext context;
  final String title;
  final Widget icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150.w,
      height: 110.h,
      child: NeumorphicButton(
          onPressed: () {
            onPressed();
          },
          style: NeumorphicStyle(
              color: color.primaryColor,
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.circular(20),
              )),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(padding: const EdgeInsets.only(bottom: 8.0), child: icon),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        color: color.secondaryTextColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
