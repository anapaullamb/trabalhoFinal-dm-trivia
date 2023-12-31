import 'package:dartz/dartz.dart';

import '../../../common/errors/errors_classes.dart';
import '../../domain/services_interfaces/auth_service_contract.dart';
import '../../domain/use_cases_interfaces/auth_signin_user_case_contract.dart';
import '../../domain/user_credencial_entity.dart';

class AuthSignInUserCaseImpl implements IAuthSignInUseCase {
  final IAuthService _authService;

  AuthSignInUserCaseImpl(this._authService);

  @override
  Future<Either<Failure, UserCredentialApp>> call(
      String email, String password) async {
    var result = await _authService.signIn(email, password);
    return result;
  }
}
