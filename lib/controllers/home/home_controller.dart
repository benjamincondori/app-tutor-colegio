import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../../utils/shared_pref.dart';

class HomeController {
  BuildContext? context;
  final SharedPref _sharedPref = SharedPref();
  late Function refresh;
  User? user;

  Future<void> init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;
    user = User.fromJson(await _sharedPref.read('user'));
    refresh();
  }
  
  logout() {
    _sharedPref.logout(context!);
  }
  
  goToStudentsScreen() {
    Navigator.pop(context!); // Cierra el Drawer
    Navigator.pushNamed(context!, 'home/students');
  }
}
