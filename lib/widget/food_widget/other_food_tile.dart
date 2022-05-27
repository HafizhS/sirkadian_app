import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/controller/hexcolor_controller.dart';
import 'package:sirkadian_app/model/food_model/food_recommendation_response_model.dart';

import '../../controller/food_controller.dart';
import '../../screen/home/nutrition_screen/food_screen/food_detail_screen.dart';

class ListRekomendasi extends StatelessWidget {
  const ListRekomendasi(
      {Key? key,
      required this.size,
      required this.sportList,
      required this.foodList,
      required this.color})
      : super(key: key);

  final Size size;
  final List<SportDummyData> sportList;
  final List<SportDummyData> foodList;
  final ColorConstantController color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Container(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     children: [
        //       Container(
        //         margin: EdgeInsets.all(10),
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             Column(
        //               crossAxisAlignment: CrossAxisAlignment.start,
        //               children: [
        //                 Text(
        //                   'Tren Makanan hari ini',
        //                   style: GoogleFonts.poppins(
        //                       textStyle: TextStyle(
        //                     color: color.primaryTextColor,
        //                     fontSize: 16,
        //                     fontWeight: FontWeight.bold,
        //                   )),
        //                 ),
        //                 Text(
        //                   'Berikut adalah makanan terbaik untukmu',
        //                   style: GoogleFonts.inter(
        //                       textStyle: TextStyle(
        //                     color: color.primaryTextColor,
        //                     fontSize: 14,
        //                     fontWeight: FontWeight.normal,
        //                   )),
        //                 )
        //               ],
        //             ),
        //             TextButton(
        //               onPressed: () {},
        //               child: Container(
        //                   decoration: BoxDecoration(
        //                       color: color.secondaryColor,
        //                       borderRadius: BorderRadius.circular(15)),
        //                   alignment: Alignment.center,
        //                   height: size.height * 0.03,
        //                   width: size.width * 0.15,
        //                   child: Text(
        //                     'See All',
        //                     style: TextStyle(color: Colors.white, fontSize: 12),
        //                   )),
        //             )
        //           ],
        //         ),
        //       ),
        //       SingleChildScrollView(
        //         scrollDirection: Axis.horizontal,
        //         child: Row(
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             for (int i = 0; i < sportList.length; i++)
        //               Padding(
        //                   padding: const EdgeInsets.all(8.0),
        //                   child: Container(
        //                       width: size.width * 0.5,
        //                       child: SportTile(
        //                         product: foodList[i],
        //                         color: color,
        //                       )))
        //           ],
        //         ),
        //       )
        //     ],
        //   ),
        // ),
        //tren olahraga
//         Container(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Container(
//                 margin: EdgeInsets.all(10),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Tren Olahraga hari ini',
//                           style: GoogleFonts.poppins(
//                               textStyle: TextStyle(
//                             color: color.primaryTextColor,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           )),
//                         ),
//                         Text(
//                           'Jaga Kesehatanmu dengan berolahraga',
//                           style: GoogleFonts.inter(
//                               textStyle: TextStyle(
//                             color: color.primaryTextColor,
//                             fontSize: 14,
//                             fontWeight: FontWeight.normal,
//                           )),
//                         )
//                       ],
//                     ),
//                     TextButton(
//                       onPressed: () {},
//                       child: Container(
//                           decoration: BoxDecoration(
//                               color: color.secondaryColor,
//                               borderRadius: BorderRadius.circular(15)),
//                           alignment: Alignment.center,
//                           height: size.height * 0.03,
//                           width: size.width * 0.15,
//                           child: Text(
//                             'See All',
//                             style: TextStyle(color: Colors.white, fontSize: 12),
//                           )),
//                     )
//                   ],
//                 ),
//               ),
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     for (int i = 0; i < sportList.length; i++)
//                       Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Container(
//                             width: size.width * 0.5,
//                             child: SportTile(
//                               product: sportList[i],
//                               color: color,
//                             )),
//                       )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
      ],
    );
  }
}

class OtherFoodRecommendationTile extends StatelessWidget {
  final DataFoodRecommendationResponse product;
  final DataFoodRecommendationResponse productOld;
  final ColorConstantController color;
  final FoodController foodController;
  final String session;

  OtherFoodRecommendationTile(
      {Key? key,
      required this.product,
      required this.productOld,
      required this.color,
      required this.foodController,
      required this.session})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return NeumorphicButton(
      onPressed: () {
        foodController.getOtherFoodRecommendation(product.foodId, session);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FoodDetailScreen(
                      foodController: foodController,
                      color: color,
                      food: product,
                      session: session,
                    ))).then((_) {
          foodController.getOtherFoodRecommendation(productOld.foodId, session);
        });
      },
      padding: EdgeInsets.all(0),
      style: NeumorphicStyle(
          depth: 4,
          color: color.bgColor,
          shape: NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(20),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              height: size.height * 0.15,
              width: size.width * 0.5,
              child: product.imageFilename == ''
                  ? Icon(Icons.image_not_supported_rounded)
                  : ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      child: Image.network(
                        product.imageFilename!,
                        fit: BoxFit.cover,
                      ),
                    )),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 5),
                child: Text(
                  product.foodName!,
                  maxLines: 2,
                  style: GoogleFonts.inter(
                      textStyle: TextStyle(
                    color: color.primaryTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                  )),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.fire,
                          color: color.redColor,
                          size: 12,
                        ),
                        Text(
                          ' ' + product.energy!.toStringAsFixed(0) + ' kkal',
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                color: color.secondaryTextColor,
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.solidClock,
                          color: color.blueColor,
                          size: 12,
                        ),
                        Text(
                          ' ' + product.duration!.toStringAsFixed(0) + ' min',
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                color: color.secondaryTextColor,
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.solidStar,
                          color: color.yellowColor,
                          size: 12,
                        ),
                        Text(
                          ' ' + product.recommendationScore!.toStringAsFixed(1),
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                color: color.secondaryTextColor,
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SportDummyData {
  String image;
  String sportTitle;
  String? kategori;
  Icon icon;

  SportDummyData({
    required this.sportTitle,
    required this.image,
    required this.icon,
    this.kategori,
  });
}

class SportChartDummyData {
  int? calorie;
  int? date;

  SportChartDummyData({
    this.date,
    this.calorie,
  });
}
