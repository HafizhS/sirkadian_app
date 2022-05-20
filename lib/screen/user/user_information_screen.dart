import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/hexcolor_controller.dart';
import '../../controller/text_controller.dart';
import '../../controller/user_controller.dart';

class UserInformationScreen extends StatefulWidget {
  const UserInformationScreen({Key? key}) : super(key: key);

  @override
  _UserInformationScreenState createState() => _UserInformationScreenState();
}

class _UserInformationScreenState extends State<UserInformationScreen> {
  final textController = Get.find<InitialSetupTextC>();
  final userController = Get.find<UserController>();
  final color = Get.find<ColorConstantController>();
  bool isOpen = false;

  @override
  void initState() {
    userController.getUserInformation();
    // userController.getUserHealthHistoryLatest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: Obx(
      () => userController.isLoadingUserInformation.isTrue ||
              userController.isLoadingUserHealthHistoryLatest.isTrue
          ? Center(
              child: CircularProgressIndicator(
                color: color.secondaryColor,
              ),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Row(
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
                              'Informasi User',
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
                                  FontAwesomeIcons.cog,
                                  size: 16,
                                  color: color.secondaryTextColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                        ),
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(10),
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/images/yuda.jpg'),
                                radius: 60,
                              ),
                            ),
                            // Container(
                            //   child: FaIcon(
                            //     FontAwesomeIcons.userCircle,
                            //     size: size.width * 0.3,
                            //   ),
                            // ),
                            Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              child: Text(
                                'Test',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'CenturyGothic'),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(10),
                              height: size.height * 0.1,
                              decoration: BoxDecoration(
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color: Colors.grey.shade200,
                                  //     // offset: const Offset(
                                  //     //   5.0,
                                  //     //   5.0,
                                  //     // ),
                                  //     blurRadius: 5.0,
                                  //     spreadRadius: 2.0,
                                  //   )
                                  // ],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        20.toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Nunito'),
                                      ),
                                      Text(
                                        'Usia',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        (userController
                                                    .userHealthHistoryLatestResponse
                                                    .value
                                                    .weight! /
                                                ((userController
                                                            .userHealthHistoryLatestResponse
                                                            .value
                                                            .height! /
                                                        100) *
                                                    (userController
                                                            .userHealthHistoryLatestResponse
                                                            .value
                                                            .height! /
                                                        100)))
                                            .toStringAsFixed(0),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Nunito'),
                                      ),
                                      Text(
                                        'BMI',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                            text: userController
                                                .userHealthHistoryLatestResponse
                                                .value
                                                .height!
                                                .toStringAsFixed(0),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            children: [
                                              TextSpan(
                                                  text: ' cm',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.normal))
                                            ]),
                                      ),
                                      Text(
                                        'Tinggi Badan',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                            text: userController
                                                .userHealthHistoryLatestResponse
                                                .value
                                                .weight!
                                                .toStringAsFixed(0),
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            children: [
                                              TextSpan(
                                                  text: ' kg',
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.normal))
                                            ]),
                                      ),
                                      Text(
                                        'Berat Badan',
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text('Integrasi Pola Hidup Sehat Anda Hari Ini'),
                      SizedBox(height: size.height * 0.03),
                      childUserGauge(size),
                    ],
                  ),
                ),
              ),
            ),
    ));
  }

  Container childUserGauge(Size size) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Column(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    isOpen = !isOpen;
                  });
                },
                child: IntegrateBarWidget(
                  size: size,
                  title: 'Diet / Makan',
                  // kebutuhanDipenuhi: (foodC.calorie /
                  //         necessityController
                  //             .productList.value!.calorie!) *
                  //     200,
                  kebutuhanDipenuhi: 80,
                  color: Colors.yellow.shade900,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              IntegrateBarWidget(
                size: size,
                title: 'Olahraga',
                kebutuhanDipenuhi: 120,
                color: Colors.green.shade400,
              ),
              SizedBox(height: size.height * 0.02),
              IntegrateBarWidget(
                size: size,
                title: 'Cairan',
                // kebutuhanDipenuhi: (drinkC.valueMinumHarian /
                //         necessityController
                //             .productList.value!.water!) *
                //     200,
                kebutuhanDipenuhi: 40,
                color: Colors.blue.shade400,
              ),
              SizedBox(height: size.height * 0.02),
              IntegrateBarWidget(
                size: size,
                title: 'Mental',
                kebutuhanDipenuhi: 150,
                color: Colors.purple.shade400,
              ),
              SizedBox(height: size.height * 0.02),
              IntegrateBarWidget(
                size: size,
                title: 'Tidur',
                kebutuhanDipenuhi: 70,
                color: Colors.grey.shade700,
              ),
              SizedBox(height: size.height * 0.02),
              IntegrateBarWidget(
                size: size,
                title: 'Adiksi',
                kebutuhanDipenuhi: 110,
                color: Colors.red.shade700,
              ),
              SizedBox(height: size.height * 0.1),
            ],
          ),
        ],
      ),
    );
  }
}

class IntegrateBarWidget extends StatelessWidget {
  const IntegrateBarWidget({
    Key? key,
    required this.size,
    required this.title,
    // required this.kebutuhanHarian,
    required this.kebutuhanDipenuhi,
    required this.color,
  }) : super(key: key);

  final Size size;
  final String title;
  // final double kebutuhanHarian;
  final double kebutuhanDipenuhi;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: size.height * 0.05,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: Colors.grey.shade400, blurRadius: 2.0)
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title),
                Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: size.height * 0.01,
                          width: 200,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        Container(
                          height: size.height * 0.01,
                          width: kebutuhanDipenuhi,
                          decoration: BoxDecoration(
                              color: color,
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ],
                    ),
                    SizedBox(width: size.width * 0.03),
                    FaIcon(
                      FontAwesomeIcons.chevronDown,
                      size: 12,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
