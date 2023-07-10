import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:login_with_firebase/app/modules/my_application/src/authentication/presenter/controller/auth_store.dart';
import 'package:login_with_firebase/app/modules/my_application/src/common/errors/errors_messagens.dart';
import 'package:login_with_firebase/app/modules/my_application/src/common/messages/messages_app.dart';
import 'package:login_with_firebase/app/modules/my_application/src/trivia/domain/categoria_entity.dart';
import 'package:login_with_firebase/app/modules/my_application/src/trivia/presenter/controller/trivia_store.dart';


class CategoriaForm extends StatelessWidget {
  final List<Categoria> categorias;
  final String textButton;
  final Categoria? categoriaEditar;
  const CategoriaForm({
    super.key,
    required this.categorias,
    required this.textButton,
    this.categoriaEditar,
  });

  @override
  Widget build(BuildContext context) {
    AuthStore authStore = context.watch<AuthStore>();
    TriviaStore triviaStore = context.watch<TriviaStore>();
    Categoria? categoriaSelecionada;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        DropdownButtonFormField<Categoria>(
          value: null,
          hint: Text('Selecione uma categoria'),
          items: categorias.map((categoria) {
            return DropdownMenuItem<Categoria>(
              value: categoria,
              child: Text(categoria!.nome!),
            );
          }).toList(),
          onChanged: (categoria) {
            if (categoria != null) {
              categoriaSelecionada=categoria!;
            }
          },
        ),
        ElevatedButton(
          onPressed: () {
            if(categoriaSelecionada != null){
              if(categoriaEditar == null){
                triviaStore.addCategoria(userId: authStore.state!.uId!, categoria: categoriaSelecionada!);
              }else{
                triviaStore.putCategoria(userId: authStore.state!.uId!, categoriaNova: categoriaSelecionada!, categoriaId: categoriaEditar!.id!);
              }
              //Modular.to.pop(context);
              Navigator.pop(context, true);
            }else{
              MessagesApp.showCustom(context, MessagesError.defaultError);
            }
          },
          child: Text(textButton),
        ),
      ],
    );
  }
}
