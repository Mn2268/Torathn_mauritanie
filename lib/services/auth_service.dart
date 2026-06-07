import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;
  static final _db = FirebaseFirestore.instance;

  static User? get currentUser => _auth.currentUser;

  static Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return _errorMessage(e.code);
    }
  }

  static Future<String?> register(String email, String password) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      await _db.collection('users').doc(cred.user!.uid).set({
        'email': email.trim(),
        'role': 'user',
        'createdAt': FieldValue.serverTimestamp(),
      });
      return null;
    } on FirebaseAuthException catch (e) {
      return _errorMessage(e.code);
    }
  }

  static Future<String> getUserRole() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return 'guest';
    try {
      final doc = await _db
          .collection('users')
          .doc(uid)
          .get(const GetOptions(source: Source.server))
          .timeout(const Duration(seconds: 8));

      if (!doc.exists) {
        await _db.collection('users').doc(uid).set({
          'email': _auth.currentUser?.email ?? '',
          'role': 'user',
          'createdAt': FieldValue.serverTimestamp(),
        });
        return 'user';
      }

      final role = (doc.data()?['role'] ?? 'user').toString();
      if (role == 'admin') return 'admin';
      return 'user';
    } catch (e) {
      return 'user';
    }
  }

  static Future<void> logout() async {
    await _auth.signOut();
  }

  static String _errorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'Utilisateur introuvable.';
      case 'wrong-password':
      case 'invalid-credential':
        return 'Mot de passe incorrect.';
      case 'email-already-in-use':
        return 'Email déjà utilisé.';
      case 'weak-password':
        return 'Mot de passe trop court (6 caractères min).';
      case 'invalid-email':
        return 'Email invalide.';
      default:
        return 'Erreur ($code).';
    }
  }
}
