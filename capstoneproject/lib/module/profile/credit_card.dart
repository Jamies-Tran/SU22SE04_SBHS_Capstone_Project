import 'package:capstoneproject/data/repository/booking_repository.dart';
import 'package:capstoneproject/data/service/booking_service.dart';
import 'package:capstoneproject/module/booking/cubit/booking_cubit.dart';
import 'package:capstoneproject/ui_kit/cubit/loading_cubit.dart';
import 'package:capstoneproject/ui_kit/widget/air_18_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';

import '../../ui_kit/widget/air_18_notification_dialog.dart';

class AddCreditCard extends StatefulWidget {
  final String roomId, checkIn, checkOut, clientMessage;

  const AddCreditCard(
      {Key? key,
      required this.roomId,
      required this.checkIn,
      required this.checkOut,
      required this.clientMessage})
      : super(key: key);

  static Route route(
      {required String roomId,
      required String checkIn,
      required String checkOut,
      required String clientMessage}) {
    return MaterialPageRoute(
      builder: (_) => AddCreditCard(
          roomId: roomId,
          checkIn: checkIn,
          checkOut: checkOut,
          clientMessage: clientMessage),
    );
  }

  @override
  _AddCreditCardState createState() => _AddCreditCardState();
}

class _AddCreditCardState extends State<AddCreditCard> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late LoadingCubit loadingCubit = LoadingCubit();
  late BookingService bookingService = BookingService();
  late BookingRepository bookingRepository =
      BookingRepository(bookingService: bookingService);
  late BookingCubit bookingCubit = BookingCubit(repository: bookingRepository);

  @override
  void initState() {
    super.initState();
    bookingCubit.stream.listen((state) {
      if (state is BookingStateLoading) {
        loadingCubit.showLoading();
      } else if (state is BookingStateSuccessful) {
        loadingCubit.hideLoading();
        showDialog(
          context: context,
          builder: (context) => Air18NotificationDialog(
            title: "Notification",
            content: "You have paid your bill, wish you a happy journey.",
            positive: "Let's go",
            onPositiveTap: () {
              Navigator.pop(context);
              bookingCubit.completed();
            },
            onNegativeTap: () {},
            isShowNegative: false,
          ),
        );
      } else if (state is BookingStateFailure) {
        loadingCubit.hideLoading();
        if(state.message == "You have been booked this room"){
          showDialog(
            context: context,
            builder: (context) => Air18NotificationDialog(
              title: "Notification",
              content: "You have been booked this room. Don't purchase again, wish you a happy journey.",
              positive: "Let's go",
              onPositiveTap: () {
                Navigator.pop(context);
                bookingCubit.completed();
              },
              onNegativeTap: () {},
              isShowNegative: false,
            ),
          );
        }else{
          showDialog(
            context: context,
            builder: (context) => Air18NotificationDialog(
              title: "Notification",
              content: state.message,
              positive: "Ok",
              onPositiveTap: () => Navigator.pop(context),
              onNegativeTap: () {},
              isShowNegative: false,
            ),
          );
        }
      }
      else if(state is BookingStateCompleted){
        Navigator.popUntil(context, (route) => route.isFirst);
      }
    });
  }

  // addData() async {
  //   Navigator.of(context).pop();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Credit Card',
          style: TextStyle(
              fontFamily: "Sofia",
              fontWeight: FontWeight.w800,
              fontSize: 22.0,
              color: Colors.black),
        ),
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0, left: 0.0, right: 0.0),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 10.0),
                      child: Text(
                        'Enter Credit Card',
                        style: TextStyle(
                          fontFamily: "Sofia",
                          color: Colors.black26,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 0.0,
                    ),
                    CreditCardWidget(
                      cardNumber: cardNumber,
                      expiryDate: expiryDate,
                      cardHolderName: cardHolderName,
                      cvvCode: cvvCode,
                      showBackView: isCvvFocused,
                      cardBgColor: const Color(0xFF8DA2BF),
                      onCreditCardWidgetChange: (CreditCardBrand) {},
                    ),
                    SingleChildScrollView(
                      child: CreditCardForm(
                        formKey: formKey,
                        obscureCvv: true,
                        obscureNumber: true,
                        cardNumberDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Number',
                          hintText: 'XXXX XXXX XXXX XXXX',
                        ),
                        expiryDateDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Expired Date',
                          hintText: 'XX/XX',
                        ),
                        cvvCodeDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'CVV',
                          hintText: 'XXX',
                        ),
                        cardHolderDecoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Card Holder',
                        ),
                        onCreditCardModelChange: onCreditCardModelChange,
                        cardHolderName: '',
                        cardNumber: '',
                        cvvCode: '',
                        expiryDate: '',
                        themeColor: Colors.blueGrey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 15.0, right: 15.0, bottom: 20.0, top: 50.0),
                      child: InkWell(
                        onTap: () async {
                          print(expiryDate.replaceAll("/", ""));
                          print(cardNumber);
                          bookingCubit.pay(
                            idRoom: widget.roomId,
                            checkIn: widget.checkIn,
                            checkOut: widget.checkOut,
                            clientMessage: "",
                            cardNumber: cardNumber.replaceAll(" ", ""),
                            cardExp: expiryDate.replaceAll("/", ""),
                            cardCVV: cvvCode,
                          );
                        },
                        child: Container(
                          height: 53.0,
                          width: double.infinity,
                          child: const Center(
                            child: Text(
                              'Pay',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Sofia",
                                  fontSize: 19.0),
                            ),
                          ),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              color: Color(0xFF8DA2BF)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Air18Loading(loadingCubit: loadingCubit)
        ],
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
