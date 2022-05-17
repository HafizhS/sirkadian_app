import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/controller/exercise_controller.dart';
import 'package:sirkadian_app/model/exercise_model/exercise_history_request_model.dart';
import 'package:sirkadian_app/model/obejctbox_model.dart/food_model.dart';
import 'package:sirkadian_app/widget/exercise_widget/exercise_tile.dart';

import '../../../controller/hexcolor_controller.dart';

class ExerciseRecommendationScreen extends StatefulWidget {
  const ExerciseRecommendationScreen({Key? key}) : super(key: key);

  @override
  State<ExerciseRecommendationScreen> createState() =>
      _ExerciseRecommendationScreenState();
}

class _ExerciseRecommendationScreenState
    extends State<ExerciseRecommendationScreen> {
  final color = Get.find<ColorConstantController>();
  final exerciseController = Get.find<ExerciseController>();
  TextEditingController _searchTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    exerciseController.getAllExercise();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Container(
          decoration: BoxDecoration(color: color.primaryColor),
          child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                  backgroundColor: color.primaryColor,
                  body: Obx(
                    () => exerciseController.listExercise.isEmpty
                        ? Center(
                            child: CircularProgressIndicator(
                              color: color.secondaryColor,
                            ),
                          )
                        : SafeArea(
                            child: Container(
                              padding: EdgeInsets.only(top: 20),
                              height: size.height,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 20),
                                          child: NeumorphicButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            style: NeumorphicStyle(
                                              shape: NeumorphicShape.flat,
                                              boxShape:
                                                  NeumorphicBoxShape.circle(),
                                              color: color.primaryColor,
                                            ),
                                            padding: const EdgeInsets.all(16.0),
                                            child: FaIcon(
                                              FontAwesomeIcons.chevronLeft,
                                              size: 16,
                                              color: color.secondaryTextColor,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Neumorphic(
                                            style: NeumorphicStyle(
                                                depth: -2,
                                                color: color.secondaryTextColor
                                                    .withOpacity(0.1),
                                                boxShape: NeumorphicBoxShape
                                                    .roundRect(
                                                  BorderRadius.circular(30),
                                                )),
                                            padding: EdgeInsets.only(
                                                left: 20, right: 10),
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: TextFormField(
                                              controller: _searchTextController,
                                              decoration: InputDecoration(
                                                icon: FaIcon(
                                                  FontAwesomeIcons.search,
                                                  size: 16,
                                                  color:
                                                      color.secondaryTextColor,
                                                ),
                                                focusedBorder: InputBorder.none,
                                                border: InputBorder.none,
                                                hintText: 'Cari Olahraga',
                                                hintStyle: GoogleFonts.inter(
                                                  textStyle: TextStyle(
                                                      color: color
                                                          .secondaryTextColor,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                                suffixIcon: IconButton(
                                                  onPressed: () {
                                                    _searchTextController
                                                        .clear();
                                                    FocusScopeNode
                                                        currentFocus =
                                                        FocusScope.of(context);

                                                    if (!currentFocus
                                                        .hasPrimaryFocus) {
                                                      currentFocus.unfocus();
                                                    }
                                                  },
                                                  icon: FaIcon(
                                                    FontAwesomeIcons.times,
                                                    size: 16,
                                                    color: color
                                                        .secondaryTextColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(
                                      height: size.height * 0.03,
                                    ),
                                    //segment 2
                                    Container(
                                        height: 30,
                                        child: TabBar(
                                            indicatorColor:
                                                color.secondaryColor,
                                            indicatorSize:
                                                TabBarIndicatorSize.label,
                                            indicatorWeight: 4,
                                            isScrollable: true,
                                            onTap: (index) {
                                              // setState(() {
                                              //   textDisease.clear();
                                              //   onSearchTextChanged('');
                                              // });
                                            },
                                            tabs: [
                                              SizedBox(
                                                width: size.width * 0.15,
                                                child: Center(
                                                  child: Text(
                                                    'Semua',
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: size.width * 0.15,
                                                child: Center(
                                                  child: Text(
                                                    'Ringan',
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: size.width * 0.15,
                                                child: Center(
                                                  child: Text(
                                                    'Sedang',
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: size.width * 0.15,
                                                child: Center(
                                                  child: Text(
                                                    'Berat',
                                                  ),
                                                ),
                                              ),
                                            ])),
                                    SizedBox(
                                      height: size.height * 0.02,
                                    ),
                                    //segment 3
                                    Expanded(
                                      child: TabBarView(children: [
                                        Container(
                                          child: ListView.builder(
                                              keyboardDismissBehavior:
                                                  ScrollViewKeyboardDismissBehavior
                                                      .onDrag,
                                              itemCount: exerciseController
                                                  .listExercise.length,
                                              itemBuilder: (context, index) {
                                                return ExerciseTile(
                                                  onpressCheck: () {},
                                                  onpressDelete: () {},
                                                  onpressPlus: () {
                                                    final exercise = Exercise(
                                                      name: exerciseController
                                                          .listExercise[index]
                                                          .name,
                                                      desc: exerciseController
                                                          .listExercise[index]
                                                          .desc,
                                                      isChecked: false,
                                                      imageFilename: '',
                                                      date: exerciseController
                                                          .selectedDay
                                                          .toString(),
                                                      sportId:
                                                          exerciseController
                                                              .listExercise[
                                                                  index]
                                                              .sportId,
                                                      mets: exerciseController
                                                          .listExercise[index]
                                                          .mets,
                                                    );
                                                    exerciseController
                                                        .exerciseStore
                                                        .box<Exercise>()
                                                        .put(exercise);

                                                    final exerciseHistoryRequest =
                                                        ExerciseHistoryRequest(
                                                            sportDate:
                                                                '${exerciseController.selectedDay.year}-${exerciseController.selectedDay.month}-${exerciseController.selectedDay.day}',
                                                            sports: []);
//                                                     exerciseController
//                                                         .postExerciseHistory(exerciseHistoryRequest: );
                                                    Navigator.pop(context);
                                                  },
                                                  onRecom: true,
                                                  imageFilename: '',
                                                  color: color,
                                                  subtitle_1: exerciseController
                                                      .listExercise[index].mets!
                                                      .toString(),
                                                  subtitle_2: exerciseController
                                                      .listExercise[index]
                                                      .desc!,
                                                  size: size,
                                                  title: exerciseController
                                                      .listExercise[index]
                                                      .name!,
                                                );
                                              }),
                                        ),
                                        Center(
                                          child: Text('Ringan'),
                                        ),
                                        Center(
                                          child: Text('Sedang'),
                                        ),
                                        Center(
                                          child: Text('Berat'),
                                        ),
                                      ]),
                                    ),
                                  ]),
                            ),
                          ),
                  )))),
    );
  }
}
