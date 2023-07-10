import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:login_with_firebase/app/modules/my_application/src/authentication/presenter/controller/auth_store.dart';
import 'package:login_with_firebase/app/modules/my_application/src/trivia/domain/categoria_entity.dart';
import 'package:login_with_firebase/app/modules/my_application/src/trivia/domain/user_ranking_entity.dart';
import 'package:login_with_firebase/app/modules/my_application/src/trivia/presenter/controller/trivia_store.dart';


class RankingView extends StatelessWidget {
  const RankingView({
    super.key,
    required this.ranking,
  });

  final List<UserRanking> ranking;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: ranking.length,
      itemBuilder: (context, index) {
        return Center(
          child: Card(
            child: SizedBox(
              width: 300,
              height: 50,
              child:
                Center(
                  child: Text(
                    "${ranking[index].nome!}: ${ranking[index].pontuacao!}",
                    style: const TextStyle(
                      fontSize: 18,
                    )
                  )
                ),
            ),
          ),
        );
      },
    );
  }
}
