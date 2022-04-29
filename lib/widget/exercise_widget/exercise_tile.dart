import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant/color.dart';

class ExerciseTile extends StatelessWidget {
  const ExerciseTile({
    Key? key,
    required this.color,
    required this.size,
    required this.isCheck,
    required this.image,
    required this.title,
    required this.subtitle_1,
    required this.subtitle_2,
  }) : super(key: key);

  final ColorConstantController color;

  final Size size;
  final bool isCheck;
  final String image;
  final String title;
  final String subtitle_1;
  final String subtitle_2;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
          color: color.primaryColor,
          shape: NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.roundRect(
            BorderRadius.circular(20),
          )),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Container(
                    height: size.height * 0.15,
                    width: size.width * 0.3,
                    decoration: BoxDecoration(
                        color: color.backupPrimaryColor,
                        borderRadius: BorderRadius.circular(20)),
                    child:
                        // CachedNetworkImage(
                        //   placeholder: (context, url) =>
                        //       Icon(Icons.image_not_supported_rounded),
                        //   imageUrl: '' == '' ? '' : 'element.imageUrl',
                        //   fit: BoxFit.cover,
                        //   height: size.height * 0.15,
                        //   width: size.width * 0.3,
                        //   errorWidget: (context, url, error) =>
                        //       Icon(Icons.image_not_supported_rounded),
                        // ),
                        Image.asset(
                      'assets/images/$image',
                      fit: BoxFit.cover,
                    )),
                SizedBox(
                  width: size.width * 0.02,
                ),
                //segment 2
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: color.primaryTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    Row(
                      children: [
                        Text(
                          subtitle_1,
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                color: color.secondaryTextColor,
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        Text(' | '),
                        Text(
                          subtitle_2,
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                color: color.secondaryTextColor,
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),

            //segment 3
            Container(
              margin: EdgeInsets.only(right: 20, bottom: 20),
              child: NeumorphicButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: NeumorphicStyle(
                  depth: isCheck ? -4 : 4,
                  shape: NeumorphicShape.flat,
                  boxShape: NeumorphicBoxShape.circle(),
                  color: color.primaryColor,
                ),
                padding: const EdgeInsets.all(10.0),
                child: FaIcon(
                  FontAwesomeIcons.check,
                  size: 12,
                  color:
                      isCheck ? color.secondaryColor : color.secondaryTextColor,
                ),
              ),
            ),
          ]),
    );
  }
}
