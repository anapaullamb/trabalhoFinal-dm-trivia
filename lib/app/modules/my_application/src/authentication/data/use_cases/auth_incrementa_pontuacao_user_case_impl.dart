import 'package:login_with_firebase/app/modules/my_application/src/authentication/domain/use_cases_interfaces/auth_incrementa_pontuacao_user_case_contract.dart';

import '../../domain/services_interfaces/auth_service_contract.dart';
import '../../domain/use_cases_interfaces/auth_signout_user_case_contract.dart';

class AuthIncrementaPontuacaoUserCaseImpl implements IAuthIncrementaPontuacaoUseCase {
  final IAuthService _authService;

  AuthIncrementaPontuacaoUserCaseImpl(this._authService);

  @override
  Future<int> call(String userId, int pontuacao) async => await _authService.incrementaPontuacao(userId, pontuacao);
}
