import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/controller/auth_controller.dart';
import 'package:sirkadian_app/controller/food_controller.dart';

import '../../../../constant/color.dart';
import '../../../../model/food_model/objectbox_model/food_model.dart';
import '../../../../objectbox.g.dart';
import '../../../../widget/food_widget/food_tile.dart';
import 'food_recommendation_screen.dart';

class FoodMealScreen extends StatefulWidget {
  const FoodMealScreen({Key? key, required this.session}) : super(key: key);

  final String session;

  @override
  State<FoodMealScreen> createState() => _FoodMealScreenState();
}

class _FoodMealScreenState extends State<FoodMealScreen> {
  final authController = Get.find<AuthController>();
  final foodController = Get.find<FoodController>();
  final color = Get.find<ColorConstantController>();
  late Stream<List<Food>> _foodStream;

  @override
  void initState() {
    super.initState();
    foodController.isOnFood(true);

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
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: color.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: NeumorphicButton(
                          onPressed: () {
                            Navigator.pop(context);

                            foodController.isOnFood(false);
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
                        widget.session,
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
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        FoodRecommendationScreen(
                                            session: widget.session)));
                          },
                          style: NeumorphicStyle(
                            shape: NeumorphicShape.flat,
                            boxShape: NeumorphicBoxShape.circle(),
                            color: color.primaryColor,
                          ),
                          padding: const EdgeInsets.all(16.0),
                          child: FaIcon(
                            FontAwesomeIcons.plus,
                            size: 16,
                            color: color.secondaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Container(
                      height: size.height * 0.75,
                      child: StreamBuilder<List<Food>>(
                          initialData: [],
                          stream: _foodStream,
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: color.secondaryColor,
                                ),
                              );
                            }
                            return (snapshot.data!.isEmpty)
                                ? Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Belum ada makanan yang kamu pilih',
                                      style: GoogleFonts.inter(
                                        textStyle: TextStyle(
                                            color: color.secondaryTextColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  )
                                : Container(
                                    child: ListView.builder(
                                        keyboardDismissBehavior:
                                            ScrollViewKeyboardDismissBehavior
                                                .onDrag,
                                        itemCount: snapshot.data!.length,
                                        itemBuilder: (context, index) {
                                          return FoodTile(
                                            containerButton: () {
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (context) =>
                                              //             FoodDetailScreen(
                                              //               foodController:
                                              //                   foodController,
                                              //               color: color,
                                              //               food:
                                              //                   DataFoodAllResponse(
                                              //                 name: snapshot
                                              //                     .data![index]
                                              //                     .name,
                                              //                 calcium: snapshot
                                              //                     .data![index]
                                              //                     .calcium,
                                              //                 carbohydrate: snapshot
                                              //                     .data![index]
                                              //                     .carbohydrate,
                                              //                 copper: snapshot
                                              //                     .data![index]
                                              //                     .copper,
                                              //                 difficulty: snapshot
                                              //                     .data![index]
                                              //                     .difficulty,
                                              //                 duration: snapshot
                                              //                     .data![index]
                                              //                     .duration,
                                              //                 energy: snapshot
                                              //                     .data![index]
                                              //                     .energy,
                                              //                 fat: snapshot
                                              //                     .data![index]
                                              //                     .fat,
                                              //                 fiber: snapshot
                                              //                     .data![index]
                                              //                     .fiber,
                                              //                 foodId: snapshot
                                              //                     .data![index]
                                              //                     .foodId,
                                              //               ),
                                              //             )));
                                            },
                                            iconButton: () {
                                              foodController.foodStore
                                                  .box<Food>()
                                                  .remove(
                                                      snapshot.data![index].id);
                                            },
                                            icon: FontAwesomeIcons.trash,
                                            size: size,
                                            color: color,
                                            imageFileName: snapshot
                                                .data![index].imageFileName!,
                                            name: snapshot.data![index].name!,
                                            necessity:
                                                (snapshot.data![index].energy! /
                                                        snapshot.data![index]
                                                            .serving!)
                                                    .toStringAsFixed(0),
                                            serving: (snapshot
                                                        .data![index].serving! /
                                                    snapshot
                                                        .data![index].serving!)
                                                .toStringAsFixed(0),
                                          );
                                        }),
                                  );
                          })),
                ]),
          ),
        ),
      ),
    );
  }
}
