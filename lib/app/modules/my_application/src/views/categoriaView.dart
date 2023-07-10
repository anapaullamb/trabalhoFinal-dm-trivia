import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:login_with_firebase/app/modules/my_application/src/authentication/presenter/controller/auth_store.dart';
import 'package:login_with_firebase/app/modules/my_application/src/trivia/domain/categoria_entity.dart';
import 'package:login_with_firebase/app/modules/my_application/src/trivia/presenter/controller/trivia_store.dart';


class CategoriaView extends StatelessWidget {
  const CategoriaView({
    super.key,
    required this.categorias,
    this.onEditCategoria,
    required this.refreshPage,
  });

  final List<Categoria> categorias;
  final void Function({required Categoria categoria})? onEditCategoria;
  final void Function() refreshPage;
  @override
  Widget build(BuildContext context) {
    AuthStore authStore = context.watch<AuthStore>();
    TriviaStore triviaStore = context.watch<TriviaStore>();
    return ListView.builder(
      shrinkWrap: true,
      itemCount: categorias.length,
      itemBuilder: (context, index) {
        return Card(
          child: ExpansionTile(
            title: Text(
              categorias[index].nome!,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      onEditCategoria!(categoria: categorias[index]);
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.amber,
                    ),
                    label: const Text(
                      'Editar',
                      style: TextStyle(color: Colors.amber),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {triviaStore.delCategoria(userId: authStore.state!.uId!, categoriaId: categorias[index].id!);refreshPage(); },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    label: const Text(
                      "Excluir",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
