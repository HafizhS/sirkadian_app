import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sirkadian_app/controller/exercise_controller.dart';
import 'package:sirkadian_app/model/obejctbox_model.dart/food_model.dart';
import 'package:sirkadian_app/objectbox.g.dart';
import 'package:sirkadian_app/screen/home/exercise_screen/exercise_future_sportPlan_screen.dart';
import 'package:sirkadian_app/screen/home/exercise_screen/exercise_recommendation_screen.dart';
import 'package:sirkadian_app/widget/exercise_widget/exercise_tile.dart';
import 'package:path_provider/path_provider.dart';
import '../../../constant/color.dart';
import '../../../widget/exercise_widget/exercise_gauge.dart';

class ExerciseGeneralScreen extends StatefulWidget {
  const ExerciseGeneralScreen({Key? key}) : super(key: key);

  @override
  State<ExerciseGeneralScreen> createState() => _ExerciseGeneralScreenState();
}

class ExerciseGaugeModel {
  final Color color;
  final String stringValue;
  final String day;
  final double value;

  ExerciseGaugeModel(
      {required this.color,
      required this.stringValue,
      required this.day,
      required this.value});
}

class _ExerciseGeneralScreenState extends State<ExerciseGeneralScreen> {
  final color = Get.find<ColorConstantController>();
  final exerciseController = Get.find<ExerciseController>();

  late Stream<List<Exercise>> _exerciseStream;
  var hasbeeninitialized = false;
  var isExpandedOpen = false;

  @override
  void initState() {
    exerciseController.getDateTime();
    exerciseController.getDatePerWeek();

    getApplicationDocumentsDirectory().then((dir) {
      exerciseController.exerciseStore =
          Store(getObjectBoxModel(), directory: '${dir.path}/exercise');
    }).then((value) => setState(() {
          _exerciseStream = exerciseController.exerciseStore
              .box<Exercise>()
              .query(Exercise_.date
                  .equals(exerciseController.selectedDay.toString()))
              .watch(triggerImmediately: true)
              .map((query) => query.find());
          hasbeeninitialized = true;
        }));

    super.initState();
  }

  @override
  void dispose() {
    //print('-------------------------store Closed------------------------');
    exerciseController.exerciseStore.close();
    hasbeeninitialized = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    exerciseController.getMonth();
    return Scaffold(
      backgroundColor: color.backgroundColor,
      body: SafeArea(
          child: !hasbeeninitialized
              ? Center(
                  child: CircularProgressIndicator(
                    color: color.secondaryColor,
                  ),
                )
              : StreamBuilder<List<Exercise>>(
                  stream: _exerciseStream,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return Center(
                          child: CircularProgressIndicator(
                            color: color.secondaryColor,
                          ),
                        );
                      case ConnectionState.active:
                        return childWidget(context, snapshot, size);
                      case ConnectionState.done:
                        return childWidget(context, snapshot, size);
                    }
                  })),
    );
  }

  SingleChildScrollView childWidget(
    BuildContext context,
    AsyncSnapshot<List<Exercise>> snapshot,
    Size size,
  ) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20),
                child: NeumorphicButton(
                  onPressed: () {
                    Navigator.pop(context);
                    exerciseController.selectedDayGauge = DateTime.utc(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day);
                    exerciseController.getDatePerWeek();
                  },
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    boxShape: NeumorphicBoxShape.circle(),
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
              Text(
                'SirkaExercise',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: color.primaryTextColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 20),
                child: NeumorphicButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FutureExercisePlanScreen(
                                  hasBeenInitialized: hasbeeninitialized,
                                  listExercise: snapshot.data!,
                                )));
                  },
                  style: NeumorphicStyle(
                    shape: NeumorphicShape.flat,
                    boxShape: NeumorphicBoxShape.circle(),
                    color: color.primaryColor,
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: FaIcon(
                    FontAwesomeIcons.calendarAlt,
                    size: 16,
                    color: color.secondaryTextColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          //segment 2
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //segment 2
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Text(
                          'Progress',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: color.secondaryTextColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: color.primaryTextColor.withOpacity(0.1),
                            borderRadius: isExpandedOpen
                                ? BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10))
                                : BorderRadius.circular(10)),
                        margin: EdgeInsets.only(right: 20),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isExpandedOpen = !isExpandedOpen;
                            });
                          },
                          child: Row(
                            children: [
                              Text(
                                exerciseController.selectedDayGauge.day
                                        .isLowerThan(8)
                                    ? 'Minggu 1'
                                    : exerciseController.selectedDayGauge.day
                                            .isLowerThan(15)
                                        ? 'Minggu 2'
                                        : exerciseController
                                                .selectedDayGauge.day
                                                .isLowerThan(22)
                                            ? 'Minggu 3'
                                            : 'Minggu 4',
                                style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                      color: color.primaryTextColor,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              SizedBox(width: size.width * 0.01),
                              FaIcon(
                                isExpandedOpen
                                    ? FontAwesomeIcons.chevronUp
                                    : FontAwesomeIcons.chevronDown,
                                color: color.primaryTextColor.withOpacity(0.7),
                                size: 12,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      AnimatedOpacity(
                        duration: const Duration(milliseconds: 100),
                        opacity: isExpandedOpen ? 1 : 0,
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 100),
                          height: isExpandedOpen ? size.height * 0.07 : 0,
                          margin: isExpandedOpen
                              ? EdgeInsets.symmetric(horizontal: 10)
                              : EdgeInsets.all(0),
                          padding: isExpandedOpen
                              ? EdgeInsets.all(10)
                              : EdgeInsets.all(0),
                          decoration: BoxDecoration(
                              color: color.primaryTextColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(5)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              weekSelectWidget(size, 'Minggu 1', () {
                                setState(() {
                                  exerciseController.selectedDayGauge =
                                      DateTime.utc(DateTime.now().year,
                                          DateTime.now().month, 7);
                                  exerciseController.getDatePerWeek();
                                  isExpandedOpen = false;
                                });
                              }),
                              weekSelectWidget(size, 'Minggu 2', () {
                                setState(() {
                                  exerciseController.selectedDayGauge =
                                      DateTime.utc(DateTime.now().year,
                                          DateTime.now().month, 14);
                                  exerciseController.getDatePerWeek();
                                  isExpandedOpen = false;
                                });
                              }),
                              weekSelectWidget(size, 'Minggu 3', () {
                                setState(() {
                                  exerciseController.selectedDayGauge =
                                      DateTime.utc(DateTime.now().year,
                                          DateTime.now().month, 21);
                                  exerciseController.getDatePerWeek();
                                  isExpandedOpen = false;
                                });
                              }),
                              weekSelectWidget(size, 'Minggu 4', () {
                                setState(() {
                                  exerciseController.selectedDayGauge =
                                      DateTime.utc(DateTime.now().year,
                                          DateTime.now().month, 28);
                                  exerciseController.getDatePerWeek();
                                  isExpandedOpen = false;
                                });
                              }),
                            ],
                          ),
                        ),
                      ),
                      exerciseGaugeWidget(size)
                    ],
                  )
                ],
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 20),
                child: Text(
                  'Rekomendasi Olahraga Mingguan',
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                        color: color.primaryTextColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Container(
                margin:
                    EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 5),
                child: Neumorphic(
                    style: NeumorphicStyle(
                        depth: -4,
                        color: color.backgroundColor,
                        shape: NeumorphicShape.flat,
                        boxShape: NeumorphicBoxShape.roundRect(
                          BorderRadius.circular(20),
                        )),
                    child: Stack(alignment: Alignment.centerLeft, children: [
                      Container(
                        height: size.height * 0.02,
                        width: size.width,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: color.secondaryColor,
                            borderRadius: BorderRadius.circular(20)),
                        height: size.height * 0.02,
                        width: size.width * 0.4,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: size.width * 0.41),
                        child: Text(
                          '70 Menit',
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                color: color.primaryTextColor,
                                fontSize: 10,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    ])),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Text(
                      '0 Menit',
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            color: color.primaryTextColor,
                            fontSize: 12,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    child: Text(
                      '160 Menit',
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                            color: color.primaryTextColor,
                            fontSize: 12,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
            ],
          ),

          //segment 3

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Row(
                      children: [
                        Text(
                          'Olahraga hari ini',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: color.secondaryTextColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          exerciseController.dateNoww,
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                                color: color.secondaryTextColor,
                                fontSize: 14,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ExerciseRecommendationScreen()));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: FaIcon(
                              FontAwesomeIcons.plus,
                              size: 20,
                              color: color.secondaryTextColor,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 20),
                        child: InkWell(
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: FaIcon(
                              FontAwesomeIcons.history,
                              size: 20,
                              color: color.secondaryTextColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              (snapshot.data!.isEmpty)
                  ? Container(
                      height: size.height * 0.4,
                      width: size.width,
                      alignment: Alignment.center,
                      child: Text(
                        'Belum ada Olahraga yang kamu pilih',
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                              color: color.secondaryTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.normal),
                        ),
                      ),
                    )
                  : listExerciseWidget(size, snapshot),
            ],
          )
        ]),
      ),
    );
  }

  Container weekSelectWidget(Size size, String week, Function() onPress) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: color.primaryTextColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: onPress,
        child: Text(
          week,
          style: GoogleFonts.inter(
            textStyle: TextStyle(
                color: color.primaryTextColor,
                fontSize: 12,
                fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
  }

  Container exerciseGaugeWidget(Size size) {
    return Container(
        height: size.height * 0.4,
        width: size.width,
        margin: EdgeInsets.all(20),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: NeverScrollableScrollPhysics(),
            itemCount: exerciseController.weekDays.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.symmetric(
                    horizontal: size.width * 0.035, vertical: 5),
                child: ExerciseGauge(
                    textColor: DateTime.now().day.toString() ==
                            exerciseController.weekDays[index].day
                        ? color.secondaryColor
                        : color.secondaryTextColor,
                    backgroundColor: color.backgroundColor,
                    foregroundColor: exerciseController.weekDays[index].color,
                    value: exerciseController.weekDays[index].value,
                    day: exerciseController.weekDays[index].day,
                    stringValue: exerciseController.weekDays[index].stringValue
                        .toString(),
                    size: size),
              );
            }));
  }

  Widget listExerciseWidget(
    Size size,
    AsyncSnapshot<List<Exercise>> snapshot,
  ) {
    return Container(
      height: size.height * 0.4,
      width: size.width,
      child: ListView.builder(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return ExerciseTile(
              onpressPlus: () {},
              onpressDelete: () {
                if (snapshot.data![index].isChecked == true) {
                  //ga kehapus krn udh di check
                } else {
                  exerciseController.exerciseStore
                      .box<Exercise>()
                      .remove(snapshot.data![index].id);
                }
              },
              onpressCheck: () {
                exerciseController.exerciseStore
                    .box<Exercise>()
                    .remove(snapshot.data![index].id);
                final exercise = Exercise(
                  name: exerciseController.listExercise[index].name,
                  desc: exerciseController.listExercise[index].desc,
                  isChecked: snapshot.data![index].isChecked =
                      !snapshot.data![index].isChecked!,
                  imageFilename: '',
                  date: exerciseController.selectedDay.toString(),
                  sportId: exerciseController.listExercise[index].sportId,
                  mets: exerciseController.listExercise[index].mets,
                );
                exerciseController.exerciseStore.box<Exercise>().put(exercise);
              },
              exercise: snapshot.data![index],
              imageFilename: '',
              onRecom: false,
              color: color,
              subtitle_1: snapshot.data![index].mets.toString(),
              subtitle_2: snapshot.data![index].desc!,
              size: size,
              title: snapshot.data![index].name!,
            );
          }),
    );
  }
}
