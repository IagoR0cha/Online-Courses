import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:online_course/models/User.dart';
import 'package:online_course/util/env.dart';
import 'package:http/http.dart' as http;

class UserController extends ChangeNotifier {
  DataUser dataUser = new DataUser(email: '', name: '', cpf: '', nivelSchool: '');

  Future<void> getDateUser(String userId) async {
    try {
      var url = Uri.https(Env.FIREBASE_URL, '/users/$userId.json');

      var resp = await http.get(url);
      var respDataUser = json.decode(resp.body);

      dataUser = new DataUser(
        email: respDataUser['email'],
        name: respDataUser['name'],
        cpf: respDataUser['cpf'],
        nivelSchool: respDataUser['nivelSchool']
      );
      print(dataUser);
    } catch (error) {
      print('deu ruim mané!');
    }

    notifyListeners();
  }
}