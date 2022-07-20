import 'dart:async';

import 'package:capstoneproject/base/base_event.dart';
import 'package:capstoneproject/base/base_widget.dart';
import 'package:capstoneproject/data/repository/search_repository.dart';
import 'package:capstoneproject/data/service/search_service.dart';
import 'package:capstoneproject/module/room/ui/room_page.dart';
import 'package:capstoneproject/module/search/search_bloc.dart';
import 'package:capstoneproject/module/search/search_event.dart';
import 'package:capstoneproject/shared_code/model/search_model.dart';
import 'package:capstoneproject/ui_kit/widget/air_18_loading_view.dart';
import 'package:capstoneproject/ui_kit/widget/base_widget/bloc_listener.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../event/base_event/expired_token_event.dart';
import '../../event/base_event/no_data_show_event.dart';
import '../../event/base_event/unknown_error_event.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      child: const Search(),
      bloc: const [],
      di: [
        Provider.value(value: SearchService()),
        ProxyProvider<SearchService, SearchRepository>(
          update: (context, service, previous) =>
              SearchRepository(searchService: service),
        ),
      ],
    );
  }
}

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late TextEditingController searchString;

  bool load = true;
  @override
  void initState() {
    super.initState();
    searchString = TextEditingController();
    Timer(const Duration(seconds: 3), () {
      setState(() {
        load = false;
      });
    });
  }

  handleEvent(BaseEvent event) {
    if (event is ExpiredTokenEvent) {
      print("ExpiredTokenEvent");
      return;
    }
    if (event is NoDataShowEvent) {
      print("NoDataShowEvent");
      return;
    }
    if (event is UnknownErrorEvent) {
      print("UnknownErrorEvent ${event.message}");
      return;
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SearchBloc>.value(
      value: SearchBloc(searchRepository: Provider.of(context)),
      child: Consumer<SearchBloc>(builder: (context, bloc, child) {
        return BlocListener<SearchBloc>(
          listener: handleEvent,
          child: buildMainUISearch(bloc),
        );
      }),
    );
  }

  Scaffold buildMainUISearch(SearchBloc bloc) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xFF09314F)),
        title: const Text(
          'Search',
          style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 19.0,
              color: Colors.black54,
              fontFamily: "Sofia"),
        ),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 25.0, left: 20.0, right: 50.0),
              child: Text(
                'Would Search',
                style: TextStyle(
                    letterSpacing: 0.1,
                    fontWeight: FontWeight.w600,
                    fontSize: 27.0,
                    color: Colors.black54,
                    fontFamily: "Sofia"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 25.0, right: 20.0, left: 20.0, bottom: 20.0),
              child: Container(
                height: 50.0,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 15.0,
                          spreadRadius: 0.0)
                    ]),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20.0,
                      right: 10.0,
                    ),
                    child: Theme(
                      data: ThemeData(hintColor: Colors.transparent),
                      child: TextFormField(
                        controller: searchString,
                        onChanged: (value) {
                          Timer(const Duration(seconds: 1), () {
                            bloc.event.add(PostSearchRoomEvent(
                                query: value.toLowerCase(), idCategory: 1));
                          });
                        },
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.search,
                              color: Color(0xFF09314F),
                              size: 28.0,
                            ),
                            hintText: 'Search',
                            hintStyle: TextStyle(
                                color: Colors.black38,
                                fontFamily: "Sofia",
                                fontWeight: FontWeight.w400)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: StreamProvider<Object?>.value(
                initialData: null,
                value: bloc.listSearchRoom,
                catchError: (context, err) {
                  print('Error List');
                  return Container();
                },
                child: Consumer<Object?>(builder: (context, data, child) {
                  if (searchString.text.isEmpty) {
                    return const Center(
                      child: Text("No Data Found"),
                    );
                  }

                  if (data == null) {
                    return const Center(
                      child: Air18LoadingView(),
                    );
                  }

                  if (data is GetSearchRoomEvent) {
                    final List<SearchModel> items = data.listRoom;

                    if (items.isEmpty) {
                      return const Center(
                        child: Text("No Data Found"),
                      );
                    }

                    return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) =>
                          buildItemSearch(context, items[index]),
                    );
                  }

                  return const Center(
                    child: Text("No Data Found"),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildItemSearch(BuildContext context, SearchModel searchModel) {
  return Padding(
    padding:
        const EdgeInsets.only(left: 20.0, right: 20.0, top: 15.0, bottom: 5.0),
    child: InkWell(
      onTap: () {
        Navigator.of(context).push(PageRouteBuilder(
            pageBuilder: (_, __, ___) => RoomPage(
                  id: searchModel.id!.toString(),
                ),
            transitionDuration: const Duration(milliseconds: 1000),
            transitionsBuilder:
                (_, Animation<double> animation, __, Widget child) {
              return Opacity(
                opacity: animation.value,
                child: child,
              );
            }));
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.black12.withOpacity(0.1),
                blurRadius: 1.0,
                spreadRadius: 1.0)
          ],
        ),
        child: Row(
          children: <Widget>[
            Material(
              child: Container(
                height: 180.0,
                width: 120.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage("https://airj18.skqist225.xyz" +
                          searchModel.thumbnail!),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    width: 174.0,
                    child: Text(
                      searchModel.name!,
                      style: const TextStyle(
                        fontFamily: "Sofia",
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        width: 5.0,
                      ),
                      SizedBox(
                        width: 150.0,
                        child: Text(
                          "\$ " + searchModel.price.toString() + "/Night",
                          style: const TextStyle(
                            fontFamily: "Sofia",
                            fontSize: 16.0,
                            color: Color(0xFF09314F),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Icon(
                        Icons.person,
                        size: 16.0,
                        color: Colors.yellow,
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      SizedBox(
                        width: 150.0,
                        child: Text(
                          searchModel.images!.length.toString(),
                          style: const TextStyle(
                            fontFamily: "Sofia",
                            fontSize: 15.0,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Icon(
                        Icons.star,
                        size: 17.0,
                        color: Colors.yellow,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(bottom: 15.0),
                      //   child: Text(
                      //     document['rating'].toString(),
                      //     style: const TextStyle(
                      //       fontFamily: "Sans",
                      //       fontSize: 15.0,
                      //       color: Colors.yellow,
                      //       fontWeight: FontWeight.w800,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  const SizedBox(
                    height: 10.0,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

///
///
/// If no item cart this class showing
///
class noItem extends StatelessWidget {
  const noItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Container(
      width: 500.0,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding:
                    EdgeInsets.only(top: mediaQueryData.padding.top + 30.0)),
            Image.asset(
              "assets/image/images/search.png",
              height: 200.0,
            ),
            const Padding(padding: const EdgeInsets.only(bottom: 10.0)),
            Text(
              'No Matching',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 17.5,
                  color: Colors.black26.withOpacity(0.3),
                  fontFamily: "Popins"),
            ),
          ],
        ),
      ),
    );
  }
}
