import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_college/Models/Request/ResetPasswordRequest.dart';
import 'package:smart_college/Repositories/ResetPasswordRepository.dart';
import '../../States/States.dart';

class SendCodeCubit extends Cubit<States> {
  final ResetPasswordRepository repository;

  SendCodeCubit(this.repository) : super(InitialState());

  TextEditingController codeController = TextEditingController();
  List<TextEditingController> controllers =
  List.generate(6, (index) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());

  bool isCodeComplete = false;
  void checkCodeCompletion() {
    isCodeComplete = controllers.every((controller) => controller.text.isNotEmpty);
    emit(InitialState()); // علشان يعيد بناء الـ UI ويعرف إن في تغيير
  }

  String lastEnteredCode = "";




  String getEnteredCode() {
    return controllers.map((e) => e.text).join();
  }

  Future<void> resetPassword({required String email, required String code}) async {
    emit(LoadingState(loadingMessage: "Loading..."));

    final request = ResetPasswordRequest(
      email: email,
      code: code,
    );

    final response = await repository.resetPassword(request);

    response.fold(
          (error) {
        emit(ErrorState(errorMessage: error.message));
      },
          (data) {
            if (data.success == true) {
              emit(ResetPassSuccessState(response: data));
            } else {
              emit(ErrorState(errorMessage: data.data?.message ?? "حدث خطأ غير متوقع"));
            }

          },
    );
  }
}
