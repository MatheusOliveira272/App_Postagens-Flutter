import 'dart:convert';

import 'package:consulta_post/domain/consulta_user.dart';
import 'package:http/http.dart' as http;

class ConsultaUserService {
  Future<List<Usuario?>> buscarUser() async {
    String urlConsulta = "https://jsonplaceholder.typicode.com/users";

    final response = await http.get(Uri.parse(urlConsulta));
    if (response.statusCode == 200) {
      List<dynamic> consulta = jsonDecode(response.body);
      return consulta.map((u) => Usuario.fromJson(u) ).toList();
     
    }
    return [];
  }
}
