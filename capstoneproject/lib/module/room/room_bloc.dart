import 'package:capstoneproject/base/base_bloc.dart';
import 'package:capstoneproject/base/base_event.dart';
import 'package:capstoneproject/data/repository/room_repository.dart';
import 'package:capstoneproject/data/service/room_service.dart';
import 'package:capstoneproject/event/base_event/expired_token_event.dart';
import 'package:capstoneproject/event/base_event/no_data_show_event.dart';
import 'package:capstoneproject/event/base_event/unknown_error_event.dart';
import 'package:capstoneproject/module/room/event/room_event.dart';
import 'package:capstoneproject/shared_code/dialog_manager/data_models/type_dialog.dart';
import 'package:capstoneproject/shared_code/dialog_manager/locator.dart';
import 'package:capstoneproject/shared_code/dialog_manager/services/dialog_service.dart';
import 'package:capstoneproject/shared_code/model/room_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class RoomBloc extends BaseBloc with ChangeNotifier {

  final RoomRepository repository;

  final DialogService _dialogService = locator<DialogService>();

  RoomBloc({required this.repository});

  final _roomSubject = BehaviorSubject<BaseEvent>();


  Stream<BaseEvent> get roomStream =>
      _roomSubject.stream;

  Sink<BaseEvent> get roomSink => _roomSubject.sink;


  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      default:
        break;
    }
  }

  Stream<BaseEvent> loadRoomDetail(String id)  {
    getRoom(id);
    return roomStream;
  }

  getRoom(String id) async {
    await repository.getRoomById(id).then(
      (result) async {
        if (result != null) {
          roomSink.add(GetRoomDetail(result));
        } else {
          await doShowDialog(
            description: "Xảy ra lỗi không xác định trong quá trình thực thi",
            event: UnknownErrorEvent(
                message: "Xảy ra lỗi không xác định trong quá trình thực thi"),
            typeDialog: ERROR_DIALOG,
          );
        }
        loadingSink.add(false); // hide loading
      },
      onError: (e) {
        loadingSink.add(false); // hide loading
        print(e);
        if (e == 401 || e == 'unauthorized') {
          doShowDialog(
            description: "Đã hết phiên đăng nhập. Vui lòng đăng nhập lại.",
            event: ExpiredTokenEvent(),
            typeDialog: ERROR_DIALOG,
          );
        } else {
          doShowDialog(
            description: "Xảy ra lỗi không xác định trong quá trình thực thi",
            event: UnknownErrorEvent(
                message: "Xảy ra lỗi không xác định trong quá trình thực thi"),
            typeDialog: ERROR_DIALOG,
          );
        }
      },
    );
  }

  Future<void> doShowDialog(
      {required String description,
      required BaseEvent event,
      String title = '',
      String typeDialog = ''}) async {
    final dialogResult = await _dialogService.showDialog(
      title: title.isNotEmpty ? title : "Thông tin",
      description: description,
      typeDialog: typeDialog.isEmpty ? typeDialog : DIALOG_ONE_BUTTON,
    );

    if (dialogResult.confirmed) {
      // Check event
      handleEventDialog(event);
    } else {
      //print('User do not logout!');
    }
  }

  void handleEventDialog(BaseEvent event) {
    switch (event.runtimeType) {
      case ExpiredTokenEvent:
        // clear Cache
        clearSPrefCache();
        processEventSink.add(ExpiredTokenEvent()); // Notify ExpiredToken
        break;
      case NoDataShowEvent:
        processEventSink.add(NoDataShowEvent());
        break;
      case UnknownErrorEvent:
        final e = event as UnknownErrorEvent;
        processEventSink.add(UnknownErrorEvent(message: e.message));
        break;
      default:
        break;
    }
  }

  Future<void> clearSPrefCache() async {
    // await SPref.instance.set(SPrefCache.KEY_ACCESS_TOKEN, '');
    // await SPref.instance.set(SPrefCache.USER_NAME, '');
  }

}