import 'package:flutter/material.dart';

const kPrimaryColor = Colors.lightBlueAccent;
const kPrimaryLightColor = Colors.lightBlue;

const double defaultPadding = 16.0;

const bookingStatus = {
  "all" : "all",
  "pending" : "BOOKING_PENDING",
  "deposit" : "BOOKING_PENDING_DEPOSIT",
  "accepted" : "BOOKING_ACCEPTED",
  "rejected" : "BOOKING_REJECTED",
  "canceled" : "BOOKING_CANCELED",
  "pending_check_in" : "BOOKING_PENDING_CHECKIN",
  "check_in" : "BOOKING_CONFIRM_CHECKIN",
  "relative_check_in" : "BOOKING_CHECKIN_BY_PASSENGER_RELATIVE",
  "landlord_check_in" : "BOOKING_CHECKIN_BY_LANDLORD",
  "pending_check_out" : "BOOKING_PENDING_CHECKOUT",
  "check_out" : "BOOKING_CONFIRM_CHECKOUT",
   "finish" : "BOOKING_FINISHED"
};

const bookingStatusDropdown = {
  "all" : "all",
  "pending" : "BOOKING_PENDING",
  "deposit" : "BOOKING_PENDING_DEPOSIT",
  "accepted" : "BOOKING_ACCEPTED",
  "rejected" : "BOOKING_REJECTED",
  "canceled" : "BOOKING_CANCELED",
  "success" : "BOOKING_PENDING_CHECKIN",
  "check-in" : "BOOKING_CONFIRM_CHECKIN",
  "check-out" : "BOOKING_CONFIRM_CHECKOUT",
  "finish" : "BOOKING_FINISHED"
};

const cityName = {
  "hcm" : "TP.HCM",
  "dl" : "TP.Da Lat",
  "hn" : "TP.Ha Noi",
  "qn" : "Quang Nam",
  "dn" : "TP.Da Nang",
  "vt" : "Vung Tau"
};


