import 'package:capstoneproject/base/base_event.dart';
import 'package:capstoneproject/base/base_widget.dart';
import 'package:capstoneproject/data/repository/favorite_repository.dart';
import 'package:capstoneproject/data/service/favorite_service.dart';
import 'package:capstoneproject/module/booking/booking_page.dart';
import 'package:capstoneproject/module/favorite/event/favorite_add_event.dart';
import 'package:capstoneproject/module/favorite/event/favorite_load_data.dart';
import 'package:capstoneproject/module/favorite/event/favorite_remove_event.dart';
import 'package:capstoneproject/module/favorite/favorite_bloc.dart';
import 'package:capstoneproject/module/home/home_bloc.dart';
import 'package:capstoneproject/module/room/ui/room_page.dart';
import 'package:capstoneproject/shared_code/model/favorite_model.dart';
import 'package:capstoneproject/ui_kit/widget/air_18_loading_view.dart';
import 'package:capstoneproject/ui_kit/widget/base_widget/bloc_listener.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  final HomeBloc homeBloc;

  const FavoritePage({
    Key? key,
    required this.homeBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Your Favorite",
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontFamily: "Gotik",
                    fontSize: 22.0,
                    color: Colors.black)),
            StreamProvider<Object?>.value(
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
                return Text(" ( ${items.length.toString()} )",
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontFamily: "Gotik",
                      fontSize: 18.0,
                      color: Colors.grey,
                    ));
              }),
            ),
          ],
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: PageContainer(
        child: FavoritePageWidget(
          homeBloc: homeBloc,
        ),
        bloc: const [],
        di: [
          Provider.value(value: FavoriteService()),
          ProxyProvider<FavoriteService, FavoriteRepository>(
            update: (context, service, previous) =>
                FavoriteRepository(favoriteService: service),
          ),
        ],
      ),
    );
  }
}

class FavoritePageWidget extends StatelessWidget {
  final HomeBloc homeBloc;
  const FavoritePageWidget({
    Key? key,
    required this.homeBloc,
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
    return ChangeNotifierProvider<FavoriteBloc>.value(
      value: FavoriteBloc(favoriteRepository: Provider.of(context)),
      child: Consumer<FavoriteBloc>(builder: (context, bloc, child) {
        return BlocListener<FavoriteBloc>(
          listener: handleEvent,
          child: StreamProvider<Object?>.value(
            value: bloc.loadFavoriteList(),
            initialData: '',
            catchError: (context, error) {
              return error;
            },
            child: Consumer<Object?>(builder: (context, data, child) {
              if (data is FavoriteLoadData) {
                final items = data.listFavorite;
                return items.isNotEmpty
                    ? buidListView(items, bloc)
                    : const Center(child:  NoItem());
              } else {
                return const Center(
                  child: Air18LoadingView(),
                );
              }
            }),
          ),
        );
      }),
    );
  }

  Widget buidListView(List<Favorite> items, FavoriteBloc bloc) {
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
        final favorites = data as List<int>;
        return ListView.builder(
          itemCount: items.length,
          padding: const EdgeInsets.only(top: 8),
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            bool favorited = favorites.contains(items[index].id);
            return CardRoom(
              bloc: bloc,
              favorited: favorited,
              favorite: items[index],
            );
          },
        );
        ;
      }),
    );
  }
}

class CardRoom extends StatelessWidget {
  final FavoriteBloc bloc;
  final bool favorited;
  final Favorite favorite;
  const CardRoom({
    Key? key,
    required this.bloc,
    required this.favorited,
    required this.favorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => RoomPage(
            id: favorite.id.toString(),
          ),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Hero(
            tag: Key('https://airj18.skqist225.xyz${favorite.images![0]}'),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  "https://airj18.skqist225.xyz" + favorite.images![0],
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: 240,
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 10,
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: LikeButton(
                size: 40,
                circleColor: const CircleColor(
                    start: Color.fromARGB(255, 255, 5, 5),
                    end: Color.fromARGB(255, 204, 0, 0)),
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
                    bloc.event
                        .add(FavoriteAddEvent(id: favorite.id.toString()));
                    print("Add room to favorite + ${favorite.id.toString()}");
                  } else {
                    bloc.event
                        .add(FavoriteRemoveEvent(id: favorite.id.toString()));
                    print(
                        "Remove room from favorite + ${favorite.id.toString()}");
                  }
                  return !v;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
