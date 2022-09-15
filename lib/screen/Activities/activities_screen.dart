import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ActivitiesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ActivitiesState();
}

class ActivitiesState extends State<ActivitiesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(child: Text("Activities")),
      ),
    );
  }
}
