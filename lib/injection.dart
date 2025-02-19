import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'injection.config.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit(preferRelativeImports: false)
Future<void> configureInjection({String env = 'dev'}) async {
  getIt.allowReassignment = true;

  getIt.init(environment: env);
}
