import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant/hex_color.dart';
import '../../controller/hexcolor_controller.dart';
import '../list_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final color = Get.find<ColorConstantController>();
  final List<WelcomeDataModel> data = [
    WelcomeDataModel(
        title: 'Hidup Sehat Bersama Sirkadian',
        subtitle:
            'Sirkadian akan menemanimu menyukseskan hidup sehat terbaik sesuai dengan kebutuhan sehari-harimu',
        images: 'assets/images/menuMarketplace.png',
        color: Colors.green.shade900),
    WelcomeDataModel(
        title: 'SirkaDiet untuk pola makan sehat',
        subtitle:
            'Mari atur bersama pola dan porsi makan yang sesuai dengan kubutuhan nutrisi dan kesehatanmu',
        images: 'assets/images/menuMakan.png',
        color: Colors.green.shade900),
    WelcomeDataModel(
        title: 'SirkaExcercise Untuk Tubuh Bugar',
        subtitle:
            'Mari atur bersama pola olahrga yang sesuai dengan kubutuhan kesehatanmu',
        images: 'assets/images/menuOlahraga.png',
        color: Colors.green.shade900),
    WelcomeDataModel(
        title: 'Kelola Minum dan Tidurmu Bareng Sirkadian',
        subtitle:
            'Sirkadian juga membantu mengelola kebutuhan cairan dan tidur supaya kamu lebih prima dalam menjalankan aktivitas',
        images: 'assets/images/menuMental.png',
        color: Colors.green.shade900),
    WelcomeDataModel(
        title: 'Konsultasikan Kebutuhanmu Bersama Para Dokter Sirkadian',
        subtitle:
            'Kamu bisa berkonsultasi seputar hidup sehat dan keluhan yang kamu alami',
        images: 'assets/images/menuKonsultasi.png',
        color: Colors.green.shade900),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: color.bgColor,
        body: Container(
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 20.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                height: 800.h,
                width: 360.w,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Get.toNamed(RouteScreens.login);
                        },
                        child: Text("Masuk",
                            style: GoogleFonts.inter(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12),
                            backgroundColor: HexColor.fromHex("73C639")),
                      ),
                      const SizedBox(height: 5),
                      ElevatedButton(
                        onPressed: () {
                          Get.toNamed(RouteScreens.register);
                        },
                        child: Text("Daftar",
                            style: GoogleFonts.inter(
                                color: HexColor.fromHex("73C639"))),
                        style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 12),
                            side: BorderSide(
                                color: HexColor.fromHex("73C639"), width: 1)),
                      ),
                      const SizedBox(height: 20),

                      // NeumorphicButton(
                      //     margin: EdgeInsets.only(top: 12.h),
                      //     onPressed: () {
                      //       Get.toNamed(RouteScreens.login);
                      //     },
                      //     style: NeumorphicStyle(
                      //         color: color.secondaryColor,
                      //         shape: NeumorphicShape.flat,
                      //         boxShape: NeumorphicBoxShape.roundRect(
                      //           BorderRadius.circular(20),
                      //         )
                      //         //border: NeumorphicBorder()
                      //         ),
                      //     padding: EdgeInsets.symmetric(
                      //         vertical: 12.h, horizontal: 120.w),
                      //     child: Text(
                      //       "Masuk",
                      //       style: GoogleFonts.inter(
                      //         textStyle: TextStyle(
                      //             color: color.primaryColor,
                      //             fontSize: 14.sp,
                      //             fontWeight: FontWeight.normal),
                      //       ),
                      //     )),
                      // SizedBox(
                      //   height: 18.h,
                      // ),
                      // TextButton(
                      //   style: ButtonStyle(
                      //       overlayColor:
                      //           MaterialStateProperty.all(Colors.transparent)),
                      //   onPressed: () {
                      //     Get.toNamed(RouteScreens.register);
                      //   },
                      //   child: RichText(
                      //     text: TextSpan(
                      //       text: 'Belum punya akun? ',
                      //       style: GoogleFonts.inter(
                      //           textStyle: TextStyle(
                      //         color: color.primaryTextColor,
                      //         fontSize: 14.sp,
                      //       )),
                      //       children: <TextSpan>[
                      //         TextSpan(
                      //           text: 'Daftar',
                      //           style: GoogleFonts.inter(
                      //             textStyle: TextStyle(
                      //                 color: color.primaryTextColor,
                      //                 fontSize: 14.sp,
                      //                 fontWeight: FontWeight.bold),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
              //
              Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: HexColor.fromHex('#000000').withOpacity(0.2),
                            blurRadius: 10,
                            spreadRadius: 6)
                      ]),
                  height: 550.h,
                  child: Swiper(
                    // itemCount: data.length,
                    itemCount: 5,
                    itemWidth: 300.w,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.only(
                            bottom: 50.h, left: 10.w, right: 10.w),
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.all(30),
                              height: 200.h,
                              width: double.infinity,
                              child: Image.asset(data[index].images!),
                            ),
                            Text(
                              data[index].title!,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: color.primaryTextColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              data[index].subtitle!,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: color.primaryTextColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    duration: 2000,
                    autoplayDelay: 8000,
                    autoplayDisableOnInteraction: true,
                    autoplay: true,
                    layout: SwiperLayout.DEFAULT,

                    pagination: new SwiperPagination(
                      builder: DotSwiperPaginationBuilder(
                          activeSize: 8,
                          space: 5,
                          color: Colors.grey,
                          size: 8,
                          activeColor: color.secondaryColor),
                    ),

                    // fade: 1.0,
                    viewportFraction: 1,
                    scale: 0.9,
                  )),
            ],
          ),
        ));
  }
}

class WelcomeDataModel {
  String? title;
  String? subtitle;
  String? images;
  Color? color;

  WelcomeDataModel({
    this.title,
    this.subtitle,
    this.images,
    this.color,
  });
}
