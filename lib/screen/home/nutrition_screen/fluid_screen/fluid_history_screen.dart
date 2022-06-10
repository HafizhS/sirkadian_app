import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../controller/hexcolor_controller.dart';

class FluidHistoryScreen extends StatefulWidget {
  FluidHistoryScreen({Key? key}) : super(key: key);

  @override
  State<FluidHistoryScreen> createState() => _FluidHistoryScreenState();
}

class _FluidHistoryScreenState extends State<FluidHistoryScreen> {
  final color = Get.find<ColorConstantController>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.h),
          child: Padding(
            padding: EdgeInsets.only(top: 20.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20.w),
                  child: NeumorphicButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: NeumorphicStyle(
                      shape: NeumorphicShape.flat,
                      boxShape: NeumorphicBoxShape.circle(),
                      color: color.bgColor,
                    ),
                    padding: EdgeInsets.all(16.sp),
                    child: FaIcon(
                      FontAwesomeIcons.chevronLeft,
                      size: 16.sp,
                      color: color.secondaryTextColor,
                    ),
                  ),
                ),
                Text(
                  'Riwayat Minum',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: color.primaryTextColor,
                        fontSize: 20.sp,
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
                      color: color.bgColor,
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
        ),
        body: Container(
            margin: EdgeInsets.only(top: 20.h),
            height: 800.h,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                child: ListView.builder(
                    // controller: _scrollController,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Neumorphic(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 10.h),
                        style: NeumorphicStyle(
                          depth: 4,
                          shape: NeumorphicShape.flat,
                          color: color.primaryColor,
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(20)),
                        ),
                        margin: EdgeInsets.symmetric(
                            horizontal: 30.w, vertical: 10.h),
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
      ),
    );
  }
}
