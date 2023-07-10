
import '../../domain/services_interfaces/trivia_service_contract.dart';
import '../../domain/use_cases_interfaces/trivia_del_categoria_case_contract.dart';

class TriviaDelCategoriaCaseImpl implements ITriviaDelCategoriaCase {
  final ITriviaService _triviaService;

  TriviaDelCategoriaCaseImpl(this._triviaService);

  @override
  Future<void> call(String userId, String categoriaId) async {
    var result = await _triviaService.delCategoria(userId,categoriaId);

    return result;
  }
}
