import 'package:task_managment_bloc/injectable/injectable.dart';
import 'main.dart' as entry;

void main() {
  configureDependencies(Env.prod);
  entry.main();
}
