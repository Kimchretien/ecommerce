import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:firebase_core/firebase_core.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  
//Login With Email and Password

  Future<void> loginWithEmailAndPassword(String email, String password) async {
  await _firebaseAuth.signInWithEmailAndPassword(
    email: email,
    password: password,
  );
}

//Logout
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  } 

  //create user with email and password
  Future<void> createUserWithEmailAndPassword(String email, String password) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  //SIGN IN WITH GOOGLE
Future <dynamic> signInWithGoogle() async{
 try{
     final GoogleSignInAccount ? googleUser = await GoogleSignIn().signIn();

     final GoogleSignInAuthentication ?googleAuth = await googleUser?.authentication;


     final credential =GoogleAuthProvider.credential(

      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
     );

     return await _firebaseAuth.signInWithCredential(credential);
    }on Exception catch(e){
      print('exception->$e');
    }
  }

}
