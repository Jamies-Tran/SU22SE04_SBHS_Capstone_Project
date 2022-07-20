import 'package:capstoneproject/base/base_bloc.dart';
import 'package:capstoneproject/base/base_event.dart';
import 'package:capstoneproject/data/repository/favorite_repository.dart';
import 'package:capstoneproject/event/base_event/expired_token_event.dart';
import 'package:capstoneproject/event/base_event/no_data_show_event.dart';
import 'package:capstoneproject/event/base_event/unknown_error_event.dart';
import 'package:capstoneproject/module/favorite/event/favorite_add_event.dart';
import 'package:capstoneproject/module/favorite/event/favorite_load_data.dart';
import 'package:capstoneproject/module/favorite/event/favorite_remove_event.dart';
import 'package:capstoneproject/shared_code/dialog_manager/data_models/type_dialog.dart';
import 'package:capstoneproject/shared_code/dialog_manager/locator.dart';
import 'package:capstoneproject/shared_code/dialog_manager/services/dialog_service.dart';
import 'package:capstoneproject/shared_code/model/favorite_response_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class FavoriteBloc extends BaseBloc with ChangeNotifier {
  final FavoriteRepository favoriteRepository;

  final DialogService _dialogService = locator<DialogService>();

  FavoriteBloc({required this.favoriteRepository});

  final _listFavoriteIdSubject = BehaviorSubject<List<int>>();

  Stream<List<int>> get listFavoriteIdStream => _listFavoriteIdSubject.stream;

  Sink<List<int>> get listFavoriteIdSink => _listFavoriteIdSubject.sink;

  //
  final _listFavoriteListSubject = BehaviorSubject<BaseEvent>();

  Stream<BaseEvent> get listFavoriteListStream =>
      _listFavoriteListSubject.stream;

  Sink<BaseEvent> get listFavoriteListSink => _listFavoriteListSubject.sink;

  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      case FavoriteAddEvent:
        handleAddFavorite(event);
        break;
      case FavoriteRemoveEvent:
        handleRemoveFavorite(event);
        break;
      default:
        break;
    }
  }

  Stream<BaseEvent> loadFavoriteList() {
    getFavorite();
    return listFavoriteListStream;
  }

  getFavorite() async {
    await favoriteRepository.getFavoriteListItem().then(
      (result) async {
        if (result.isNotEmpty) {
          listFavoriteListSink.add(FavoriteLoadData(result));
        } else {
          print("Xảy ra lỗi không xác định trong quá trình thực thi");
          listFavoriteListSink.add(FavoriteLoadData([]));
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

  Future<void> loadListFavoriteId() async {
    await favoriteRepository.getFavoriteListId().then(
      (result) async {
        if (result.isNotEmpty) {
          listFavoriteIdSink.add(result);
        } else {
          listFavoriteIdSink.add([]);
          // await doShowDialog(
          //   description: "Xảy ra lỗi không xác định trong quá trình thực thi",
          //   event: UnknownErrorEvent(
          //       message: "Xảy ra lỗi không xác định trong quá trình thực thi"),
          //   typeDialog: ERROR_DIALOG,
          // );
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

  void handleAddFavorite(event) async {
    FavoriteAddEvent e = event as FavoriteAddEvent;

    await favoriteRepository.pushFavoriteListId(event.id).then((value) {
      if (value) {
        processEventSink.add(FavoriteAddSuccess());
        
      } else {
        processEventSink.add(FavoriteAddError(e.toString()));
      }
    });
  }

  void handleRemoveFavorite(event) async {
    FavoriteRemoveEvent e = event as FavoriteRemoveEvent;

    await favoriteRepository.removeFavoriteListId(event.id).then((value) {
      if (value) {
        processEventSink.add(FavoriteRemoveSuccess());
      } else {
        processEventSink.add(FavoriteRemoveError(e.toString()));
      }
    });
  }
}
