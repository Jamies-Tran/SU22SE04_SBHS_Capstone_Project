import 'package:capstoneproject/data/repository/register_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../api/model/gender_response.dart';

part 'switch_cubit.freezed.dart';

class SwitchCubit extends Cubit<SwitchState> {
  final RegisterRepository registerRepository;
  SwitchCubit({required this.registerRepository}) : super(const SwitchState.loading());

  void reset() {
    emit(const SwitchState.loading());
  }

  String? get item =>
      state.maybeMap(orElse: () => null, loaded: (loaded) => loaded.item);

  List<Gender>? get list =>
      state.maybeMap(orElse: () => null, loaded: (loaded) => loaded.list);


  void selected(String v) {
    if (state is SwitchStateLoaded) {
      final SwitchStateLoaded currentState = state as SwitchStateLoaded;
      emit(currentState.copyWith(item: v));
    }
  }

  // Future<void> setUpGender() async {
  //   try{
  //     final response = await registerRepository.getGender();
  //     if(response.success==true){
  //
  //       emit(SwitchState.loaded(
  //           response.data!,
  //           response.data!.first.id ?? ''));
  //
  //     }
  //   }catch(e){
  //     debugPrint(e.toString());
  //   }
  // }


  Map<String, String> getMap(List<Gender> list) {
    final map = Map<String, String>();
    list.forEach((element) {
      map[element.id!] = element.value!;
    });
    return map;
  }

}

@freezed
class SwitchState with _$SwitchState {
  const factory SwitchState.loading() = SwitchStateLoading;

  const factory SwitchState.loaded(List<Gender> list, String item) =
      SwitchStateLoaded;
}
