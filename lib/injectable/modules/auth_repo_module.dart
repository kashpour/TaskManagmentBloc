import 'package:injectable/injectable.dart';
import '../../data/repositories/auth_repo/auth_repo.dart';


@module
abstract class AuthModule {
  @dev
  @lazySingleton
  AuthRepo devAuthRepo() => DevAuthRepo();

  @prod
  @lazySingleton
  AuthRepo prodAuthRepo() => ProdAuthRepo();
}
