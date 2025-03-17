import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:truetask/app/data/models/user_model.dart';
import 'package:truetask/app/data/services/firestore_service.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _googleAuth = GoogleSignIn();
  final _db = FirestoreService();

  Future<void> registerUser(UserModel userModel, String password) async {
    try {
      // Return the user credential when success
      final userCredential = await _auth.createUserWithEmailAndPassword(
          email: userModel.email!, password: password);

      // Set uid to userModel from user credential
      userModel.uid = userCredential.user?.uid ?? '';

      // Store user data to Firestore
      return _db.createUser(userModel);
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  Future<void> loginUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  Future<void> signInGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // If User is new, store user data to Firestore
      if (userCredential.additionalUserInfo!.isNewUser) {
        UserModel userModel = UserModel(
          uid: userCredential.user!.uid,
          name: userCredential.user!.displayName!,
          email: userCredential.user!.email!,
        );
        return _db.createUser(userModel);
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }

  String? getCurrentUserId() {
    return _auth.currentUser!.uid;
  }

  Future<void> userLogout() async {
    try {
      final isGoogleAccount = await _googleAuth.isSignedIn();
      if (isGoogleAccount) {
        await _googleAuth.signOut();
      } else {
        await _auth.signOut();
      }
    } on FirebaseAuthException catch (e) {
      throw Exception(e);
    }
  }
}
