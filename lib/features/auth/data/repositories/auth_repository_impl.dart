import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  // final FirebaseAuth _auth;
  // final FirebaseFirestore _firestore;

  // AuthRepositoryImpl(this._auth, this._firestore);
  AuthRepositoryImpl();

  @override
  Future<Either<Failure, UserEntity>> signIn(String email, String password) async {
    try {
      // SIMULATION MODE (Normally we would use FirebaseAuth)
      await Future.delayed(const Duration(seconds: 2)); // Network delay

      if (password == 'error') {
        return const Left(AuthFailure('Senha incorreta (Simulação)'));
      }

      // Mock Logic based on email pattern
      String role = 'MEMBRO';
      String uid = 'user_123';

      if (email.contains('admin')) {
        role = 'ADMIN';
        uid = 'admin_001';
      } else if (email.contains('pastor')) {
        role = 'PASTOR';
        uid = 'pastor_001';
      }

      /* 
      REAL IMPLEMENTATION:
      final userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      final doc = await _firestore.collection('users').doc(userCredential.user!.uid).get();
      final data = doc.data()!;
      role = data['role'];
      */

      return Right(UserEntity(
        id: uid,
        email: email,
        role: role,
      ));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<void> signOut() async {
    // await _auth.signOut();
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Future<Either<Failure, UserEntity>> getCurrentUser() async {
    // Mock persistence
    return const Left(AuthFailure('No user logged in'));
  }
}
