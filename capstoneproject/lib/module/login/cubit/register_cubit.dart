import 'package:capstoneproject/data/repository/register_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'register_cubit.freezed.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRepository repository;

  RegisterCubit({required this.repository})
      : super(const RegisterState.loading());

  Future<void> register(Map<String, dynamic> data) async {
    try {
      emit(const RegisterState.loading());
      final response = await repository.register(data: data);
      if (response.success == true) {
        emit(const RegisterState.successful());
      } else {
        emit(RegisterState.failure(response.error ?? ''));
      }
    } catch (e) {
      emit(const RegisterState.failure(''));
    }
  }
  Future<void> completed() async {
    emit(const RegisterStateCompleted());
  }

}


@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState.loading() = RegisterStateLoading;

  const factory RegisterState.failure(String message) = RegisterStateFailure;

  const factory RegisterState.successful() =RegisterStateSuccessful;

  const factory RegisterState.otp() = RegisterStateOtp;

  const factory RegisterState.completed() = RegisterStateCompleted;

}
