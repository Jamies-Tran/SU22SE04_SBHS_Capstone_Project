import 'package:capstoneproject/base/base_bloc.dart';
import 'package:capstoneproject/base/base_event.dart';
import 'package:capstoneproject/data/repository/booking_repository.dart';
import 'package:capstoneproject/module/booking/event/booking_event.dart';
import 'package:capstoneproject/shared_code/dialog_manager/data_models/type_dialog.dart';
import 'package:capstoneproject/shared_code/dialog_manager/locator.dart';
import 'package:capstoneproject/shared_code/dialog_manager/services/dialog_service.dart';
import 'package:capstoneproject/shared_code/model/booked_rooms.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class BookingBloc extends BaseBloc with ChangeNotifier {
  final BookingRepository bookingRepository;

  BookingBloc({required this.bookingRepository}) {
    loadBookedHistoryList();
  }

  final DialogService _dialogService = locator<DialogService>();

  final _bookingRoomSubject = BehaviorSubject<BaseEvent>();

  final _getBookingRoomSubject = BehaviorSubject<List<BookedRooms>>();

  Stream<BaseEvent> get bookingRoomStream => _bookingRoomSubject.stream;

  Stream<List<BookedRooms>> get getbookingRoomStream =>
      _getBookingRoomSubject.stream;

  Sink<List<BookedRooms>> get listFavoriteIdSink => _getBookingRoomSubject.sink;

  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      case BookingEvent:
        handleBooking(event);
        break;
      case CancleBookingEvent:
        handleCancleBooking(event);
        break;
      default:
        break;
    }
  }

  void handleCancleBooking(BaseEvent event) async {
    CancleBookingEvent e = event as CancleBookingEvent;

    await bookingRepository.cancelBookingId(e.id).then((value) {
      doShowDialog(
          description: value.data!, typeDialog: DIALOG_CONGRATULATE_BUTTON);
    }, onError: (e) {
      doShowDialog(
          description: 'Booking fail !!!\nError: $e',
          typeDialog: DIALOG_ONE_BUTTON);
    });
  }

  Future<void> loadBookedHistoryList() async {
    await bookingRepository.getAllBookingHistory().then(
      (result) async {
        if (result.bookedRooms!.isNotEmpty) {
          listFavoriteIdSink.add(result.bookedRooms!);
          print("Data1 $result");
        } else {
          print("Xảy ra lỗi không xác định trong quá trình thực thi");
        }
        loadingSink.add(false); // hide loading
      },
      onError: (e) {
        loadingSink.add(false); // hide loading
        print(e);
        if (e == 401 || e == 'unauthorized') {
          print("Error: $e");
        } else {
          print("Error: $e");
        }
      },
    );
  }

  Future<void> doShowDialog(
      {required String description,
      BaseEvent? event,
      String title = '',
      String typeDialog = ''}) async {
    final dialogResult = await _dialogService.showDialog(
      title: title.isNotEmpty ? title : 'Info',
      description: description,
      typeDialog: typeDialog.isNotEmpty ? typeDialog : DIALOG_TWO_BUTTON,
    );

    if (dialogResult.confirmed) {
      handleEventDialog(event);
    } else {
      print('User do not logout!');
    }
  }

  void handleEventDialog(BaseEvent? event) {
    switch (event.runtimeType) {
      default:
        break;
    }
  }

  void handleBooking(BaseEvent event) async {
    BookingEvent e = event as BookingEvent;
    await bookingRepository
        .pushBookingRoom(
      e.idRoom,
      e.checkIn,
      e.checkOut,
      e.numberOfDays,
    )
        .then((value) {
      doShowDialog(
          description: 'Booking successfull !!!',
          typeDialog: DIALOG_CONGRATULATE_BUTTON);
    }, onError: (e) {
      doShowDialog(
          description: 'Booking fail !!!', typeDialog: DIALOG_ONE_BUTTON);
    });
  }
}
