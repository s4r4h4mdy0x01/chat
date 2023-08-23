import 'package:chat/pages/cubits/cubit_register/register_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  Future<void> registerUser(
      {required String email, required String password}) async {
    emit(RegisterLoading());
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(
            RegisterFailure(errorMessage: 'The password provided is too weak'));
      } else if (e.code == 'email-already-in-use') {
        emit(RegisterFailure(
            errorMessage: 'The account already exists for that email'));
      }
    } catch (e) {
      emit(RegisterFailure(errorMessage: 'there was an error'));
    }
  }
}
