import 'dart:async';
import 'package:capstoneproject/base/base_event.dart';
import 'package:capstoneproject/base/base_widget.dart';
import 'package:capstoneproject/data/repository/booking_repository.dart';
import 'package:capstoneproject/data/service/booking_service.dart';
import 'package:capstoneproject/module/booking/booked_item.dart';
import 'package:capstoneproject/module/booking/booking_bloc.dart';
import 'package:capstoneproject/shared_code/model/booked_rooms.dart';
import 'package:capstoneproject/ui_kit/widget/air_18_loading_view.dart';
import 'package:capstoneproject/ui_kit/widget/base_widget/bloc_listener.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class BookingHistoryPage extends StatefulWidget {
  const BookingHistoryPage({Key? key}) : super(key: key);

  @override
  State<BookingHistoryPage> createState() => _BookingHistoryPageState();
}

class _BookingHistoryPageState extends State<BookingHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      child: const BookingPage(),
      bloc: const [],
      di: [
        Provider.value(value: BookingService()),
        ProxyProvider<BookingService, BookingRepository>(
          update: (context, service, previous) =>
              BookingRepository(bookingService: service),
        ),
      ],
    );
  }
}

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  _BookingPageState createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  ///
  /// Get image data dummy from firebase server
  ///
  var imageNetwork = const NetworkImage(
      "https://firebasestorage.googleapis.com/v0/b/beauty-look.appspot.com/o/Artboard%203.png?alt=media&token=dc7f4bf5-8f80-4f38-bb63-87aed9d59b95");

  ///
  /// check the condition is right or wrong for image loaded or no
  ///
  bool loadImage = true;

  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          loadImage = false;
        });
      }
    });
    super.initState();
  }

  handleEvent(BaseEvent event) {}

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookingBloc>.value(
      value: BookingBloc(bookingRepository: Provider.of(context)),
      child: Consumer<BookingBloc>(
        builder: (context, bloc, child) {
          return BlocListener<BookingBloc>(
            listener: handleEvent,
            child: buildMainMethod(bloc),
          );
        },
      ),
    );
  }

  Scaffold buildMainMethod(BookingBloc bloc) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: false,
        elevation: 0.0,
        title: const Padding(
          padding: EdgeInsets.only(top: 20.0, left: 5.0),
          child: Text(
            'Reservations',
            style: TextStyle(
                fontFamily: "Sofia",
                fontSize: 36.0,
                fontWeight: FontWeight.w800,
                color: Colors.black),
          ),
        ),
      ),
      body: StreamProvider<Object?>.value(
        initialData: null,
        value: bloc.getbookingRoomStream,
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
          final items = data as List<BookedRooms>;
          return ListView.builder(
            itemBuilder: (context, index) => BookedItem(
              booked: items[index],
              bloc: bloc,
            ),
            itemCount: items.length,
          );
        }),
      ),
    );
  }
}

Widget cardHeaderLoading(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
    child: Container(
      height: 250.0,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.black12.withOpacity(0.1),
                blurRadius: 3.0,
                spreadRadius: 1.0)
          ]),
      child: Shimmer.fromColors(
        baseColor: Colors.black38,
        highlightColor: Colors.white,
        child: Column(children: [
          Container(
            height: 165.0,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  topLeft: Radius.circular(10.0)),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 10.0, right: 10.0),
              child: CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.black12,
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                  )),
            ),
            alignment: Alignment.topRight,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 220.0,
                        height: 25.0,
                        color: Colors.black12,
                      ),
                      const Padding(padding: EdgeInsets.only(top: 5.0)),
                      Container(
                        height: 15.0,
                        width: 100.0,
                        color: Colors.black12,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.9),
                        child: Container(
                          height: 12.0,
                          width: 140.0,
                          color: Colors.black12,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 13.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 35.0,
                        width: 55.0,
                        color: Colors.black12,
                      ),
                      const Padding(padding: EdgeInsets.only(top: 8.0)),
                      Container(
                        height: 10.0,
                        width: 55.0,
                        color: Colors.black12,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    ),
  );
}

///
///
/// Calling imageLoading animation for set a list layout
///
///
Widget _loadingDataList(BuildContext context, int panjang) {
  return Container(
    child: ListView.builder(
      shrinkWrap: true,
      primary: false,
      padding: const EdgeInsets.only(top: 0.0),
      itemCount: panjang,
      itemBuilder: (ctx, i) {
        return loadingCard(ctx);
      },
    ),
  );
}

Widget loadingCard(BuildContext ctx) {
  return Padding(
    padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
    child: Container(
      height: 250.0,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10.0)),
          boxShadow: [
            BoxShadow(
                color: Colors.black12.withOpacity(0.1),
                blurRadius: 3.0,
                spreadRadius: 1.0)
          ]),
      child: Shimmer.fromColors(
        baseColor: Colors.black38,
        highlightColor: Colors.white,
        child: Column(children: [
          Container(
            height: 165.0,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  topLeft: Radius.circular(10.0)),
            ),
            child: const Padding(
              padding: EdgeInsets.only(top: 10.0, right: 10.0),
              child: CircleAvatar(
                radius: 20.0,
                backgroundColor: Colors.black12,
              ),
            ),
            alignment: Alignment.topRight,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 220.0,
                        height: 25.0,
                        color: Colors.black12,
                      ),
                      const Padding(padding: EdgeInsets.only(top: 5.0)),
                      Container(
                        height: 15.0,
                        width: 100.0,
                        color: Colors.black12,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.9),
                        child: Container(
                          height: 12.0,
                          width: 140.0,
                          color: Colors.black12,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 13.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 35.0,
                        width: 55.0,
                        color: Colors.black12,
                      ),
                      const Padding(padding: EdgeInsets.only(top: 8.0)),
                      Container(
                        height: 10.0,
                        width: 55.0,
                        color: Colors.black12,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    ),
  );
}

// class DataFirestore extends StatelessWidget {
//   final String userId;
//   dataFirestore({this.list, this.userId});
//   final List<DocumentSnapshot> list;
//   final _txtStyleTitle = const TextStyle(
//     color: Colors.black87,
//     fontFamily: "Gotik",
//     fontSize: 17.0,
//     fontWeight: FontWeight.w800,
//   );

//   final _txtStyleSub = const TextStyle(
//     color: Colors.black26,
//     fontFamily: "Gotik",
//     fontSize: 12.5,
//     fontWeight: FontWeight.w600,
//   );

//   @override
//   Widget build(BuildContext context) {
//     var imageOverlayGradient = const DecoratedBox(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           begin: FractionalOffset.bottomCenter,
//           end: FractionalOffset.topCenter,
//           colors: [
//             Color(0xFF000000),
//             Color(0x00000000),
//             Colors.black,
//             Colors.black,
//             Colors.black,
//             Colors.black,
//           ],
//         ),
//       ),
//     );

//     return SizedBox.fromSize(
//         child: ListView.builder(
//       scrollDirection: Axis.vertical,
//       shrinkWrap: true,
//       primary: false,
//       itemCount: list.length,
//       itemBuilder: (context, i) {
//         List<String> photo = List.from(list[i].data()['photo']);
//         List<String> service = List.from(list[i].data()['service']);
//         List<String> description = List.from(list[i].data()['description']);
//         String title = list[i].data()['title'].toString();
//         String type = list[i].data()['type'].toString();
//         num rating = list[i].data()['rating'];
//         String image = list[i].data()['image'].toString();
//         String id = list[i].data()['id'].toString();
//         String checkIn = list[i].data()['Check In'].toString();
//         String checkOut = list[i].data()['Check Out'].toString();
//         String count = list[i].data()['Count'].toString();
//         String locationReservision = list[i].data()['Location'].toString();
//         String rooms = list[i].data()['Rooms'].toString();
//         String roomName = list[i].data()['Room Name'].toString();
//         String information = list[i].data()['Information Room'].toString();

//         num priceRoom = list[i].data()['Price Room'];
//         num price = list[i].data()['price'];
//         num latLang1 = list[i].data()['latLang1'];
//         num latLang2 = list[i].data()['latLang2'];

//         DocumentSnapshot _list = list[i];

//         return InkWell(
//           onTap: () {
//             Navigator.of(context).push(PageRouteBuilder(
//                 pageBuilder: (_, __, ___) => BookingDetail(
//                       userId: userId,
//                       titleD: title,
//                       idD: id,
//                       imageD: image,
//                       information: information,
//                       priceRoom: priceRoom,
//                       roomName: roomName,
//                       latLang1D: latLang1,
//                       latLang2D: latLang2,
//                       priceD: price,
//                       listItem: _list,
//                       descriptionD: description,
//                       photoD: photo,
//                       ratingD: rating,
//                       serviceD: service,
//                       typeD: type,
//                       checkIn: checkIn,
//                       checkOut: checkOut,
//                       count: count,
//                       locationReservision: locationReservision,
//                       rooms: rooms,
//                     ),
//                 transitionDuration: const Duration(milliseconds: 1000),
//                 transitionsBuilder:
//                     (_, Animation<double> animation, __, Widget child) {
//                   return Opacity(
//                     opacity: animation.value,
//                     child: child,
//                   );
//                 }));
//           },
//           child: Padding(
//             padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
//             child: Container(
//               height: 280.0,
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: const BorderRadius.all(const Radius.circular(10.0)),
//                   boxShadow: [
//                     BoxShadow(
//                         color: Colors.black12.withOpacity(0.1),
//                         blurRadius: 3.0,
//                         spreadRadius: 1.0)
//                   ]),
//               child: Column(children: [
//                 Container(
//                   height: 165.0,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     borderRadius: const BorderRadius.only(
//                         topRight: Radius.circular(10.0),
//                         topLeft: Radius.circular(10.0)),
//                     image: DecorationImage(
//                         image: NetworkImage(image), fit: BoxFit.cover),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.only(top: 10.0, right: 10.0),
//                     child: CircleAvatar(
//                         radius: 20.0,
//                         backgroundColor: Colors.black54,
//                         child: InkWell(
//                           onTap: () {
//                             showDialog(
//                                 context: context,
//                                 builder: (_) => NetworkGiffyDialog(
//                                       image: Image.network(
//                                         image,
//                                         fit: BoxFit.cover,
//                                       ),
//                                       title: Text(
//                                           AppLocalizations.of(context)
//                                               .tr('cancelBooking'),
//                                           textAlign: TextAlign.center,
//                                           style: const TextStyle(
//                                               fontFamily: "Gotik",
//                                               fontSize: 22.0,
//                                               fontWeight: FontWeight.w600)),
//                                       description: Text(
//                                         AppLocalizations.of(context)
//                                                 .tr('areYouWant') +
//                                             title,
//                                         textAlign: TextAlign.center,
//                                         style: const TextStyle(
//                                             fontFamily: "Popins",
//                                             fontWeight: FontWeight.w300,
//                                             color: Colors.black26),
//                                       ),
//                                       onOkButtonPressed: () {
//                                         Navigator.pop(context);

//                                         FirebaseFirestore.instance
//                                             .runTransaction(
//                                                 (transaction) async {
//                                           DocumentSnapshot snapshot =
//                                               await transaction
//                                                   .get(list[i].reference);
//                                           await transaction
//                                               .delete(snapshot.reference);
//                                           SharedPreferences prefs =
//                                               await SharedPreferences
//                                                   .getInstance();
//                                           prefs.remove(title);
//                                         });
//                                         Scaffold.of(context)
//                                             .showSnackBar(SnackBar(
//                                           content: Text(
//                                               AppLocalizations.of(context)
//                                                       .tr('cancelBooking2') +
//                                                   title),
//                                           backgroundColor: Colors.red,
//                                           duration: const Duration(seconds: 3),
//                                         ));
//                                       },
//                                     ));
//                           },
//                           child: const Icon(
//                             Icons.delete,
//                             color: Colors.white,
//                           ),
//                         )),
//                   ),
//                   alignment: Alignment.topRight,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 8.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Padding(
//                         padding: const EdgeInsets.only(left: 15.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             Container(
//                                 width: 220.0,
//                                 child: Text(
//                                   title,
//                                   style: _txtStyleTitle,
//                                   overflow: TextOverflow.ellipsis,
//                                 )),
//                             const Padding(padding: EdgeInsets.only(top: 5.0)),
//                             Row(
//                               children: <Widget>[
//                                 ratingbar(
//                                   starRating: rating,
//                                   color: const Color(0xFF09314F),
//                                 ),
//                                 const Padding(padding: EdgeInsets.only(left: 5.0)),
//                                 Text(
//                                   "(" + rating.toString() + ")",
//                                   style: _txtStyleSub,
//                                 )
//                               ],
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(top: 4.9),
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: <Widget>[
//                                   const Icon(
//                                     Icons.location_on,
//                                     size: 16.0,
//                                     color: Colors.black26,
//                                   ),
//                                   const Padding(padding: EdgeInsets.only(top: 3.0)),
//                                   Text(locationReservision, style: _txtStyleSub)
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(right: 13.0),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: <Widget>[
//                             Text(
//                               "\$" + price.toString(),
//                               style: const TextStyle(
//                                   fontSize: 25.0,
//                                   color: Color(0xFF09314F),
//                                   fontWeight: FontWeight.w500,
//                                   fontFamily: "Gotik"),
//                             ),
//                             Text(AppLocalizations.of(context).tr('perNight'),
//                                 style: _txtStyleSub.copyWith(fontSize: 11.0))
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(top: 6.9),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           Text(
//                               AppLocalizations.of(context).tr('checkIn') +
//                                   " : \t",
//                               style: _txtStyleSub.copyWith(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black)),
//                           const Padding(padding: const EdgeInsets.only(top: 3.0)),
//                           Text(checkIn, style: _txtStyleSub)
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 6.9),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           Text(
//                               AppLocalizations.of(context).tr('checkOut') +
//                                   " : \t",
//                               style: _txtStyleSub.copyWith(
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.black)),
//                           const Padding(padding: EdgeInsets.only(top: 3.0)),
//                           Text(checkOut, style: _txtStyleSub)
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ]),
//             ),
//           ),
//         );
//       },
//     ));
//   }
// }

///
///
/// If no item cart this class showing
///
class NoItem extends StatelessWidget {
  const NoItem({Key? key}) : super(key: key);

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
                padding: EdgeInsets.only(top: mediaQueryData.size.height / 5)),
            Image.asset(
              "assets/image/illustration/empty.png",
              height: 270.0,
            ),
            Text(
              'Not Have Item',
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 19.5,
                  color: Colors.black26.withOpacity(0.4),
                  fontFamily: "Sofia"),
            ),
          ],
        ),
      ),
    );
  }
}
