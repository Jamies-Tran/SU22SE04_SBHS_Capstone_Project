import '../model/passenger_model.dart';

const baseUserUrl = "http://10.0.2.2:8080/api/user";

abstract class IPassengerService {
  Future<dynamic> registerPassenger(PassengerModel passengerModel);
}