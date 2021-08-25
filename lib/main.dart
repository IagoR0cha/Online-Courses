import 'package:flutter/material.dart';
import 'package:online_course/controller/ImageController.dart';
import 'package:online_course/controller/SignInController.dart';
import 'package:online_course/controller/UserController.dart';
import 'package:online_course/util/PersistenceValidation.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserController(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => SignInController(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => ImageController(),
          lazy: false,
        )
      ],
      child: MaterialApp(
        title: 'Cursos Online',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: PersistenceValidation(),
      ),
    );
  }
}
