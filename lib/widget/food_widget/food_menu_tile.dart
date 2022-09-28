import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../controller/hexcolor_controller.dart';

class FoodMenuTile extends StatelessWidget {
  const FoodMenuTile({
    Key? key,
    required this.color,
    required this.name,
    required this.necessity,
    required this.serving,
    required this.duration,
    required this.containerButton,
    required this.depth,
    required this.imageFilename,
  }) : super(key: key);

  final ColorConstantController color;
  final String name;
  final String necessity;
  final String serving;

  final String duration;

  final double depth;
  final String imageFilename;
  final Function() containerButton;

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onPressed: containerButton,
      padding: EdgeInsets.all(0),
      style: NeumorphicStyle(
          color: color.bgColor,
          shape: NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(20),
          )),
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
      child: Row(
        children: [
          Container(
              height: 80.h,
              width: 80.w,
              decoration: BoxDecoration(
                  color: color.backupPrimaryColor,
                  borderRadius: BorderRadius.circular(20)),
              child: imageFilename == ''
                  ? Icon(Icons.image_not_supported_rounded)
                  : Image.network(
                      imageFilename,
                      fit: BoxFit.cover,
                    )),
          SizedBox(
            width: 10.w,
          ),
          //segment 2
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 200.w,
                child: Text(
                  name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: color.primaryTextColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // FaIcon(
                      //   FontAwesomeIcons.fire,
                      //   color: color.redColor,
                      //   size: 12.sp,
                      // ),
                      Text(
                        ' ' + necessity + ' kkal',
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              color: color.secondaryTextColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                  Text(' | '),
                  Row(
                    children: [
                      // FaIcon(
                      //   FontAwesomeIcons.clock,
                      //   color: color.blueColor,
                      //   size: 12,
                      // ),
                      Text(
                        ' ' +
                            (int.parse(duration) / 60).toStringAsFixed(0) +
                            ' min',
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              color: color.secondaryTextColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    ],
                  ),
                  Text(' | '),
                  Text(
                    serving + ' Porsi',
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          color: color.secondaryTextColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
