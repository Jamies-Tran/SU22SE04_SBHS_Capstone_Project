import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/repository/booking_repository.dart';

part 'booking_cubit.freezed.dart';

class BookingCubit extends Cubit<BookingState> {
  final BookingRepository repository;

  BookingCubit({required this.repository})
      : super(const BookingState.loading());

  Future<void> pay({
    required String idRoom,
    required String checkIn,
    required String checkOut,
    required String clientMessage,
    required String cardNumber,
    required String cardExp,
    required String cardCVV,
  }) async {
    try {
      emit(const BookingState.loading());
      final response = await repository.pay(
        idRoom: idRoom,
        checkIn: checkIn,
        checkOut: checkOut,
        clientMessage: clientMessage,
        cardNumber: cardNumber,
        cardExp: cardExp,
        cardCVV: cardCVV,
      );
      if (response.success == true) {
        emit(const BookingState.successful());
      } else {
        emit(BookingState.failure(response.error ?? ''));
      }
    } catch (e) {
      emit(const BookingState.failure(''));
    }
  }
  void completed(){
    emit(const BookingState.loading());
    emit(const BookingState.completed());
  }
}

@freezed
class BookingState with _$BookingState {
  const factory BookingState.loading() = BookingStateLoading;

  const factory BookingState.failure(String message) = BookingStateFailure;

  const factory BookingState.successful() = BookingStateSuccessful;

  const factory BookingState.completed() = BookingStateCompleted;

}
