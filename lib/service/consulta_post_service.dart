import 'dart:convert';

import 'package:consulta_post/domain/consulta_post.dart';
import 'package:http/http.dart' as http;

class ConsultaPostService {
  Future<List<Post?>> buscarPost() async {
    String urlConsulta = "https://jsonplaceholder.typicode.com/posts";

    final response = await http.get(Uri.parse(urlConsulta));
    if (response.statusCode == 200) {
      List<dynamic> consulta = jsonDecode(response.body);
      return consulta.map((p) => Post.fromJson(p) ).toList();
     
    }
    return [];
  }
}
