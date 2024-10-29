import 'package:injectable/injectable.dart';
import 'package:task_managment_bloc/data/repositories/auth_repo/auth_repo.dart';
import 'package:task_managment_bloc/data/repositories/auth_repo/dev_auth_repo.dart';
import 'package:task_managment_bloc/data/repositories/auth_repo/prod_auth_repo.dart';

@module
abstract class AuthRepoModule {
  @dev
  @lazySingleton
  AuthRepo devAuthRepo() => DevAuthRepo();

  @prod
  @lazySingleton
  AuthRepo prodAuthRepo() => ProdAuthRepo();
}
