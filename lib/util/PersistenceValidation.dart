import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:online_course/controller/SignInController.dart';

import '../screens/SignInScreen.dart';
import '../screens/HomeScreen.dart';

class PersistenceValidation extends StatefulWidget {
  @override
  Validated createState() => Validated();
}

class Validated extends State<PersistenceValidation> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SignInController>(builder: (_, login, __) {
      if (login.hasAutenticated) {
        return HomeScreen();
      } else {
        return SignInScreen();
      }
    });
  }
}
