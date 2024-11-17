import 'package:injectable/injectable.dart';

import '../../data/repositories/auth_repo/auth_repo.dart';
import '../../data/repositories/task_repo/task_repo.dart';

@module
abstract class TaskModule {
  @dev
  TaskRepo devTaskRepo() => DevTaskRepo();

  @prod
  TaskRepo proTaskRepo() => ProdTaskRepo(prodAuthRepo: ProdAuthRepo());
}
