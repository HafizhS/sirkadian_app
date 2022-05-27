import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/hexcolor_controller.dart';

class ExerciseTile extends StatelessWidget {
  const ExerciseTile({
    Key? key,
    required this.color,
    required this.size,
    required this.title,
    required this.mets,
    required this.difficulty,
    required this.desc,
    required this.onRecom,
    required this.depth,
    required this.iconColor,
    required this.icon,
    required this.imageFilename,
    required this.onpressPlus,
    required this.onpressCheck,
    required this.onpressDelete,
  }) : super(key: key);

  final ColorConstantController color;

  final Size size;

  final String title;
  final String mets;
  final String difficulty;
  final String desc;
  final String imageFilename;
  final bool onRecom;
  final double depth;
  final Color iconColor;
  final IconData icon;
  final Function() onpressPlus;
  final Function() onpressCheck;
  final Function() onpressDelete;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
          color: color.bgColor,
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
                    child: imageFilename == ''
                        ? Icon(Icons.image_not_supported_rounded)
                        : Image.network(
                            imageFilename,
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
                          'Mets: ',
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                color: color.secondaryTextColor,
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        Text(
                          mets,
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                color: color.secondaryTextColor,
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        Text(' | '),
                        Text(
                          difficulty,
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                color: color.secondaryTextColor,
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      desc,
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

            //segment 3
            onRecom
                ? Container(
                    margin: EdgeInsets.only(right: 20, bottom: 20),
                    child: NeumorphicButton(
                        onPressed: onpressPlus,
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.circle(),
                          color: color.bgColor,
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: FaIcon(
                          FontAwesomeIcons.plus,
                          size: 12,
                          color: color.secondaryTextColor,
                        )))
                :
                // Row(
                //     children: [
                // Container(
                //   margin: EdgeInsets.only(right: 10, bottom: 20),
                //   child: NeumorphicButton(
                //     onPressed: onpressCheck,
                //     style: NeumorphicStyle(
                //       depth: exercise!.isChecked! ? -4 : 4,
                //       shape: NeumorphicShape.flat,
                //       boxShape: NeumorphicBoxShape.circle(),
                //       color: color.bgColor,
                //     ),
                //     padding: const EdgeInsets.all(10.0),
                //     child: FaIcon(
                //       FontAwesomeIcons.check,
                //       size: 12,
                //       color: exercise!.isChecked!
                //           ? color.secondaryColor
                //           : color.secondaryTextColor,
                //     ),
                //   ),
                // ),
                // !exercise!.isChecked!
                // ?
                Container(
                    margin: EdgeInsets.only(right: 20, bottom: 20),
                    child: NeumorphicButton(
                      onPressed: onpressDelete,
                      style: NeumorphicStyle(
                        depth: depth,
                        shape: NeumorphicShape.flat,
                        boxShape: NeumorphicBoxShape.circle(),
                        color: color.bgColor,
                      ),
                      padding: const EdgeInsets.all(10.0),
                      child: FaIcon(
                        icon,
                        size: 12,
                        color: iconColor,
                      ),
                    ),
                  )
            //         // : Container()
            //   ],
            // ),
          ]),
    );
  }
}
