import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Stream to listen to auth state changes (user session management)
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Google Sign-In method
  Future<User?> signInWithGoogle() async {
    try {
      // Step 1: Trigger the authentication flow
      print("Triggering Google Sign-In...");
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print("User canceled sign-in");
        return null; // User canceled the sign-in
      }

      print("Google Sign-In success! Getting authentication...");
      // Step 2: Obtain authentication details from request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      print("Google authentication received, creating Firebase credential...");
      // Step 3: Create a new credential
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      print("Signing in to Firebase...");
      // Step 4: Sign in to Firebase with the credential
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      print("Firebase sign-in success! Returning user...");
      return userCredential.user;
    } catch (e) {
      print("Google Sign-In Error: $e");
      return null;
    }
  }

  // Sign-out method
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
