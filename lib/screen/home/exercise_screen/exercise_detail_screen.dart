import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/controller/exercise_controller.dart';
import 'package:sirkadian_app/controller/hexcolor_controller.dart';
import 'package:sirkadian_app/model/exercise_model/exerciseAll_response_model.dart';

class ExerciseDetailScreen extends StatefulWidget {
  final ColorConstantController color;
  final ExerciseController exerciseController;
  final DataExerciseAllResponse exercise;
  ExerciseDetailScreen({
    Key? key,
    required this.color,
    required this.exerciseController,
    required this.exercise,
  }) : super(key: key);

  @override
  State<ExerciseDetailScreen> createState() => _ExerciseDetailScreenState();
}

class _ExerciseDetailScreenState extends State<ExerciseDetailScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        controller: scrollController,
        child: Container(
          height: 800.h,
          padding: EdgeInsets.all(20.sp),
          color: widget.color.bgColor,
          child: Column(children: [
            Stack(children: [
              Container(
                  height: 200.h,
                  width: 360.w,
                  decoration: BoxDecoration(
                      color: widget.color.backupPrimaryColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: widget.exercise.imageFilename == ''
                      ? Icon(Icons.image_not_supported_rounded)
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            widget.exercise.imageFilename!,
                            fit: BoxFit.cover,
                          ),
                        )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 5.w),
                    child: NeumorphicButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: NeumorphicStyle(
                        shape: NeumorphicShape.flat,
                        depth: 0,
                        boxShape: NeumorphicBoxShape.circle(),
                        color: widget.color.primaryColor,
                      ),
                      padding: EdgeInsets.all(16.sp),
                      child: FaIcon(
                        FontAwesomeIcons.chevronLeft,
                        size: 20.sp,
                        color: widget.color.secondaryTextColor,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 5.w),
                    child: NeumorphicButton(
                      onPressed: () {},
                      style: NeumorphicStyle(
                        depth: 0,
                        shape: NeumorphicShape.flat,
                        boxShape: NeumorphicBoxShape.circle(),
                        color: widget.color.primaryColor,
                      ),
                      padding: EdgeInsets.all(16.sp),
                      child: FaIcon(
                        FontAwesomeIcons.signal,
                        size: 16.sp,
                        color: widget.color.secondaryTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ]),
            SizedBox(height: 10.h),
            Neumorphic(
              padding: EdgeInsets.all(15.sp),
              style: NeumorphicStyle(
                shape: NeumorphicShape.flat,
                color: widget.color.primaryColor,
                boxShape:
                    NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
              ),
              margin: EdgeInsets.symmetric(vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Container(
                          // width: 300.w,
                          child: Text(
                            widget.exercise.name!,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: widget.color.primaryTextColor,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      Text(
                          'Id: ' +
                              (widget.exercise.sportId!).toStringAsFixed(0),
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                color: widget.color.tersierTextColor,
                                fontSize: 14,
                                fontWeight: FontWeight.normal),
                          )),
                      SizedBox(width: 20.w),
                      FaIcon(
                        FontAwesomeIcons.levelUpAlt,
                        size: 14.sp,
                        color: widget.color.tersierTextColor,
                      ),
                      Text(' ' + widget.exercise.difficulty!,
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                color: widget.color.tersierTextColor,
                                fontSize: 14,
                                fontWeight: FontWeight.normal),
                          )),
                      SizedBox(width: 20.w),
                      Text(
                        'Mets: ' + (widget.exercise.mets!).toStringAsFixed(0),
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              color: widget.color.tersierTextColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    widget.exercise.desc!,
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          color: widget.color.primaryTextColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Variasi :',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: widget.color.primaryTextColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                NeumorphicButton(
                  onPressed: () {},
                  style: NeumorphicStyle(
                    depth: 4,
                    shape: NeumorphicShape.flat,
                    boxShape: NeumorphicBoxShape.circle(),
                    color: widget.color.bgColor,
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: FaIcon(FontAwesomeIcons.search,
                      size: 14, color: widget.color.secondaryColor),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            widget.exercise.variations!.isEmpty
                ? Padding(
                    padding: EdgeInsets.only(top: 100.h),
                    child: Center(
                      child: Text(
                        'Tidak ada variasi untuk olahraga ini.',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: widget.color.primaryTextColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: widget.exercise.variations!
                        .map(
                            (variation) =>
                                Stack(alignment: Alignment.topRight, children: [
                                  Neumorphic(
                                      padding: EdgeInsets.all(15.sp),
                                      style: NeumorphicStyle(
                                        shape: NeumorphicShape.flat,
                                        color: widget.color.primaryColor,
                                        boxShape: NeumorphicBoxShape.roundRect(
                                            BorderRadius.circular(20)),
                                      ),
                                      margin:
                                          EdgeInsets.symmetric(vertical: 10.h),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            variation.name!,
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  color: widget
                                                      .color.primaryTextColor,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                          SizedBox(height: 10.h),
                                          Row(
                                            children: [
                                              Text(
                                                  'Id: ' +
                                                      (variation
                                                              .sportVariationId!)
                                                          .toStringAsFixed(0),
                                                  style: GoogleFonts.inter(
                                                    textStyle: TextStyle(
                                                        color: widget.color
                                                            .tersierTextColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  )),
                                              SizedBox(width: 20.w),
                                              FaIcon(
                                                FontAwesomeIcons.levelUpAlt,
                                                size: 14.sp,
                                                color: widget
                                                    .color.tersierTextColor,
                                              ),
                                              Text(' ' + variation.difficulty!,
                                                  style: GoogleFonts.inter(
                                                    textStyle: TextStyle(
                                                        color: widget.color
                                                            .tersierTextColor,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  )),
                                              SizedBox(width: 20.w),
                                              Text(
                                                'Mets: ' +
                                                    (variation.mets!)
                                                        .toStringAsFixed(0),
                                                style: GoogleFonts.inter(
                                                  textStyle: TextStyle(
                                                      color: widget.color
                                                          .tersierTextColor,
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )),
                                  Container(
                                    padding: EdgeInsets.all(15.sp),
                                    child: NeumorphicButton(
                                      onPressed: () {
                                        Get.bottomSheet(Container(
                                          decoration: BoxDecoration(
                                              color: widget.color.primaryColor,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(20),
                                                  topRight:
                                                      Radius.circular(20))),
                                          height: 300.h,
                                          width: 360.w,
                                          padding: EdgeInsets.all(10.sp),
                                          child: Column(
                                            children: [
                                              Text(
                                                'Id variasi: ' +
                                                    (variation
                                                            .sportVariationId)!
                                                        .toStringAsFixed(0),
                                                style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: widget.color
                                                          .primaryTextColor,
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                              variation.subvariations!.isEmpty
                                                  ? Padding(
                                                      padding: EdgeInsets.only(
                                                          top: 100.h),
                                                      child: Center(
                                                        child: Text(
                                                          'Tidak ada subvariasi untuk variasi ini.',
                                                          style: GoogleFonts
                                                              .poppins(
                                                            textStyle: TextStyle(
                                                                color: widget
                                                                    .color
                                                                    .primaryTextColor,
                                                                fontSize: 12.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : SingleChildScrollView(
                                                      child: Column(
                                                        children: variation
                                                            .subvariations!
                                                            .map((subvariation) =>
                                                                Neumorphic(
                                                                    padding: EdgeInsets
                                                                        .all(15
                                                                            .sp),
                                                                    style:
                                                                        NeumorphicStyle(
                                                                      shape: NeumorphicShape
                                                                          .flat,
                                                                      color: widget
                                                                          .color
                                                                          .primaryColor,
                                                                      boxShape:
                                                                          NeumorphicBoxShape.roundRect(
                                                                              BorderRadius.circular(20)),
                                                                    ),
                                                                    margin: EdgeInsets.symmetric(
                                                                        vertical: 10
                                                                            .h),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Text(
                                                                          'Id subvariasi: ' +
                                                                              (subvariation.sportSubVariationId)!.toStringAsFixed(0),
                                                                          style:
                                                                              GoogleFonts.poppins(
                                                                            textStyle: TextStyle(
                                                                                color: widget.color.primaryTextColor,
                                                                                fontSize: 16.sp,
                                                                                fontWeight: FontWeight.w600),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                            height:
                                                                                10.h),
                                                                        Row(
                                                                          children: [
                                                                            Text('Jumlah: ' + (subvariation.amount)!.toStringAsFixed(0),
                                                                                style: GoogleFonts.inter(
                                                                                  textStyle: TextStyle(color: widget.color.tersierTextColor, fontSize: 14, fontWeight: FontWeight.normal),
                                                                                )),
                                                                            SizedBox(width: 20.w),
                                                                            FaIcon(
                                                                              FontAwesomeIcons.levelUpAlt,
                                                                              size: 14.sp,
                                                                              color: widget.color.tersierTextColor,
                                                                            ),
                                                                            Text('Set: ' + subvariation.set!.toStringAsFixed(0),
                                                                                style: GoogleFonts.inter(
                                                                                  textStyle: TextStyle(color: widget.color.tersierTextColor, fontSize: 14, fontWeight: FontWeight.normal),
                                                                                )),
                                                                            SizedBox(width: 20.w),
                                                                            Text(
                                                                              'Durasi: ' + (subvariation.duration!).toStringAsFixed(0) + ' Menit',
                                                                              style: GoogleFonts.inter(
                                                                                textStyle: TextStyle(color: widget.color.tersierTextColor, fontSize: 14.sp, fontWeight: FontWeight.normal),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    )))
                                                            .toList(),
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        ));
                                      },
                                      style: NeumorphicStyle(
                                        depth: 4,
                                        shape: NeumorphicShape.flat,
                                        boxShape: NeumorphicBoxShape.circle(),
                                        color: widget.color.primaryColor,
                                      ),
                                      padding: const EdgeInsets.all(12.0),
                                      child: FaIcon(FontAwesomeIcons.info,
                                          size: 12,
                                          color: widget.color.secondaryColor),
                                    ),
                                  ),
                                ]))
                        .toList(),
                  ),
          ]),
        ),
      )),
    );
  }
}
