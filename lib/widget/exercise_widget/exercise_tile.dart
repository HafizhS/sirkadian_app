import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/hexcolor_controller.dart';
import '../../controller/exercise_controller.dart';
import '../../model/obejctbox_model.dart/food_model.dart';

class ExerciseTile extends StatefulWidget {
  const ExerciseTile({
    Key? key,
    required this.color,
    required this.size,
    required this.title,
    required this.subtitle_1,
    required this.subtitle_2,
    required this.onRecom,
    required this.imageFilename,
    required this.onpressPlus,
    required this.onpressCheck,
    required this.onpressDelete,
    this.exercise,
  }) : super(key: key);

  final ColorConstantController color;

  final Size size;

  final String title;
  final String subtitle_1;
  final String subtitle_2;
  final String imageFilename;
  final bool onRecom;
  final Exercise? exercise;
  final Function() onpressPlus;
  final Function() onpressCheck;
  final Function() onpressDelete;

  @override
  State<ExerciseTile> createState() => _ExerciseTileState();
}

class _ExerciseTileState extends State<ExerciseTile> {
  final exerciseController = Get.find<ExerciseController>();
  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
          color: widget.color.primaryColor,
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
                    height: widget.size.height * 0.15,
                    width: widget.size.width * 0.3,
                    decoration: BoxDecoration(
                        color: widget.color.backupPrimaryColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: widget.imageFilename == ''
                        ? Icon(Icons.image_not_supported_rounded)
                        : Image.network(widget.imageFilename)),
                SizedBox(
                  width: widget.size.width * 0.02,
                ),
                //segment 2
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: widget.color.primaryTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: widget.size.height * 0.02,
                    ),
                    Row(
                      children: [
                        Text(
                          widget.subtitle_1,
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                color: widget.color.secondaryTextColor,
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        Text(' | '),
                        Text(
                          widget.subtitle_2,
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                color: widget.color.secondaryTextColor,
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
            widget.onRecom
                ? Container(
                    margin: EdgeInsets.only(right: 20, bottom: 20),
                    child: NeumorphicButton(
                        onPressed: widget.onpressPlus,
                        style: NeumorphicStyle(
                          shape: NeumorphicShape.flat,
                          boxShape: NeumorphicBoxShape.circle(),
                          color: widget.color.primaryColor,
                        ),
                        padding: const EdgeInsets.all(10.0),
                        child: FaIcon(
                          FontAwesomeIcons.plus,
                          size: 12,
                          color: widget.color.secondaryTextColor,
                        )))
                : Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10, bottom: 20),
                        child: NeumorphicButton(
                          onPressed: widget.onpressCheck,
                          style: NeumorphicStyle(
                            depth: widget.exercise!.isChecked! ? -4 : 4,
                            shape: NeumorphicShape.flat,
                            boxShape: NeumorphicBoxShape.circle(),
                            color: widget.color.primaryColor,
                          ),
                          padding: const EdgeInsets.all(10.0),
                          child: FaIcon(
                            FontAwesomeIcons.check,
                            size: 12,
                            color: widget.exercise!.isChecked!
                                ? widget.color.secondaryColor
                                : widget.color.secondaryTextColor,
                          ),
                        ),
                      ),
                      !widget.exercise!.isChecked!
                          ? Container(
                              margin: EdgeInsets.only(right: 20, bottom: 20),
                              child: NeumorphicButton(
                                onPressed: widget.onpressDelete,
                                style: NeumorphicStyle(
                                  depth: widget.exercise!.isChecked! ? -4 : 4,
                                  shape: NeumorphicShape.flat,
                                  boxShape: NeumorphicBoxShape.circle(),
                                  color: widget.color.primaryColor,
                                ),
                                padding: const EdgeInsets.all(10.0),
                                child: FaIcon(
                                  FontAwesomeIcons.trash,
                                  size: 12,
                                  color: widget.exercise!.isChecked!
                                      ? widget.color.secondaryTextColor
                                      : widget.color.redColor,
                                ),
                              ),
                            )
                          : Container()
                    ],
                  ),
          ]),
    );
  }
}
