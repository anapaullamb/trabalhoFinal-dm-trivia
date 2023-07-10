import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:login_with_firebase/app/modules/my_application/src/authentication/presenter/controller/auth_store.dart';
import 'package:login_with_firebase/app/modules/my_application/src/trivia/domain/categoria_entity.dart';
import 'package:login_with_firebase/app/modules/my_application/src/trivia/model/question_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:login_with_firebase/app/modules/my_application/src/trivia/presenter/controller/trivia_store.dart';

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  late QuestionModel question;
  List<String> answers = [];

  void _mostraDialog(bool isCorrect) {
    final result = isCorrect ? 'Correta' : 'Errada';
    final dialogType = isCorrect ? DialogType.success : DialogType.error;
    AwesomeDialog(
      context: context,
      dialogType: dialogType,
      headerAnimationLoop: false,
      title: 'Resultado',
      desc: 'Sua resposta está $result!',
      btnOkOnPress: () {
        setState(() {});
      },
    ).show();
  }

  void _verificaResposta(option, Function incrementaPontuacao) async {
    final isCorrect = option == question.correctAnswer;
    if(isCorrect){
      await incrementaPontuacao();
    }
    _mostraDialog(isCorrect);
  }
  @override
  Widget build(BuildContext context) {
    AuthStore authStore = context.watch<AuthStore>();
    TriviaStore triviaStore = context.watch<TriviaStore>();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Quiz'),
        ),
        body: FutureBuilder<QuestionModel>(
          future: getData(triviaStore.state!),
          builder: (context, snapshot) {
            if (!snapshot.hasError) {
              if (snapshot.connectionState == ConnectionState.done) {
                question = snapshot.data!;
                return SingleChildScrollView  (
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Text( question.category.replaceAll('_', ' '),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                )),
                            ),
                            Expanded(
                              child: Text( question.difficulty, textAlign: TextAlign.end,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Text( question.text,  style: TextStyle(fontSize: 18)),
                      ),
                      SizedBox(height: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          ...question.answers.map<Widget>((option) => ElevatedButton(
                            onPressed: () {_verificaResposta(option, authStore.userIncrementaPontuacao); },
                            child: Text(option),
                          )),
                        ],
                      ),
                      SizedBox(height: 16),
                      Text( "Pontos: ${authStore.state!.pontuacao!}",   style: TextStyle(fontSize: 12)),
                    ],
                  ),
                );
              } else {
                return waitingIndicator();
              }
            } else {
              return waitingIndicator();
            }
          },
        ));
  }

  Center waitingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

String concatenaCategorias(List<Categoria> categorias){
  String query = "&categories=";
  for (int i = 0; i < categorias.length; i++) {
    if (i > 0) {
      query += ",";
    }
    query += categorias[i].value!;
  }
  return query;
}
Future<QuestionModel> getData(List<Categoria> categorias) async {
  String requestApi = "https://the-trivia-api.com/v2/questions?limit=1${concatenaCategorias(categorias)}";
  print("requestApi: "+requestApi);
  var response = await http.get(Uri.parse(requestApi));
  var json = jsonDecode(response.body);
  QuestionModel question = QuestionModel.fromJson(json[0]);
  question.answers.add(question.correctAnswer);
  print("correctAnswer: "+question.correctAnswer);
  question.answers.shuffle();

  return QuestionModel.fromJson(json[0]);
}