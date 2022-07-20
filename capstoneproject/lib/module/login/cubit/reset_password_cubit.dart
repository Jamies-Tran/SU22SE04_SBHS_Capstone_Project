import 'package:capstoneproject/api/model/reponse_existed.dart';
import 'package:capstoneproject/data/repository/forgot_password_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'reset_password_cubit.freezed.dart';

@injectable
class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  final ForgotPasswordRepository repository;
  ResetPasswordCubit(this.repository)
      : super(const ResetPasswordState.loading());

  Future<void> resetPassword(String phone, String password) async {
    try {
      emit(const ResetPasswordState.loading());
      final data = await repository.resetPassword(
        {
          'phone': phone,
          'newPassword': password,
          'confirmNewPassword' : password
        }
      );
      if (data.success == true)
      {
        emit(const ResetPasswordState.success());
      }
    } on DioError catch (e) {
      ApiResponse data = ApiResponse.fromJson(e.response?.data);
      emit(ResetPasswordState.failed(data.error ?? 'Has error'));
    }
  }
  Future<void> completed() async {
    emit(const ResetPasswordState.loading());
    emit(const ResetPasswordState.completed());
  }
}

@freezed
class ResetPasswordState with _$ResetPasswordState {
  const factory ResetPasswordState.loading() = ResetPasswordStateLoading;
  const factory ResetPasswordState.failed(String error) =
      ResetPasswordStateFailed;
  const factory ResetPasswordState.success() = ResetPasswordStateSuccess;
  const factory ResetPasswordState.completed() = ResetPasswordStateCompleted;
}
