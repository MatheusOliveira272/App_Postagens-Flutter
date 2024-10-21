// ignore_for_file: unnecessary_null_comparison, unused_local_variable, use_build_context_synchronously, avoid_print

import 'package:consulta_post/domain/consulta_coment.dart';
import 'package:consulta_post/domain/consulta_post.dart';
import 'package:consulta_post/domain/consulta_user.dart';
import 'package:consulta_post/service/consulta_comment_service.dart';
import 'package:consulta_post/service/consulta_post_service.dart';
import 'package:consulta_post/service/consulta_user_service.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const AppPosts());
}

class AppPosts extends StatelessWidget {
  const AppPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppPost',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Aplicação de Postagem'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<bool> _isExpanded;
  List<bool> isExpanded = [];
  List<Post> posts = <Post>[];
  ConsultaPostService consultapostService = ConsultaPostService();
  List<Usuario> users = <Usuario>[];
  ConsultaUserService consultaUserService = ConsultaUserService();
  Map<int, List<Comentario>> postComments = {}; // Mapeia comentários por postId
  ConsultaCommentService consultaCommentService = ConsultaCommentService();

  @override
  void initState() {
    super.initState();
    consultaPost();
    consultaUser();
    _isExpanded =
        List<bool>.filled(posts.length, false); // Inicializa com falses
  }

  void consultaPost() async {
    List<Post>? cp = (await consultapostService.buscarPost()).cast<Post>();
    if (cp != null) {
      setState(() {
        posts = cp;
        _isExpanded = List<bool>.filled(posts.length, false); // Inicializa os posts
      });
    }
  }

  void consultaUser() async {
    List<Usuario>? cu =
        (await consultaUserService.buscarUser()).cast<Usuario>();
    if (cu != null) {
      setState(() {
        users = cu;
      });
    }
  }

  Future<List<Comentario>?> consultaComment(int postId) async {
    List<Comentario>? cc =
        (await consultaCommentService.buscarComent(postId)).cast<Comentario>();
    if (cc != null && cc.isNotEmpty) {
     // print('Comentários encontrados para o postId: $postId: ${cc.length}');
      setState(() {
        postComments[postId] = cc; // Armazenando comentários
      });
      //print('PostComments após a atualização: $postComments'); // Verifiquei aqui
      return cc; // Retorna a lista de comentários
    } else {
      return [];
    }
  }

//busca o usuário com base no ID do post
  Usuario buscUserPorId(int userId) {
    return users.firstWhere((user) => user.id == userId,
        orElse: () => const Usuario()); // Aqui deve retornar um usuário correspondente
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: posts.isEmpty
          ? const Center(
              child:
                  CircularProgressIndicator(), // Mostra um indicador enquanto carrega os dados
            )
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final Post post = posts[index];
                //final Usuario usuario = (index < users.length) ? users[index] : Usuario();
                final List<Comentario> comentariosDoPost = postComments[post.id] ?? []; // Busca os comentários do post
                final Usuario usuario = buscUserPorId(post.userId!);

                //Post...
                return Card(
                  margin: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                          title: Text( 
                            post.title ?? 'Sem título',
                            //textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Conteúdo do post
                        subtitle: Text(
                          post.body ?? 'Sem conteúdo',
                         // textAlign: TextAlign.justify,
                          style: const TextStyle(fontSize: 12.0),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          // Botão para exibir informações do usuário
                          IconButton(
                            icon: const Icon(Icons.account_box_outlined),
                            onPressed: () {
                              setState(() {
                                _isExpanded[index] = !_isExpanded[index]; // Aumeta o tamnho do post
                              });
                            },
                          ),
                        //Onde aparecee as informações do usuário ...
                          _isExpanded[index]
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Informações do autor do post: ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Username: ${usuario.username ?? 'Sem username'}',
                                        ),
                                        Text(
                                            'Nome: ${usuario.name ?? 'Sem nome'}'),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(),

                          /*  // Botão para exibir informações do usuário com o dialog mas ficou estranho
                          IconButton(
                            icon: const Icon(Icons.account_box_outlined),
                            onPressed: () {
                                                           showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                        usuario.username ?? 'Sem username'),
                                    content: Text(usuario.name ?? 'Sem nome'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Fechar'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),*/

                          // Botão para exibir comentários
                          IconButton(
                            icon: const Icon(Icons.add_comment_outlined),
                            onPressed: () async {
                              if (post.id != null) {
                                await consultaComment(post.id!); // await = aguarda a busca de comentários

                                final List<Comentario> comentariosDoPost = postComments[post.id] ?? [];
                              
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      padding: const EdgeInsets.all(20.0),
                                      height: 350,
                                      child: comentariosDoPost.isNotEmpty
                                          ? ListView.builder(
                                              itemCount:
                                                  comentariosDoPost.length,
                                              itemBuilder: (context, index) {
                                                final comentario =
                                                    comentariosDoPost[index];
                                                return Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Nome: ${comentario.name ?? 'Sem nome'}',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    Text(
                                                      'Email: ${comentario.email ?? 'Sem email'}',
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    const Text('Comentário: ',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    Text(comentario.body ??
                                                        'Sem comentários'),
                                                    const Divider(),
                                                  ],
                                                );
                                              },
                                            )
                                          : const Center(
                                              child: Text('Nenhum comentário disponível')),
                                    );
                                  },
                                );
                              } else {
                                print('ID do post é nulo');
                              }
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
