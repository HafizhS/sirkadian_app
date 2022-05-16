import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constant/color.dart';

class FoodTile extends StatelessWidget {
  const FoodTile({
    Key? key,
    required this.color,
    required this.name,
    required this.necessity,
    required this.serving,
    required this.size,
    required this.containerButton,
    required this.iconButton,
    required this.icon,
    required this.imageFilename,
  }) : super(key: key);

  final ColorConstantController color;
  final String name;
  final String necessity;
  final String serving;
  final Size size;
  final IconData icon;
  final String imageFilename;
  final Function() containerButton;
  final Function() iconButton;

  @override
  Widget build(BuildContext context) {
    return NeumorphicButton(
      onPressed: containerButton,
      padding: EdgeInsets.all(0),
      style: NeumorphicStyle(
          color: color.primaryColor,
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
                    : Image.network(imageFilename)),
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
                    // overflow: TextOverflow.ellipsis,
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
                    Text(
                      necessity + ' kkal',
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            color: color.secondaryTextColor,
                            fontSize: 12,
                            fontWeight: FontWeight.normal),
                      ),
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
        Container(
          margin: EdgeInsets.only(right: 20, bottom: 20),
          child: NeumorphicButton(
            onPressed: iconButton,
            style: NeumorphicStyle(
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.circle(),
              color: color.primaryColor,
            ),
            padding: const EdgeInsets.all(10.0),
            child: FaIcon(
              icon,
              size: 12,
              color: color.secondaryColor,
            ),
          ),
        ),
      ]),
    );
  }
}
