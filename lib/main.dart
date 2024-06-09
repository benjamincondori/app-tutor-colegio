import 'package:flutter/material.dart';
import 'package:school_student_app/screens/home/home_screen.dart';
import 'package:school_student_app/screens/login/login_screen.dart';
import 'package:school_student_app/screens/students/students_screen.dart';
import 'package:school_student_app/utils/my_colors.dart';
import 'package:school_student_app/utils/shared_pref.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isLoggedIn = await SharedPref().contains('user');
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatefulWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // fontFamily: 'NimbusSans'
        primarySwatch: MyColors.primarySwatch,
      ),
      title: 'Student App Flutter',
      initialRoute: widget.isLoggedIn ? 'home' : 'login',
      routes: {
        'login': (BuildContext context) => const LoginScreen(),
        'home': (BuildContext context) => const HomeScreen(),
        'home/students': (BuildContext context) => const StudentsListScreen(),
      },
    );
  }
}


