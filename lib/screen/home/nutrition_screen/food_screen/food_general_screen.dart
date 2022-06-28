import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/controller/user_controller.dart';
import 'package:sirkadian_app/screen/home/nutrition_screen/food_screen/food_history_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../controller/hexcolor_controller.dart';
import '../../../../controller/food_controller.dart';
import '../../../../model/obejctbox_model.dart/food_fluid_exercise_model.dart';
import '../../../../widget/food_widget/necessity_display.dart';
import 'food_mealplan_screen.dart';

class FoodGeneralScreen extends StatefulWidget {
  const FoodGeneralScreen({
    Key? key,
    required this.hasBeenInitialized,
    required this.listMealNecessity,
    required this.listMealSarapan,
    required this.listMealMakanSiang,
    required this.listMealMakanMalam,
    // required this.listMealSnack,
  }) : super(key: key);

  final bool hasBeenInitialized;
  final List<Food> listMealNecessity;
  final List<Food> listMealSarapan;
  final List<Food> listMealMakanSiang;
  final List<Food> listMealMakanMalam;
  // final List<Food> listMealSnack;

  @override
  State<FoodGeneralScreen> createState() => _FoodGeneralScreenState();
}

class _FoodGeneralScreenState extends State<FoodGeneralScreen> {
  final foodController = Get.find<FoodController>();
  final userController = Get.find<UserController>();

  final color = Get.find<ColorConstantController>();
  var maxSarapan = 0;
  var maxIndexSarapan = null;
  var maxMakanSiang = 0;
  var maxIndexMakanSiang = null;
  var maxMakanMalam = 0;
  var maxIndexMakanMalam = null;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          //segment mealplan
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20.w),
                    child: Row(
                      children: [
                        Text(
                          'Makan Apa Hari ini?',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: color.secondaryTextColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          foodController.dateNoww,
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                color: color.secondaryTextColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                  ),
                  NeumorphicButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FoodHistoryScreen()));
                    },
                    padding: EdgeInsets.all(5.sp),
                    style: NeumorphicStyle(
                      depth: 2,
                      color: color.bgColor,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(5)),
                    ),
                    margin: EdgeInsets.only(right: 20.w),
                    child: FaIcon(
                      FontAwesomeIcons.history,
                      size: 20.sp,
                      color: color.secondaryTextColor,
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.h),
                height: 150.h,
                width: 360.w,
                child: Swiper(
                  itemCount: foodController.sessions.length,
                  itemWidth: 300.w,
                  index: 0,
                  layout: SwiperLayout.DEFAULT,
                  viewportFraction: 0.5,
                  scale: 0.9,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      widget.listMealSarapan.asMap().forEach((index, element) {
                        if (element.energy! > maxSarapan) {
                          maxIndexSarapan = index;
                          maxSarapan = element.energy!.toInt();
                        }
                      });
                    } else if (index == 1) {
                      widget.listMealMakanSiang
                          .asMap()
                          .forEach((index, element) {
                        if (element.energy! > maxMakanSiang) {
                          maxIndexMakanSiang = index;
                          maxMakanSiang = element.energy!.toInt();
                        }
                      });
                    } else {
                      widget.listMealMakanMalam
                          .asMap()
                          .forEach((index, element) {
                        if (element.energy! > maxMakanMalam) {
                          maxIndexMakanMalam = index;
                          maxMakanMalam = element.energy!.toInt();
                        }
                      });
                    }

                    switch (index) {
                      case 0:
                        return Container(
                          margin: EdgeInsets.all(10.sp),
                          child: NeumorphicButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        settings: RouteSettings(
                                            name: "/foodMealScreen"),
                                        builder: (context) => FoodMealScreen(
                                              session: foodController
                                                  .sessions[index],
                                              isFromFutureMealplan: false,
                                            )));
                              },
                              style: NeumorphicStyle(
                                  color: color.bgColor,
                                  shape: NeumorphicShape.flat,
                                  boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(20),
                                  )),
                              child: widget.listMealSarapan.isNotEmpty
                                  ? notEmptyChild(
                                      widget.listMealSarapan[maxIndexSarapan]
                                          .imageFileName!,
                                      index,
                                    )
                                  : emptySessionChild(index)),
                        );

                      case 1:
                        return Container(
                          margin: EdgeInsets.all(10),
                          child: NeumorphicButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        settings: RouteSettings(
                                            name: "/foodMealScreen"),
                                        builder: (context) => FoodMealScreen(
                                              session: foodController
                                                  .sessions[index],
                                              isFromFutureMealplan: false,
                                            )));
                              },
                              style: NeumorphicStyle(
                                  color: color.bgColor,
                                  shape: NeumorphicShape.flat,
                                  boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(20),
                                  )),
                              child: widget.listMealMakanSiang.isNotEmpty
                                  ? notEmptyChild(
                                      widget
                                          .listMealMakanSiang[
                                              maxIndexMakanSiang]
                                          .imageFileName!,
                                      index,
                                    )
                                  : emptySessionChild(index)),
                        );
                      case 2:
                        return Container(
                          margin: EdgeInsets.all(10.sp),
                          child: NeumorphicButton(
                              padding: EdgeInsets.all(0),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        settings: RouteSettings(
                                            name: "/foodMealScreen"),
                                        builder: (context) => FoodMealScreen(
                                              session: foodController
                                                  .sessions[index],
                                              isFromFutureMealplan: false,
                                            )));
                              },
                              style: NeumorphicStyle(
                                  color: color.bgColor,
                                  shape: NeumorphicShape.flat,
                                  boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(20),
                                  )),
                              child: widget.listMealMakanMalam.isNotEmpty
                                  ? notEmptyChild(
                                      widget
                                          .listMealMakanMalam[
                                              maxIndexMakanMalam]
                                          .imageFileName!,
                                      index,
                                    )
                                  : emptySessionChild(index)),
                        );
                      // case 3:
                      //   return Container(
                      //     margin: EdgeInsets.all(10.sp),
                      //     child: NeumorphicButton(
                      //         padding: EdgeInsets.all(0),
                      //         onPressed: () {
                      //           Navigator.push(
                      //               context,
                      //               MaterialPageRoute(
                      //                   settings: RouteSettings(
                      //                       name: "/foodMealScreen"),
                      //                   builder: (context) => FoodMealScreen(
                      //                       session: foodController
                      //                           .sessions[index])));
                      //         },
                      //         style: NeumorphicStyle(
                      //             color: color.bgColor,
                      //             shape: NeumorphicShape.flat,
                      //             boxShape: NeumorphicBoxShape.roundRect(
                      //               BorderRadius.circular(20),
                      //             )),
                      //         child: widget.listMealSnack.isNotEmpty
                      //             ? notEmptyChild(
                      //                 widget.listMealSnack[0].imageFileName!,
                      //                 index,
                      //               )
                      //             : emptySessionChild(index)),
                      //   );
                      default:
                        return Container(
                            margin: EdgeInsets.all(10.sp),
                            child: NeumorphicButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          settings: RouteSettings(
                                              name: "/foodMealScreen"),
                                          builder: (context) => FoodMealScreen(
                                                session: foodController
                                                    .sessions[index],
                                                isFromFutureMealplan: false,
                                              )));
                                },
                                style: NeumorphicStyle(
                                    color: color.bgColor,
                                    shape: NeumorphicShape.flat,
                                    boxShape: NeumorphicBoxShape.roundRect(
                                      BorderRadius.circular(20),
                                    )),
                                child: emptySessionChild(index)));
                    }
                  },
                ),
              ),
            ],
          ),
          //segment nutrisi
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20.w),
                    child: Text(
                      'Nutrisi Hari ini',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: color.secondaryTextColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  NeumorphicButton(
                    onPressed: () {
                      Get.bottomSheet(Container(
                        decoration: BoxDecoration(
                            color: color.primaryColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20))),
                        height: 400.h,
                        width: 360.w,
                        padding: EdgeInsets.all(10),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              bottomSheetNecesityChild(
                                  'Kalsium',
                                  foodController.calcium /
                                      foodController
                                          .necessity.value.micro!.calcium!),
                              bottomSheetNecesityChild(
                                  'Zat Besi',
                                  foodController.iron /
                                      foodController
                                          .necessity.value.micro!.iron!),
                              bottomSheetNecesityChild(
                                  'zinc',
                                  foodController.zinc /
                                      foodController
                                          .necessity.value.micro!.zinc!),
                              bottomSheetNecesityChild(
                                  'Copper',
                                  foodController.copper /
                                      foodController
                                          .necessity.value.micro!.copper!),
                              bottomSheetNecesityChild(
                                  'Vitamin C',
                                  foodController.vitaminC /
                                      foodController
                                          .necessity.value.micro!.vitaminC!),
                              bottomSheetNecesityChild(
                                  'Vitamin B1',
                                  foodController.vitaminB1 /
                                      foodController
                                          .necessity.value.micro!.vitaminB1!),
                              bottomSheetNecesityChild(
                                  'Vitamin B2',
                                  foodController.vitaminB2 /
                                      foodController
                                          .necessity.value.micro!.vitaminB2!),
                              bottomSheetNecesityChild(
                                  'Vitamin B3',
                                  foodController.vitaminB3 /
                                      foodController
                                          .necessity.value.micro!.vitaminB3!),
                              bottomSheetNecesityChild(
                                  'Retinol',
                                  foodController.retinol /
                                      foodController
                                          .necessity.value.micro!.retinol!),
                            ],
                          ),
                        ),
                      ));
                    },
                    padding: EdgeInsets.all(5.sp),
                    style: NeumorphicStyle(
                      depth: 2,
                      color: color.bgColor,
                      boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(5)),
                    ),
                    margin: EdgeInsets.only(right: 20.w),
                    child: FaIcon(
                      FontAwesomeIcons.ellipsisH,
                      size: 20.sp,
                      color: color.secondaryTextColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          !widget.hasBeenInitialized
              ? Container()
              : NecessityDisplayWidget(
                  listMeal: widget.listMealNecessity,
                  listMealSarapan: widget.listMealSarapan,
                  listMealMakanSiang: widget.listMealMakanSiang,
                  listMealMakanMalam: widget.listMealMakanMalam,
                  color: color,
                  foodController: foodController,
                ),
        ],
      ),
    );
  }

  Widget notEmptyChild(String imageFilename, int index) {
    return Container(
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          height: 70.h,
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomLeft: Radius.zero,
                bottomRight: Radius.zero),
          ),
          child: imageFilename == ''
              ? Icon(Icons.image_not_supported_rounded)
              : Image.network(
                  imageFilename,
                  width: 360.w,
                  alignment: Alignment.topRight,
                  fit: BoxFit.cover,
                ),
        ),
        Text(
          foodController.sessions[index],
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                color: color.primaryTextColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.normal),
          ),
        ),
        SizedBox(height: 18.h),
      ]),
    );
  }

  Widget emptySessionChild(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Neumorphic(
            style: NeumorphicStyle(
              color: color.bgColor,
              shape: NeumorphicShape.flat,
              depth: 4,
              boxShape: NeumorphicBoxShape.circle(),
            ),
            padding: EdgeInsets.all(12.0.sp),
            child: FaIcon(
              FontAwesomeIcons.plus,
              size: 16,
              color: color.secondaryColor,
            )),
        SizedBox(height: 18.h),
        Text(
          foodController.sessions[index],
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
                color: color.primaryTextColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.normal),
          ),
        ),
      ],
    );
  }

  Widget bottomSheetNecesityChild(String title, double value) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20.w, top: 10.h, bottom: 10.h),
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        color: color.secondaryTextColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 20.w, top: 10.h, bottom: 10.h),
                child: Text(
                  '${((value) * 100).round().toString()}%',
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        color: color.secondaryTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ],
          ),
          Neumorphic(
              style: NeumorphicStyle(
                  depth: -4,
                  color: color.backgroundColor,
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.circular(20),
                  )),
              child: Stack(alignment: Alignment.centerLeft, children: [
                Container(
                  height: 18.h,
                  width: 360.w,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: color.secondaryColor,
                      borderRadius: BorderRadius.circular(20)),
                  height: 18.h,
                  width: 360.w * value,
                ),
              ])),
        ],
      ),
    );
  }
}


// class FoodScreen extends StatelessWidget {
//   const FoodScreen({
//     Key? key,
//     required this.color,
//     required this.size,
//     required this.foodController,
//     required this.hasBeenInitialized,
//     required Stream<List<Food>> necessityStream,
//   })  : _necessityStream = necessityStream,
//         super(key: key);

//   final ColorConstantController color;
//   final Size size;
//   final FoodController foodController;
//   final bool hasBeenInitialized;
//   final Stream<List<Food>> _necessityStream;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: Column(
//       children: [
//         //segment mealplan
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               margin: EdgeInsets.only(left: 20),
//               child: Text(
//                 'Mau Makan Apa Hari ini?',
//                 style: GoogleFonts.poppins(
//                   textStyle: TextStyle(
//                       color: color.secondaryTextColor,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600),
//                 ),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.symmetric(vertical: 10),
//               height: size.height * 0.2,
//               width: double.infinity,
//               child: Swiper(
//                 itemCount: foodController.sessions.length,
//                 itemWidth: size.width * 0.8,
//                 index: 0,
//                 layout: SwiperLayout.DEFAULT,
//                 viewportFraction: 0.5,
//                 scale: 0.9,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Container(
//                     margin: EdgeInsets.all(10),
//                     child: NeumorphicButton(
//                         onPressed: () {
//                           Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => FoodMealScreen(
//                                       session:
//                                           foodController.sessions[index])));
//                         },
//                         style: NeumorphicStyle(
//                             color: color.primaryColor,
//                             shape: NeumorphicShape.flat,
//                             boxShape: NeumorphicBoxShape.roundRect(
//                               BorderRadius.circular(20),
//                             )),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Neumorphic(
//                               style: NeumorphicStyle(
//                                 color: color.primaryColor,
//                                 shape: NeumorphicShape.flat,
//                                 depth: 4,
//                                 boxShape: NeumorphicBoxShape.circle(),
//                               ),
//                               padding: const EdgeInsets.all(12.0),
//                               child: FaIcon(
//                                 FontAwesomeIcons.plus,
//                                 size: 16,
//                                 color: color.secondaryColor,
//                               ),
//                             ),
//                             SizedBox(height: size.height * 0.02),
//                             Text(
//                               foodController.sessions[index],
//                               style: GoogleFonts.poppins(
//                                 textStyle: TextStyle(
//                                     color: color.primaryTextColor,
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.normal),
//                               ),
//                             ),
//                           ],
//                         )),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//         //segment nutrisi
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               margin: EdgeInsets.only(left: 20),
//               child: Text(
//                 'Nutrisi Hari ini',
//                 style: GoogleFonts.poppins(
//                   textStyle: TextStyle(
//                       color: color.secondaryTextColor,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w600),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: size.height * 0.02,
//             ),
//             !hasBeenInitialized
//                 ? Container()
//                 : StreamBuilder<List<Food>>(
//                     stream: _necessityStream,
//                     builder: (context, snapshot) {
//                       switch (snapshot.connectionState) {
//                         case ConnectionState.none:
//                         case ConnectionState.waiting:
//                           return Center(
//                             child: CircularProgressIndicator(
//                               color: color.secondaryColor,
//                             ),
//                           );
//                         case ConnectionState.active:
//                           return NecessityDisplayWidget(
//                             size: size,
//                             color: color,
//                             listMeal: snapshot.data!,
//                             foodController: foodController,
//                           );
//                         case ConnectionState.done:
//                           return NecessityDisplayWidget(
//                             size: size,
//                             color: color,
//                             listMeal: snapshot.data!,
//                             foodController: foodController,
//                           );
//                       }
//                     })
//             //   if (!snapshot.hasData) {
//             //     return Center(
//             //       child: CircularProgressIndicator(
//             //         color: color.secondaryColor,
//             //       ),
//             //     );
//             //   }
//             //   return NecessityDisplayWidget(
//             //     size: size,
//             //     color: color,
//             //     listMeal: snapshot.data!,
//             //     foodController: foodController,
//             //   );
//             // }),
//           ],
//         ),
//       ],
//     ));
//   }
// }