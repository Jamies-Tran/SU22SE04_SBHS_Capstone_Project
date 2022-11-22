import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:staywithme_passenger_application/bloc/complete_google_reg_bloc.dart';
import 'package:staywithme_passenger_application/bloc/event/reg_google_event.dart';

// TODO: update complete gg reg screen
class CompleteGoogleRegisterScreen extends StatefulWidget {
  const CompleteGoogleRegisterScreen({super.key});

  static const completeGoogleRegisterScreenRoute = "/complete_google_sign_in";

  @override
  State<CompleteGoogleRegisterScreen> createState() =>
      _CompleteGoogleRegisterScreenState();
}

class _CompleteGoogleRegisterScreenState
    extends State<CompleteGoogleRegisterScreen> {
  final completeGoogleRegisterBloc = CompleteGoogleRegBloc();
  final formState = GlobalKey<FormState>();
  final dobTextFieldController = TextEditingController();
  final dateFormat = DateFormat("yyyy-MM-dd");

  @override
  Widget build(BuildContext context) {
    final getArguments = ModalRoute.of(context)!.settings.arguments as Map;
    final TextEditingController usernameTextFieldController =
        getArguments["usernameTextEditingCtl"];
    final TextEditingController emailTextFieldController =
        getArguments["emailTextEditingCtl"];
    final GoogleSignIn googleSignIn = getArguments["googleSignIn"];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  StreamBuilder(
                    stream: completeGoogleRegisterBloc.stateController.stream,
                    initialData: completeGoogleRegisterBloc.initData(
                        usernameTextFieldController.text,
                        emailTextFieldController.text),
                    builder: (context, snapshot) {
                      return Column(children: [
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(top: 10),
                            height: 100,
                            width: 370,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "images/complete_register.jpg"),
                                  fit: BoxFit.fill),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Form(
                            key: formState,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: usernameTextFieldController,
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
                                  onChanged: (value) =>
                                      completeGoogleRegisterBloc
                                          .eventController.sink
                                          .add(InputUsernameGoogleAuthEvent(
                                              username: value)),
                                  validator: (value) =>
                                      snapshot.data!.validateUsername(),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                TextFormField(
                                  controller: emailTextFieldController,
                                  readOnly: true,
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
                                  onChanged: (value) =>
                                      completeGoogleRegisterBloc
                                          .eventController.sink
                                          .add(ReceiveEmailGoogleAuthEvent(
                                              email: value)),
                                  validator: (value) =>
                                      snapshot.data!.validateEmail(),
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                TextFormField(
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
                                  onChanged: (value) => completeGoogleRegisterBloc
                                      .eventController.sink
                                      .add(
                                          InputCitizenIdentificationGoogleAuthEvent(
                                              citizenIdentification: value)),
                                  validator: (value) => snapshot.data!
                                      .validateCitizenIdentification(),
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
                                        onChanged: (value) =>
                                            completeGoogleRegisterBloc
                                                .eventController.sink
                                                .add(InputPhoneGoogleAuthEvent(
                                                    phone: value)),
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
                                            prefixIcon:
                                                Icon(Icons.location_city)),
                                        onChanged: (value) =>
                                            completeGoogleRegisterBloc
                                                .eventController.sink
                                                .add(
                                                    InputAddressGoogleAuthEvent(
                                                        address: value)),
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
                                            prefixIcon:
                                                Icon(Icons.calendar_today)),
                                        onTap: () {
                                          showDatePicker(
                                            context: context,
                                            initialDate: DateTime(1980),
                                            firstDate: DateTime(1980),
                                            lastDate: DateTime(2004),
                                          ).then((value) {
                                            dobTextFieldController.text =
                                                dateFormat.format(value!);
                                            completeGoogleRegisterBloc
                                                .eventController.sink
                                                .add(InputDobGoogleAuthEvent(
                                                    dob: dobTextFieldController
                                                        .text));
                                          });
                                        },
                                        validator: (value) =>
                                            snapshot.data!.validateDob(),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                        flex: 1,
                                        child: SizedBox(
                                          height: 59,
                                          child: InputDecorator(
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          3.0),
                                                  borderSide: const BorderSide(
                                                      color: Colors.blueAccent,
                                                      width: 1.0),
                                                ),
                                                label: const Text("Gender")),
                                            child: DropdownButton<String>(
                                              items: completeGoogleRegisterBloc
                                                  .genderSelection
                                                  .map((e) => DropdownMenuItem(
                                                        value: e,
                                                        child: Text(e),
                                                      ))
                                                  .toList(),
                                              value: snapshot.data!.gender,
                                              icon: snapshot.data!.gender ==
                                                      "Male"
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
                                              onChanged: (value) =>
                                                  completeGoogleRegisterBloc
                                                      .eventController.sink
                                                      .add(
                                                          ChooseGenderGoogleAuthEvent(
                                                              gender: value)),
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                                const SizedBox(
                                  height: 25,
                                ),
                                const SizedBox(
                                  height: 100,
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      if (formState.currentState!.validate()) {
                                        completeGoogleRegisterBloc
                                            .eventController.sink
                                            .add(SubmitGoogleCompleteRegisterEvent(
                                                address: snapshot.data!.address,
                                                avatarUrl:
                                                    snapshot.data!.avatarUrl,
                                                citizenIdentification: snapshot
                                                    .data!
                                                    .citizenIdentification,
                                                dob: snapshot.data!.dob,
                                                email: snapshot.data!.email,
                                                gender: snapshot.data!.gender,
                                                phone: snapshot.data!.phone,
                                                username:
                                                    snapshot.data!.username));
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
                                TextButton(
                                    onPressed: (() async {
                                      completeGoogleRegisterBloc
                                          .eventController.sink
                                          .add(
                                              CancelCompleteGoogleAccountRegisterEvent(
                                                  context: context,
                                                  googleSignIn: googleSignIn));
                                    }),
                                    child: const Text(
                                      "Cancel",
                                      style: TextStyle(color: Colors.red),
                                    ))
                              ],
                            ))
                      ]);
                    },
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
