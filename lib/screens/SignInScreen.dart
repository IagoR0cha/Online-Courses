import 'package:flutter/material.dart';
import 'package:online_course/controller/UserController.dart';
import 'package:provider/provider.dart';

import '../util/env.dart';

import '../controller/SignInController.dart';

import '../screens/HomeScreen.dart';
import '../screens/SignUpScreen.dart';

class SignInScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  SignInController signInController = SignInController();

  String? email;
  String? password;

  Future<void> submit(
      BuildContext context, SignInController signInController, UserController userController) async {
    try {
      await signInController.signIn(email: email, password: password);

      if (signInController.currentToken.isNotEmpty) {
        userController.getDateUser(signInController.user.id!);
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
          return HomeScreen();
        }));
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        appBar: AppBar(
          title: Text("Entrar"),
          elevation: 0,
          centerTitle: true,
        ),
        body: _body(context));
  }

  _body(context) {
    return SingleChildScrollView(
      child: Container(
          padding: EdgeInsets.all(48),
          child: Form(
              key: _formKey,
              child: Column(children: [
                _formInputs(),
                _signInButton(context),
                _signUpButton(context)
              ]))),
    );
  }

  _formInputs() {
    return Padding(
        padding: EdgeInsets.all(16),
        child: Column(children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'E-mail'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Insira um e-mail válido';
              }
            },
            onSaved: (value) {
              email = value!;
            },
          ),
          Divider(
            height: 10,
            color: Colors.white,
          ),
          TextFormField(
            decoration: InputDecoration(labelText: 'Senha'),
            autocorrect: false,
            enableSuggestions: false,
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Insira uma senha';
              }
            },
            onSaved: (value) {
              password = value!;
            },
          ),
        ]));
  }

  _signInButton(context) {
    return Consumer<UserController>(
      builder: (_, userController, __) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                }

                await submit(context, signInController, userController);
              },
              child: Text("Entrar")
            )
          )
        );
      }
    );
  }

  _signUpButton(context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => SignUpScreen()));
      },
      child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Cadastrar',
            style: TextStyle(color: Colors.blue),
          )),
    );
  }
}
