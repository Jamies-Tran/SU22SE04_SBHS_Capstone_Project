import 'package:flutter/material.dart';
import 'package:staywithme_passenger_application/bloc/event/log_in_event.dart';
import 'package:staywithme_passenger_application/bloc/log_in_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String loginScreenRoute = "/log-in";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final loginBloc = LoginBlog();

  final usernameTextEditingCtl = TextEditingController();
  final passwordTextEditingCtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
        loginBloc.eventController.sink
            .add(FocusTextFieldLoginEvent(isFocus: false));
      },
      child: Stack(children: [
        Image.asset(
          "images/login_background.jpg",
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: StreamBuilder(
            stream: loginBloc.stateController.stream,
            initialData: loginBloc.initData(),
            builder: (context, snapshot) {
              return SafeArea(
                  top: true,
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          height: 200,
                          width: 300,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("images/login.jpg"),
                                fit: BoxFit.fill),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Form(
                          key: formKey,
                          child: Center(
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 300,
                                  child: TextFormField(
                                    controller: usernameTextEditingCtl,
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: snapshot.data!.focusColor(),
                                        label: const Text(
                                          "Username",
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.greenAccent,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        prefixIcon: const Icon(
                                          Icons.account_box,
                                          color: Colors.greenAccent,
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 2.5)),
                                        errorStyle: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.redAccent)),
                                    onTap: () => loginBloc.eventController.sink
                                        .add(FocusTextFieldLoginEvent(
                                            isFocus: true)),
                                    onEditingComplete: () => loginBloc
                                        .eventController.sink
                                        .add(FocusTextFieldLoginEvent(
                                            isFocus: false)),
                                    onChanged: (value) => loginBloc
                                        .eventController.sink
                                        .add(InputUsernameLoginEvent(
                                            username: value)),
                                    validator: (value) =>
                                        snapshot.data!.validateUsername(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                SizedBox(
                                  width: 300,
                                  child: TextFormField(
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: snapshot.data!.focusColor(),
                                        enabledBorder: const OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 2.5)),
                                        errorBorder: const OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(3.0)),
                                            borderSide: BorderSide(
                                                color: Colors.orange,
                                                width: 1.0)),
                                        errorStyle: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.redAccent),
                                        label: const Text(
                                          "Password",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.orange,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        prefixIcon: const Icon(
                                          Icons.lock,
                                          color: Colors.orange,
                                        )),
                                    onTap: () => loginBloc.eventController.sink
                                        .add(FocusTextFieldLoginEvent(
                                            isFocus: true)),
                                    onChanged: (value) => loginBloc
                                        .eventController.sink
                                        .add(InputPasswordLoginEvent(
                                            password: value)),
                                    validator: (value) =>
                                        snapshot.data!.validatePassword(),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {}
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                        minimumSize: const Size(300, 50),
                                        maximumSize: const Size(300, 50)),
                                    child: const Text(
                                      "Login",
                                      style: TextStyle(fontFamily: "Lobster"),
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.redAccent,
                                            minimumSize: const Size(140, 50),
                                            maximumSize: const Size(140, 50)),
                                        child: const Text(
                                          "Google",
                                          style:
                                              TextStyle(fontFamily: "Lobster"),
                                        )),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          loginBloc.eventController.sink.add(
                                              NavigateToRegScreenEvent(
                                                  context: context));
                                        },
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blueAccent,
                                            minimumSize: const Size(140, 50),
                                            maximumSize: const Size(140, 50)),
                                        child: const Text(
                                          "Register",
                                          style:
                                              TextStyle(fontFamily: "Lobster"),
                                        )),
                                  ],
                                )
                              ],
                            ),
                          )),
                    ],
                  ));
            },
          ),
        ),
      ]),
    );
  }
}
