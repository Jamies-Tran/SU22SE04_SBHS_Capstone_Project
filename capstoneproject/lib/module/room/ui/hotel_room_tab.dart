import 'package:capstoneproject/module/room/ui/room_item.dart';
import 'package:flutter/material.dart';
class HotelRoomTab extends StatelessWidget {
  const HotelRoomTab({
    Key? key,
    this.images,
  }) : super(key: key);

  final List<String>? images;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: images!.length,
      itemBuilder: (context, index) => RoomItem(image: images![index]),
    );
  }
}
