import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '../../constant/color.dart';
import '../../constant/hex_color.dart';
import '../../controller/food_controller.dart';
import '../../model/obejctbox_model.dart/food_model.dart';
import 'necessity_gauge.dart';

class NecessityDisplayWidget extends StatefulWidget {
  const NecessityDisplayWidget({
    Key? key,
    required this.size,
    required this.color,
    required this.listMeal,
    required this.foodController,
  }) : super(key: key);

  final Size size;
  final ColorConstantController color;
  final List<Food> listMeal;
  final FoodController foodController;

  @override
  State<NecessityDisplayWidget> createState() => _NecessityDisplayWidgetState();
}

class _NecessityDisplayWidgetState extends State<NecessityDisplayWidget> {
  @override
  void initState() {
    super.initState();
    getFoodNecessity();
  }

  @override
  void didUpdateWidget(NecessityDisplayWidget oldWidget) {
    getFoodNecessity();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      height: widget.size.height * 0.75,
      width: double.infinity,
      child: GridView(
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          children: [
            NecessityGauge(
              color: widget.color,
              text: 'Kalori',
              backgroundColor: widget.color.secondaryTextColor.withOpacity(0.3),
              foregroundColor: HexColor.fromHex('#5B9423'),
              value: widget.foodController.energy /
                  (widget.foodController.necessity.value.energy!.breakfast! +
                      widget.foodController.necessity.value.energy!.lunch! +
                      widget.foodController.necessity.value.energy!.dinner!),
              size: Size(widget.size.width * 0.32, widget.size.height * 0.15),
            ),
            NecessityGauge(
              color: widget.color,
              text: 'Karbohidrat',
              backgroundColor: widget.color.secondaryTextColor.withOpacity(0.3),
              foregroundColor: HexColor.fromHex('#895DD1'),
              value: widget.foodController.carbohydrate /
                  (widget.foodController.necessity.value.macro!.breakfast!
                          .carbohydrate! +
                      widget.foodController.necessity.value.macro!.lunch!
                          .carbohydrate! +
                      widget.foodController.necessity.value.macro!.dinner!
                          .carbohydrate!),
              size: Size(widget.size.width * 0.3, widget.size.height * 0.15),
            ),
            NecessityGauge(
              color: widget.color,
              text: 'Protein',
              backgroundColor: widget.color.secondaryTextColor.withOpacity(0.3),
              foregroundColor: HexColor.fromHex('#94223D'),
              value: widget.foodController.protein /
                  (widget.foodController.necessity.value.macro!.breakfast!
                          .protein! +
                      widget.foodController.necessity.value.macro!.lunch!
                          .protein! +
                      widget.foodController.necessity.value.macro!.dinner!
                          .protein!),
              size: Size(widget.size.width * 0.32, widget.size.height * 0.15),
            ),
            NecessityGauge(
              color: widget.color,
              text: 'Lemak',
              backgroundColor: widget.color.secondaryTextColor.withOpacity(0.3),
              foregroundColor: HexColor.fromHex('#D3AA19'),
              value: widget.foodController.fat /
                  (widget.foodController.necessity.value.macro!.breakfast!
                          .fat! +
                      widget.foodController.necessity.value.macro!.lunch!.fat! +
                      widget
                          .foodController.necessity.value.macro!.dinner!.fat!),
              size: Size(widget.size.width * 0.32, widget.size.height * 0.15),
            ),
            NecessityGauge(
              color: widget.color,
              text: 'Serat',
              backgroundColor: widget.color.secondaryTextColor.withOpacity(0.3),
              foregroundColor: HexColor.fromHex('#4E5749'),
              value: widget.foodController.fiber /
                  (widget.foodController.necessity.value.macro!.breakfast!
                          .fiber! +
                      widget
                          .foodController.necessity.value.macro!.lunch!.fiber! +
                      widget.foodController.necessity.value.macro!.dinner!
                          .fiber!),
              size: Size(widget.size.width * 0.32, widget.size.height * 0.15),
            ),

            NecessityGauge(
              color: widget.color,
              text: 'Cairan',
              backgroundColor: widget.color.secondaryTextColor.withOpacity(0.3),
              foregroundColor: HexColor.fromHex('#238094'),
              value: widget.foodController.water /
                  widget.foodController.necessity.value.water!,
              size: Size(widget.size.width * 0.32, widget.size.height * 0.15),
            ),
            // NecessityGauge(
            //   color: widget.color,
            //   text: 'Kalsium',
            //   backgroundColor: widget.color.secondaryTextColor.withOpacity(0.3),
            //   foregroundColor: HexColor.fromHex('#238094'),
            //   value: widget.foodController.calcium /
            //       widget.foodController.necessity.calcium!,
            //   size: Size(widget.size.width * 0.32, widget.size.height * 0.2),
            // ),
            // NecessityGauge(
            //   color: widget.color,
            //   text: 'Zat Besi',
            //   backgroundColor: widget.color.secondaryTextColor.withOpacity(0.3),
            //   foregroundColor: HexColor.fromHex('#238094'),
            //   value: widget.foodController.iron /
            //       widget.foodController.necessity.iron!,
            //   size: Size(widget.size.width * 0.32, widget.size.height * 0.2),
            // ),
            // NecessityGauge(
            //   color: widget.color,
            //   text: 'zinc',
            //   backgroundColor: widget.color.secondaryTextColor.withOpacity(0.3),
            //   foregroundColor: HexColor.fromHex('#238094'),
            //   value: widget.foodController.zinc /
            //       widget.foodController.necessity.zinc!,
            //   size: Size(widget.size.width * 0.32, widget.size.height * 0.2),
            // ),
            // NecessityGauge(
            //   color: widget.color,
            //   text: 'copper',
            //   backgroundColor: widget.color.secondaryTextColor.withOpacity(0.3),
            //   foregroundColor: HexColor.fromHex('#238094'),
            //   value: widget.foodController.copper /
            //       widget.foodController.necessity.copper!,
            //   size: Size(widget.size.width * 0.32, widget.size.height * 0.2),
            // ),
            // NecessityGauge(
            //   color: widget.color,
            //   text: 'vitamin C',
            //   backgroundColor: widget.color.secondaryTextColor.withOpacity(0.3),
            //   foregroundColor: HexColor.fromHex('#238094'),
            //   value: widget.foodController.vitaminC /
            //       widget.foodController.necessity.vitaminC!,
            //   size: Size(widget.size.width * 0.32, widget.size.height * 0.2),
            // ),
            // NecessityGauge(
            //   color: widget.color,
            //   text: 'vitamin B1',
            //   backgroundColor: widget.color.secondaryTextColor.withOpacity(0.3),
            //   foregroundColor: HexColor.fromHex('#238094'),
            //   value: widget.foodController.vitaminB1 /
            //       widget.foodController.necessity.vitaminB1!,
            //   size: Size(widget.size.width * 0.32, widget.size.height * 0.2),
            // ),
            // NecessityGauge(
            //   color: widget.color,
            //   text: 'vitamin B2',
            //   backgroundColor: widget.color.secondaryTextColor.withOpacity(0.3),
            //   foregroundColor: HexColor.fromHex('#238094'),
            //   value: widget.foodController.vitaminB2 /
            //       widget.foodController.necessity.vitaminB2!,
            //   size: Size(widget.size.width * 0.32, widget.size.height * 0.2),
            // ),
            // NecessityGauge(
            //   color: widget.color,
            //   text: 'vitamin B3',
            //   backgroundColor: widget.color.secondaryTextColor.withOpacity(0.3),
            //   foregroundColor: HexColor.fromHex('#238094'),
            //   value: widget.foodController.vitaminB3 /
            //       widget.foodController.necessity.vitaminB3!,
            //   size: Size(widget.size.width * 0.32, widget.size.height * 0.2),
            // ),
            // NecessityGauge(
            //   color: widget.color,
            //   text: 'retinol',
            //   backgroundColor: widget.color.secondaryTextColor.withOpacity(0.3),
            //   foregroundColor: HexColor.fromHex('#238094'),
            //   value: widget.foodController.retinol /
            //       widget.foodController.necessity.retinol!,
            //   size: Size(widget.size.width * 0.32, widget.size.height * 0.2),
            // ),
          ]),
    );
  }

  void getFoodNecessity() {
    widget.foodController.energy = 0;
    widget.foodController.protein = 0;
    widget.foodController.fat = 0;
    widget.foodController.carbohydrate = 0;
    widget.foodController.fiber = 0;
    widget.foodController.water = 0;
    widget.foodController.sodium = 0;
    widget.foodController.calcium = 0;
    widget.foodController.iron = 0;
    widget.foodController.phosphor = 0;
    widget.foodController.potassium = 0;
    widget.foodController.zinc = 0;
    widget.foodController.copper = 0;
    widget.foodController.vitaminC = 0;
    widget.foodController.vitaminB1 = 0;
    widget.foodController.vitaminB2 = 0;
    widget.foodController.vitaminB3 = 0;
    widget.foodController.retinol = 0;
    for (var i = 0; i < widget.listMeal.length; i++) {
      setState(() {
        widget.foodController.energy = widget.foodController.energy +
            (widget.listMeal[i].energy! / widget.listMeal[i].serving!);
        widget.foodController.protein = widget.foodController.protein +
            (widget.listMeal[i].protein! / widget.listMeal[i].serving!);
        widget.foodController.fat = widget.foodController.fat +
            (widget.listMeal[i].fat! / widget.listMeal[i].serving!);
        widget.foodController.carbohydrate = widget
                .foodController.carbohydrate +
            (widget.listMeal[i].carbohydrate! / widget.listMeal[i].serving!);
        widget.foodController.fiber = widget.foodController.fiber +
            (widget.listMeal[i].fiber! / widget.listMeal[i].serving!);
        widget.foodController.water = widget.foodController.water +
            (widget.listMeal[i].water! / widget.listMeal[i].serving!);

        widget.foodController.calcium = widget.foodController.calcium +
            (widget.listMeal[i].calcium! / widget.listMeal[i].serving!);
        widget.foodController.iron = widget.foodController.iron +
            (widget.listMeal[i].iron! / widget.listMeal[i].serving!);
        widget.foodController.phosphor = widget.foodController.phosphor +
            (widget.listMeal[i].phosphor! / widget.listMeal[i].serving!);
        widget.foodController.potassium = widget.foodController.potassium +
            (widget.listMeal[i].potassium! / widget.listMeal[i].serving!);
        widget.foodController.sodium = widget.foodController.sodium +
            (widget.listMeal[i].sodium! / widget.listMeal[i].serving!);
        widget.foodController.zinc = widget.foodController.zinc +
            (widget.listMeal[i].zinc! / widget.listMeal[i].serving!);
        widget.foodController.copper = widget.foodController.copper +
            (widget.listMeal[i].copper! / widget.listMeal[i].serving!);
        widget.foodController.vitaminC = widget.foodController.vitaminC +
            (widget.listMeal[i].vitaminC! / widget.listMeal[i].serving!);
        widget.foodController.vitaminB1 = widget.foodController.vitaminB1 +
            (widget.listMeal[i].vitaminB1! / widget.listMeal[i].serving!);
        widget.foodController.vitaminB2 = widget.foodController.vitaminB2 +
            (widget.listMeal[i].vitaminB2! / widget.listMeal[i].serving!);
        widget.foodController.vitaminB3 = widget.foodController.vitaminB3 +
            (widget.listMeal[i].vitaminB3! / widget.listMeal[i].serving!);
        widget.foodController.retinol = widget.foodController.retinol +
            (widget.listMeal[i].retinol! / widget.listMeal[i].serving!);
        widget.foodController.water = widget.foodController.water +
            (widget.listMeal[i].water! / widget.listMeal[i].serving!);
      });
    }
  }
}
