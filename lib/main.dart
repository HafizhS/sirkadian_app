import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../bindings/bindings.dart';
import 'package:get_storage/get_storage.dart';
import '../screen/root_screen.dart';
import 'screen/list_screen.dart';

void main() async {
  await GetStorage.init();
  await GetStorage.init('myData');
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sirkadian App',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const RootScreen(),
      getPages: ListScreen.screens,
      initialBinding: ControllerBinding(),
    );
  }
}
