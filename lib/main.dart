import 'package:app/constants/colors.dart';
import 'package:app/screens/welcomescreen.dart';
import 'package:app/services/colorservice.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mentry App',
      theme: ThemeData(
        primarySwatch: ColorService.createMaterialColor(CustomColors.purple),
      ),
      home: const WelcomeScreen(),
    );
  }
}
