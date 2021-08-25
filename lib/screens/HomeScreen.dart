import 'dart:io';
import 'package:online_course/controller/UserController.dart';
import 'package:online_course/models/User.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../controller/SignInController.dart';

import './SignInScreen.dart';

class HomeScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  DataUser dataUser = new DataUser(email: '', name: '', cpf: '', nivelSchool: '');

  @override
  Widget build(BuildContext context) {
    return Consumer2<SignInController, UserController>(
        builder: (_, signInController, userController, __) {
      return _scaffold(context, signInController, userController);
    });
  }

  _scaffold(context, SignInController signInController, UserController userController) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        title: Text('Cartas'),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                signInController.signOut();

                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (_) {
                  return SignInScreen();
                }));
              },
              icon: Icon(Icons.exit_to_app, color: Colors.white))
        ],
      ),
      body: card(signInController, userController),
    );
  }

  card(SignInController signInController, UserController userController) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(bottom: 16),
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              textInfo('Nome', userController.dataUser.name),
              Divider(
                height: 10,
                color: Colors.white,
              ),
              textInfo('CPF', userController.dataUser.cpf),
              Divider(
                height: 10,
                color: Colors.white,
              ),
              textInfo('Email', userController.dataUser.email),
              Divider(
                height: 10,
                color: Colors.white,
              ),
              textInfo('Nível Escolar', userController.dataUser.nivelSchool),
              Divider(
                height: 10,
                color: Colors.white,
              ),
            ],
          )),
    );
  }

  _cardImage(String imageUrl) {
    return Image.network(imageUrl, fit: BoxFit.cover, width: 250);
  }

  textInfo(String label, String value) {
    return Row(children: [
      Text("$label: ",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              letterSpacing: 1)),
      Text(value,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 20,
              letterSpacing: 1)),
    ]);
  }
}
