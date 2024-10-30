import 'package:injectable/injectable.dart';

import '../../data/repositories/task_repo/task_repo.dart';

import '../../data/repositories/auth_repo/auth_repo.dart';

@module
abstract class TaskModule {
  @dev
  @lazySingleton
  TaskRepo devTaskRepo() => DevTaskRepo();

  @prod
  @lazySingleton
  TaskRepo proTaskRepo() => ProdTaskRepo(prodAuthRepo: ProdAuthRepo());
}
