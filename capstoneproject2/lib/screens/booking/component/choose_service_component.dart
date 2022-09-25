import 'package:capstoneproject2/constants.dart';
import 'package:capstoneproject2/screens/booking/booking_screen.dart';
import 'package:capstoneproject2/screens/booking/component/booking_schedule_component.dart';
import 'package:capstoneproject2/services/model/homestay_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChooseServiceComponent extends StatefulWidget {
  const ChooseServiceComponent({
    Key? key,
    this.homestayModel,
    this.checkIn,
    this.checkOut,
    this.totalPriceOfBookingDays,
    this.balance
  }) : super(key: key);
  final HomestayModel? homestayModel;
  final String? checkIn;
  final String? checkOut;
  final TotalPriceOfBookingDays? totalPriceOfBookingDays;
  final int? balance;

  @override
  State<ChooseServiceComponent> createState() => _ChooseServiceComponentState();
}

class _ChooseServiceComponentState extends State<ChooseServiceComponent> {
  Map<int, bool> markSelectedService = {};
  final currencyFormat = NumberFormat("#,##0");
  List<HomestayServiceModel> homestayServices = [];



  @override
  Widget build(BuildContext context) {
    int getTotalPhasePrice() {
      int total = widget.totalPriceOfBookingDays!.totalPrice!;
      if(homestayServices.isNotEmpty) {
        for (var element in homestayServices) {
          total = total + element.price!;
        }
      }
      return total;
    }

    if(widget.homestayModel!.homestayServices.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("Homestay does not contain any services.", style: TextStyle(
            fontSize: 15,
            fontFamily: 'OpenSans',
            letterSpacing: 2.0,
            color: Colors.black,
          )),
          const SizedBox(height: 50,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: kPrimaryLightColor,
              maximumSize: const Size(200, 56),
              minimumSize: const Size(200, 56),
            ),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BookingScreen(
                  homestayModel: widget.homestayModel,
                  chooseCheckOutPhase: false,
                  chooseCheckInPhase: false,
                  chooseServicesPhase: false,
                  finishingPhase: true,
                  checkInDate: widget.checkIn,
                  checkOutDate: widget.checkOut,
                  homestayServiceList: homestayServices,
                  totalPriceOfBookingDays: widget.totalPriceOfBookingDays,
              ),));
            },
            child: const Text("Skip"),
          )
        ],
      );
    } else {
      return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(
              height: 150,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: widget.homestayModel!.homestayServices.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Row(
                        children: [
                          Text(
                              "${widget.homestayModel!.homestayServices[index].name}", style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'OpenSans',
                              letterSpacing: 2.0,
                              fontWeight: FontWeight.bold,
                              color: markSelectedService[index] == true ? Colors.green : Colors.black,
                          )),
                          markSelectedService[index] == true ? const Icon(Icons.check, color: Colors.green,) : const SizedBox()
                        ],
                      ),
                      subtitle: Text(
                        "Price: ${currencyFormat.format(widget.homestayModel!.homestayServices[index].price)} VND"
                      ),
                      onTap: () {
                       setState(() {
                         markSelectedService[index] = markSelectedService[index] != null ? !markSelectedService[index]! : true;
                         if(markSelectedService[index] == true) {
                           homestayServices.add(widget.homestayModel!.homestayServices[index]);
                         } else {
                           homestayServices.remove(widget.homestayModel!.homestayServices[index]);
                         }
                       });
                      },
                    );
                  },
              ),
            ),
            const SizedBox(height: 20,),
            Center(
              child: Text("Total: ${currencyFormat.format(getTotalPhasePrice())} VND", style: TextStyle(
                fontFamily: 'OpenSans',
                letterSpacing: 1.0,
                color: widget!.balance! < getTotalPhasePrice() ? Colors.redAccent : Colors.green,
              ))
            ),
            const SizedBox(height: 20,),
            homestayServices.isNotEmpty ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: widget!.balance! >= getTotalPhasePrice() ? Colors.green : Colors.red,
                  maximumSize: const Size(200, 56),
                  minimumSize: const Size(200, 56),
                ),
                onPressed: () {
                  if(widget!.balance! >= getTotalPhasePrice()) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => BookingScreen(
                        homestayModel: widget.homestayModel,
                        chooseCheckOutPhase: false,
                        chooseCheckInPhase: false,
                        chooseServicesPhase: false,
                        finishingPhase: true,
                        checkInDate: widget.checkIn,
                        checkOutDate: widget.checkOut,
                        homestayServiceList: homestayServices,
                        totalPriceOfBookingDays: widget.totalPriceOfBookingDays,
                    ),));
                  }

                },
                child: Text(widget!.balance! >= getTotalPhasePrice() ? "Select".toUpperCase() : "Insufficient balance".toUpperCase())
            ) : ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: kPrimaryLightColor,
                maximumSize: const Size(200, 56),
                minimumSize: const Size(200, 56),
              ),
              onPressed: () {
                widget.totalPriceOfBookingDays?.totalPrice = getTotalPhasePrice();
                Navigator.push(context, MaterialPageRoute(builder: (context) => BookingScreen(
                    homestayModel: widget.homestayModel,
                    chooseCheckOutPhase: false,
                    chooseCheckInPhase: false,
                    chooseServicesPhase: false,
                    finishingPhase: true,
                    checkInDate: widget.checkIn,
                    checkOutDate: widget.checkOut,
                    totalPriceOfBookingDays: widget.totalPriceOfBookingDays,
                    homestayServiceList: homestayServices
                ),));
              },
              child: Text("Skip".toUpperCase()),
            ),



          ],
        ),
      );
    }
  }
}
