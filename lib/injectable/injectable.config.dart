// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../data/repositories/auth_repo/auth_repo.dart' as _i657;
import '../data/repositories/auth_repo/dev_auth_repo.dart' as _i625;
import '../data/repositories/auth_repo/prod_auth_repo.dart' as _i800;
import '../data/repositories/task_repo/dev_task_repo.dart' as _i491;
import '../data/repositories/task_repo/prod_task_repo.dart' as _i219;
import '../data/repositories/task_repo/task_repo.dart' as _i858;
import '../features/auth/bloc/auth_bloc.dart' as _i275;
import '../features/home/bloc/task_bloc.dart' as _i665;

const String _dev = 'dev';
const String _prod = 'prod';

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i657.AuthRepo>(
      () => _i625.DevAuthRepo(),
      registerFor: {_dev},
    );
    gh.factory<_i858.TaskRepo>(
      () => _i491.DevTaskRepo(),
      registerFor: {_dev},
    );
    gh.factory<_i275.AuthBloc>(
        () => _i275.AuthBloc(authRepo: gh<_i657.AuthRepo>()));
    gh.factory<_i657.AuthRepo>(
      () => _i800.ProdAuthRepo(),
      registerFor: {_prod},
    );
    gh.factory<_i665.TaskBloc>(() => _i665.TaskBloc(
          authRepo: gh<_i657.AuthRepo>(),
          taskRepo: gh<_i858.TaskRepo>(),
        ));
    gh.factory<_i858.TaskRepo>(
      () => _i219.ProdTaskRepo(prodAuthRepo: gh<_i657.AuthRepo>()),
      registerFor: {_prod},
    );
    return this;
  }
}
