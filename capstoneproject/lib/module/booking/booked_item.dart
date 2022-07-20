import 'package:capstoneproject/module/booking/booking_bloc.dart';
import 'package:capstoneproject/module/booking/event/booking_event.dart';
import 'package:capstoneproject/module/room/ui/room_page.dart';
import 'package:capstoneproject/shared_code/model/booked_rooms.dart';
import 'package:capstoneproject/shared_code/responsive/responsive.dart';
import 'package:capstoneproject/ui_kit/SupportingLibrary/ratting/rating.dart';
import 'package:flutter/material.dart';
import 'package:giff_dialog/giff_dialog.dart';

class BookedItem extends StatefulWidget {
  final BookedRooms booked;
  final BookingBloc bloc;

  const BookedItem({Key? key, required this.booked, required this.bloc})
      : super(key: key);

  @override
  State<BookedItem> createState() => _BookedItemState();
}

class _BookedItemState extends State<BookedItem> {
  final _txtStyleTitle = const TextStyle(
    color: Colors.black87,
    fontFamily: "Gotik",
    fontSize: 17.0,
    fontWeight: FontWeight.w800,
  );

  final _txtStyleSub = const TextStyle(
    color: Colors.black26,
    fontFamily: "Gotik",
    fontSize: 12.5,
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => RoomPage(
              id: widget.booked.roomId.toString(),
            ),
            transitionDuration: const Duration(milliseconds: 1000),
            transitionsBuilder:
                (_, Animation<double> animation, __, Widget child) {
              return Opacity(
                opacity: animation.value,
                child: child,
              );
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
        child: Container(
          height: Responsive.isDesktop(context) ? 400.0 : 280.0,
          width: 100,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12.withOpacity(0.1),
                    blurRadius: 3.0,
                    spreadRadius: 1.0)
              ]),
          child: Column(children: [
            Container(
              height: Responsive.isDesktop(context) ? 300 : 165.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0)),
                image: DecorationImage(
                    image: NetworkImage("https://airj18.skqist225.xyz" +
                        widget.booked.roomThumbnail!),
                    fit: BoxFit.cover),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  (!widget.booked.complete! && widget.booked.refund!)
                      ? const SizedBox.shrink()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                              radius: 20.0,
                              backgroundColor: Colors.black54,
                              child: InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          NetworkGiffDialog(
                                            image: Image.network(
                                              "https://airj18.skqist225.xyz" +
                                                  widget.booked.roomThumbnail!,
                                              fit: BoxFit.cover,
                                            ),
                                            title: const Text("Cancle booking",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: "Gotik",
                                                    fontSize: 22.0,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                            description: Text(
                                              'Are You Want ' +
                                                  widget.booked.roomName!,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontFamily: "Popins",
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.black26),
                                            ),
                                            onOkButtonPressed: () {
                                              //Cancle booking
                                              widget.bloc.event.add(
                                                CancleBookingEvent(
                                                  id: widget.booked.bookingId!
                                                      .toString(),
                                                ),
                                              );
                                              widget.bloc
                                                  .loadBookedHistoryList();
                                              Navigator.pop(context);
                                            },
                                          ));
                                },
                                child: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                              )),
                        ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(22.0),
                      ),
                      child:
                          !(!widget.booked.complete! && widget.booked.refund!)
                              ? Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: (widget.booked.complete!)
                                      ? const Text(
                                          "Accepted",
                                          style: TextStyle(color: Colors.white),
                                        )
                                      : const Text(
                                          "Waiting",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                )
                              : const Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Text(
                                    "Cancled",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                    ),
                  ),
                ],
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
                        SizedBox(
                            width: 220.0,
                            child: Text(
                              widget.booked.roomName!,
                              style: _txtStyleTitle,
                              overflow: TextOverflow.ellipsis,
                            )),
                        const Padding(padding: EdgeInsets.only(top: 5.0)),
                        Row(
                          children: <Widget>[
                            Ratingbar(
                              starRating: widget.booked.reviewRating != null
                                  ? widget.booked.reviewRating!.value!
                                      .toDouble()
                                  : 0.0,
                              color: const Color(0xFF09314F),
                            ),
                            const Padding(padding: EdgeInsets.only(left: 5.0)),
                            Text(
                              widget.booked.reviewRating != null
                                  ? widget.booked.reviewRating!.accuracy!
                                      .toString()
                                  : "0.0",
                              style: _txtStyleSub,
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.9),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Icon(
                                Icons.location_on,
                                size: 16.0,
                                color: Colors.black26,
                              ),
                              const Padding(padding: EdgeInsets.only(top: 3.0)),
                              Text(widget.booked.roomCategory!,
                                  style: _txtStyleSub)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "\$" + (widget.booked.pricePerDay!).toString(),
                          style: const TextStyle(
                              fontSize: 22.0,
                              color: Color(0xFF09314F),
                              fontWeight: FontWeight.w500,
                              fontFamily: "Gotik"),
                        ),
                        Text('Per Night',
                            style: _txtStyleSub.copyWith(fontSize: 11.0))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 6.9),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Check In' + " : \t",
                          style: _txtStyleSub.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      const Padding(padding: EdgeInsets.only(top: 3.0)),
                      Text(widget.booked.checkinDate!, style: _txtStyleSub)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 6.9),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Check Out' + " : \t",
                          style: _txtStyleSub.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      const Padding(padding: EdgeInsets.only(top: 3.0)),
                      Text(widget.booked.checkoutDate!, style: _txtStyleSub)
                    ],
                  ),
                )
              ],
            ),
          ]),
        ),
      ),
    );
    ;
  }
}
