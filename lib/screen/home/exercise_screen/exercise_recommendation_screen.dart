import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/controller/exercise_controller.dart';
import 'package:sirkadian_app/model/obejctbox_model.dart/food_exercise_model.dart';
import 'package:sirkadian_app/screen/home/exercise_screen/exercise_detail_screen.dart';
import 'package:sirkadian_app/widget/exercise_widget/exercise_tile.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return DefaultTabController(
      length: 4,
      initialIndex: 0,
      child: Container(
          decoration: BoxDecoration(color: color.bgColor),
          child: GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Scaffold(
                  backgroundColor: color.bgColor,
                  body: Obx(
                    () => exerciseController.isLoadingExerciseAll.isTrue
                        ? Center(
                            child: CircularProgressIndicator(
                              color: color.secondaryColor,
                            ),
                          )
                        : SafeArea(
                            child: Container(
                              padding: EdgeInsets.only(top: 20.h),
                              height: 800.h,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(left: 20.w),
                                          child: NeumorphicButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            style: NeumorphicStyle(
                                              shape: NeumorphicShape.flat,
                                              boxShape:
                                                  NeumorphicBoxShape.circle(),
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
                                                left: 20.w, right: 10.w),
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 20.w),
                                            child: TextFormField(
                                              controller: _searchTextController,
                                              decoration: InputDecoration(
                                                icon: FaIcon(
                                                  FontAwesomeIcons.search,
                                                  size: 16.sp,
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
                                                      fontSize: 14.sp,
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
                                                    size: 16.sp,
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
                                      height: 28.h,
                                    ),
                                    //segment 2
                                    Container(
                                        height: 30.h,
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
                                                width: 60.w,
                                                child: Center(
                                                  child: Text(
                                                    'Semua',
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 60.w,
                                                child: Center(
                                                  child: Text(
                                                    'Ringan',
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 60.w,
                                                child: Center(
                                                  child: Text(
                                                    'Sedang',
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 60.w,
                                                child: Center(
                                                  child: Text(
                                                    'Berat',
                                                  ),
                                                ),
                                              ),
                                            ])),
                                    SizedBox(
                                      height: 18.h,
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
                                                  depth: 4,
                                                  icon: FontAwesomeIcons.trash,
                                                  iconColor: color.redColor,
                                                  containerButton: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ExerciseDetailScreen(
                                                                  color: color,
                                                                  exerciseController:
                                                                      exerciseController,
                                                                  exerciseId: exerciseController
                                                                      .listExercise[
                                                                          index]
                                                                      .sportId!,
                                                                )));
                                                  },
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
                                                      imageFilename:
                                                          exerciseController
                                                              .listExercise[
                                                                  index]
                                                              .imageFilename,
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
                                                      difficulty:
                                                          exerciseController
                                                              .listExercise[
                                                                  index]
                                                              .difficulty,
                                                    );
                                                    exerciseController
                                                        .exerciseStore
                                                        .box<Exercise>()
                                                        .put(exercise);

                                                    Navigator.pop(context);
                                                  },
                                                  onRecom: true,
                                                  imageFilename:
                                                      exerciseController
                                                          .listExercise[index]
                                                          .imageFilename!,
                                                  color: color,
                                                  mets: exerciseController
                                                      .listExercise[index].mets!
                                                      .toString(),
                                                  difficulty: exerciseController
                                                      .listExercise[index]
                                                      .difficulty!,
                                                  desc: exerciseController
                                                      .listExercise[index]
                                                      .desc!,
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
