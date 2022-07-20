import 'package:capstoneproject/base/base_bloc.dart';
import 'package:capstoneproject/base/base_event.dart';
import 'package:capstoneproject/data/repository/home_repository.dart';
import 'package:capstoneproject/event/base_event/expired_token_event.dart';
import 'package:capstoneproject/event/base_event/no_data_show_event.dart';
import 'package:capstoneproject/event/base_event/unknown_error_event.dart';
import 'package:capstoneproject/module/home/ui/home_event.dart';
import 'package:capstoneproject/shared_code/dialog_manager/data_models/type_dialog.dart';
import 'package:capstoneproject/shared_code/dialog_manager/locator.dart';
import 'package:capstoneproject/shared_code/dialog_manager/services/dialog_service.dart';
import 'package:capstoneproject/shared_code/model/category_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';

class HomeBloc extends BaseBloc with ChangeNotifier {
  final HomeRepository homeRepository;

  final DialogService _dialogService = locator<DialogService>();

  HomeBloc({required this.homeRepository}) {
    loadListCategory();
    loadFavoriteIdList();
  }

  final _listCategorySubject = BehaviorSubject<List<CategoryModel>>();

  final _listRoomByCategorySubject = BehaviorSubject<BaseEvent>();

  final _listFavoriteIdSubject = BehaviorSubject<List<int>>();

  Stream<List<CategoryModel>> get listCategoryStream =>
      _listCategorySubject.stream;
  Stream<BaseEvent> get listRoomByCategoryStream =>
      _listRoomByCategorySubject.stream;

  Stream<List<int>> get listFavoriteIdStream => _listFavoriteIdSubject.stream;

  Sink<List<CategoryModel>> get listCategorySink => _listCategorySubject.sink;

  Sink<BaseEvent> get listRoomByCategorySink => _listRoomByCategorySubject.sink;

  Sink<List<int>> get listFavoriteIdSink => _listFavoriteIdSubject.sink;

  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      default:
        break;
    }
  }

  Future<void> loadFavoriteIdList() async {
    print("Data das");

    await homeRepository.getFavoriteListId().then(
      (result) async {
        if (result.isNotEmpty) {
          listFavoriteIdSink.add(result);
          print("Data1 $result");
        } else {
          listFavoriteIdSink.add([]);
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

  Future<void> loadListCategory() async {
    await homeRepository.getCategoryList().then(
      (result) async {
        if (result.isNotEmpty) {
          listCategorySink.add(result);
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

  Stream<BaseEvent> loadListRoomByCategory(String id) {
    getRoom(id);

    return listRoomByCategoryStream;
  }

  getRoom(String id) {
    homeRepository.getRoomByCategory(id).then(
      (result) async {
        if (result.isNotEmpty) {
          listRoomByCategorySink.add(GetRoomEvent(result));
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
