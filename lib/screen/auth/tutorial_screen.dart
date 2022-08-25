import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/hexcolor_controller.dart';
import '../../constant/hex_color.dart';
import '../list_screen.dart';

class TutorialScreen extends StatefulWidget {
  const TutorialScreen({Key? key}) : super(key: key);

  @override
  State<TutorialScreen> createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  final color = Get.find<ColorConstantController>();
  int pageActive = 0;
  PageController _controller = PageController(initialPage: 0);
  final List<TutorialDataModel> data = [
    TutorialDataModel(
        title: 'Tutorial 1',
        subtitle:
            'Sirkadian akan menemanimu menyukseskan hidup sehat terbaik sesuai dengan kebutuhan sehari-harimu',
        images: 'assets/images/menuMarketplace.png',
        color: Colors.green.shade900),
    TutorialDataModel(
        title: 'Tutorial 2',
        subtitle:
            'Mari atur bersama pola dan porsi makan yang sesuai dengan kubutuhan nutrisi dan kesehatanmu',
        images: 'assets/images/menuMakan.png',
        color: Colors.green.shade900),
    TutorialDataModel(
        title: 'Tutorial 3',
        subtitle:
            'Mari atur bersama pola olahrga yang sesuai dengan kubutuhan kesehatanmu',
        images: 'assets/images/menuOlahraga.png',
        color: Colors.green.shade900),
    TutorialDataModel(
        title: 'Tutorial 4',
        subtitle:
            'Sirkadian juga membantu mengelola kebutuhan cairan dan tidur supaya kamu lebih prima dalam menjalankan aktivitas',
        images: 'assets/images/menuMental.png',
        color: Colors.green.shade900),
    TutorialDataModel(
        title: 'Tutorial 5',
        subtitle:
            'Kamu bisa berkonsultasi seputar hidup sehat dan keluhan yang kamu alami',
        images: 'assets/images/menuKonsultasi.png',
        color: Colors.green.shade900),
  ];
  @override
  Widget build(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    return Scaffold(
      backgroundColor: color.bgColor,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Container(
              child: Column(children: [
            Expanded(
              flex: 12,
              child: PageView(
                scrollDirection: Axis.horizontal,
                controller: _controller,
                onPageChanged: (index) {
                  setState(() {
                    pageActive = index;
                  });
                },
                children: [
                  Container(
                    child: Center(child: Text('Tutorial 1')),
                  ),
                  Container(
                    child: Center(child: Text('Tutorial 2')),
                  ),
                  Container(
                    child: Center(child: Text('Tutorial 3')),
                  ),
                  Container(
                    child: Center(child: Text('Tutorial 4')),
                  )
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List<Widget>.generate(4, (int index) {
                            return AnimatedContainer(
                                duration: Duration(milliseconds: 300),
                                height: 12.h,
                                width: 10.w,
                                margin: EdgeInsets.only(
                                    left: 5.w, right: 5.w, bottom: 10.h),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: (index == pageActive)
                                        ? color.tersierColor
                                        : color.secondaryColor
                                            .withOpacity(0.4)));
                          })),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          NeumorphicButton(
                              onPressed: () {
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                                _controller.previousPage(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOutQuint);
                              },
                              margin: EdgeInsets.only(top: 10.h),
                              style: NeumorphicStyle(
                                  color: color.secondaryColor,
                                  depth: 4,
                                  shape: NeumorphicShape.flat,
                                  boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(20),
                                  )),
                              padding: EdgeInsets.symmetric(
                                  vertical: 12.h, horizontal: 50.w),
                              child: Text(
                                "Kembali",
                                style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      color: color.primaryColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal),
                                ),
                              )),
                          SizedBox(width: 20.w),
                          NeumorphicButton(
                              onPressed: () {
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                                // if (pageActive == 1) {
                                // } else {
                                _controller.nextPage(
                                    duration: Duration(milliseconds: 800),
                                    curve: Curves.easeInOutQuint);
                                // }
                              },
                              margin: EdgeInsets.only(top: 10.h),
                              style: NeumorphicStyle(
                                  color: color.secondaryColor,
                                  depth: 4,
                                  shape: NeumorphicShape.flat,
                                  boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(20),
                                  )),
                              padding: EdgeInsets.symmetric(
                                  vertical: 12.h, horizontal: 50.w),
                              child: Text(
                                pageActive == 3 ? 'Selesai' : "Lanjut",
                                style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      color: color.primaryColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal),
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ])),
        ),
      ),
    );
  }
}

class TutorialDataModel {
  String? title;
  String? subtitle;
  String? images;
  Color? color;
  TutorialDataModel({
    this.title,
    this.subtitle,
    this.images,
    this.color,
  });
}
