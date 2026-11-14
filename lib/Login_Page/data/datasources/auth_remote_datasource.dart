
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_bloc_loginpage/Login_Page/data/model/user_model.dart';

class AuthRemoteDataSource{
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSource({
    required this.firestore,
    required this.firebaseAuth
});

  Future<UserModel> signUP({
    required String name,
    required String email,
    required String password
}) async{
    final credential = await firebaseAuth.createUserWithEmailAndPassword(email: email.trim(), password: password);

    final firebaseUser = credential.user!;

    await firebaseUser.updateDisplayName(name.trim());

    final user = UserModel(uid: firebaseUser.uid, name: name.trim(), email: firebaseUser.email!);

    await firestore.collection('users').doc(firebaseUser.uid).set(user.toJson());

    return user;

  }

  Future<UserModel> signIn({
    required String email,
    required String password,
}) async{

    final credential = await firebaseAuth.signInWithEmailAndPassword(email: email.trim(), password: password);

    final firebaseUser = credential.user!;

    return UserModel(uid: firebaseUser.uid, name: firebaseUser.displayName ?? "", email: email.trim());

  }

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

UserModel? getCurrentUser() {
    final user = firebaseAuth.currentUser;

    if(user == null) return null;
    return UserModel(uid: user.uid, name: user.displayName ?? "", email: user.email ?? '');
}
}