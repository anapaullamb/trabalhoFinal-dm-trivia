
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:login_with_firebase/app/modules/my_application/src/authentication/presenter/controller/auth_store.dart';
import 'package:login_with_firebase/app/modules/my_application/src/trivia/domain/categoria_entity.dart';
import 'package:login_with_firebase/app/modules/my_application/src/trivia/presenter/controller/trivia_store.dart';
import 'package:login_with_firebase/app/modules/my_application/src/views/categoriaForm.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    TriviaStore triviaStore = context.watch<TriviaStore>();
    AuthStore authStore = context.watch<AuthStore>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Categoria Favorita'),
      ),
      body: FutureBuilder<List<Categoria>>(
        future: triviaStore.getDominioCategorias(userId: authStore.state!.uId!),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Categoria> categorias = snapshot.data!;
            return SingleChildScrollView  (
              padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
              child: CategoriaForm(textButton: 'Adicionar categoria favorita', categorias: categorias),
            );
          } else if (snapshot.hasError) {
          return Text('Erro ao carregar as categorias');
          } else {
          return CircularProgressIndicator();
          }
        }
      ),
    );
  }
}

