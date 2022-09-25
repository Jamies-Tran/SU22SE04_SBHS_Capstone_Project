
import 'package:capstoneproject2/components/spinkit_component.dart';
import 'package:capstoneproject2/constants.dart';
import 'package:capstoneproject2/screens/booking/booking_list_screen.dart';
import 'package:capstoneproject2/screens/booking/booking_screen.dart';
import 'package:capstoneproject2/screens/home_page/components/rating_component.dart';
import 'package:capstoneproject2/screens/booking/component/booking_schedule_component.dart';
import 'package:capstoneproject2/screens/login/login_screen.dart';
import 'package:capstoneproject2/screens/welcome/welcome_screen.dart';
import 'package:capstoneproject2/services/auth_service.dart';
import 'package:capstoneproject2/services/booking_service.dart';
import 'package:capstoneproject2/services/firebase_service/firebase_auth_service.dart';
import 'package:capstoneproject2/services/locator/service_locator.dart';
import 'package:capstoneproject2/services/model/booking_model.dart';
import 'package:capstoneproject2/services/model/error_handler_model.dart';
import 'package:capstoneproject2/services/model/passenger_model.dart';
import 'package:capstoneproject2/services/passenger_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

import '../../../services/model/homestay_model.dart';

class HomestayDetailsBody extends StatelessWidget {
  const HomestayDetailsBody({Key? key, this.homestayModel}) : super(key: key);
  final HomestayModel? homestayModel;


  @override
  Widget build(BuildContext context) {
    final firebaseAuth = FirebaseAuth.instance;
    final currencyFormat = NumberFormat("#,##0");
    final formatDate = DateFormat("yyyy-MM-dd");
    final userService = locator.get<IPassengerService>();
    final bookingService = locator.get<IBookingService>();
    const Color propertiesExistColor = Colors.green;
    const Color propertiesNonExistColor = Colors.red;
    var homestayServiceRows = <TableRow>[];
    var homestayNormalAndWeekendPriceListRows = <TableRow>[];
    var homestaySpecialPriceListRows = <TableRow>[];

    homestayModel?.homestayPriceLists!.where((element) => element.type.compareTo("normal") == 0 || element.type.compareTo("weekend") == 0).forEach((element) {
      homestayNormalAndWeekendPriceListRows.add(TableRow(
          children: [
            TableCell(
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.all(15),
                  child: Text(element.type.compareTo("normal") == 0 ? "Normal day" : "Weekend", style: const TextStyle(
                      fontSize: 17,
                      fontFamily: 'OpenSans',
                      letterSpacing: 3.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),),
                )),
            TableCell(
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text("${currencyFormat.format(element.price)} / vnd", style: const TextStyle(
                    fontSize: 17,
                    fontFamily: 'OpenSans',
                    letterSpacing: 3.0,
                    color: Colors.black,
                  ),),
                )
            )
          ]
      ));
    });

    homestayModel?.homestayPriceLists!.where((element) => element.type.compareTo("special") == 0).forEach((element) {
      homestaySpecialPriceListRows.add(TableRow(
          children: [
            TableCell(
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.all(10),
                  child: Text("${element.specialDayPriceList!.description}", style: const TextStyle(
                      fontSize: 12,
                      fontFamily: 'OpenSans',
                      letterSpacing: 3.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold
                  ),),
                )),
            TableCell(
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Text("${currencyFormat.format(element.price)} / vnd", style: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'OpenSans',
                    letterSpacing: 3.0,
                    color: Colors.black,
                  ),),
                )
            )
          ]
      ));
    });
    
    homestayModel?.homestayServices.forEach((element) {
      homestayServiceRows.add(TableRow(
        children: [
          TableCell(
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.all(15),
                child: Text("${element.name}", style: const TextStyle(
                    fontSize: 17,
                    fontFamily: 'OpenSans',
                    letterSpacing: 3.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),),
          )),
          TableCell(
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                child: Text("${currencyFormat.format(element.price)} / vnd", style: const TextStyle(
                    fontSize: 17,
                    fontFamily: 'OpenSans',
                    letterSpacing: 3.0,
                    color: Colors.black,
                ),),
              )
          )
        ]
      ));
    });

    HomestayCommonFacilityModel? homestayFacility(String facility) {
      if(homestayModel!.homestayCommonFacilities.where((element) => element.name.toLowerCase().compareTo(facility) == 0).isNotEmpty) {
        return homestayModel!.homestayCommonFacilities.where((element) => element.name.toLowerCase().compareTo(facility) == 0).single;
      }

      return null;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: Text("${homestayModel!.name}", style: const TextStyle(
              fontSize: 25,
              fontFamily: 'OpenSans',
              letterSpacing: 2.0,
              color: Colors.black87,
              fontWeight: FontWeight.bold
          ))
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.attach_money, color: Colors.green),
                      Text  ("${currencyFormat.format(homestayModel?.homestayPriceLists!.first.price)} ~ ${currencyFormat.format(homestayModel?.homestayPriceLists!.last.price)}/day", style: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'OpenSans',
                          letterSpacing: 2.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold
                      )),
                      const SizedBox(width: 40,),
                      const Icon(Icons.bedroom_parent_sharp, color: Colors.red,),
                      Text("${homestayModel?.numberOfRoom}/rooms", style: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'OpenSans',
                          letterSpacing: 2.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold
                      )),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.red),
                      Text("${homestayModel?.address}", style: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'OpenSans',
                          letterSpacing: 2.0,
                          color: Colors.black87,
                          fontWeight: FontWeight.bold
                      )),
                    ],
                  )
                ],
              )
          ],
        ),
        const SizedBox(height: 20),

        // firebaseAuth.currentUser != null
        // ? FutureBuilder(
        //     future: bookingService.getNearestBookingDate(firebaseAuth.currentUser?.email, homestayModel!.name!),
        //     builder: (context, snapshot) {
        //       if(snapshot.connectionState == ConnectionState.waiting) {
        //         return const SizedBox();
        //       } else if(snapshot.hasData) {
        //         final snapshotData = snapshot.data;
        //
        //         if(snapshotData is BookingModel) {
        //           int remainDate = formatDate.parse(snapshotData.checkIn).difference(DateTime.now()).inDays;
        //           if(remainDate > 0) {
        //             final msg = remainDate == 0 ? "today" : remainDate == 1 ? "tomorrow" : "within $remainDate";
        //             return Center(child: Text("You have appointment $msg", style: const TextStyle(
        //                 fontSize: 14,
        //                 fontFamily: 'OpenSans',
        //                 letterSpacing: 1.0,
        //                 color: Colors.black87,
        //                 fontWeight: FontWeight.bold
        //             ),));
        //           } else {
        //             return const SizedBox();
        //           }
        //         }
        //       }else if(snapshot.hasError) {
        //
        //         return const SizedBox();
        //       }
        //
        //       return const SizedBox();
        //     },
        // ) : Container(),

        const SizedBox(height: 12,),

        FutureBuilder(
            future: bookingService.configureHomestayDetailBooking(firebaseAuth.currentUser?.email, homestayModel!.name!),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting) {
                return const SizedBox();
              } else if(snapshot.hasData) {
                String configuration = snapshot.data as String;
              // : configuration.compareTo("BOOKING_PROGRESS") == 0
              // ? Colors.green
                return Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if(firebaseAuth.currentUser == null) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(homestayName: homestayModel!.name, isSignInFromBookingScreen: true),));
                        } else if(configuration.compareTo("INSUFFICIENT_BALANCE") == 0) {

                        } else if(configuration.compareTo("ACCESS_DENIED") == 0) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(homestayName: homestayModel!.name, isSignInFromBookingScreen: true),));
                        } else {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => BookingScreen(homestayModel: homestayModel, chooseCheckInPhase: true)));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          primary: firebaseAuth.currentUser == null
                              ? Colors.red
                              : configuration.compareTo("INSUFFICIENT_BALANCE") == 0
                              ? Colors.redAccent
                              : kPrimaryColor, elevation: 0),
                      child: Text(
                        firebaseAuth.currentUser == null
                            ? "Sign Up For Booking".toUpperCase()
                            : configuration.compareTo("INSUFFICIENT_BALANCE") == 0 ? "Insufficient balance".toUpperCase()
                            : configuration.compareTo("ACCESS_DENIED") == 0 ? "Pre-login".toUpperCase()
                  : "Book".toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    configuration.compareTo("BOOKING_PROGRESS") == 0 ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const SizedBox(height: 5,),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => BookingListScreen(homestayName: homestayModel!.name,email: firebaseAuth.currentUser!.email),));
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,

                          ),
                          child:  Text(
                            "Booking history".toUpperCase(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ) : Container()
                  ],
                );
              }
              return ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    primary: Colors.grey, elevation: 0),
                child: const Text(
                  "Something wrong",
                  style: TextStyle(color: Colors.black),
                ),
              );
            },
        ),
        const SizedBox(height: 10,),
        Container(
          margin: const EdgeInsets.only(top: 20, bottom: 10),
          child: const Text(
            "Description: ",
            style: TextStyle(
                fontSize: 25,
                fontFamily: 'OpenSans',
                letterSpacing: 3.0,
                color: kPrimaryColor,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        Row(
          children: [
            Flexible(
                child: Text(
                  "${homestayModel?.description!}",
                  maxLines: 10,
                  softWrap: true,
                  overflow: TextOverflow.fade,
                  style: const TextStyle(
                      fontSize: 17,
                      fontFamily: 'OpenSans',
                      letterSpacing: 2.0,
                      color: Colors.black,
                  ),
                )
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 20, bottom: 10),
          child: const Text(
            "Ratings: ",
            style: TextStyle(
                fontSize: 25,
                fontFamily: 'OpenSans',
                letterSpacing: 3.0,
                color: kPrimaryColor,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        Center(
          child: Column(
            children: [
              const Text(
                "Security: ",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'OpenSans',
                    letterSpacing: 1.5,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 15,),
              RatingComponent(size: 30.0 , point: double.parse(homestayModel!.securityPoint.toStringAsFixed(1))),
              const SizedBox(height: 15,),
              const Text(
                "Convenient: ",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'OpenSans',
                    letterSpacing: 1.5,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 15,),
              RatingComponent(size: 30.0 , point: double.parse(homestayModel!.convenientPoint.toStringAsFixed(1))),
              const SizedBox(height: 15,),
              const Text(
                "Position: ",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'OpenSans',
                    letterSpacing: 1.5,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 15,),
              RatingComponent(size: 30.0 , point: double.parse(homestayModel!.positionPoint.toStringAsFixed(1))),
              const SizedBox(height: 15,),
              const Divider(color: Colors.black,thickness: 0.5,),
              const SizedBox(height: 15,),
              const Text(
                "Average: ",
                style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'OpenSans',
                    letterSpacing: 1.5,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(height: 15,),
              RatingComponent(size: 30.0 , point: double.parse(homestayModel!.averagePoint.toStringAsFixed(1))),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 10, top: 20),
          child: const Text(
            "Service table: ",
            style: TextStyle(
                fontSize: 25,
                fontFamily: 'OpenSans',
                letterSpacing: 3.0,
                color: kPrimaryColor,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        Center(
          child: homestayModel!.homestayServices.isNotEmpty ? Container(
            width: 300,
            child: Table(
                border: TableBorder.all(color: Colors.black54.withOpacity(0.2)),
                columnWidths: const {
                  0 : IntrinsicColumnWidth(),
                  2 : IntrinsicColumnWidth()
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: homestayServiceRows
            ),
          ) : const Text("Landlord didn't register any service",style: TextStyle(
              fontSize: 17,
              fontFamily: 'OpenSans',
              letterSpacing: 1.0,
              color: Colors.black,
              fontWeight: FontWeight.bold
          )),
        ),

        Container(
          margin: const EdgeInsets.only(bottom: 10, top: 20),
          child: const Text(
            "Normal day price list: ",
            style: TextStyle(
                fontSize: 25,
                fontFamily: 'OpenSans',
                letterSpacing: 3.0,
                color: kPrimaryColor,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        Center(
          child: SizedBox(
            width: 300,
            child: Table(
                border: TableBorder.all(color: Colors.black54.withOpacity(0.2)),
                columnWidths: const {
                  0 : IntrinsicColumnWidth(),
                  2 : IntrinsicColumnWidth()
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: homestayNormalAndWeekendPriceListRows
            ),
          )
        ),

        Container(
          margin: const EdgeInsets.only(bottom: 10, top: 20),
          child: const Text(
            "Special day price list: ",
            style: TextStyle(
                fontSize: 25,
                fontFamily: 'OpenSans',
                letterSpacing: 3.0,
                color: kPrimaryColor,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        SizedBox(
          width: 400,
          child: Table(
              border: TableBorder.all(color: Colors.black54.withOpacity(0.2)),
              columnWidths: const {
                0 : IntrinsicColumnWidth(),
                2 : IntrinsicColumnWidth()
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: homestaySpecialPriceListRows
          ),
        ),

        Container(
          margin: const EdgeInsets.only(bottom: 10, top: 20),
          child: const Text(
            "Common Facilities: ",
            style: TextStyle(
                fontSize: 25,
                fontFamily: 'OpenSans',
                letterSpacing: 3.0,
                color: kPrimaryColor,
                fontWeight: FontWeight.bold
            ),
          ),
        ),

        homestayModel!.homestayCommonFacilities.isNotEmpty
        ? SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            margin: const EdgeInsets.only(left: 10),
            child: Row(
              children: [

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    homestayFacility("tv") != null ? Row(
                      children: [
                        const Icon(Icons.tv, color: propertiesExistColor),
                        Text("${homestayFacility("tv")!.name} - ${homestayFacility("tv")!.amount} / units",style: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'OpenSans',
                          letterSpacing: 1.5,
                          color: Colors.black,
                        ),)
                      ],
                    ) : Row(
                      children: const [
                        Icon(Icons.tv, color: propertiesNonExistColor),
                        Text("TV - none",style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'OpenSans',
                          letterSpacing: 1.5,
                          color: Colors.black,
                        ),)
                      ],
                    ),

                    const SizedBox(height: 15),

                    homestayFacility("kitchen") != null ? Row(
                      children: [
                        const Icon(Icons.kitchen, color: propertiesExistColor),
                        Text("${homestayFacility("kitchen")!.name} - ${homestayFacility("kitchen")!.amount} / units",style: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'OpenSans',
                          letterSpacing: 1.5,
                          color: Colors.black,
                        ),)
                      ],
                    ) : Row(
                      children: const [
                        Icon(Icons.kitchen, color: propertiesNonExistColor),
                        Text("Kitchen - none",style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'OpenSans',
                          letterSpacing: 1.5,
                          color: Colors.black,
                        ),)
                      ],
                    ),

                    const SizedBox(height: 15),

                    homestayFacility("kitchen") != null ? Row(
                      children: [
                        const Icon(Icons.bed, color: propertiesExistColor),
                        Text("${homestayFacility("bed")!.name} - ${homestayFacility("bed")!.amount} / units",style: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'OpenSans',
                          letterSpacing: 1.5,
                          color: Colors.black,
                        ),)
                      ],
                    ) : Row(
                      children: const [
                        Icon(Icons.bed, color: propertiesNonExistColor),
                        Text("Bed - none",style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'OpenSans',
                          letterSpacing: 1.5,
                          color: Colors.black,
                        ),)
                      ],
                    ),

                    const SizedBox(height: 15),

                    homestayFacility("shower") != null ? Row(
                      children: [
                        const Icon(Icons.shower_outlined, color: propertiesExistColor),
                        Text("${homestayFacility("shower")!.name} - ${homestayFacility("shower")!.amount} / units",style: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'OpenSans',
                          letterSpacing: 1.5,
                          color: Colors.black,
                        ),)
                      ],
                    ) : Row(
                      children: const [
                        Icon(Icons.shower_outlined, color: propertiesNonExistColor),
                        Text("Shower - none",style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'OpenSans',
                          letterSpacing: 2.0,
                          color: Colors.black,
                        ),)
                      ],
                    ),
                  ],
                ),

                const SizedBox(width: 40,),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    homestayFacility("sofa") != null ? Row(
                      children: [
                        const Icon(Icons.chair_outlined, color: propertiesExistColor),
                        Text("${homestayFacility("sofa")!.name} - ${homestayFacility("sofa")!.amount} / units",style: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'OpenSans',
                          letterSpacing: 2.0,
                          color: Colors.black,
                        ),)
                      ],
                    ) : Row(
                      children: const [
                        Icon(Icons.chair_outlined, color: propertiesNonExistColor),
                        Text("Sofa - none",style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'OpenSans',
                          letterSpacing: 1.5,
                          color: Colors.black,
                        ),)
                      ],
                    ),

                    const SizedBox(height: 15),

                    homestayFacility("toilet") != null ? Row(
                      children: [
                        const Icon(Icons.wc, color: kPrimaryColor),
                        Text("${homestayFacility("toilet")!.name} - ${homestayFacility("toilet")!.amount} / units",style: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'OpenSans',
                          letterSpacing: 2.0,
                          color: Colors.black,
                        ),)
                      ],
                    ) : Row(
                      children: const [
                        Icon(Icons.wc_outlined, color: Colors.red),
                        Text("Toilet - none",style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'OpenSans',
                          letterSpacing: 2.0,
                          color: Colors.black,
                        ),)
                      ],
                    ),

                    const SizedBox(height: 15),

                    homestayFacility("fan") != null ? Row(
                      children: [
                        const FaIcon(FontAwesomeIcons.fan, color: kPrimaryColor,),
                        Text("${homestayFacility("fan")!.name} - ${homestayFacility("fan")!.amount} / units",style: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'OpenSans',
                          letterSpacing: 2.0,
                          color: Colors.black,
                        ),)
                      ],
                    ) : Row(
                      children: const [
                        FaIcon(FontAwesomeIcons.fan, color: Colors.red,),
                        Text("Fan - none",style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'OpenSans',
                          letterSpacing: 2.0,
                          color: Colors.black,
                        ),)
                      ],
                    ),

                    const SizedBox(height: 15),

                    homestayFacility("bathtub") != null ? Row(
                      children: [
                        const Icon(Icons.bathtub_outlined, color: kPrimaryColor,),
                        Text("${homestayFacility("bathtub")!.name} - ${homestayFacility("bathtub")!.amount} / units",style: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'OpenSans',
                          letterSpacing: 2.0,
                          color: Colors.black,
                        ),)
                      ],
                    ) : Row(
                      children: const [
                        Icon(Icons.bathtub_outlined, color: Colors.red,),
                        Text("Bathtub - none",style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'OpenSans',
                          letterSpacing: 2.0,
                          color: Colors.black,
                        ),)
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ) : const Text("Homestay does not contain common facility.",style:  TextStyle(
          fontSize: 15,
          fontFamily: 'OpenSans',
          letterSpacing: 2.0,
          color: Colors.black,
        )),

        Container(
          margin: const EdgeInsets.only(bottom: 10, top: 20),
          child: const Text(
            "Additional Facilities: ",
            style: TextStyle(
                fontSize: 25,
                fontFamily: 'OpenSans',
                letterSpacing: 3.0,
                color: kPrimaryColor,
                fontWeight: FontWeight.bold
            ),
          ),
        ),

        homestayModel!.homestayAdditionalFacilities.isNotEmpty
        ? Container(
          height: homestayModel!.homestayAdditionalFacilities.length == 1 ? 50 : homestayModel!.homestayAdditionalFacilities.length < 5 ? 70 : 100,
          margin: const EdgeInsets.only(left: 10),
          child: ListView.builder(
              itemCount: homestayModel!.homestayAdditionalFacilities.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    children: [
                      Text("${homestayModel!.homestayAdditionalFacilities[index].name}", style: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'OpenSans',
                          letterSpacing: 2.0,
                          color: propertiesExistColor,
                          fontWeight: FontWeight.bold
                      ),),
                      const SizedBox(width: 5,),
                      const Text("-"),
                      const SizedBox(width: 5,),
                      Text("${homestayModel!.homestayAdditionalFacilities[index].amount} / unit", style: const TextStyle(
                        fontSize: 15,
                        fontFamily: 'OpenSans',
                        letterSpacing: 2.0,
                        color: Colors.black,
                      ),),
                    ],
                  ),
                );
              },
          ),
        ) : const SizedBox(
          height: 150,
          child: Center(
            child: Text("Homestay does not contain additional facilities."),
          ),
        ),


        Container(
          margin: const EdgeInsets.only(bottom: 10, top: 20),
          child: const Text(
            "Landlord contacts: ",
            style: TextStyle(
                fontSize: 25,
                fontFamily: 'OpenSans',
                letterSpacing: 3.0,
                color: kPrimaryColor,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        
        FutureBuilder(
            future: userService.findUserByUsername(homestayModel!.owner),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting) {
                return const SpinKitComponent();
              } else if(snapshot.hasData) {
                var snapshotData = snapshot.data;
                if(snapshotData is PassengerModel) {
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text("Username: ",  style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'OpenSans',
                            letterSpacing: 3.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        )),
                        Text("${snapshotData.username}",  style: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'OpenSans',
                          letterSpacing: 3.0,
                          color: Colors.black,
                        )),
                        const SizedBox(height: 15),
                        const Text("Email:",  style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'OpenSans',
                            letterSpacing: 3.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        )),
                        Text("${snapshotData.email}",  style: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'OpenSans',
                          letterSpacing: 3.0,
                          color: Colors.black,

                        )),
                        const SizedBox(height: 15),
                        const Text("Phone: ",  style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'OpenSans',
                            letterSpacing: 3.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                        )),
                        Text("${snapshotData.phone}",  style: const TextStyle(
                          fontSize: 15,
                          fontFamily: 'OpenSans',
                          letterSpacing: 3.0,
                          color: Colors.black,
                        ))
                      ],
                    ),
                  );
                } else if(snapshotData is ErrorHandlerModel){
                  return Text("${snapshotData.message}");
                }
              } else {
                return const Text("Error loading landlord's information");
              }

              return Container();
            },
        )
      ],
    );
  }
}
