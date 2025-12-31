import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_college/Repositories/GoogleRepository.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smart_college/services/local/sharedPreference.dart';

import '../../../Models/Request/GoogleRequest.dart';
import '../../../services/local/sharedPreference.dart';
import '../../States/States.dart';
import 'loginScreenViewModel.dart';

class GoogleCubit extends Cubit<States> {
  final GoogleRepository repository;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
    serverClientId: "813623514492-jibeig9a2l5a4gap63um33chv4navsq0.apps.googleusercontent.com",
  );

  GoogleCubit(this.repository) : super(InitialState());

  Future<void> signInWithGoogle({String? role}) async {
    emit(LoadingState(loadingMessage: 'Loading...'));
    try {
      await _googleSignIn.signOut();

      final account = await _googleSignIn.signIn();
      if (account == null) {
        emit(ErrorState(errorMessage: 'Google sign in cancelled'));
        return;
      }

      final auth = await account.authentication;
      final idToken = auth.idToken;
      print("idToken: $idToken");



      if (idToken == null) {
        emit(ErrorState(errorMessage: "No ID Token received from Google"));
        return;
      }

      // ابعت idToken للباك اند
      final response = await repository.google(GoogleLoginRequest(idToken: idToken, role: role!));

      response.fold(
        // في حالة error
            (error) {
          emit(ErrorState(errorMessage: error.error?.message ?? 'Login failed'));
        },
        // في حالة success
            (googleResponse) async {
          final token = googleResponse.token;
          await TokenStorage.saveToken(token);
          final savedToken = await TokenStorage.getToken();
          print("Saved token locally: $savedToken");



          final role = googleResponse.role;
          await TokenStorage.saveRole(role);
          final savedRole = await TokenStorage.getRole();
          print("Saved role locally: $savedRole");


          final id = googleResponse.user.id;
          await TokenStorage.saveId(id);
          final savedId = await TokenStorage.getUserId();
          print("Saved id locally: $savedId");

          final isNew = googleResponse.isNew;
          await TokenStorage.saveIsNew(isNew);
          final savedIsNew= await TokenStorage.getIsNew();
          print("Saved new: $savedIsNew");


          emit(GoogleSuccessState(response: googleResponse));
                },
      );
    } catch (e) {
      emit(ErrorState(errorMessage: "Error: $e"));
    }
  }
}

