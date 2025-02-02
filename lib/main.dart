import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:login_app/injection.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureInjection();

  if (!kIsWeb) {
    final directory = await getApplicationDocumentsDirectory();
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: HydratedStorageDirectory(directory.path),
    );
  } else {
    // Fallback storage for web
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: HydratedStorageDirectory.web,
    );
  }

  runApp(MyApp());
}
