import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

      // Use Firebase's GitHub authentication with a popup
      GithubAuthProvider githubProvider = GithubAuthProvider();

      UserCredential userCredential;

      if (kIsWeb) {
        // For web, use signInWithPopup
        userCredential = await _auth.signInWithPopup(githubProvider);
      } else {
        // For mobile, use signInWithProvider (no redirect needed)
        userCredential = await _auth.signInWithProvider(githubProvider);
      }

      debugPrint("GitHub sign-in success! Returning user...");
      return userCredential.user;
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
