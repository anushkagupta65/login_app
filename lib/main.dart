import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:login_app/firebase_options.dart';
import 'package:login_app/injection.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await configureInjection();

  if (!kIsWeb) {
    final directory = await getApplicationDocumentsDirectory();
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: HydratedStorageDirectory(directory.path),
    );
  } else {
    HydratedBloc.storage = await HydratedStorage.build(
      storageDirectory: HydratedStorageDirectory.web,
    );
  }

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:login_app/src/core/auth_service.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   final AuthService _authService = AuthService();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: StreamBuilder<User?>(
//         stream: _authService.authStateChanges,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.active) {
//             final user = snapshot.data;
//             if (user == null) {
//               return SignInScreen(authService: _authService);
//             } else {
//               return HomeScreen(user: user, authService: _authService);
//             }
//           }
//           return Center(child: CircularProgressIndicator());
//         },
//       ),
//     );
//   }
// }

// class SignInScreen extends StatelessWidget {
//   final AuthService authService;

//   SignInScreen({required this.authService});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Sign In with Google')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             final user = await authService.signInWithGoogle();
//             if (user != null) {
//               print("User signed in: ${user.displayName}");
//             } else {
//               print("Sign-in failed!");
//             }
//           },
//           child: Text('Sign in with Google'),
//         ),
//       ),
//     );
//   }
// }

// class HomeScreen extends StatelessWidget {
//   final User user;
//   final AuthService authService;

//   HomeScreen({required this.user, required this.authService});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Welcome, ${user.displayName}')),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircleAvatar(
//               backgroundImage: NetworkImage(user.photoURL ?? ''),
//               radius: 50,
//             ),
//             SizedBox(height: 20),
//             Text('Welcome, ${user.displayName}'),
//             SizedBox(height: 10),
//             Text('Email: ${user.email}'),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 await authService.signOut();
//                 print("User signed out.");
//               },
//               child: Text('Sign out'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
