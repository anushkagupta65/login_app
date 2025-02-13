import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sign_sphere/firebase_options.dart';
import 'package:sign_sphere/injection.dart';
import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

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
// import 'package:shared_preferences/shared_preferences.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Auth Demo',
//       home: const SignUpScreen(),
//     );
//   }
// }

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});

//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController =
//       TextEditingController();

//   Future<void> _signUp() async {
//     if (_passwordController.text != _confirmPasswordController.text) {
//       ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Passwords do not match')));
//       return;
//     }
//     try {
//       await _auth.createUserWithEmailAndPassword(
//         email: _emailController.text,
//         password: _passwordController.text,
//       );
//       ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Account created successfully')));
//       Navigator.pushReplacement(
//           context, MaterialPageRoute(builder: (_) => const LoginScreen()));
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'email-already-in-use') {
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//             content: Text('Email already in use. Please log in.')));
//       } else {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(content: Text('Error: ${e.message}')));
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Sign Up')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _emailController,
//               decoration: const InputDecoration(labelText: 'Email'),
//               keyboardType: TextInputType.emailAddress,
//             ),
//             TextField(
//               controller: _passwordController,
//               decoration: const InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             TextField(
//               controller: _confirmPasswordController,
//               decoration: const InputDecoration(labelText: 'Confirm Password'),
//               obscureText: true,
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _signUp,
//               child: const Text('Sign Up'),
//             ),
//             TextButton(
//               onPressed: () => Navigator.pushReplacement(context,
//                   MaterialPageRoute(builder: (_) => const LoginScreen())),
//               child: const Text('Already have an account? Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _rememberMe = false;

//   @override
//   void initState() {
//     super.initState();
//     _loadSavedEmail();
//   }

//   Future<void> _loadSavedEmail() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _emailController.text = prefs.getString('email') ?? '';
//       _rememberMe = prefs.getBool('rememberMe') ?? false;
//     });
//   }

//   Future<void> _login() async {
//     try {
//       await _auth.signInWithEmailAndPassword(
//         email: _emailController.text,
//         password: _passwordController.text,
//       );

//       if (_rememberMe) {
//         final prefs = await SharedPreferences.getInstance();
//         await prefs.setString('email', _emailController.text);
//         await prefs.setBool('rememberMe', true);
//       }

//       ScaffoldMessenger.of(context)
//           .showSnackBar(const SnackBar(content: Text('Login successful')));
//     } on FirebaseAuthException catch (e) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('Login failed: ${e.message}')));
//     }
//   }

//   Future<void> _forgotPassword() async {
//     try {
//       await _auth.sendPasswordResetEmail(email: _emailController.text);
//       ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Password reset email sent')));
//     } catch (e) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text('Error: $e')));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Login')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _emailController,
//               decoration: const InputDecoration(labelText: 'Email'),
//               keyboardType: TextInputType.emailAddress,
//             ),
//             TextField(
//               controller: _passwordController,
//               decoration: const InputDecoration(labelText: 'Password'),
//               obscureText: true,
//             ),
//             Row(
//               children: [
//                 Checkbox(
//                   value: _rememberMe,
//                   onChanged: (value) {
//                     setState(() {
//                       _rememberMe = value ?? false;
//                     });
//                   },
//                 ),
//                 const Text('Remember Me'),
//               ],
//             ),
//             ElevatedButton(
//               onPressed: _login,
//               child: const Text('Login'),
//             ),
//             TextButton(
//               onPressed: _forgotPassword,
//               child: const Text('Forgot Password?'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
