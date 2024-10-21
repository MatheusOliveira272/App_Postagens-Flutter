import 'dart:convert';

import 'package:consulta_post/domain/consulta_coment.dart';
import 'package:http/http.dart' as http;

class ConsultaCommentService {
  Future<List<Comentario?>> buscarComent(int postId) async {
    String urlConsulta = "https://jsonplaceholder.typicode.com/comments?postId=$postId";

    final response = await http.get(Uri.parse(urlConsulta));
    //print('Resposta da API: ${response.body}'); 
    if (response.statusCode == 200) {
      List<dynamic> consulta = jsonDecode(response.body);
      return consulta.map((c) => Comentario.fromJson(c) ).toList();
     
    }
    return [];
  }
}
