// @dart=2.9
import 'package:ambulance_tracker/Animation/FadeAnimation.dart';
import 'package:ambulance_tracker/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'screens/Welcome/welcome_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    )
);
}

