import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/controller/information_controller.dart';
import 'package:sirkadian_app/controller/subscription_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controller/hexcolor_controller.dart';
import '../../model/subscription_model/subscription_all_model.dart';

class ProgramDetailScreen extends StatefulWidget {
  final SubscriptionPackages subscriptionItem;

  ProgramDetailScreen({
    required this.subscriptionItem,
    Key? key,
  }) : super(key: key);

  @override
  State<ProgramDetailScreen> createState() => _ProgramDetailScreenState();
}

class _ProgramDetailScreenState extends State<ProgramDetailScreen> {
  final subscriptionController = Get.find<SubscriptionController>();
  final informationController = Get.put(InformationController());
  final color = Get.find<ColorConstantController>();
  List<String> listDapatkan = [
    'Rekomendasi pola makan',
    'Rekomendasi menu dan resep makanan',
    'Rekomendasi pola kebutuhan cairan',
    'Reminder kebutuhan cairan',
    'Rekomendasi olahraga'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(130.h),
        child: Container(
          padding: EdgeInsets.only(top: 40.h, right: 20.w, left: 20.w),
          width: double.infinity,
          height: 290.h,
          decoration:
              BoxDecoration(color: color.tersierColor, boxShadow: <BoxShadow>[
            BoxShadow(
                color: color.blackColor.withOpacity(0.2),
                blurRadius: 20,
                spreadRadius: 6)
          ]),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.arrowLeft,
                      color: color.primaryColor,
                      size: 24.sp,
                    )),
                Text(
                  widget.subscriptionItem.name!,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: color.primaryColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
            SizedBox(height: 3.h),
            Text(
              widget.subscriptionItem.description!,
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                    color: color.primaryColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ]),
        ),
      ),
      //
      body: Container(
        margin: EdgeInsets.only(top: 40.h, left: 20.w, right: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                Text(
                  'Mulailah perjalanan penurunan berat badanmu dan dapatkan hasil yang diinginkan dengan rekomendasi program diet berlangganan yang telah Sirkadian rencanakan sehari-hari khusus untukmu.',
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        color: color.tersierTextColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              ],
            ),
            SizedBox(height: 18.h),
            Text(
              'Ini waktumu untuk memulainya!',
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                    color: color.tersierTextColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.normal),
              ),
            ),
            SizedBox(height: 30.h),
            Text(
              'Dapatkan:',
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                    color: color.primaryTextColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Column(
                children: listDapatkan
                    .map((e) => Padding(
                          padding: EdgeInsets.all(5.sp),
                          child: Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.check,
                                size: 12.sp,
                                color: color.secondaryColor,
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                e,
                                style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      color: color.tersierTextColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.normal),
                                ),
                              )
                            ],
                          ),
                        ))
                    .toList()),
            Center(
              child: NeumorphicButton(
                  margin: EdgeInsets.only(top: 160.h),
                  onPressed: () {
                    informationController.snackBarError('Fitur belum tersedia',
                        'Anda bisa mulai berlangganan setelah dilakukan uji versi beta');
                  },
                  style: NeumorphicStyle(
                      color: color.secondaryColor,
                      shape: NeumorphicShape.flat,
                      boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(20),
                      )
                      //border: NeumorphicBorder()
                      ),
                  padding:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 100.w),
                  child: Text(
                    "Mulai Berlangganan",
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          color: color.primaryColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
