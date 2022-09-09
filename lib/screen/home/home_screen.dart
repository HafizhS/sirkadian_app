import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';
import 'package:sirkadian_app/controller/article_controller.dart';
import 'package:sirkadian_app/controller/fluid_controller.dart';
import 'package:sirkadian_app/controller/food_controller.dart';
import 'package:sirkadian_app/controller/information_controller.dart';
import 'package:sirkadian_app/controller/integrated_controller.dart';
import 'package:sirkadian_app/screen/home/article_screen/article_detail_screen.dart';
import 'package:sirkadian_app/screen/list_screen.dart';
import '../../constant/hex_color.dart';
import '../../controller/auth_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controller/hexcolor_controller.dart';
import '../../controller/notification_controller.dart';
import '../../controller/user_controller.dart';
import '../../model/obejctbox_model.dart/food_fluid_exercise_model.dart';
import '../../objectbox.g.dart';
import '../../widget/food_widget/necessity_gauge.dart';
import 'exercise_screen/exercise_general_screen.dart';
import 'nutrition_screen/nutrition_screen.dart';
import 'package:path_provider/path_provider.dart';

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

      appBar: PreferredSize(
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
                        Stack(alignment: Alignment.center, children: [
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
                      ],
                    ),
                  ])),
        ),
      ),

      //
      body: Container(
        margin: EdgeInsets.only(top: 10.h),
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
                  NeumorphicButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NutritionScreen(
                                      hasBeenInitializedFood:
                                          hasBeenInitializedFood,
                                    ))).then((_) {
                          setState(() {});
                        });
                      },
                      style: NeumorphicStyle(
                          color: color.primaryColor,
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(20),
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Neumorphic(
                            style: NeumorphicStyle(
                                color: color.primaryColor,
                                shape: NeumorphicShape.flat,
                                depth: 4,
                                boxShape: NeumorphicBoxShape.circle(),
                                shadowLightColor: HexColor.fromHex('#CCDBD9'),
                                shadowDarkColor: HexColor.fromHex('#CCDBD9')),
                            padding: const EdgeInsets.all(12.0),
                            child: FaIcon(
                              FontAwesomeIcons.utensils,
                              size: 16,
                              color: color.secondaryColor,
                            ),
                          ),
                          Container(
                            height: 50.h,
                            width: 100.w,
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "Penuhi Nutrisi",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: color.secondaryTextColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      )),
                  NeumorphicButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ExerciseGeneralScreen()));
                        // if (Get.isSnackbarOpen) {
                        //   Get.back();
                        // } else {
                        //   informationController.snackBarError(
                        //       'Fitur Belum Tersedia',
                        //       'Fitur akan segera diujicoba');
                        // }
                      },
                      style: NeumorphicStyle(
                          color: color.primaryColor,
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(20),
                          )
                          //border: NeumorphicBorder()
                          ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Neumorphic(
                            style: NeumorphicStyle(
                                color: color.primaryColor,
                                shape: NeumorphicShape.flat,
                                depth: 4,
                                boxShape: NeumorphicBoxShape.circle(),
                                shadowLightColor: HexColor.fromHex('#CCDBD9'),
                                shadowDarkColor: HexColor.fromHex('#CCDBD9')),
                            padding: EdgeInsets.all(12.sp),
                            child: FaIcon(
                              FontAwesomeIcons.dumbbell,
                              size: 16.sp,
                              color: color.secondaryColor,
                            ),
                          ),
                          Container(
                            height: 50.h,
                            width: 100.w,
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "Olahraga",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: color.secondaryTextColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      )),
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
                  NeumorphicButton(
                      margin: EdgeInsets.only(top: 12.h),
                      onPressed: () {
                        articleController.getArticleAll();
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
                      padding: EdgeInsets.symmetric(
                          vertical: 12.h, horizontal: 30.w),
                      child: Text(
                        "Refresh",
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              color: color.primaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.normal),
                        ),
                      )),
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
}
