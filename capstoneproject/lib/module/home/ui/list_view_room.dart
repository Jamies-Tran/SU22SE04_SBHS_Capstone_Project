import 'package:capstoneproject/module/home/home_bloc.dart';
import 'package:capstoneproject/module/home/ui/room_item.dart';
import 'package:capstoneproject/shared_code/model/room_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListViewRoom extends StatelessWidget {
  final List<RoomModel> rooms;
  final HomeBloc homeBloc;
  const ListViewRoom({Key? key, required this.rooms, required this.homeBloc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<Object?>.value(
      initialData: null,
      value: homeBloc.listFavoriteIdStream,
      catchError: (context, err) {
        print('Error List');
        return Container();
      },
      child: Consumer<Object?>(builder: (context, data, child) {
        if (data == null) {
          return const SizedBox.shrink();
        }
        final items = data as List<int>;
        return ListView.builder(
          itemCount: rooms.length,
          padding: const EdgeInsets.only(top: 8),
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            return RoomItem(
              favoritedList: items,
              bloc: homeBloc,
              room: rooms[index],
              key: UniqueKey(),
            );
          },
        );
      }),
    );
  }
}
