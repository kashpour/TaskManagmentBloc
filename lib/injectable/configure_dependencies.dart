import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:task_managment_bloc/injectable/configure_dependencies.config.dart';

final getIt = GetIt.instance;
@InjectableInit(
    initializerName: 'init', preferRelativeImports: true, asExtension: true)
void configureDependencies(String env) => getIt.init(environment: env);

abstract class Env {
  static const String dev = 'dev';
  static const String prod = 'prod';
}
