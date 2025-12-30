import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_college/Repositories/GoogleRepository.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smart_college/services/local/sharedPreference.dart';

import '../../../Models/Request/GoogleRequest.dart';
import 'States.dart';

class GoogleCubit extends Cubit<LoginStates> {
  final GoogleRepository repository;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    serverClientId: "813623514492-jibeig9a2l5a4gap63um33chv4navsq0.apps.googleusercontent.com",
  );
  GoogleCubit(this.repository) : super(LoginInitialState());

  Future<void> signInWithGoogle() async {
    emit(LoginLoadingState(loadingMessage: 'Loading........'));
    try {
      final account = await _googleSignIn.signIn();
      if (account == null) {
        emit(LoginErrorState(errorMessage: 'error...'));
        return;
      }
      final auth = await account.authentication;
      final token = auth.idToken;

      if (token == null) {
        emit(LoginErrorState(errorMessage: "No ID Token received"));
        return;
      }

      final response = await repository.google(GoogleLoginRequest(idToken: token));

      response.fold(
        // لو Error
            (error) {
          emit(LoginErrorState(errorMessage: error.error?.message ?? 'Login failed'));
        },
        // لو Success
            (googleResponse) async {
          if (googleResponse.token != null) {
            // Use TokenStorage to save token with the correct key
            await TokenStorage.saveToken(googleResponse.token!);
            final savedToken = await TokenStorage.getToken();
            print("Saved Google token locally: $savedToken");

            emit(GoogleSuccessState(response: googleResponse));
          } else {
            emit(LoginErrorState(errorMessage: googleResponse.message ?? "Login failed"));
          }
        },
      );
    } catch (e) {
      emit(LoginErrorState(errorMessage: "Error: $e"));
    }
  }

}
