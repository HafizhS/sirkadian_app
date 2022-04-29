import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sirkadian_app/model/auth_model/login_response_model.dart';
import 'package:sirkadian_app/screen/main_screen.dart';

import 'auth/welcome_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  final data = GetStorage('myData');

  var storedDataUser = DataLoginResponse().obs;
  void getData() {
    if (data.read('dataUser') != null) {
      print('ada data');
      var storageDataUser = data.read('dataUser');
      storedDataUser.value = DataLoginResponse.fromJson(storageDataUser);
    } else {
      print('tidak ada data');
    }
  }

  @override
  void initState() {
    super.initState();

    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => storedDataUser.value.id != null ? MainScreen() : WelcomeScreen(),
    );
  }
}
