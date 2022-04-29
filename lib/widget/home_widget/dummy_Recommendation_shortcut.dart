import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/constant/color.dart';

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
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tren Makanan hari ini',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: color.primaryTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                        ),
                        Text(
                          'Berikut adalah makanan terbaik untukmu',
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                            color: color.primaryTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          )),
                        )
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Container(
                          decoration: BoxDecoration(
                              color: color.secondaryColor,
                              borderRadius: BorderRadius.circular(15)),
                          alignment: Alignment.center,
                          height: size.height * 0.03,
                          width: size.width * 0.15,
                          child: Text(
                            'See All',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          )),
                    )
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < sportList.length; i++)
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: size.width * 0.5,
                              child: SportTile(
                                product: foodList[i],
                                color: color,
                              )))
                  ],
                ),
              )
            ],
          ),
        ),
        //tren olahraga
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tren Olahraga hari ini',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: color.primaryTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                        ),
                        Text(
                          'Jaga Kesehatanmu dengan berolahraga',
                          style: GoogleFonts.inter(
                              textStyle: TextStyle(
                            color: color.primaryTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          )),
                        )
                      ],
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Container(
                          decoration: BoxDecoration(
                              color: color.secondaryColor,
                              borderRadius: BorderRadius.circular(15)),
                          alignment: Alignment.center,
                          height: size.height * 0.03,
                          width: size.width * 0.15,
                          child: Text(
                            'See All',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          )),
                    )
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (int i = 0; i < sportList.length; i++)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: size.width * 0.5,
                            child: SportTile(
                              product: sportList[i],
                              color: color,
                            )),
                      )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class SportTile extends StatelessWidget {
  final SportDummyData product;
  final ColorConstantController color;

  SportTile({Key? key, required this.product, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {},
      child: Neumorphic(
        style: NeumorphicStyle(
            depth: 4,
            color: color.backgroundColor,
            shape: NeumorphicShape.flat,
            boxShape: NeumorphicBoxShape.roundRect(
              BorderRadius.circular(20),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Stack(alignment: Alignment.topRight, children: [
                  Container(
                      height: size.height * 0.15,
                      width: double.infinity,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(6),
                              topRight: Radius.circular(6)),
                          color: Colors.black.withOpacity(0.1)),
                      child: Image.asset(
                        product.image,
                        fit: BoxFit.cover,
                      )),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: NeumorphicButton(
                      onPressed: () {},
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        boxShape: NeumorphicBoxShape.circle(),
                        color: color.primaryColor,
                      ),
                      padding: const EdgeInsets.all(12.0),
                      child: FaIcon(
                        FontAwesomeIcons.plus,
                        size: 12,
                        color: color.secondaryTextColor,
                      ),
                    ),
                  ),
                ]),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (product.sportTitle).toString(),
                    maxLines: 2,
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: color.primaryTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    )),
                    overflow: TextOverflow.ellipsis,
                  ),
                  // SizedBox(
                  //   height: 10,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Icon(
                                Icons.local_fire_department_outlined,
                                size: 14,
                              ),
                            ),
                            TextSpan(
                              text: 150.toString(),
                              style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                color: color.primaryTextColor,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Icon(
                                Icons.schedule_outlined,
                                size: 14,
                              ),
                            ),
                            TextSpan(
                              text: 310.toString(),
                              style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                color: color.primaryTextColor,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: Icon(Icons.star, size: 14),
                            ),
                            TextSpan(
                              text: 200.toString(),
                              style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                color: color.primaryTextColor,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
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
