import 'package:bloc/bloc.dart';
import 'package:capstoneproject/module/home/home_bloc.dart';
import 'package:capstoneproject/module/home/ui/room_by_category.dart';
import 'package:capstoneproject/shared_code/model/category_model.dart';
import 'package:capstoneproject/shared_code/responsive/responsive.dart';
import 'package:capstoneproject/utils/materials/app_color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vertical_tabs_flutter/vertical_tabs.dart';

class CategoryList extends StatefulWidget {
  final List<CategoryModel> categories;
  final HomeBloc bloc;
  const CategoryList({Key? key, required this.categories, required this.bloc})
      : super(key: key);
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList>
    with SingleTickerProviderStateMixin {
  late final List<CategoryModel> categories;
  late TabController _tabController;
  int categoryID = 0;

  @override
  void initState() {
    super.initState();
    categories = widget.categories;
    _tabController = TabController(vsync: this, length: categories.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: !Responsive.isDesktop(context)
            ? PreferredSize(
                preferredSize: const Size.fromHeight(40.0),
                child: AppBar(
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  bottom: TabBar(
                    controller: _tabController,
                    indicatorColor: Colors.grey,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorWeight: 1.0,
                    unselectedLabelColor: Colors.grey,
                    labelColor: Colors.black,
                    isScrollable: true,
                    tabs: categories.map((CategoryModel categoryModel) {
                      return Container(
                        padding: const EdgeInsets.only(bottom: 8.0, top: 10.0),
                        child: Text(categoryModel.name!,
                            style: const TextStyle(
                                color: Colors.black38,
                                fontFamily: "Gotik",
                                fontWeight: FontWeight.w800,
                                fontSize: 14.0)),
                      );
                    }).toList(),
                  ),
                ),
              )
            : const PreferredSize(
                preferredSize: Size.fromHeight(40.0),
                child: SizedBox(),
              ),
        body: !Responsive.isDesktop(context)
            ? TabBarView(
                controller: _tabController,
                physics: const NeverScrollableScrollPhysics(),
                children: categories.map((CategoryModel categoryModel) {
                  return CategoryRooms(
                    categoryId: categoryModel.id.toString(),
                    homeBloc: widget.bloc,
                  );
                }).toList(),
              )
            : Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: VerticalTabs(
                  tabsWidth: 400,
                  tabs: categories.map((CategoryModel categoryModel) {
                    return Tab(
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 8.0, top: 10.0),
                        child: Text(categoryModel.name!,
                            style: const TextStyle(
                                color: Colors.black38,
                                fontFamily: "Gotik",
                                fontWeight: FontWeight.w800,
                                fontSize: 14.0)),
                      ),
                    );
                  }).toList(),
                  contents: categories.map((CategoryModel categoryModel) {
                    return CategoryRooms(
                      categoryId: categoryModel.id.toString(),
                      homeBloc: widget.bloc,
                    );
                  }).toList(),
                  backgroundColor: Colors.white,
                  onSelect: (int tabIndex) {},
                  indicatorSide: IndicatorSide.start,
                ),
            ),
        // : SingleChildScrollView(
        //     child: SizedBox(
        //       height: 500,
        //       child: NavigationRail(
        //         onDestinationSelected: (int index) {
        //           setState(() {
        //             categoryID = index;
        //           });
        //         },
        //         destinations:
        //             categories.map((CategoryModel categoryModel) {
        //           return NavigationRailDestination(
        //             icon: Column(
        //               children: [
        //                 const Icon(Icons.favorite_border),
        //                 Text(categories[categoryID].name!)
        //               ],
        //             ),
        //             selectedIcon: Container(
        //               color: AppColor.colorGrey,
        //               child: Column(
        //                 children: [
        //                   const Icon(Icons.favorite_border),
        //                   Text(categories[categoryID].name!)
        //                 ],
        //               ),
        //             ),
        //             label: const Text(''),
        //           );
        //           // return CategoryRooms(
        //           //   categoryId: categoryModel.id.toString(),
        //           //   homeBloc: widget.bloc,
        //           // );
        //         }).toList(), selectedIndex: null,
        //         // selectedIndex: categoryID,
        //       ),
        //     ),
        //   )
        // : Row(
        //     children: [
        //       SizedBox(
        //         width: MediaQuery.of(context).size.width * 0.3,
        //         child: ListView.builder(
        //           itemCount: categories.length,
        //           itemBuilder: (context, index) {
        //             return GestureDetector(
        //               onTap: () => setState(() {
        //                 categoryID = index;
        //               }),
        //               child: Padding(
        //                 padding: const EdgeInsets.all(8.0),
        //                 child: Text(categories[index].name!),
        //               ),
        //             );
        //           },
        //         ),
        //       ),
        //       Expanded(
        //         child: CategoryRooms(
        //           categoryId: categories[categoryID].id.toString(),
        //           homeBloc: widget.bloc,
        //         ),
        //       )
        //     ],
        //   ),
      ),
    );
  }
}
