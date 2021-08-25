import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../util/env.dart';

class SignUpController {
  Future<void> signUp(
      {String? email, String? password, String? name, String? nivelSchool, String? cpf, String? picture }) async {
    try {
      var url = Uri.https(
        'identitytoolkit.googleapis.com',
        '/v1/accounts:signUp',
        {'key': Env.API_KEY},
      );

      var response = await http.post(
        url,
        body: json.encode({
          "email": email,
          "password": password,
        }),
      );

      print(response.body);
      var userId = json.decode(response.body)["localId"];


      var insertUserUrl = Uri.https(Env.FIREBASE_URL, '/users/$userId.json');

      await http.patch(insertUserUrl,
          body: jsonEncode({
            'email': email,
            'name': name,
            'nivelSchool': nivelSchool,
            'cpf': cpf,
            'picture': picture
          }));
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
