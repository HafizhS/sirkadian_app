import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/controller/fluid_controller.dart';

import '../../../../controller/hexcolor_controller.dart';
import '../../../../controller/food_controller.dart';
import '../../../../widget/food_widget/necessity_gauge.dart';

class FluidGeneralScreen extends StatefulWidget {
  final Function(int index)? change;

  FluidGeneralScreen({Key? key, this.change}) : super(key: key);

  @override
  _FluidGeneralScreenState createState() => _FluidGeneralScreenState();
}

class _FluidGeneralScreenState extends State<FluidGeneralScreen> {
  final foodController = Get.find<FoodController>();
  final fluidController = Get.find<FluidController>();
  final color = Get.find<ColorConstantController>();
  ScrollController _scrollController = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  double sum = 1.0;
  bool u1 = true;
  double val1 = 100;
  bool u2 = false;
  double val2 = 125;
  bool u3 = false;
  double val3 = 150;
  bool u4 = false;
  double val4 = 175;
  bool u5 = false;
  double val5 = 200;
  bool u6 = false;
  double val6 = 300;
  bool u7 = false;
  double val7 = 400;

  late String dateTimeView;

  @override
  void initState() {
    _scrollController.addListener(() {
      setState(() {
        if (closeTopContainer == false) {
          print('false');
          closeTopContainer = _scrollController.offset > 50;
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //segment 1
        AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: closeTopContainer ? 0 : 1,
          child: AnimatedContainer(
            height: closeTopContainer ? 0 : size.height * 0.43,
            duration: const Duration(milliseconds: 200),
            child: FittedBox(
              fit: BoxFit.fill,
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: size.width,
                child: (Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        'Penuhi Kebutuhan Cairanmu',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: color.secondaryTextColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Neumorphic(
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          style: NeumorphicStyle(
                            depth: 4,
                            shape: NeumorphicShape.flat,
                            color: color.bgColor,
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(20)),
                          ),
                          margin: EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomPaint(
                                child: Container(
                                  alignment: Alignment.center,
                                  height: size.width * 0.4,
                                  width: size.width * 0.4,
                                  child: Text(
                                    '${((foodController.water / foodController.necessity.value.water!) * 100).round().toString()}%',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: color.blueColor,
                                          fontSize: 35,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                foregroundPainter: CircleProgressBarPainter(
                                  foregroundColor: color.blueColor,
                                  backgroundColor:
                                      color.secondaryTextColor.withOpacity(0.3),
                                  percentage: foodController.water /
                                      foodController.necessity.value.water!,
                                  sizeContainer:
                                      Size(size.width * 0.4, size.width * 0.4),
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: foodController.water.toStringAsFixed(0),
                                  style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: color.primaryTextColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text:
                                            ' / ${foodController.necessity.value.water!.toStringAsFixed(0)}',
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                color: color.primaryTextColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold))),
                                    TextSpan(
                                      text: ' ml',
                                      style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: color.primaryTextColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            NeumorphicButton(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              onPressed: () {},
                              style: NeumorphicStyle(
                                  color: color.bgColor,
                                  shape: NeumorphicShape.flat,
                                  boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(20),
                                  )),
                              child: FaIcon(FontAwesomeIcons.cog),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    visualDensity: VisualDensity(
                                        horizontal: -4, vertical: -4),
                                    splashRadius: 15,
                                    onPressed: () {
                                      if (sum <= 1) {
                                        print('dah mentok');
                                      } else {
                                        setState(() {
                                          sum = sum - 0.25;
                                        });
                                      }
                                    },
                                    icon: Icon(
                                      Icons.chevron_left,
                                      size: 20,
                                    )),
                                Container(
                                  child: Text(
                                    // sum == 1.0 ||
                                    //         sum == 2.0 ||
                                    //         sum == 3.0 ||
                                    //         sum == 4.0 ||
                                    //         sum == 5.0
                                    //     ? sum.toStringAsFixed(0)
                                    //     : sum
                                    //         .toMixedFraction()
                                    //         .toString(),
                                    '1.0',
                                    style: TextStyle(fontFeatures: [
                                      // FontFeature.fractions(),
                                      // FontFeature.denominator()
                                    ]),
                                  ),
                                ),
                                IconButton(
                                    visualDensity: VisualDensity(
                                        horizontal: -4, vertical: -4),
                                    splashRadius: 15,
                                    onPressed: () {
                                      if (sum >= 5) {
                                        print('dah mentok');
                                      } else {
                                        setState(() {
                                          sum = sum + 0.25;
                                        });
                                      }
                                    },
                                    icon: Icon(
                                      Icons.chevron_right,
                                      size: 20,
                                    )),
                              ],
                            ),
                            Text('Gelas'),
                            SizedBox(height: size.height * 0.01),
                            NeumorphicButton(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              onPressed: () {},
                              style: NeumorphicStyle(
                                  color: color.bgColor,
                                  shape: NeumorphicShape.flat,
                                  boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(20),
                                  )),
                              child: FaIcon(FontAwesomeIcons.glassWhiskey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    //segment 2
                    DrinkWaters(
                      color: color,
                      size: size,
                      fluidController: fluidController,
                    ),
                    SizedBox(
                      height: size.height * 0.01,
                    ),
                  ],
                )),
              ),
            ),
          ),
        ),

        //segment 3
        Container(
            height: closeTopContainer ? size.height * 0.6 : size.height * 0.2,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      'Terakhir Minum',
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            color: color.primaryTextColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 30),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          closeTopContainer = false;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: FaIcon(
                          FontAwesomeIcons.chevronDown,
                          size: 20,
                          color: color.secondaryTextColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                    controller: _scrollController,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Neumorphic(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        style: NeumorphicStyle(
                          depth: 4,
                          shape: NeumorphicShape.flat,
                          color: color.primaryColor,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(20)),
                        ),
                        margin:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        child: ListTile(
                          leading: Icon(Icons.access_time),
                          // title: Text('$dateTimeView'),
                          title: Text('Pukul: 04.00 Wib '),
                          subtitle: Text(
                            '1.0 gelas',
                            style: TextStyle(fontFeatures: []),
                          ),
                          trailing: Text(
                            '200 ml',
                          ),
                        ),
                      );
                    }),
              )
            ])),
      ],
    );
  }

  void showDialogX() {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 400),
      context: context,
      pageBuilder: (context, __, ___) {
        return Align(
          alignment: Alignment.bottomCenter,
          child: AlertDialog(
            content: Container(
              height: 200,
              width: 300,
              // margin: EdgeInsets.only(bottom: 50, left: 12, right: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Column(
                children: [
                  Text('Ubah Ukuran Gelas'),
                  Container(
                    height: 170,
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, mainAxisSpacing: 1),
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              u1 = true;
                              u2 = false;
                              u3 = false;
                              u4 = false;
                              u5 = false;
                              u6 = false;
                              u7 = false;
                            });
                            // _dismissDialog();
                          },
                          child: GridTile(
                            child: (u1)
                                ? Container(
                                    child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/images/100mlc.png',
                                        height: 30,
                                        width: 30,
                                      ),
                                      Text(
                                        '100 ml',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.blue),
                                      ),
                                    ],
                                  ))
                                : Container(
                                    child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/images/100ml.png',
                                        height: 30,
                                        width: 30,
                                      ),
                                      Text(
                                        '100 ml',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              u1 = false;
                              u2 = true;
                              u3 = false;
                              u4 = false;
                              u5 = false;
                              u6 = false;
                              u7 = false;
                            });
                            // _dismissDialog();
                          },
                          child: GridTile(
                            child: (u2)
                                ? Container(
                                    child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/images/125ml.png',
                                        height: 30,
                                        width: 30,
                                      ),
                                      Text(
                                        '125 ml',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.blue),
                                      ),
                                    ],
                                  ))
                                : Container(
                                    child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/images/125ml.png',
                                        height: 30,
                                        width: 30,
                                      ),
                                      Text(
                                        '125 ml',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              u1 = false;
                              u2 = false;
                              u3 = true;
                              u4 = false;
                              u5 = false;
                              u6 = false;
                              u7 = false;
                            });
                            // _dismissDialog();
                          },
                          child: GridTile(
                            child: (u3)
                                ? Container(
                                    child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/images/150ml.png',
                                        height: 30,
                                        width: 30,
                                      ),
                                      Text(
                                        '150 ml',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.blue),
                                      ),
                                    ],
                                  ))
                                : Container(
                                    child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/images/150ml.png',
                                        height: 30,
                                        width: 30,
                                      ),
                                      Text(
                                        '150 ml',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              u1 = false;
                              u2 = false;
                              u3 = false;
                              u4 = true;
                              u5 = false;
                              u6 = false;
                              u7 = false;
                            });
                            // _dismissDialog();
                          },
                          child: GridTile(
                            child: (u4)
                                ? Container(
                                    child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/images/175mlc.png',
                                        height: 30,
                                        width: 30,
                                      ),
                                      Text(
                                        '175 ml',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.blue),
                                      ),
                                    ],
                                  ))
                                : Container(
                                    child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/images/175ml.png',
                                        height: 30,
                                        width: 30,
                                      ),
                                      Text(
                                        '175 ml',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              u1 = false;
                              u2 = false;
                              u3 = false;
                              u4 = false;
                              u5 = true;
                              u6 = false;
                              u7 = false;
                            });
                            // _dismissDialog();
                          },
                          child: GridTile(
                            child: (u5)
                                ? Container(
                                    child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/images/200mlc.png',
                                        height: 30,
                                        width: 30,
                                      ),
                                      Text(
                                        '200 ml',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.blue),
                                      ),
                                    ],
                                  ))
                                : Container(
                                    child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/images/200ml.png',
                                        height: 30,
                                        width: 30,
                                      ),
                                      Text(
                                        '200 ml',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              u1 = false;
                              u2 = false;
                              u3 = false;
                              u4 = false;
                              u5 = false;
                              u6 = true;
                              u7 = false;
                            });
                            // _dismissDialog();
                          },
                          child: GridTile(
                            child: (u6)
                                ? Container(
                                    child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/images/300mlc.png',
                                        height: 30,
                                        width: 30,
                                      ),
                                      Text(
                                        '300 ml',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.blue),
                                      ),
                                    ],
                                  ))
                                : Container(
                                    child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/images/300ml.png',
                                        height: 30,
                                        width: 30,
                                      ),
                                      Text(
                                        '300 ml',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  )),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              u1 = false;
                              u2 = false;
                              u3 = false;
                              u4 = false;
                              u5 = false;
                              u6 = false;
                              u7 = true;
                            });
                            // _dismissDialog();
                          },
                          child: GridTile(
                            child: (u7)
                                ? Container(
                                    child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/images/400mlc.png',
                                        height: 30,
                                        width: 30,
                                      ),
                                      Text(
                                        '400 ml',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.blue),
                                      ),
                                    ],
                                  ))
                                : Container(
                                    child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/images/400ml.png',
                                        height: 30,
                                        width: 30,
                                      ),
                                      Text(
                                        '400 ml',
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ],
                                  )),
                          ),
                        ),
                        GridTile(
                          child: Container(
                              child: Column(
                            children: [
                              Icon(Icons.local_drink),
                              Text(
                                'Kustom',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    // _dismissDialog();
                  },
                  child: Text('Tutup')),
            ],
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }
}

class DrinkWaters extends StatelessWidget {
  const DrinkWaters(
      {Key? key,
      required this.color,
      required this.size,
      required this.fluidController})
      : super(key: key);

  final Size size;
  final FluidController fluidController;
  final ColorConstantController color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Minum 8 kali sehari',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: color.secondaryTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Container(
            height: size.height * 0.07,
            width: size.width,
            child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: fluidController.isCheckedDrinkWater.length,
                itemBuilder: (context, index) {
                  return Obx(
                    () => NeumorphicButton(
                        onPressed: () {
                          fluidController.isCheckedDrinkWater[index] =
                              !fluidController.isCheckedDrinkWater[index];
                        },
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        style: NeumorphicStyle(
                          depth: fluidController.isCheckedDrinkWater[index]
                              ? -4
                              : 4,
                          color: color.bgColor,
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(20),
                          ),
                        ),
                        child: FaIcon(
                          FontAwesomeIcons.wineGlassAlt,
                          size: 20,
                          color: fluidController.isCheckedDrinkWater[index]
                              ? color.secondaryColor
                              : color.secondaryTextColor,
                        )),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
