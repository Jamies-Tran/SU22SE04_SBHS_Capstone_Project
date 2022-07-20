import 'package:capstoneproject/module/home/home_bloc.dart';
import 'package:capstoneproject/module/home/ui/home_event.dart';
import 'package:capstoneproject/module/home/ui/list_view_room.dart';
import 'package:capstoneproject/module/home/ui/room_item.dart';
import 'package:capstoneproject/shared_code/model/room_model.dart';
import 'package:capstoneproject/ui_kit/widget/air_18_loading_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryRooms extends StatefulWidget {
  final String categoryId;
  final HomeBloc homeBloc;
  const CategoryRooms(
      {Key? key, required this.categoryId, ho, required this.homeBloc})
      : super(key: key);

  @override
  State<CategoryRooms> createState() => _CategoryRoomsState();
}

class _CategoryRoomsState extends State<CategoryRooms> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamProvider<Object?>.value(
        initialData: null,
        value: widget.homeBloc.loadListRoomByCategory(widget.categoryId),
        catchError: (context, err) {
          print('Error List');
          return Container();
        },
        child: Consumer<Object?>(builder: (context, data, child) {
          if (data is GetRoomEvent) {
            final items = data.listRoom;
            return ListViewRoom(rooms: items, homeBloc: widget.homeBloc);
          } else {
            return const Center(
              child: Air18LoadingView(),
            );
          }
        }),
      ),
    );
  }
}
