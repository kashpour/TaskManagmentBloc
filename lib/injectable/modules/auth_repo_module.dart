import 'package:injectable/injectable.dart';
import '../../data/repositories/auth_repo/auth_repo.dart';


@module
abstract class AuthModule {
  @dev
  AuthRepo devAuthRepo() => DevAuthRepo();

  @prod
  AuthRepo prodAuthRepo() => ProdAuthRepo();
}
