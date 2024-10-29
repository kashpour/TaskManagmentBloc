import 'package:injectable/injectable.dart';
import 'package:task_managment_bloc/data/repositories/auth_repo/prod_auth_repo.dart';
import 'package:task_managment_bloc/data/repositories/task_repo/dev_task_repo.dart';
import 'package:task_managment_bloc/data/repositories/task_repo/prod_task_repo.dart';
import 'package:task_managment_bloc/data/repositories/task_repo/task_repo.dart';

@module
abstract class TaskModule {
  @dev
  @lazySingleton
  TaskRepo devTaskRepo() => DevTaskRepo();

  @prod
  @lazySingleton
  TaskRepo proTaskRepo() => ProdTaskRepo(prodAuthRepo: ProdAuthRepo());
}
