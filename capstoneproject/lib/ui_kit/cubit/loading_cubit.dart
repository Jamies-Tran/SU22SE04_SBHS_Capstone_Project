import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
part 'loading_cubit.freezed.dart';

@injectable
class LoadingCubit extends Cubit<LoadingState>{
  LoadingCubit() : super(const LoadingState.init());

  void showLoading(){
    emit(const LoadingState.loading());
  }
  void hideLoading(){
    emit(const LoadingState.init());
  }
  Future<void> showSuccess() async{
    emit(const LoadingState.success());
    await Future.delayed(const Duration(milliseconds: 800));
    emit(const LoadingState.init());
  }
}
@freezed
class LoadingState with _$LoadingState{
  const factory LoadingState.loading() = LoadingStateLoading;
  const factory LoadingState.failed() = LoadingStateFailed;
  const factory LoadingState.success() = LoadingStateSuccess;
  const factory LoadingState.init() = LoadingStateInit;
}