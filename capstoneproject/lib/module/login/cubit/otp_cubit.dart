import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../data/repository/otp_repository.dart';

part 'otp_cubit.freezed.dart';

@injectable
class OtpCubit extends Cubit<OtpState> {
  final OTPRepository repository;

  OtpCubit(this.repository) : super(const OtpState.loading());

  Future<void> checkEmail(String email) async {
    try {
      emit(const OtpState.loading());
      final response = await repository.checkEmail(email);
      if (response.success == true) {
        emit(const OtpState.validEmail());
      } else {
        emit(OtpState.invalidEmail(response.error ?? ''));
      }
    } catch (e) {
      emit(const OtpState.invalidEmail(''));
    }
  }

  Future<void> checkPhone(String phone) async {
    try {
      emit(const OtpState.loading());
      final response = await repository.checkPhone(phone);
      if (response.success == true) {
        emit(const OtpState.validPhone());
      } else {
        emit(OtpState.invalidPhone(response.error ?? ''));
      }
    } catch (e) {
      emit(const OtpState.invalidPhone(''));
    }
  }

  Future<void> sendOtp(String phone) async{
    try {
      emit(const OtpState.loading());
      final response = await repository.sendOtp(phone);
      if (response.success == true) {
        emit(const OtpState.sendSuccess());
      } else {
        emit(OtpState.sendFailed(response.error ?? ''));
      }
    } catch (e) {
      emit(const OtpState.sendFailed(''));
    }
  }

  Future<void> verifyOtp(String otp) async{
    try {
      emit(const OtpState.loading());
      final response = await repository.verifyOtp(otp);
      if (response.success == true) {
        emit(const OtpState.verifySuccess());
      } else {
        emit(OtpState.verifyFailed(response.error ?? ''));
      }
    } catch (e) {
      emit(const OtpState.verifyFailed(''));
    }
  }
}

@freezed
class OtpState with _$OtpState {
  const factory OtpState.loading() = OtpStateLoading;

  const factory OtpState.sendFailed(String error) = OtpStateSendFailed;
  const factory OtpState.verifyFailed(String error) = OtpStateVerifyFailed;
  const factory OtpState.sendSuccess() = OtpStateSendSuccess;

  const factory OtpState.verifySuccess() = OtpStateVerifySuccess;

  const factory OtpState.registerFailed(String error) = OtpStateRegisterFailed;
  const factory OtpState.registerSuccess() = OtpStateRegisterSuccess;

  const factory OtpState.validEmail() = OtpStateValidEmail;
  const factory OtpState.invalidEmail(String error) = OtpStateInValidEmail;
  const factory OtpState.validPhone() = OtpStateValidPhone;
  const factory OtpState.invalidPhone(String error) = OtpStateInValidPhone;
}
