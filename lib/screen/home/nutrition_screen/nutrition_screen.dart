import 'dart:async';

import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sirkadian_app/screen/home/nutrition_screen/fluid_screen/fuild_general_screen.dart';
import 'package:sirkadian_app/screen/home/nutrition_screen/food_screen/food_general_screen.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';

import '../../../constant/color.dart';
import '../../../controller/auth_controller.dart';
import '../../../controller/food_controller.dart';
import '../../../model/food_model/objectbox_model/food_model.dart';
import '../../../objectbox.g.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({Key? key}) : super(key: key);

  @override
  State<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  final authController = Get.find<AuthController>();
  final foodController = Get.find<FoodController>();
  final color = Get.find<ColorConstantController>();
  // StreamController<List<Food>> controller = StreamController<List<Food>>();
  late Stream<List<Food>> _necessityStream;
  late Stream<List<Food>> _sarapanStream;
  late Stream<List<Food>> _makanSiangStream;
  late Stream<List<Food>> _makanMalamStream;
  late Stream<List<Food>> _snackStream;
  // = controller.stream;

  bool hasBeenInitialized = false;
  var isFood = true;

  @override
  void initState() {
    super.initState();
    getNecessity();

    getApplicationDocumentsDirectory().then((dir) {
      foodController.foodStore = Store(getObjectBoxModel(),
          directory: join(dir.path, 'foodObjectBox'));
    }).then((value) => setState(() {
          _necessityStream = foodController.foodStore
              .box<Food>()
              .query(Food_.date.equals(foodController.selectedDay.toString()))
              .watch(triggerImmediately: true)
              .map((query) => query.find());
          _sarapanStream = foodController.foodStore
              .box<Food>()
              .query(Food_.date.equals(foodController.selectedDay.toString()) &
                  Food_.session.equals('Sarapan'))
              .watch(triggerImmediately: true)
              .map((query) => query.find());
          _makanSiangStream = foodController.foodStore
              .box<Food>()
              .query(Food_.date.equals(foodController.selectedDay.toString()) &
                  Food_.session.equals('Makan Siang'))
              .watch(triggerImmediately: true)
              .map((query) => query.find());
          _makanMalamStream = foodController.foodStore
              .box<Food>()
              .query(Food_.date.equals(foodController.selectedDay.toString()) &
                  Food_.session.equals('Makan Malam'))
              .watch(triggerImmediately: true)
              .map((query) => query.find());
          _snackStream = foodController.foodStore
              .box<Food>()
              .query(Food_.date.equals(foodController.selectedDay.toString()) &
                  Food_.session.equals('Snack'))
              .watch(triggerImmediately: true)
              .map((query) => query.find());

          hasBeenInitialized = true;
        }));
  }

  @override
  void dispose() {
    //print('-------------------------store Closed------------------------');
    foodController.foodStore.close();
    // controller.close();

    // foodController.hasBeenInitialized(false);
    hasBeenInitialized = false;
    super.dispose();
  }

  Future<void> getNecessity() async {
    await foodController.getNecessity();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: color.backgroundColor,
      body: SafeArea(
        child: Obx(() => foodController.isLoadingNecessity == true
            ? Center(
                child: CircularProgressIndicator(
                  color: color.secondaryColor,
                ),
              )
            : !hasBeenInitialized
                ? Container()
                : StreamBuilder5<List<Food>, List<Food>, List<Food>, List<Food>,
                        List<Food>>(
                    streams: Tuple5(_necessityStream, _sarapanStream,
                        _makanSiangStream, _makanMalamStream, _snackStream),
                    // stream: _necessityStream,
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
                          return nutritionChildWidget(
                              context,
                              size,
                              snapshot.item1,
                              snapshot.item2,
                              snapshot.item3,
                              snapshot.item4,
                              snapshot.item5);
                        case ConnectionState.done:
                          return nutritionChildWidget(
                              context,
                              size,
                              snapshot.item1,
                              snapshot.item2,
                              snapshot.item3,
                              snapshot.item4,
                              snapshot.item5);
                      }
                    })),
      ),
    );
  }

  Widget nutritionChildWidget(
    BuildContext context,
    Size size,
    AsyncSnapshot<List<Food>> snapshotNecessity,
    AsyncSnapshot<List<Food>> snapshotSarapan,
    AsyncSnapshot<List<Food>> snapshotMakanSiang,
    AsyncSnapshot<List<Food>> snapshotMakanMalam,
    AsyncSnapshot<List<Food>> snapshotSnack,
  ) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            //segment 1
            Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: NeumorphicButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            style: NeumorphicStyle(
                              shape: NeumorphicShape.flat,
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
                        Text(
                          'SirkaDiet',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: color.primaryTextColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 20),
                          child: NeumorphicButton(
                            onPressed: () {},
                            style: NeumorphicStyle(
                              shape: NeumorphicShape.flat,
                              boxShape: NeumorphicBoxShape.circle(),
                              color: color.primaryColor,
                            ),
                            padding: const EdgeInsets.all(16.0),
                            child: FaIcon(
                              FontAwesomeIcons.history,
                              size: 16,
                              color: color.secondaryTextColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NeumorphicButton(
                            margin: EdgeInsets.only(top: 12),
                            onPressed: () {
                              setState(() {
                                isFood = true;
                              });
                            },
                            style: NeumorphicStyle(
                                depth: isFood ? -4 : 4,
                                color: color.primaryColor,
                                shape: NeumorphicShape.flat,
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.only(
                                        bottomLeft: Radius.circular(20),
                                        topLeft: Radius.circular(20)))),
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: size.width * 0.1),
                            child: Text(
                              'Makan',
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    color: isFood
                                        ? color.secondaryColor
                                        : color.secondaryTextColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                            )),
                        NeumorphicButton(
                            margin: EdgeInsets.only(top: 12),
                            onPressed: () {
                              setState(() {
                                isFood = false;
                              });
                            },
                            style: NeumorphicStyle(
                                depth: isFood ? 4 : -4,
                                color: color.primaryColor,
                                shape: NeumorphicShape.flat,
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.only(
                                        bottomRight: Radius.circular(20),
                                        topRight: Radius.circular(20)))),
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: size.width * 0.1),
                            child: Text(
                              'Minum',
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                    color: isFood
                                        ? color.secondaryTextColor
                                        : color.secondaryColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal),
                              ),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                  ]),
            ),
            //segment 2
            AnimatedCrossFade(
                duration: const Duration(milliseconds: 200),
                crossFadeState: isFood
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                firstChild: FoodGeneralScreen(
                  hasBeenInitialized: hasBeenInitialized,
                  listMealNecessity: snapshotNecessity.data!,
                  listMealSarapan: snapshotSarapan.data!,
                  listMealMakanSiang: snapshotMakanSiang.data!,
                  listMealMakanMalam: snapshotMakanMalam.data!,
                  listMealSnack: snapshotSnack.data!,
                ),
                secondChild: FluidGeneralScreen())
          ],
        ),
      ),
    );
  }
}
