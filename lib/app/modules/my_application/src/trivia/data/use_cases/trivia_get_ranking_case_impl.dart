
import 'package:login_with_firebase/app/modules/my_application/src/trivia/domain/user_ranking_entity.dart';

import '../../domain/services_interfaces/trivia_service_contract.dart';
import '../../domain/use_cases_interfaces/trivia_get_ranking_case_contract.dart';

class TriviaGetRankingCaseImpl implements ITriviaGetRankingCase {
  final ITriviaService _triviaService;

  TriviaGetRankingCaseImpl(this._triviaService);

  @override
  Future<List<UserRanking>> call() async {
    var result = await _triviaService.getRanking();
    return result;
  }
}
