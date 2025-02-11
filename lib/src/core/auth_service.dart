import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Google Sign-In
  Future<User?> signInWithGoogle() async {
    try {
      debugPrint("Triggering Google Sign-In...");
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        debugPrint("User canceled sign-in");
        return null;
      }

      debugPrint("Google Sign-In success! Getting authentication...");
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      debugPrint(
          "Google authentication received, creating Firebase credential...");
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      debugPrint("Signing in to Firebase...");
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      debugPrint("Firebase sign-in success! Returning user...");
      return userCredential.user;
    } catch (e) {
      debugPrint("Google Sign-In Error: $e");
      return null;
    }
  }

  /// GitHub Sign-In
  Future<User?> signInWithGitHub() async {
    try {
      debugPrint("Starting GitHub Sign-In...");

      GithubAuthProvider githubProvider = GithubAuthProvider();
      UserCredential userCredential;

      try {
        // Try signing in with GitHub
        if (kIsWeb) {
          userCredential = await _auth.signInWithPopup(githubProvider);
        } else {
          userCredential = await _auth.signInWithProvider(githubProvider);
        }
        return userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == "account-exists-with-different-credential") {
          debugPrint(
              "Account exists with a different credential. Linking accounts...");

          // Get the list of providers already linked to this email
          String email = e.email!;
          List<String> signInMethods =
              await _auth.fetchSignInMethodsForEmail(email);

          if (signInMethods.contains("gmail.com")) {
            // User has signed in with Google before
            GoogleAuthProvider googleProvider = GoogleAuthProvider();
            UserCredential googleCredential =
                await _auth.signInWithProvider(googleProvider);

            // Link GitHub credentials to the existing Google account
            await googleCredential.user?.linkWithCredential(e.credential!);
            debugPrint("GitHub linked to Google account successfully!");
            return googleCredential.user;
          } else {
            debugPrint(
                "User has an existing account with an unknown provider.");
            return null;
          }
        } else {
          debugPrint("GitHub Sign-In Error: ${e.message}");
          return null;
        }
      }
    } catch (e) {
      debugPrint("GitHub Sign-In Error: $e");
      return null;
    }
  }

  /// Sign Out
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    debugPrint("User signed out from Firebase.");
  }
}
