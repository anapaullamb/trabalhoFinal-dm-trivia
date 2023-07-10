import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:login_with_firebase/app/modules/my_application/src/trivia/presenter/controller/trivia_store.dart';
import 'package:login_with_firebase/app/modules/my_application/src/views/categoriaView.dart';

import '../authentication/presenter/controller/auth_store.dart';
import '../trivia/domain/categoria_entity.dart';

class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  @override
  Widget build(BuildContext context) {
    AuthStore authStore = context.watch<AuthStore>();
    TriviaStore triviaStore = context.watch<TriviaStore>();
    triviaStore.getCategorias(userId: authStore.state!.uId!);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuracao trivia'),
        actions: [
          IconButton(onPressed: (){Modular.to.pushNamed('/page2').then((_) => refreshPage());}, icon: Icon(Icons.add))
        ],
      ),
      body: FutureBuilder<List<Categoria>>(
        future: triviaStore.getCategorias(userId: authStore.state!.uId!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Categoria> categorias = snapshot.data!;
            return SingleChildScrollView  (
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: const Text(
                        "Definição de categorias",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      child: Text(
                        "Bem-vindo, "+authStore.state!.name!,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      )
                    ),
                    Container(
                      child: Text(
                        "Pontos coletados: ${authStore.state!.pontuacao!}",
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                      )
                    ),
                    const SizedBox(height: 20),
                    if(categorias.isEmpty)
                      const Card(
                        child: SizedBox(
                          width: 300,
                          height: 50,
                          child: Center(
                            child: Text(
                              "Nenhuma categoria selecionada",
                              style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              ),
                            )
                          ),
                        ),
                      ),
                    if(categorias.isNotEmpty)

                      CategoriaView(
                        categorias: categorias,
                        onEditCategoria: onEditCategoria,
                        refreshPage:refreshPage,
                      ),
                      const SizedBox(height: 20),
                    if(categorias.isNotEmpty)
                      Container(
                        width: 300,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Modular.to.pushNamed('/page4').then((_) => refreshPage());
                          },
                          child: Text("Iniciar jogo"),
                        ),
                      ),
                  ],
                ),
            );
          } else if (snapshot.hasError) {
            return Text('Erro ao carregar as categorias do usuario');
          } else {
            return CircularProgressIndicator();
          }
        }
      ),
    );
  }

  void onEditCategoria({required Categoria categoria}){
    Modular.to.pushNamed('/page3', arguments: categoria).then((_) => refreshPage());
  }
  void refreshPage() {
    setState(() {});
  }

}
