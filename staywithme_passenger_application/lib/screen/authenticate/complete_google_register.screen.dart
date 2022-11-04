import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:staywithme_passenger_application/bloc/event/authentication_event.dart';
import 'package:staywithme_passenger_application/bloc/register_bloc.dart';
// import 'package:staywithme_passenger_application/service/auth_by_google_service.dart';
// import 'package:staywithme_passenger_application/service_locator/service_locator.dart';

class CompleteGoogleRegisterScreen extends StatefulWidget {
  const CompleteGoogleRegisterScreen({super.key});

  static const completeGoogleRegisterRoute = "/complete_google_sign_in";

  @override
  State<CompleteGoogleRegisterScreen> createState() =>
      _CompleteGoogleRegisterScreenState();
}

// TODO: sửa tràn màng hình khi click vào textfield
class _CompleteGoogleRegisterScreenState
    extends State<CompleteGoogleRegisterScreen> {
  final registerBloc = RegisterBloc();
  final formState = GlobalKey<FormState>();
  final dobTextFieldController = TextEditingController();
  final usernameTextFieldController = TextEditingController();
  final emailTextFieldController = TextEditingController();
  final dateFormat = DateFormat("yyyy-MM-dd");

  @override
  Widget build(BuildContext context) {
    final getArguments = ModalRoute.of(context)!.settings.arguments as Map;
    final TextEditingController usernameTextEditingCtl =
        getArguments["usernameTextEditingCtl"];
    final TextEditingController emailTextEditingCtl =
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
                    stream: registerBloc.stateController.stream,
                    initialData: registerBloc.initData,
                    builder: (context, snapshot) {
                      return Column(children: [
                        const Center(
                          child: Text(
                            "Complete account",
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
                                TextFormField(
                                  controller: usernameTextEditingCtl,
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
                                const SizedBox(
                                  height: 25,
                                ),
                                TextFormField(
                                  controller: emailTextEditingCtl,
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
                                  onChanged: (value) => registerBloc
                                      .eventController.sink
                                      .add(InputEmailEvent(email: value)),
                                  validator: (value) =>
                                      snapshot.data!.validateEmail(),
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
                                            prefixIcon:
                                                Icon(Icons.card_membership)),
                                        onChanged: (value) => registerBloc
                                            .eventController.sink
                                            .add(
                                                InputCitizenIdentificationEvent(
                                                    citizenIdentification:
                                                        value)),
                                        validator: (value) => snapshot.data!
                                            .validateCitizenIdentification(),
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
                                            .add(InputPasswordEvent(
                                                password: value)),
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
                                        onChanged: (value) => registerBloc
                                            .eventController.sink
                                            .add(InputAddressEvent(
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
                                            registerBloc.eventController.sink
                                                .add(InputDobEvent(
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
                                              items: registerBloc
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
                                              onChanged: (value) => registerBloc
                                                  .eventController.sink
                                                  .add(InputGenderEvent(
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
                                        registerBloc.eventController.sink.add(
                                            SubmitRegisterAccountEvent(
                                                address: snapshot.data!.address,
                                                avatarUrl:
                                                    snapshot.data!.avatarUrl,
                                                citizenIdentification: snapshot
                                                    .data!
                                                    .citizenIdentification,
                                                dob: snapshot.data!.dob,
                                                email: snapshot.data!.email,
                                                gender: snapshot.data!.gender,
                                                password:
                                                    snapshot.data!.password,
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
                                      registerBloc.eventController.sink.add(
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
