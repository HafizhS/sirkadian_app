import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/controller/auth_controller.dart';
import 'package:sirkadian_app/controller/food_controller.dart';
import 'package:sirkadian_app/controller/information_controller.dart';
import 'package:sirkadian_app/model/food_model/food_history_request_model.dart';

import '../../../../controller/hexcolor_controller.dart';
import '../../../../controller/user_controller.dart';
import '../../../../model/obejctbox_model.dart/food_fluid_exercise_model.dart';
import '../../../../objectbox.g.dart';
import '../../../../widget/food_widget/food_tile.dart';
import 'food_detail_screen.dart';
import 'food_recommendation_screen.dart';

class FoodMealScreen extends StatefulWidget {
  const FoodMealScreen(
      {Key? key, required this.session, required this.isFromFutureMealplan})
      : super(key: key);

  final String session;
  final bool isFromFutureMealplan;

  @override
  State<FoodMealScreen> createState() => _FoodMealScreenState();
}

class _FoodMealScreenState extends State<FoodMealScreen> {
  final authController = Get.find<AuthController>();
  final foodController = Get.find<FoodController>();
  final informationController = Get.find<InformationController>();
  final userController = Get.find<UserController>();
  final color = Get.find<ColorConstantController>();
  late Stream<List<Food>> _foodStream;
  final data = GetStorage('myData');
  List<Foods> listFoodSarapan = [];
  List<Foods> listFoodMakanSiang = [];
  List<Foods> listFoodMakanMalam = [];
  bool isGanti = true;

  @override
  void initState() {
    super.initState();
    foodController.isOnFood(true);

    if (data.read('dataSessionSarapan') == null ||
        data.read('dataSessionSarapan')['date'] !=
            foodController.focusedDay.toString()) {
      setState(() {
        data.write('dataSessionSarapan', {
          'sessionSarapan': false,
          'date': foodController.focusedDay.toString(),
        });
        // foodController.foodStore.box<Food>().removeAll();
      });
    } else {
      print('sama dan ada data');
    }
    if (data.read('dataSessionMakanSiang') == null ||
        data.read('dataSessionMakanSiang')['date'] !=
            foodController.focusedDay.toString()) {
      setState(() {
        data.write('dataSessionMakanSiang', {
          'sessionMakanSiang': false,
          'date': foodController.focusedDay.toString(),
        });
        // foodController.foodStore.box<Food>().removeAll();
      });
    }
    if (data.read('dataSessionMakanMalam') == null ||
        data.read('dataSessionMakanMalam')['date'] !=
            foodController.focusedDay.toString()) {
      setState(() {
        data.write('dataSessionMakanMalam', {
          'sessionMakanMalam': false,
          'date': foodController.focusedDay.toString(),
        });
        // foodController.foodStore.box<Food>().removeAll();
      });
    }

    setState(() {
      _foodStream = foodController.foodStore
          .box<Food>()
          .query(Food_.date.equals(foodController.selectedDay.toString()) &
              Food_.session.equals(widget.session))
          .watch(triggerImmediately: true)
          .map((query) => query.find());
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Food>>(
        initialData: [],
        stream: _foodStream,
        builder: (context, snapshot) {
          //
          foodController.foodEaten = '';
          foodController.listFoodId = [];
          foodController.listFoodName = [];
          snapshot.data!.forEach((e) {
            foodController.listFoodId.add(e.id);
            foodController.listFoodName.add(e.name);
            foodController.foodEaten =
                foodController.foodEaten + '&food_eaten=' + e.foodId!;
          });

          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: color.secondaryColor,
              ),
            );
          }
          return Scaffold(
            backgroundColor: color.bgColor,
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: Stack(alignment: Alignment.bottomRight, children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20.w),
                              child: NeumorphicButton(
                                onPressed: () {
                                  Navigator.pop(context);

                                  foodController.isOnFood(false);
                                },
                                style: NeumorphicStyle(
                                    shape: NeumorphicShape.flat,
                                    boxShape: NeumorphicBoxShape.circle(),
                                    color: color.bgColor),
                                padding: EdgeInsets.all(16.sp),
                                child: FaIcon(
                                  FontAwesomeIcons.chevronLeft,
                                  size: 16.sp,
                                  color: color.secondaryTextColor,
                                ),
                              ),
                            ),
                            Text(
                              widget.session,
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: color.primaryTextColor,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(right: 20.w),
                              child: NeumorphicButton(
                                onPressed: () {
                                  getNavigationRecomFunction();
                                },
                                style: NeumorphicStyle(
                                    depth: getDepth(),
                                    shape: NeumorphicShape.flat,
                                    boxShape: NeumorphicBoxShape.circle(),
                                    color: color.bgColor),
                                padding: EdgeInsets.all(16.sp),
                                child: FaIcon(
                                  getIconPlus(),
                                  size: 16.sp,
                                  color: color.secondaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 28.h,
                        ),
                        Expanded(
                            // height: 600.h,
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(right: 30.w),
                              child: Text(
                                snapshot.data!.length.toString() + ' item',
                                style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      color: color.secondaryTextColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ),
                            (snapshot.data!.isEmpty)
                                ? Column(
                                    children: [
                                      SizedBox(height: 220.h),
                                      Center(
                                        child: Text(
                                          'Belum ada makanan yang kamu pilih',
                                          style: GoogleFonts.inter(
                                            textStyle: TextStyle(
                                                color: color.secondaryTextColor,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.normal),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Expanded(
                                    child: ListView.builder(
                                        keyboardDismissBehavior:
                                            ScrollViewKeyboardDismissBehavior
                                                .onDrag,
                                        itemCount: snapshot.data!.length,
                                        itemBuilder: (context, index) {
                                          return Slidable(
                                              closeOnScroll: true,
                                              key: UniqueKey(),
                                              endActionPane: ActionPane(
                                                motion: DrawerMotion(),
                                                children: [
                                                  SlidableAction(
                                                    flex: 1,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            bottomLeft: Radius
                                                                .circular(30),
                                                            topLeft:
                                                                Radius.circular(
                                                                    30)),
                                                    onPressed:
                                                        (BuildContext context) {
                                                      setState(() {
                                                        isGanti = true;
                                                      });
                                                      getSlidableSession(
                                                          snapshot.data!,
                                                          index);
                                                    },
                                                    backgroundColor:
                                                        color.secondaryColor,
                                                    foregroundColor:
                                                        color.primaryColor,
                                                    icon: FontAwesomeIcons
                                                        .solidEdit,
                                                    label: 'Ganti',
                                                  ),
                                                  SlidableAction(
                                                    flex: 1,
                                                    onPressed:
                                                        (BuildContext context) {
                                                      setState(() {
                                                        isGanti = false;
                                                      });
                                                      getSlidableSession(
                                                          snapshot.data!,
                                                          index);
                                                    },
                                                    backgroundColor:
                                                        color.tersierColor,
                                                    foregroundColor:
                                                        color.primaryColor,
                                                    icon: FontAwesomeIcons.plus,
                                                    label: 'Tambah',
                                                  ),
                                                ],
                                              ),
                                              child: FoodTile(
                                                containerButton: () {
                                                  foodController
                                                      .getOtherFoodRecommendation(
                                                          snapshot.data![index]
                                                              .foodId,
                                                          widget.session);
                                                  foodController.getFoodItem(
                                                      snapshot
                                                          .data![index].foodId);
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              FoodDetailScreen(
                                                                isFromFoodMeal:
                                                                    true,
                                                                session: widget
                                                                    .session,
                                                                foodController:
                                                                    foodController,
                                                                color: color,
                                                                recommendationScore:
                                                                    snapshot
                                                                        .data![
                                                                            index]
                                                                        .recommendationScore!,
                                                                foodId: snapshot
                                                                    .data![
                                                                        index]
                                                                    .foodId!,
                                                              )));
                                                },
                                                iconButton: () {
                                                  getDeleteFunction(
                                                      snapshot.data!, index);
                                                },
                                                icon: getIconDelete(),
                                                depth: getDepth(),
                                                color: color,
                                                imageFilename: snapshot
                                                    .data![index]
                                                    .imageFileName!,
                                                name:
                                                    snapshot.data![index].name!,
                                                necessity: (snapshot
                                                            .data![index]
                                                            .energy! /
                                                        snapshot.data![index]
                                                            .serving!)
                                                    .toStringAsFixed(0),
                                                serving: (snapshot.data![index]
                                                            .serving! /
                                                        snapshot.data![index]
                                                            .serving!)
                                                    .toStringAsFixed(0),
                                                recommendationScore: snapshot
                                                    .data![index]
                                                    .recommendationScore!,
                                                duration: snapshot
                                                    .data![index].duration!
                                                    .toStringAsFixed(0),
                                              ));
                                        }),
                                  ),
                          ],
                        ))
                      ]),
                  snapshot.data!.isNotEmpty &&
                          widget.isFromFutureMealplan == false
                      ? Container(
                          margin: EdgeInsets.only(right: 20.w, bottom: 20.h),
                          child: NeumorphicButton(
                              margin: EdgeInsets.only(top: 12.h),
                              onPressed: () {
                                getSaveSessionFunction(snapshot.data!);
                              },
                              style: NeumorphicStyle(
                                  color: getColor(),
                                  shape: NeumorphicShape.flat,
                                  boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(20),
                                  )
                                  //border: NeumorphicBorder()
                                  ),
                              padding: EdgeInsets.symmetric(
                                  vertical: 12.h, horizontal: 15.w),
                              child: Text(
                                getText(),
                                style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      color: color.primaryColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal),
                                ),
                              )),
                        )
                      : Container(),
                ]),
              ),
            ),
          );
        });
  }

  void getSlidableSession(List<Food> foods, index) {
    if (widget.session == 'Sarapan') {
      if (data.read('dataSessionSarapan')['sessionSarapan'] == true) {
        informationController.snackBarError(
            'Sesi Sudah Ditutup', 'Batalkan sesi untuk mengubah mealplan');
      } else {
        foodController
            .getFoodRecommendationByFood(widget.session, foods[index].foodId!)
            .then((_) {
          recommendationByFoodBottomSheet(foods, index, isGanti);
        });
      }
    } else if (widget.session == 'Makan Siang') {
      if (data.read('dataSessionMakanSiang')['sessionMakanSiang'] == true) {
        informationController.snackBarError(
            'Sesi Sudah Ditutup', 'Batalkan sesi untuk mengubah mealplan');
      } else {
        foodController
            .getFoodRecommendationByFood(widget.session, foods[index].foodId!)
            .then((_) {
          recommendationByFoodBottomSheet(foods, index, isGanti);
        });
      }
    } else {
      if (data.read('dataSessionMakanMalam')['sessionMakanMalam'] == true) {
        informationController.snackBarError(
            'Sesi Sudah Ditutup', 'Batalkan sesi untuk mengubah mealplan');
      } else {
        foodController
            .getFoodRecommendationByFood(widget.session, foods[index].foodId!)
            .then((_) {
          recommendationByFoodBottomSheet(foods, index, isGanti);
        });
      }
    }
  }

  double getDepth() {
    return widget.session == "Sarapan"
        ? data.read('dataSessionSarapan')['sessionSarapan'] == true
            ? 0
            : 4
        : widget.session == "Makan Siang"
            ? data.read('dataSessionMakanSiang')['sessionMakanSiang'] == true
                ? 0
                : 4
            : data.read('dataSessionMakanMalam')['sessionMakanMalam'] == true
                ? 0
                : 4;
  }

  Color getColor() {
    return widget.session == "Sarapan"
        ? data.read('dataSessionSarapan')['sessionSarapan'] == true
            ? color.redColor
            : color.secondaryColor
        : widget.session == "Makan Siang"
            ? data.read('dataSessionMakanSiang')['sessionMakanSiang'] == true
                ? color.redColor
                : color.secondaryColor
            : data.read('dataSessionMakanMalam')['sessionMakanMalam'] == true
                ? color.redColor
                : color.secondaryColor;
  }

  String getText() {
    return widget.session == "Sarapan"
        ? data.read('dataSessionSarapan')['sessionSarapan'] == true
            ? 'Batalkan Sesi'
            : "Selesaikan Sesi"
        : widget.session == "Makan Siang"
            ? data.read('dataSessionMakanSiang')['sessionMakanSiang'] == true
                ? 'Batalkan Sesi'
                : "Selesaikan Sesi"
            : data.read('dataSessionMakanMalam')['sessionMakanMalam'] == true
                ? 'Batalkan Sesi'
                : "Selesaikan Sesi";
  }

  IconData getIconPlus() {
    return widget.session == "Sarapan"
        ? data.read('dataSessionSarapan')['sessionSarapan'] == true
            ? FontAwesomeIcons.check
            : FontAwesomeIcons.plus
        : widget.session == "Makan Siang"
            ? data.read('dataSessionMakanSiang')['sessionMakanSiang'] == true
                ? FontAwesomeIcons.check
                : FontAwesomeIcons.plus
            : data.read('dataSessionMakanMalam')['sessionMakanMalam'] == true
                ? FontAwesomeIcons.check
                : FontAwesomeIcons.plus;
  }

  IconData getIconDelete() {
    return widget.session == "Sarapan"
        ? data.read('dataSessionSarapan')['sessionSarapan'] == true
            ? FontAwesomeIcons.checkCircle
            : FontAwesomeIcons.trash
        : widget.session == "Makan Siang"
            ? data.read('dataSessionMakanSiang')['sessionMakanSiang'] == true
                ? FontAwesomeIcons.checkCircle
                : FontAwesomeIcons.trash
            : data.read('dataSessionMakanMalam')['sessionMakanMalam'] == true
                ? FontAwesomeIcons.checkCircle
                : FontAwesomeIcons.trash;
  }

  void getSaveSessionFunction(List<Food> food) {
    if (widget.session == "Sarapan") {
      if (data.read('dataSessionSarapan')['sessionSarapan'] == true) {
        if (Get.isSnackbarOpen) Get.back();
        final foodHistoryRequest = FoodHistoryRequest(
            foodDate: foodController.date,
            foodTime: foodController.getSessions(widget.session),
            foods: []);
        foodController
            .postFoodHistory(
                foodHistoryRequest: foodHistoryRequest, session: widget.session)
            .then((_) {
          setState(() {
            foodController.sessionSarapanClosed.value = false;
            foodController.saveSession(
                session: widget.session,
                date: foodController.focusedDay.toString());
          });
        });
      } else {
        if (Get.isSnackbarOpen) Get.back();
        listFoodSarapan.clear();
        food.forEach((element) {
          listFoodSarapan.add(Foods(foodId: element.foodId, portion: 1));
        });
        final foodHistoryRequest = FoodHistoryRequest(
            foodDate: foodController.date,
            foodTime: foodController.getSessions(widget.session),
            foods: listFoodSarapan);
        foodController
            .postFoodHistory(
                foodHistoryRequest: foodHistoryRequest, session: widget.session)
            .then((_) {
          setState(() {
            foodController.sessionSarapanClosed.value = true;
            foodController.saveSession(
                session: widget.session,
                date: foodController.focusedDay.toString());
          });
        });
      }
    } else if (widget.session == 'Makan Siang') {
      if (data.read('dataSessionMakanSiang')['sessionMakanSiang'] == true) {
        if (Get.isSnackbarOpen) Get.back();
        final foodHistoryRequest = FoodHistoryRequest(
            foodDate: foodController.date,
            foodTime: foodController.getSessions(widget.session),
            foods: []);
        foodController
            .postFoodHistory(foodHistoryRequest: foodHistoryRequest)
            .then((_) {
          setState(() {
            foodController.sessionMakanSiangClosed.value = false;
            foodController.saveSession(
                session: widget.session,
                date: foodController.focusedDay.toString());
          });
        });
      } else {
        if (Get.isSnackbarOpen) Get.back();
        listFoodSarapan.clear();
        food.forEach((element) {
          listFoodMakanSiang.add(Foods(foodId: element.foodId, portion: 1));
        });
        final foodHistoryRequest = FoodHistoryRequest(
            foodDate: foodController.date,
            foodTime: foodController.getSessions(widget.session),
            foods: listFoodMakanSiang);
        foodController
            .postFoodHistory(foodHistoryRequest: foodHistoryRequest)
            .then((_) {
          setState(() {
            foodController.sessionMakanSiangClosed.value = true;
            foodController.saveSession(
                session: widget.session,
                date: foodController.focusedDay.toString());
          });
        });
      }
    } else {
      if (data.read('dataSessionMakanMalam')['sessionMakanMalam'] == true) {
        if (Get.isSnackbarOpen) Get.back();
        final foodHistoryRequest = FoodHistoryRequest(
            foodDate: foodController.date,
            foodTime: foodController.getSessions(widget.session),
            foods: listFoodMakanMalam);
        foodController
            .postFoodHistory(foodHistoryRequest: foodHistoryRequest)
            .then((_) {
          setState(() {
            foodController.sessionMakanMalamClosed.value = false;
            foodController.saveSession(
                session: widget.session,
                date: foodController.focusedDay.toString());
          });
        });
      } else {
        if (Get.isSnackbarOpen) Get.back();
        listFoodSarapan.clear();
        food.forEach((element) {
          listFoodMakanMalam.add(Foods(foodId: element.foodId, portion: 1));
        });
        final foodHistoryRequest = FoodHistoryRequest(
            foodDate: foodController.date,
            foodTime: foodController.getSessions(widget.session),
            foods: listFoodMakanMalam);
        foodController
            .postFoodHistory(foodHistoryRequest: foodHistoryRequest)
            .then((_) {
          setState(() {
            foodController.sessionMakanMalamClosed.value = true;
            foodController.saveSession(
                session: widget.session,
                date: foodController.focusedDay.toString());
          });
        });
      }
    }
  }

  void getDeleteFunction(List<Food> foods, index) {
    if (widget.session == "Sarapan") {
      if (data.read('dataSessionSarapan')['sessionSarapan'] == true) {
      } else {
        foodController.foodStore.box<Food>().remove(foods[index].id);
      }
    } else if (widget.session == 'Makan Siang') {
      if (data.read('dataSessionMakanSiang')['sessionMakanSiang'] == true) {
      } else {
        foodController.foodStore.box<Food>().remove(foods[index].id);
      }
    } else {
      if (data.read('dataSessionMakanMalam')['sessionMakanMalam'] == true) {
      } else {
        foodController.foodStore.box<Food>().remove(foods[index].id);
      }
    }
  }

  void getNavigationRecomFunction() {
    if (widget.session == "Sarapan") {
      if (data.read('dataSessionSarapan')['sessionSarapan'] == true) {
        informationController.snackBarError(
            'Sesi Sudah Ditutup', 'Batalkan sesi untuk mengubah mealplan');
      } else {
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        FoodRecommendationScreen(session: widget.session)))
            .then((_) {
          setState(() {
            foodController.isStopFoodMenu = false;
            foodController.isStopFood = false;
          });
        });
      }
    } else if (widget.session == 'Makan Siang') {
      if (data.read('dataSessionMakanSiang')['sessionMakanSiang'] == true) {
        informationController.snackBarError(
            'Sesi Sudah Ditutup', 'Batalkan sesi untuk mengubah mealplan');
      } else {
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        FoodRecommendationScreen(session: widget.session)))
            .then((_) {
          setState(() {
            foodController.isStopFoodMenu = false;
            foodController.isStopFood = false;
          });
        });
      }
    } else {
      if (data.read('dataSessionMakanMalam')['sessionMakanMalam'] == true) {
        informationController.snackBarError(
            'Sesi Sudah Ditutup', 'Batalkan sesi untuk mengubah mealplan');
      } else {
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        FoodRecommendationScreen(session: widget.session)))
            .then((_) {
          setState(() {
            foodController.isStopFoodMenu = false;
            foodController.isStopFood = false;
          });
        });
      }
    }
  }

  void recommendationByFoodBottomSheet(List<Food> foods, index, bool isGanti) {
    Get.bottomSheet(Container(
      height: 400.h,
      width: 360.w,
      decoration: BoxDecoration(
          color: color.primaryColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: ListView.builder(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: foodController.listFoodByFood.length,
          itemBuilder: (context, idx) {
            return FoodTile(
              depth: 4,
              containerButton: () {
                foodController.getOtherFoodRecommendation(
                    foodController.listFoodByFood[idx].foodId, widget.session);
                foodController
                    .getFoodItem(foodController.listFoodByFood[idx].foodId);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FoodDetailScreen(
                              session: widget.session,
                              isFromFoodMeal: true,
                              foodController: foodController,
                              color: color,
                              recommendationScore: foodController
                                  .listFoodByFood[idx].recommendationScore!
                                  .toStringAsFixed(2),
                              foodId:
                                  foodController.listFoodByFood[idx].foodId!,
                            )));
              },
              iconButton: () {
                final food = Food(
                  imageFileName:
                      foodController.listFoodByFood[idx].imageFilename,
                  session: widget.session,
                  date: foodController.selectedDay.toString(),
                  name: foodController.listFoodByFood[idx].foodName,
                  calcium: foodController.listFoodByFood[idx].calcium,
                  carbohydrate: foodController.listFoodByFood[idx].carbohydrate,
                  copper: foodController.listFoodByFood[idx].copper,
                  difficulty: foodController.listFoodByFood[idx].difficulty,
                  duration: foodController.listFoodByFood[idx].duration,
                  energy: foodController.listFoodByFood[idx].energy,
                  fat: foodController.listFoodByFood[idx].fat,
                  fiber: foodController.listFoodByFood[idx].fiber,
                  foodId: foodController.listFoodByFood[idx].foodId,
                  foodTypes: foodController.listFoodByFood[idx].foodTypes,
                  iron: foodController.listFoodByFood[idx].iron,
                  phosphor: foodController.listFoodByFood[idx].phosphor,
                  potassium: foodController.listFoodByFood[idx].potassium,
                  protein: foodController.listFoodByFood[idx].protein,
                  retinol: foodController.listFoodByFood[idx].retinol,
                  serving: foodController.listFoodByFood[idx].serving,
                  sodium: foodController.listFoodByFood[idx].sodium,
                  tags: foodController.listFoodByFood[idx].tags,
                  vitaminB1: foodController.listFoodByFood[idx].vitaminB1,
                  vitaminB2: foodController.listFoodByFood[idx].vitaminB2,
                  vitaminB3: foodController.listFoodByFood[idx].vitaminB3,
                  vitaminC: foodController.listFoodByFood[idx].vitaminC,
                  water: foodController.listFoodByFood[idx].water,
                  zinc: foodController.listFoodByFood[idx].zinc,
                  itemFood: '',
                  recommendationScore: foodController
                      .listFoodByFood[idx].recommendationScore!
                      .toStringAsFixed(2),
                );

                foodController.foodStore.box<Food>().put(food);
                if (isGanti) {
                  getDeleteFunction(foods, index);
                } else {}
                Navigator.pop(context);
              },
              icon: FontAwesomeIcons.plus,
              color: color,
              imageFilename:
                  foodController.listFoodByFood[idx].imageFilename! == ''
                      ? ''
                      : foodController.listFoodByFood[idx].imageFilename!,
              name: foodController.listFoodByFood[idx].foodName!,
              necessity: (foodController.listFoodByFood[idx].energy!)
                  .toStringAsFixed(0),
              serving: (foodController.listFoodByFood[idx].serving!)
                  .toStringAsFixed(0),
              recommendationScore: foodController
                  .listFoodByFood[idx].recommendationScore!
                  .toStringAsFixed(2),
              duration: foodController.listFoodByFood[idx].duration!
                  .toStringAsFixed(0),
            );
          }),
    ));
  }
}
