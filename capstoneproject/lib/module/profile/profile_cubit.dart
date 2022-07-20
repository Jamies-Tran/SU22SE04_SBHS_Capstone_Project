import 'package:bloc/bloc.dart';
import 'package:capstoneproject/data/repository/user_repository.dart';
import 'package:capstoneproject/shared_code/model/user_response.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../data/repository/login_repository.dart';

part 'profile_cubit.freezed.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UserRepository repository;

  ProfileCubit({
    required this.repository,
  }) : super(const ProfileState.loading()) {}

  Future<void> updateAvatar(String path) async {
    try {
      emit(const ProfileState.loading());
      UserResponse response = await repository.updateAvatar(path);
      if (response.success == true) {
        emit(ProfileState.success(response.data!));
      } else {
        emit(ProfileState.failure(response.error ?? "Update Image Failure."));
      }
    } catch (e) {
      emit(ProfileState.failure(e.toString()));
    }
  }

  Future<void> getUserInfo() async {
    try {
      emit(const ProfileState.loading());
      UserResponse response = await repository.getUserInfo();
      if (response.success == true) {
        emit(ProfileState.success(response.data!));
      } else {
        emit(ProfileState.failure(response.error ?? "Get infomation failed."));
      }
    } catch (e) {
      emit(ProfileState.failure(e.toString()));
    }
  }

  Future<void> updateUser(Map<String, dynamic> data) async {
    try {
      emit(const ProfileState.loading());
      UserResponse response = await repository.updateUser(data);
      if (response.success == true) {
        emit(ProfileState.updateProfileSucessfull(response.data!));
      } else {
        emit(ProfileState.updateProfileFailure(
            response.error ?? "Update User Failure. Please try again!"));
      }
    } catch (e) {
      emit(ProfileState.updateProfileFailure(e.toString()));
    }
  }
}

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.loading() = ProfileStateLoading;
  const factory ProfileState.success(Data user) = ProfileStateSuccess;
  const factory ProfileState.updateProfileSucessfull(Data user) = UpdateProfileStateSucessull;
  const factory ProfileState.updateProfileFailure(String message) = UpdateProfileStateFailure;
  const factory ProfileState.failure(String message) = ProfileStateFailure;

}
