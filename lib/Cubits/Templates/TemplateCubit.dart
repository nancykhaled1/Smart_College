import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_college/Cubits/Templates/TemplateStates.dart';
import 'package:smart_college/Repositories/TemplateRepository.dart';

class TemplateCubit extends Cubit<TemplateStates> {
  final TemplateRepository repository;

  TemplateCubit(this.repository) : super(TemplateInitialState());

  Future<void> getTemplates() async {
    emit(TemplateLoadingState(loadingMessage: "جاري تحميل القوالب..."));
    
    final response = await repository.getTemplates();
    
    response.fold(
      (error) {
        emit(TemplateErrorState(
          errorMessage: error.error?.message ?? "حدث خطأ أثناء تحميل القوالب",
        ));
      },
      (templateResponse) {
        emit(TemplateSuccessState(response: templateResponse));
      },
    );
  }

  /// Get template details by ID
  Future<void> getTemplateById(String id) async {
    emit(TemplateDetailLoadingState(loadingMessage: "جاري تحميل تفاصيل القالب..."));
    
    final response = await repository.getTemplateById(id);
    
    response.fold(
      (error) {
        emit(TemplateDetailErrorState(
          errorMessage: error.error?.message ?? "حدث خطأ أثناء تحميل تفاصيل القالب",
        ));
      },
      (templateDetailResponse) {
        emit(TemplateDetailSuccessState(response: templateDetailResponse));
      },
    );
  }
}

