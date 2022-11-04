import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:staywithme_passenger_application/bloc/complete_google_auth_bloc.dart';
import 'package:staywithme_passenger_application/bloc/event/auth_by_google_event.dart';
import 'package:staywithme_passenger_application/bloc/event/authentication_event.dart';
import 'package:staywithme_passenger_application/bloc/register_bloc.dart';
import 'package:staywithme_passenger_application/bloc/state/register_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static const registerAccountRoute = "/register_account";

  @override
  State<RegisterScreen> createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  final formState = GlobalKey<FormState>();
  final registerBloc = RegisterBloc();
  final dateFormat = DateFormat("yyyy-MM-dd");
  final dobTextFieldController = TextEditingController();

  @override
  void dispose() {
    registerBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
          child: StreamBuilder<RegisterState>(
            stream: registerBloc.stateController.stream,
            initialData: registerBloc.initData,
            builder: (context, snapshot) {
              return Column(children: [
                const Center(
                  child: Text(
                    "Register account",
                    style: TextStyle(
                        fontSize: 35,
                        fontFamily: "SourceCodePro",
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                    key: formState,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    fillColor: Colors.white,
                                    focusColor: Colors.grey,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(3.0)),
                                        borderSide: BorderSide(
                                            color: Colors.blueAccent,
                                            width: 1.0)),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(3.0)),
                                        borderSide: BorderSide(
                                            color: Colors.redAccent,
                                            width: 1.0)),
                                    label: Text("Username"),
                                    prefixIcon: Icon(Icons.account_box)),
                                onChanged: (value) => registerBloc
                                    .eventController.sink
                                    .add(InputUsernameEvent(username: value)),
                                validator: (value) =>
                                    snapshot.data!.validateUsername(),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    fillColor: Colors.white,
                                    focusColor: Colors.grey,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(3.0)),
                                        borderSide: BorderSide(
                                            color: Colors.blueAccent,
                                            width: 1.0)),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(3.0)),
                                        borderSide: BorderSide(
                                            color: Colors.redAccent,
                                            width: 1.0)),
                                    label: Text("Password"),
                                    prefixIcon: Icon(Icons.lock)),
                                onChanged: (value) => registerBloc
                                    .eventController.sink
                                    .add(InputPasswordEvent(password: value)),
                                validator: (value) =>
                                    snapshot.data!.validatePassword(),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                    fillColor: Colors.white,
                                    focusColor: Colors.grey,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(3.0)),
                                        borderSide: BorderSide(
                                            color: Colors.blueAccent,
                                            width: 1.0)),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(3.0)),
                                        borderSide: BorderSide(
                                            color: Colors.redAccent,
                                            width: 1.0)),
                                    label: Text("Email"),
                                    prefixIcon: Icon(Icons.email)),
                                onChanged: (value) => registerBloc
                                    .eventController.sink
                                    .add(InputEmailEvent(email: value)),
                                validator: (value) =>
                                    snapshot.data!.validateEmail(),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    fillColor: Colors.white,
                                    focusColor: Colors.grey,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(3.0)),
                                        borderSide: BorderSide(
                                            color: Colors.blueAccent,
                                            width: 1.0)),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(3.0)),
                                        borderSide: BorderSide(
                                            color: Colors.redAccent,
                                            width: 1.0)),
                                    label: Text("Address"),
                                    prefixIcon: Icon(Icons.location_city)),
                                onChanged: (value) => registerBloc
                                    .eventController.sink
                                    .add(InputAddressEvent(address: value)),
                                validator: (value) =>
                                    snapshot.data!.validateAddress(),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                keyboardType: TextInputType.phone,
                                decoration: const InputDecoration(
                                    fillColor: Colors.white,
                                    focusColor: Colors.grey,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(3.0)),
                                        borderSide: BorderSide(
                                            color: Colors.blueAccent,
                                            width: 1.0)),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(3.0)),
                                        borderSide: BorderSide(
                                            color: Colors.redAccent,
                                            width: 1.0)),
                                    label: Text("Phone"),
                                    prefixIcon: Icon(Icons.phone)),
                                onChanged: (value) => registerBloc
                                    .eventController.sink
                                    .add(InputPhoneEvent(phone: value)),
                                validator: (value) =>
                                    snapshot.data!.validatePhone(),
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                    fillColor: Colors.white,
                                    focusColor: Colors.grey,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(3.0)),
                                        borderSide: BorderSide(
                                            color: Colors.blueAccent,
                                            width: 1.0)),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(3.0)),
                                        borderSide: BorderSide(
                                            color: Colors.redAccent,
                                            width: 1.0)),
                                    label: Text("ID card"),
                                    prefixIcon: Icon(Icons.card_membership)),
                                onChanged: (value) => registerBloc
                                    .eventController.sink
                                    .add(InputCitizenIdentificationEvent(
                                        citizenIdentification: value)),
                                validator: (value) => snapshot.data!
                                    .validateCitizenIdentification(),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                                flex: 1,
                                child: SizedBox(
                                  height: 59,
                                  child: InputDecorator(
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(3.0),
                                          borderSide: const BorderSide(
                                              color: Colors.blueAccent,
                                              width: 1.0),
                                        ),
                                        label: const Text("Gender")),
                                    child: DropdownButton<String>(
                                      items: registerBloc.genderSelection
                                          .map((e) => DropdownMenuItem(
                                                value: e,
                                                child: Text(e),
                                              ))
                                          .toList(),
                                      value: snapshot.data!.gender,
                                      icon: snapshot.data!.gender == "Male"
                                          ? const Icon(
                                              Icons.boy,
                                              size: 20,
                                              color: Colors.blue,
                                            )
                                          : const Icon(
                                              Icons.girl,
                                              size: 20,
                                              color: Colors.pink,
                                            ),
                                      underline: const SizedBox(),
                                      onChanged: (value) => registerBloc
                                          .eventController.sink
                                          .add(InputGenderEvent(gender: value)),
                                    ),
                                  ),
                                )),
                            const SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              flex: 1,
                              child: TextFormField(
                                readOnly: true,
                                controller: dobTextFieldController,
                                decoration: const InputDecoration(
                                    fillColor: Colors.white,
                                    focusColor: Colors.grey,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(3.0)),
                                        borderSide: BorderSide(
                                            color: Colors.blueAccent,
                                            width: 1.0)),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(3.0)),
                                        borderSide: BorderSide(
                                            color: Colors.redAccent,
                                            width: 1.0)),
                                    label: Text("Birth day"),
                                    prefixIcon: Icon(Icons.calendar_today)),
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime(1980),
                                    firstDate: DateTime(1980),
                                    lastDate: DateTime(2004),
                                  ).then((value) {
                                    dobTextFieldController.text =
                                        dateFormat.format(value!);
                                    registerBloc.eventController.sink.add(
                                        InputDobEvent(
                                            dob: dobTextFieldController.text));
                                  });
                                },
                                validator: (value) =>
                                    snapshot.data!.validateDob(),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              if (formState.currentState!.validate()) {
                                registerBloc.eventController.sink.add(
                                    SubmitRegisterAccountEvent(
                                        address: snapshot.data!.address,
                                        avatarUrl: snapshot.data!.avatarUrl,
                                        citizenIdentification: snapshot
                                            .data!.citizenIdentification,
                                        dob: snapshot.data!.dob,
                                        email: snapshot.data!.email,
                                        gender: snapshot.data!.gender,
                                        password: snapshot.data!.password,
                                        phone: snapshot.data!.phone,
                                        username: snapshot.data!.username));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                minimumSize: const Size(300, 50),
                                maximumSize: const Size(300, 50)),
                            child: const Text(
                              "Submit",
                              style: TextStyle(fontFamily: "Lobster"),
                            )),
                        const SizedBox(
                          height: 25,
                        ),
                        const Center(
                          child: Text(
                            "Or sign up with",
                            style: TextStyle(
                                fontFamily: "SourceCodePro",
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              registerBloc.eventController.sink.add(
                                  ChooseGoogleAccountEvent(context: context));
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                minimumSize: const Size(300, 50),
                                maximumSize: const Size(300, 50)),
                            child: const Text(
                              "Google Account",
                              style: TextStyle(fontFamily: "Lobster"),
                            )),
                      ],
                    ))
              ]);
            },
          ),
        ),
      )),
    );
  }
}

class ChooseGoogleAccountScreen extends StatefulWidget {
  const ChooseGoogleAccountScreen({super.key});

  static const chooseGoogleAccountScreenRoute = "/choose-google-account";

  @override
  State<ChooseGoogleAccountScreen> createState() =>
      _ChooseGoogleAccountScreenState();
}

class _ChooseGoogleAccountScreenState extends State<ChooseGoogleAccountScreen> {
  final registerBloc = RegisterBloc();
  final completeGoogleAuthBloc = CompleteGoogleAuthBloc();

  @override
  void dispose() {
    registerBloc.dispose();
    completeGoogleAuthBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final googleSignIn = GoogleSignIn();
    return Scaffold(
        backgroundColor: Colors.blueAccent,
        body: FutureBuilder(
          future: googleSignIn.signIn(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              completeGoogleAuthBloc.eventController.sink
                  .add(BackwardToRegisterScreenEvent(context: context));
            } else {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SpinKitCircle(
                        color: Colors.white,
                      ),
                      Text(
                        "Wait a sec...",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            fontFamily: "SourceCodePro"),
                      ),
                    ],
                  );
                case ConnectionState.active:
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SpinKitCircle(
                        color: Colors.white,
                      ),
                      Text(
                        "Getting your google accounts...",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            fontFamily: "SourceCodePro"),
                      ),
                    ],
                  );
                case ConnectionState.done:
                  if (snapshot.hasData) {
                    completeGoogleAuthBloc.eventController.sink.add(
                        ForwardCompleteGoogleRegisterScreenEvent(
                            context: context,
                            googleSignInAccount: snapshot.data,
                            googleSignIn: googleSignIn));
                  } else {
                    completeGoogleAuthBloc.eventController.sink
                        .add(BackwardToRegisterScreenEvent(context: context));
                  }
                  break;
                default:
                  return Container();
              }
            }

            return Container();
          },
        ));
  }
}
