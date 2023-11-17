import 'package:flutter/material.dart';
import 'package:nmg_assignment/Resources/color_picker.dart';
import 'package:nmg_assignment/Screens/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    navigateUser();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  /// show splash screen for 2 secs and then move to Dashboard Page
  Future navigateUser() async{
    Future.delayed(const Duration(milliseconds: 2000), (){
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute<void>(builder: (BuildContext context) => const DashboardScreen()),
        ModalRoute.withName('/dashboard'),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
        child: Image.asset(
          'assets/nmg_logo.jpg',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
