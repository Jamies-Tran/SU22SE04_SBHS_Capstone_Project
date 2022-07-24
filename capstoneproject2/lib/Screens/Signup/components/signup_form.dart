import 'package:capstoneproject2/locator/service_locator.dart';
import 'package:capstoneproject2/model/error_handler_model.dart';
import 'package:capstoneproject2/model/passenger_model.dart';
import 'package:capstoneproject2/services/passenger_service.dart';
import 'package:flutter/material.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Login/login_screen.dart';

// mấy cái form nhập dữ liệu nên sài stateful
class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override
  void initState() {
    setup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    IPassengerService passengerService = locator.get<IPassengerService>();

    return Form(
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          // Padding(padding: padding)
          const SizedBox(height: defaultPadding / 2),
          ElevatedButton(
            onPressed: () async {
              PassengerModel passengerModel = PassengerModel(
                  username: "passengerFromMobile002",
                  password: "passengerFromMobile002",
                  address: "43 phan van tri, p2, q5",
                  gender: "male",
                  email: "minhtq2198@gmail.com",
                  phone: "0981874703",
                  citizenIdentificationString: "0000000003",
                  dob: "1997-02-01",
                  avatarUrl: "passenger avatar3"
              );
              dynamic responseFromServer = await passengerService.registerPassenger(passengerModel);
              if(responseFromServer is PassengerModel) {
                // TODO: Nếu server trả về object là PassengerModel có nghĩa là đã đăng kí thành công, chuyển sang trang login
                print("username: ${responseFromServer.username} - email: ${responseFromServer.email}");
              } else if(responseFromServer is ErrorHandlerModel) {
                // TODO: Nếu server trả về object là ErrorHandlerModel có nghĩa là đã có lỗi , lấy message show lên pop-up
                print("error message: ${responseFromServer.message}");
              }
            },
            child: Text("Sign Up".toUpperCase()),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            login: false,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const LoginScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}