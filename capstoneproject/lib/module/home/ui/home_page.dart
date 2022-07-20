import 'package:capstoneproject/base/base_event.dart';
import 'package:capstoneproject/base/base_widget.dart';
import 'package:capstoneproject/data/repository/home_repository.dart';
import 'package:capstoneproject/data/service/home_service.dart';
import 'package:capstoneproject/event/base_event/expired_token_event.dart';
import 'package:capstoneproject/event/base_event/no_data_show_event.dart';
import 'package:capstoneproject/event/base_event/unknown_error_event.dart';
import 'package:capstoneproject/hive/hive_service.dart';
import 'package:capstoneproject/injection/injection.dart';
import 'package:capstoneproject/module/favorite/ui/favorited_page.dart';
import 'package:capstoneproject/module/home/home_bloc.dart';
import 'package:capstoneproject/module/home/ui/Promo_Detail_Information.dart';
import 'package:capstoneproject/module/profile/update_profile.dart';
import 'package:capstoneproject/module/search/search_page.dart';
import 'package:capstoneproject/shared_code/model/category_model.dart';
import 'package:capstoneproject/ui_kit/widget/air_18_loading_view.dart';
import 'package:capstoneproject/ui_kit/widget/base_widget/bloc_listener.dart';
import 'package:capstoneproject/ui_kit/widget/category_list.dart';
import 'package:capstoneproject/ui_kit/widget/loading_widget/loading_task.dart';
import 'package:capstoneproject/utils/materials/constant.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../data/shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageContainer(
      child: const HotelHomeWidget(),
      bloc: const [],
      di: [
        Provider.value(value: HomeService()),
        ProxyProvider<HomeService, HomeRepository>(
          update: (context, service, previous) =>
              HomeRepository(homeService: service),
        ),
      ],
    );
  }
}

class HotelHomeWidget extends StatefulWidget {
  const HotelHomeWidget({Key? key}) : super(key: key);

  @override
  _HotelHomeScreenState createState() => _HotelHomeScreenState();
}

class _HotelHomeScreenState extends State<HotelHomeWidget>
    with TickerProviderStateMixin {
  List<CategoryModel> totalListItems = <CategoryModel>[];

  bool isLoadingMore = false;
  //Call API
  // final CategoryBloc _categoryBloc = CategoryBloc();

  final ScrollController _scrollController = ScrollController();

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));
  String path = "" ;
  @override
  void initState() {
    super.initState();
    print("ddddddddddddddd ${SPref.instance.get(SPrefCache.KEY_ACCESS_TOKEN)}");
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
    final _searchBox = Padding(
      padding: const EdgeInsets.only(
          left: 15.0, right: 15.0, bottom: 10.0, top: 10.0),
      child: InkWell(
        onTap: () => Navigator.of(context).push(PageRouteBuilder(
          pageBuilder: (_, __, ___) => const SearchPage(),
          transitionsBuilder:
              (_, Animation<double> animation, __, Widget child) {
            return Opacity(
              opacity: animation.value,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 500),
        )),
        child: Container(
          height: 43.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(9.0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black12.withOpacity(0.2),
                spreadRadius: 1.0,
                blurRadius: 3.0,
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 10.0),
            child: Row(
              children: const [
                Icon(
                  Icons.search,
                  color: Color(0xFF09314F),
                  size: 25.0,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  child: Text('Find Do You Want',
                      style: TextStyle(
                          color: Colors.black26,
                          fontFamily: "Gotik",
                          fontWeight: FontWeight.w300,
                          fontSize: 15.0)),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    return ChangeNotifierProvider<HomeBloc>.value(
      value: HomeBloc(homeRepository: Provider.of(context)),
      child: Consumer<HomeBloc>(builder: (context, bloc, child) {
        return BlocListener<HomeBloc>(
          listener: handleEvent,
          child: Scaffold(
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            appBar: buildAppBar(bloc),
            body: Stack(
              children: <Widget>[
                InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: NestedScrollView(
                          controller: _scrollController,
                          headerSliverBuilder:
                              (BuildContext context, bool innerBoxIsScrolled) {
                            return <Widget>[
                              SliverList(
                                delegate: SliverChildBuilderDelegate(
                                    (BuildContext context, int index) {
                                  return Column(
                                    children: <Widget>[
                                      // getSearchBarUI(),
                                      _searchBox,
                                      _sliderImage(),
                                      // _sliderImage,
                                      // getTimeDateUI(),
                                    ],
                                  );
                                }, childCount: 1),
                              ),
                            ];
                          },
                          body: LoadingTask(
                            bloc: bloc,
                            child: _listCategoryWidget(bloc),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _sliderImage() => Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: CarouselSlider(
          options: CarouselOptions(
            height: 190,
            aspectRatio: 24 / 18,
            viewportFraction: 0.9,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            scrollDirection: Axis.horizontal,
          ),
          items: [0, 1, 2, 3].map((i) {
            return InkWell(
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (_, __, ___) => PromoDetailInformation(
                          image: listSlide[i].image,
                          description: [listSlide[i].description],
                        )));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin:
                    const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 9.0,
                          spreadRadius: 8.0,
                          color: Colors.black12.withOpacity(0.05))
                    ],
                    image: DecorationImage(
                        image: NetworkImage(listSlide[i].image),
                        fit: BoxFit.cover),
                    color: const Color(0xFF23252E)),
              ),
            );
          }).toList(),
        ),
      );

  Widget _listCategoryWidget(HomeBloc homeBloc) {
    return StreamProvider<Object?>.value(
      initialData: null,
      value: homeBloc.listCategoryStream,
      catchError: (context, err) {
        print('Error List');
        return Container();
      },
      child: Consumer<Object?>(builder: (context, data, child) {
        if (data == null) {
          return const Center(
            child: Air18LoadingView(),
          );
        }
        final items = data as List<CategoryModel>;
        return CategoryList(
          categories: items,
          bloc: homeBloc,
        );
      }),
    );
  }

  AppBar buildAppBar(bloc) {
    path = getIt<HiveService>().avatar;
    return AppBar(
      backgroundColor: Colors.white,
      title: const Text('Home',
          style: TextStyle(
              fontWeight: FontWeight.w900,
              fontFamily: "Gotik",
              fontSize: 28.0,
              color: Colors.black)),
      centerTitle: false,
      actions: <Widget>[
        Stack(
          children: [
            Center(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(32.0),
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavoritePage(
                        homeBloc: bloc,
                      ),
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.favorite_sharp,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                      StreamProvider<Object?>.value(
                        initialData: null,
                        value: bloc.listFavoriteIdStream,
                        catchError: (context, err) {
                          print('Error List');
                          return Container();
                        },
                        child:
                            Consumer<Object?>(builder: (context, data, child) {
                          if (data == null) {
                            return const SizedBox.shrink();
                          }
                          final items = data as List<int>;
                          return Text(
                            items.length < 10 ? items.length.toString() : "9+",
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0),
          child: InkWell(
            onTap: () {},
            child: Stack(children: <Widget>[
              Padding(
                  padding:
                      const EdgeInsets.only(right: 0.0, top: 9.0, left: 10.0),
                  child: Container(
                    height: 40.0,
                    width: 40.0,
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                        image: DecorationImage(
                            image: NetworkImage(
                                "$baseUrl$path"),
                            fit: BoxFit.cover)),
                  )),
            ]),
          ),
        )
      ],
      elevation: 0.0,
    );
  }

  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 4, bottom: 4),
                  child: TextField(
                    onChanged: (String txt) {},
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: 'London...',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(38.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: const Offset(0, 2),
                    blurRadius: 8.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Icon(
                    Icons.search,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget getFilterBarUI() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 24,
            decoration: BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(0, -2),
                    blurRadius: 8.0),
              ],
            ),
          ),
        ),
        Container(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 0),
            child: Row(
              children: <Widget>[
                const Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '530 hotels found',
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      // FocusScope.of(context).requestFocus(FocusNode());
                      // Navigator.push<dynamic>(
                      //   context,
                      //   MaterialPageRoute<dynamic>(
                      //       builder: (BuildContext context) =>
                      //           const FiltersScreen(),
                      //       fullscreenDialog: true),
                      // );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        children: const [
                          Text(
                            'Filter',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.sort,
                              // color:
                              //     HotelAppTheme.buildLightTheme().primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Divider(
            height: 1,
          ),
        )
      ],
    );
  }
}

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  ContestTabHeader(
    this.searchUI,
  );
  final Widget searchUI;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return searchUI;
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class Slide {
  final String image;
  final String description;

  Slide({required this.image, required this.description});
}

List<Slide> listSlide = [
  Slide(
      image:
          "https://e-images.juwaistatic.com/content-site/2021/02/16031444/Vietnam-Travel-MI-.jpg",
      description: "Vietnam's travel restrictions due to COVID-19"),
  Slide(
      image:
          "https://e-images.juwaistatic.com/content-site/2021/02/16031441/Vietnam-Airport-.jpg",
      description: "Restrictions regarding tourism sites"),
  Slide(
      image:
          "https://assets.wego.com/image/upload/v1611848131/country-pages/vn.jpg",
      description: "Is Vietnam open for visitors?"),
  Slide(
      image:
          "https://www.shareexit.com/wp-content/uploads/2020/10/1920_sustainabletravel-810x450.jpg",
      description: "Why You Must Focus On Sustainable Travelling?"),
];
