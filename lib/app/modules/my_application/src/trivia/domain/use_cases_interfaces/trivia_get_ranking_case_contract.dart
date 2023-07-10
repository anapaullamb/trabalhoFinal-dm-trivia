import 'package:dartz/dartz.dart';
import 'package:login_with_firebase/app/modules/my_application/src/trivia/domain/user_ranking_entity.dart';

import '../../../common/errors/errors_classes.dart';
import '../categoria_entity.dart';

abstract class ITriviaGetRankingCase {
  Future<List<UserRanking>> call();
}
