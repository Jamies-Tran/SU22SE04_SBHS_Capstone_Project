import 'package:capstoneproject2/locator/service_locator.dart';
import 'package:capstoneproject2/model/auth_model.dart';
import 'package:capstoneproject2/model/error_handler_model.dart';
import 'package:capstoneproject2/services/auth_service.dart';
import 'package:flutter/material.dart';

import '../../../components/already_have_an_account_acheck.dart';
import '../../../constants.dart';
import '../../Signup/signup_screen.dart';

// mấy cái form nhập dữ liệu nên sài stateful
class LoginForm extends StatefulWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  
  @override
  void initState() {

    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    IAuthenticateService authenticateService = locator.get<IAuthenticateService>();
    
    return Form(
      child: Column(
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: const InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
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
          const SizedBox(height: defaultPadding),
          Hero(
            tag: "login_btn",
            child: ElevatedButton(
              onPressed: () async {
                AuthenticateModel authenticateModel = AuthenticateModel(userInfo: "passenger001", password: "passenger001");
                dynamic responseFromServer = await authenticateService.login(authenticateModel);
                if(responseFromServer is AuthenticateModel) {
                  // TODO: Nếu server trả về object là AuthenticateModel có nghĩa là đã đăng nhập thành công, chuyển sang trang chủ
                  print("user infor : ${responseFromServer.userInfo} - jwt token: ${responseFromServer.jwtToken}");
                } else if(responseFromServer is ErrorHandlerModel) {
                  print("messge: ${responseFromServer.message}");
                }
              },
              child: Text(
                "Login".toUpperCase(),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return SignUpScreen();
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
