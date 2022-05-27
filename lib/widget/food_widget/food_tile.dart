import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/hexcolor_controller.dart';

class FoodTile extends StatelessWidget {
  const FoodTile({
    Key? key,
    required this.color,
    required this.name,
    required this.necessity,
    required this.serving,
    required this.recommendationScore,
    required this.duration,
    required this.size,
    required this.containerButton,
    required this.iconButton,
    required this.icon,
    required this.depth,
    required this.imageFilename,
  }) : super(key: key);

  final ColorConstantController color;
  final String name;
  final String necessity;
  final String serving;
  final String recommendationScore;
  final String duration;
  final Size size;
  final IconData icon;
  final double depth;
  final String imageFilename;
  final Function() containerButton;
  final Function() iconButton;

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
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Stack(alignment: Alignment.bottomRight, children: [
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
                Container(
                  width: size.width * 0.5,
                  child: Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: color.primaryTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.fire,
                          color: color.redColor,
                          size: 12,
                        ),
                        Text(
                          ' ' + necessity + ' kkal',
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                color: color.secondaryTextColor,
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                    Text(' | '),
                    Row(
                      children: [
                        FaIcon(
                          FontAwesomeIcons.clock,
                          color: color.blueColor,
                          size: 12,
                        ),
                        Text(
                          ' ' + duration + ' min',
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                color: color.secondaryTextColor,
                                fontSize: 12,
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
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(right: 20, bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FaIcon(
                    FontAwesomeIcons.solidStar,
                    color: color.yellowColor,
                    size: 12,
                  ),
                  Text(
                    ' ' + recommendationScore,
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                          color: color.secondaryTextColor,
                          fontSize: 12,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 20, bottom: 20),
              child: NeumorphicButton(
                onPressed: iconButton,
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
                  color: color.secondaryColor,
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
