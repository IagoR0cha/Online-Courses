import 'package:flutter/material.dart';
import 'package:online_course/controller/ImageController.dart';
import 'package:provider/provider.dart';

import '../util/env.dart';

import '../controller/SignUpController.dart';

class SignUpScreen extends StatelessWidget {
  SignUpController signupController = SignUpController();

  final _formKey = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String name = '';
  String cpf = '';
  String nivelSchool = '';
  String picture = '';

  Future<void> submit(
      BuildContext context, SignUpController signupController) async {
    await signupController.signUp(email: email, password: password, name: name, cpf: cpf, nivelSchool: nivelSchool, picture: picture);

    Navigator.of(context).pop();
  }

  Future<void> handleGetPicture(BuildContext context, ImageController imageController) async {
    try {
      await imageController.selectImage();
      var urlPic = await imageController.uploadImage();
      picture = urlPic;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        appBar: AppBar(
          title: Text("Cadastrar"),
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
              child: Column(
                  children: [_formInputs(), pictureButton(context), _signUpButton(context)]))),
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
          Divider(),
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
          Divider(),
          TextFormField(
            decoration: InputDecoration(labelText: 'Nome'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Insira seu nome';
              }
            },
            onSaved: (value) {
              name = value!;
            },
          ),
          Divider(),
          TextFormField(
            decoration: InputDecoration(labelText: 'CPF'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Insira seu CPF';
              }
            },
            onSaved: (value) {
              cpf = value!;
            },
          ),
          Divider(),
          TextFormField(
            decoration: InputDecoration(labelText: 'Nível de escolaridade'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Insira seu nível de escolaridade';
              }
            },
            onSaved: (value) {
              nivelSchool = value!;
            },
          ),
        ]));
  }

  pictureButton(context) {
    return Consumer<ImageController>(
      builder: (_, imageController, __) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                await handleGetPicture(context, imageController);
              },
              child: Text('Tirar Foto')
            )
          )
        );
      }
    );
  }

  _signUpButton(context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();

              await submit(context, signupController);
            }
          },
          child: Text("Cadsatrar")
        )
      )
    );
  }
}
