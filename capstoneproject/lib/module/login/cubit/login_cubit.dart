import 'package:bloc/bloc.dart';
import 'package:capstoneproject/shared_code/model/user_response.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../data/repository/login_repository.dart';

part 'login_cubit.freezed.dart';

@injectable
class LoginCubit extends Cubit<LoginState>{
  final LoginRepository repository;
  LoginCubit({
    required this.repository,}) : super(const LoginState.loading()){
  }

  Future<void> login({required String email, required String password}) async {
    try{
      emit(const LoginState.loading());
      Map<String,dynamic> data = {'email':email, 'password': password};
      debugPrint("Login:"+data.toString());
      UserResponse response = await repository.login(username: email, password: password);
      if(response.success == true){
        emit(LoginState.success(response.data!));
      }else{
        emit(LoginState.failure(response.error ?? "Login failed"));
      }
    }catch(e){
      emit(LoginState.failure(e.toString()));
    }
  }

}

@freezed
class LoginState with _$LoginState{
  const factory LoginState.loading() = LoginStateLoading;
  const factory LoginState.success(Data user) = LoginStateSuccess;
  const factory LoginState.failure(String message) = LoginStateFailure;
}