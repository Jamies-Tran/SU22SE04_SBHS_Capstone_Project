import 'package:capstoneproject/base/base_event.dart';
import 'package:capstoneproject/base/base_widget.dart';
import 'package:capstoneproject/data/repository/favorite_repository.dart';
import 'package:capstoneproject/data/service/favorite_service.dart';
import 'package:capstoneproject/module/favorite/event/favorite_add_event.dart';
import 'package:capstoneproject/module/favorite/event/favorite_remove_event.dart';
import 'package:capstoneproject/module/favorite/favorite_bloc.dart';
import 'package:capstoneproject/module/home/home_bloc.dart';
import 'package:capstoneproject/module/room/ui/room_page.dart';
import 'package:capstoneproject/shared_code/model/room_model.dart';
import 'package:capstoneproject/ui_kit/widget/base_widget/bloc_listener.dart';
import 'package:capstoneproject/ui_kit/widget/hotel_price_text.dart';
import 'package:capstoneproject/ui_kit/widget/ticket_rent.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

class RoomItem extends StatelessWidget {
  const RoomItem({
    Key? key,
    required this.room,
    required this.bloc,
    required this.favoritedList,
  }) : super(key: key);

  final RoomModel room;
  final HomeBloc bloc;
  final List<int> favoritedList;

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      child: RoomItemWidget(
        favoritedList: favoritedList,
        room: room,
        homeBloc: bloc,
      ),
      bloc: const [],
      di: [
        Provider.value(value: FavoriteService()),
        ProxyProvider<FavoriteService, FavoriteRepository>(
          update: (context, service, previous) =>
              FavoriteRepository(favoriteService: service),
        ),
      ],
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<HomeBloc>('bloc', bloc));
  }
}

class RoomItemWidget extends StatelessWidget {
  final RoomModel room;
  final HomeBloc homeBloc;
  final List<int> favoritedList;
  const RoomItemWidget({
    Key? key,
    required this.room,
    required this.homeBloc,
    required this.favoritedList,
  }) : super(key: key);

  handleEvent(BaseEvent event) async {
    if (event is FavoriteAddSuccess) {
      print("FavoriteAddSuccess ");
      await homeBloc.loadFavoriteIdList();
      return;
    }
    if (event is FavoriteRemoveSuccess) {
      print("FavoriteRemoveSuccess ");
      await homeBloc.loadFavoriteIdList();
      return;
    }

    return;
  }

  @override
  Widget build(BuildContext context) {
    bool favorited = favoritedList.contains(room.id);
    return ChangeNotifierProvider<FavoriteBloc>.value(
      value: FavoriteBloc(favoriteRepository: Provider.of(context)),
      child: Consumer<FavoriteBloc>(builder: (context, bloc, child) {
        return BlocListener<FavoriteBloc>(
          listener: handleEvent,
          child: CardRoom(room: room, bloc: bloc, favorited: favorited),
        );
      }),
    );
  }
}

class CardRoom extends StatelessWidget {
  final FavoriteBloc bloc;
  final bool favorited;
  final RoomModel room;
  const CardRoom({
    Key? key,
    required this.bloc,
    required this.favorited,
    required this.room,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => RoomPage(
            id: room.id.toString(),
          ),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Hero(
            tag: Key('https://airj18.skqist225.xyz${room.images![0]}'),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  "https://airj18.skqist225.xyz" + room.images![0],
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: 240,
                ),
              ),
            ),
          ),
          // Positioned(
          //   right: 0,
          //   top: 10,
          //   child: Padding(
          //     padding: const EdgeInsets.all(40),
          //     child: GestureDetector(
          // onTap: () {
          //   if (!favorited) {
          //     bloc.event.add(FavoriteAddEvent(id: room.id.toString()));
          //     print("Add room to favorite + ${room.id}");
          //   } else {
          //     bloc.event.add(FavoriteRemoveEvent(id: room.id.toString()));
          //     print("Remove room from favorite + ${room.id}");
          //   }
          // },
          //       child: Container(
          //         padding: const EdgeInsets.all(8),
          //         decoration: const BoxDecoration(
          //           shape: BoxShape.circle,
          //           color: Colors.white54,
          //         ),
          //         child: favorited
          //             ? const Icon(
          //                 Icons.favorite,
          //                 color: Colors.red,
          //               )
          //             : const Icon(Icons.favorite_border),
          //       ),
          //     ),
          //   ),
          // ),
          Positioned(
            right: 0,
            top: 10,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: LikeButton(
                size: 40,
                circleColor: const CircleColor(
                    start: Color.fromARGB(255, 255, 5, 5), end: Color.fromARGB(255, 204, 0, 0)),
                bubblesColor: const BubblesColor(
                  dotPrimaryColor: Color.fromARGB(255, 229, 51, 51),
                  dotSecondaryColor: Color.fromARGB(255, 204, 0, 0),
                ),
                likeBuilder: (bool isLiked) {
                  return Icon(
                    Icons.favorite,
                    color: favorited ? Colors.redAccent : Colors.white,
                    size: 40,
                  );
                },
                onTap: (v) async {
                  if (!favorited) {
                    bloc.event.add(FavoriteAddEvent(id: room.id.toString()));
                    print("Add room to favorite + ${room.id}");
                  } else {
                    bloc.event.add(FavoriteRemoveEvent(id: room.id.toString()));
                    print("Remove room from favorite + ${room.id}");
                  }
                  return !v;
                },
                //likeCount: 665,
                // countBuilder: (int? count, bool? isLiked, String text) {
                //   var color = favorited ? Colors.redAccent : Colors.grey;
                //   Widget result;
                //   if (count == 0) {
                //     result = Text(
                //       "love",
                //       style: TextStyle(color: color),
                //     );
                //   } else {
                //     result = Text(
                //       text,
                //       style: TextStyle(color: color),
                //     );
                //   }
                //   return result;
                // },
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(40),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.only(top: 200),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.all(8),
                        child: TicketRent(
                          color: Colors.black54,
                          title: 'FOR RENT',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: HotelPriceText(
                            price: room.price!,
                            currencySymbol: room.currencySymbol!),
                      ),
                    ],
                  ),
                  ListTile(
                    title: Text(
                      room.name!,
                      style: titleTextStyle,
                    ),
                    subtitle: Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(room.likedByUsers!.length.toString(),
                              style: const TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
                    trailing: Container(
                      decoration: const BoxDecoration(
                          color: Color(0xfffd8c00), shape: BoxShape.circle),
                      child: Transform.rotate(
                        angle: 25 * 3.1416 / 180,
                        child: IconButton(
                          icon: const Icon(Icons.navigation),
                          onPressed: () {},
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

TextStyle titleTextStyle = const TextStyle(
  color: Colors.black,
  fontSize: 16,
  fontWeight: FontWeight.w500,
);
