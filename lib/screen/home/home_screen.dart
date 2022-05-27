import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../constant/hex_color.dart';
import '../../controller/auth_controller.dart';

import '../../controller/hexcolor_controller.dart';
import '../../widget/food_widget/necessity_gauge.dart';
import '../../widget/food_widget/other_food_tile.dart';
import 'exercise_screen/exercise_general_screen.dart';
import 'nutrition_screen/nutrition_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final authController = Get.find<AuthController>();
  final color = Get.find<ColorConstantController>();
  ScrollController scrollController = ScrollController();
  final closeTopContainer = false.obs;
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      setState(() {
        closeTopContainer.value = scrollController.offset > 130;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: color.bgColor,

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            !closeTopContainer.value ? size.height * 0.4 : size.height * 0.1),
        child: AnimatedCrossFade(
          duration: const Duration(milliseconds: 200),
          crossFadeState: !closeTopContainer.value
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          firstChild: Container(
            padding: EdgeInsets.only(top: 40, right: 20, left: 20),
            height: size.height * 0.4,
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
                    Stack(alignment: Alignment.center, children: [
                      CircleAvatar(
                        backgroundColor: color.primaryColor,
                        radius: 25,
                      ),
                      CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/user_male.jpg'),
                        radius: 20,
                      ),
                    ]),
                  ],
                ),
                //

                SizedBox(height: size.height * 0.01),

                RichText(
                  text: TextSpan(
                    text: 'Hai ',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                      color: color.primaryTextColor,
                      fontSize: 16,
                    )),
                    children: <TextSpan>[
                      TextSpan(
                        text:
                            '${authController.data.read('dataUser')['username']},',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: color.primaryTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),

                Expanded(
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
                      top: 10,
                      bottom: 10,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Log Kesehatan Hari ini',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: color.secondaryTextColor,
                                fontSize: 16,
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
                                    height: size.width * 0.2,
                                    width: size.width * 0.2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${((0.6) * 100).round().toString()}%',
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
                                    backgroundColor: color.secondaryTextColor
                                        .withOpacity(0.3),
                                    percentage: 0.6,
                                    sizeContainer: Size(
                                        size.width * 0.3, size.width * 0.3),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                CustomPaint(
                                  child: Container(
                                    height: size.width * 0.2,
                                    width: size.width * 0.2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${((0.3) * 100).round().toString()}%',
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
                                  foregroundPainter: CircleProgressBarPainter(
                                    foregroundColor: color.secondaryColor,
                                    backgroundColor: color.secondaryTextColor
                                        .withOpacity(0.3),
                                    percentage: 0.3,
                                    sizeContainer: Size(
                                        size.width * 0.3, size.width * 0.3),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                CustomPaint(
                                  child: Container(
                                    height: size.width * 0.2,
                                    width: size.width * 0.2,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${((0.4) * 100).round().toString()}%',
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
                                    backgroundColor: color.secondaryTextColor
                                        .withOpacity(0.3),
                                    percentage: 0.4,
                                    sizeContainer: Size(
                                        size.width * 0.3, size.width * 0.3),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          secondChild: Container(
              padding: EdgeInsets.only(top: 40, right: 20, left: 20),
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
                        Stack(alignment: Alignment.center, children: [
                          CircleAvatar(
                            backgroundColor: color.primaryColor,
                            radius: 25,
                          ),
                          CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/user_male.jpg'),
                            radius: 20,
                          ),
                        ]),
                      ],
                    ),
                  ])),
        ),
      ),

      //
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          controller: scrollController,
          child: Column(children: [
            //segmen 2

            SizedBox(height: size.height * 0.03),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  NeumorphicButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NutritionScreen()));
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
                            height: size.height * 0.05,
                            width: size.width * 0.3,
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "Penuhi Nutrisi",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: color.secondaryTextColor,
                                    fontSize: 14,
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
                            padding: const EdgeInsets.all(12.0),
                            child: FaIcon(
                              FontAwesomeIcons.dumbbell,
                              size: 16,
                              color: color.secondaryColor,
                            ),
                          ),
                          Container(
                            height: size.height * 0.05,
                            width: size.width * 0.3,
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "Olahraga",
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: color.secondaryTextColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      )),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "Artikel Kesehatan Terbaru",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: color.blackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    width: size.width,
                    height: size.height * 0.27,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        Container(
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  child: Image.asset(
                                      'assets/images/featured_1.jpeg')),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "Resep Menu Sehat",
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
                          decoration: BoxDecoration(
                            color: color.primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: EdgeInsets.all(10),
                          height: 200,
                          width: 200,
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  child:
                                      Image.asset('assets/images/jogging.jpg')),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "Resep Menu Sehat",
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
                          decoration: BoxDecoration(
                            color: color.primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: EdgeInsets.all(10),
                          height: 200,
                          width: 200,
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  child: Image.asset('assets/images/bcg.jpg')),
                              Container(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "Resep Menu Sehat",
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
                          decoration: BoxDecoration(
                            color: color.primaryColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: EdgeInsets.all(10),
                          height: 200,
                          width: 200,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              ListRekomendasi(
                  size: size,
                  sportList: sportList,
                  foodList: foodList,
                  color: color),
              SizedBox(height: size.height * 0.1),
            ]),
          ]),
        ),
      ),
    );
  }

  final List<SportDummyData> sportList = [
    SportDummyData(
      image: 'assets/images/situp.jpg',
      sportTitle: 'Sit Up',
      icon: Icon(
        Icons.check,
        color: Colors.green.shade900,
        size: 30,
      ),
    ),
    SportDummyData(
      image: 'assets/images/jogging.jpg',
      sportTitle: 'Jogging',
      icon: Icon(
        Icons.directions_run,
        color: Colors.green.shade900,
        size: 30,
      ),
    ),
    SportDummyData(
      image: 'assets/images/pushup.jpg',
      sportTitle: 'Push Up',
      icon: Icon(
        Icons.check,
        color: Colors.green.shade900,
        size: 30,
      ),
    ),
    SportDummyData(
      image: 'assets/images/situp.jpg',
      sportTitle: 'Sit Up',
      icon: Icon(
        Icons.check,
        color: Colors.green.shade900,
        size: 30,
      ),
    ),
    SportDummyData(
      image: 'assets/images/pushup.jpg',
      sportTitle: 'Push Up',
      icon: Icon(
        Icons.check,
        color: Colors.green.shade900,
        size: 30,
      ),
    ),
  ];
  //--
  final List<SportDummyData> foodList = [
    SportDummyData(
      image: 'assets/images/images_1.jpg',
      sportTitle: 'Nasi Goreng',
      icon: Icon(
        Icons.check,
        color: Colors.green.shade900,
        size: 30,
      ),
    ),
    SportDummyData(
      image: 'assets/images/images_3.jpg',
      sportTitle: 'Bakso',
      icon: Icon(
        Icons.directions_run,
        color: Colors.green.shade900,
        size: 30,
      ),
    ),
    SportDummyData(
      image: 'assets/images/images_2.jpg',
      sportTitle: 'Mie Goreng',
      icon: Icon(
        Icons.check,
        color: Colors.green.shade900,
        size: 30,
      ),
    ),
    SportDummyData(
      image: 'assets/images/images_1.jpg',
      sportTitle: 'Nasi Goreng',
      icon: Icon(
        Icons.check,
        color: Colors.green.shade900,
        size: 30,
      ),
    ),
    SportDummyData(
      image: 'assets/images/images_2.jpg',
      sportTitle: 'Mie Goreng',
      icon: Icon(
        Icons.check,
        color: Colors.green.shade900,
        size: 30,
      ),
    ),
  ];
}
