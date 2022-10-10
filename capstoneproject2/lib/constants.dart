import 'package:flutter/material.dart';

const kPrimaryColor = Colors.lightBlueAccent;
const kPrimaryLightColor = Colors.lightBlue;
const googleApiKey = "AIzaSyCZQviiuwR3Dxs_MWYf614pqjXPUxGJ6bM";

const double defaultPadding = 16.0;

const bookingStatus = {
  "all" : "all",
  "pending" : "BOOKING_PENDING",
  "pending_alert_sent" : "BOOKING_PENDING_ALERT_SENT",
  "deposit" : "BOOKING_PENDING_DEPOSIT",
  "accepted" : "BOOKING_ACCEPTED",
  "rejected" : "BOOKING_REJECTED",
  "canceled" : "BOOKING_CANCELED",
  "pending_check_in" : "BOOKING_PENDING_CHECKIN",
  "pending_check_in_remain_sent" : "BOOKING_PENDING_CHECKIN_REMAIN_SENT",
  "pending_check_in_appointment_sent" : "BOOKING_PENDING_CHECKIN_APPOINTMENT_SENT",
  "check_in" : "BOOKING_CONFIRM_CHECKIN",
  "relative_check_in" : "BOOKING_CHECKIN_BY_PASSENGER_RELATIVE",
  "landlord_check_in" : "BOOKING_CHECKIN_BY_LANDLORD",
  "pending_check_out" : "BOOKING_PENDING_CHECKOUT",
  "check_out" : "BOOKING_CONFIRM_CHECKOUT",
  "landlord_check_out" : "BOOKING_CHECKOUT_BY_LANDLORD",
  "relative_check_out" : "BOOKING_CHECKOUT_BY_PASSENGER_RELATIVE",
   "finish" : "BOOKING_FINISHED"
};

const homestayStatus = {};

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


