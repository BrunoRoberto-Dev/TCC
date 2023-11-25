import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? user = FirebaseAuth.instance.currentUser;

  Future<String?> signUpUsers({
    required String nome,
    required String senha,
    required String email,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: senha);
      userCredential.user!.updateDisplayName(nome);

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return "E-MAIL IS ALREADY REGISTERED";
      }
      if (e.code == 'invalid-email') {
        return "INVALID E-MAIL";
      }
      return 'UNKNOWN ERROR';
    }
  }

  Future<String?> loginUsers({required email, required senha}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: senha);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        return 'INVALID CREDENTIALS';
      }
      ;
    }
  }

  Future<void> logoff() async {
    return _firebaseAuth.signOut();
  }

  Future<String?> forgotPassword({required email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      return 'ENTER E-MAIL';
    }
  }

  Future<String?> redefinePassword({required senha, required novasenha}) async {
    try {
      String? email = FirebaseAuth.instance.currentUser?.email;
      AuthCredential credential =
          EmailAuthProvider.credential(email: email!, password: senha);
      await user!.reauthenticateWithCredential(credential).then((value) {
        user!.updatePassword(novasenha);
      });
      return null;
    } on FirebaseAuthException catch (e) {
      if(e.code == 'channel-error') {
        return 'ENTER CURRENT PASSWORD';
      }
      if(e.code == 'INVALID_LOGIN_CREDENTIALS'){
        return 'INVALID CREDENTIALS';
      };
    }
  }
}
