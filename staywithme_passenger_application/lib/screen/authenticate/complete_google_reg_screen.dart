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

    return GestureDetector(
      onTap: () {
        completeGoogleRegisterBloc.eventController.sink.add(
            FocusTextFieldCompleteGoogleRegEvent(isFocusOnTextField: false));
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.grey,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: Colors.white),
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
                            child: Column(children: const [
                              Text(
                                "One more step",
                                style: TextStyle(
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "These information will help us support you better",
                                style: TextStyle(
                                    fontFamily: "SourceCodePro",
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent),
                              )
                            ]),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Form(
                              key: formState,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 300,
                                    child: TextFormField(
                                      controller: usernameTextFieldController,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.5),
                                      decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          label: const Text(
                                            "Username",
                                            style: TextStyle(
                                                fontFamily: "SourceCodePro",
                                                color: Colors.black45,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 1.5),
                                          ),
                                          prefixIcon: const Icon(
                                            Icons.account_circle,
                                            color: Colors.black45,
                                          ),
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              Icons.close,
                                              color:
                                                  snapshot.data!.focusColor(),
                                            ),
                                            onPressed: () {
                                              usernameTextFieldController
                                                  .clear();
                                              completeGoogleRegisterBloc
                                                  .eventController.sink
                                                  .add(InputUsernameGoogleAuthEvent(
                                                      username:
                                                          usernameTextFieldController
                                                              .text));
                                            },
                                          ),
                                          enabledBorder:
                                              const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white,
                                                      width: 1.0)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: snapshot.data!
                                                      .focusColor(),
                                                  width: 1.0)),
                                          errorStyle: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.redAccent)),
                                      onTap: () => completeGoogleRegisterBloc
                                          .eventController.sink
                                          .add(
                                              FocusTextFieldCompleteGoogleRegEvent(
                                                  isFocusOnTextField: true)),
                                      onChanged: (value) =>
                                          completeGoogleRegisterBloc
                                              .eventController.sink
                                              .add(InputUsernameGoogleAuthEvent(
                                                  username: value)),
                                      validator: (value) =>
                                          snapshot.data!.validateUsername(),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  SizedBox(
                                    width: 300,
                                    child: TextFormField(
                                      controller: emailTextFieldController,
                                      readOnly: true,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.5),
                                      decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          label: const Text(
                                            "Email",
                                            style: TextStyle(
                                                fontFamily: "SourceCodePro",
                                                color: Colors.black45,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 1.5),
                                          ),
                                          prefixIcon: const Icon(
                                            Icons.mail,
                                            color: Colors.black45,
                                          ),
                                          suffixIcon: IconButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                    title: const Center(
                                                      child: Text(
                                                        "Choose account",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    content: const Padding(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: Text(
                                                        "Do you want to change google account?",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "SourceCodePro",
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    actions: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          TextButton(
                                                              onPressed: () {
                                                                completeGoogleRegisterBloc
                                                                    .eventController
                                                                    .sink
                                                                    .add(CancelChooseAnotherGoogleAccountEvent(
                                                                        context:
                                                                            context));
                                                              },
                                                              child: const Text(
                                                                "Cancel",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "SourceCodePro",
                                                                    color: Colors
                                                                        .red,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              )),
                                                          TextButton(
                                                              onPressed: () {
                                                                completeGoogleRegisterBloc
                                                                    .eventController
                                                                    .sink
                                                                    .add(CancelCompleteGoogleAccountRegisterEvent(
                                                                        context:
                                                                            context,
                                                                        googleSignIn:
                                                                            googleSignIn,
                                                                        isChangeGoogleAccount:
                                                                            true));
                                                              },
                                                              child: const Text(
                                                                "Change",
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        "SourceCodePro",
                                                                    color: Colors
                                                                        .green,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ))
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                );
                                              },
                                              icon: const Icon(
                                                  Icons.restart_alt)),
                                          enabledBorder:
                                              const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white,
                                                      width: 1.0)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: snapshot.data!
                                                      .focusColor(),
                                                  width: 1.0)),
                                          errorStyle: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.redAccent)),
                                      onChanged: (value) =>
                                          completeGoogleRegisterBloc
                                              .eventController.sink
                                              .add(ReceiveEmailGoogleAuthEvent(
                                                  email: value)),
                                      validator: (value) =>
                                          snapshot.data!.validateEmail(),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  SizedBox(
                                    width: 300,
                                    child: TextFormField(
                                      keyboardType: TextInputType.phone,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.5),
                                      decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          label: const Text(
                                            "Phone",
                                            style: TextStyle(
                                                fontFamily: "SourceCodePro",
                                                color: Colors.black45,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 1.5),
                                          ),
                                          prefixIcon: const Icon(
                                            Icons.phone,
                                            color: Colors.black45,
                                          ),
                                          enabledBorder:
                                              const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white,
                                                      width: 1.0)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: snapshot.data!
                                                      .focusColor(),
                                                  width: 1.0)),
                                          errorStyle: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.redAccent)),
                                      onTap: () => completeGoogleRegisterBloc
                                          .eventController.sink
                                          .add(
                                              FocusTextFieldCompleteGoogleRegEvent(
                                                  isFocusOnTextField: true)),
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
                                    height: 25,
                                  ),
                                  SizedBox(
                                    width: 300,
                                    child: TextFormField(
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.5),
                                      decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          label: const Text(
                                            "Address",
                                            style: TextStyle(
                                                fontFamily: "SourceCodePro",
                                                color: Colors.black45,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 1.5),
                                          ),
                                          prefixIcon: const Icon(
                                            Icons.location_city,
                                            color: Colors.black45,
                                          ),
                                          enabledBorder:
                                              const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white,
                                                      width: 1.0)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: snapshot.data!
                                                      .focusColor(),
                                                  width: 1.0)),
                                          errorStyle: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.redAccent)),
                                      onTap: () => completeGoogleRegisterBloc
                                          .eventController.sink
                                          .add(
                                              FocusTextFieldCompleteGoogleRegEvent(
                                                  isFocusOnTextField: true)),
                                      onChanged: (value) =>
                                          completeGoogleRegisterBloc
                                              .eventController.sink
                                              .add(InputAddressGoogleAuthEvent(
                                                  address: value)),
                                      validator: (value) =>
                                          snapshot.data!.validateAddress(),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  SizedBox(
                                    width: 300,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.5),
                                      decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.white,
                                          label: const Text(
                                            "ID Card",
                                            style: TextStyle(
                                                fontFamily: "SourceCodePro",
                                                color: Colors.black45,
                                                fontWeight: FontWeight.bold,
                                                letterSpacing: 1.5),
                                          ),
                                          prefixIcon: const Icon(
                                            Icons.card_membership,
                                            color: Colors.black45,
                                          ),
                                          enabledBorder:
                                              const UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.white,
                                                      width: 1.0)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: snapshot.data!
                                                      .focusColor(),
                                                  width: 1.0)),
                                          errorStyle: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.redAccent)),
                                      onTap: () => completeGoogleRegisterBloc
                                          .eventController.sink
                                          .add(
                                              FocusTextFieldCompleteGoogleRegEvent(
                                                  isFocusOnTextField: true)),
                                      onChanged: (value) =>
                                          completeGoogleRegisterBloc
                                              .eventController.sink
                                              .add(
                                                  InputCitizenIdentificationGoogleAuthEvent(
                                                      citizenIdentification:
                                                          value)),
                                      validator: (value) => snapshot.data!
                                          .validateCitizenIdentification(),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: 150,
                                        child: TextFormField(
                                          readOnly: true,
                                          controller: dobTextFieldController,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1.5),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              label: const Text(
                                                "Birth day",
                                                style: TextStyle(
                                                  fontFamily: "SourceCodePro",
                                                  color: Colors.black45,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              prefixIcon: const Icon(
                                                Icons.calendar_month,
                                                color: Colors.black45,
                                              ),
                                              enabledBorder:
                                                  const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white,
                                                          width: 1.0)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: snapshot.data!
                                                          .focusColor(),
                                                      width: 1.0)),
                                              errorStyle: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.redAccent)),
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
                                                      dob:
                                                          dobTextFieldController
                                                              .text));
                                            });
                                          },
                                          validator: (value) =>
                                              snapshot.data!.validateDob(),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 2,
                                      ),
                                      SizedBox(
                                        height: 59,
                                        width: 150,
                                        child: InputDecorator(
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              label: const Text(
                                                "Gender",
                                                style: TextStyle(
                                                  fontFamily: "SourceCodePro",
                                                  color: Colors.black45,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              prefixIcon:
                                                  snapshot.data!.gender ==
                                                          "Male"
                                                      ? const Icon(
                                                          Icons.boy,
                                                          color: Colors.black45,
                                                        )
                                                      : const Icon(
                                                          Icons.girl,
                                                          color: Colors.black45,
                                                        ),
                                              enabledBorder:
                                                  const UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white,
                                                          width: 1.0)),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: snapshot.data!
                                                          .focusColor(),
                                                      width: 1.0)),
                                              errorStyle: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.redAccent)),
                                          child: DropdownButton<String>(
                                            items: completeGoogleRegisterBloc
                                                .genderSelection
                                                .map((e) => DropdownMenuItem(
                                                      value: e,
                                                      child: Text(
                                                        e,
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            letterSpacing: 1.5),
                                                      ),
                                                    ))
                                                .toList(),
                                            value: snapshot.data!.gender,
                                            underline: const SizedBox(),
                                            onChanged: (value) =>
                                                completeGoogleRegisterBloc
                                                    .eventController.sink
                                                    .add(
                                                        ChooseGenderGoogleAuthEvent(
                                                            gender: value)),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  ElevatedButton(
                                      onPressed: () {
                                        print(usernameTextFieldController.text);
                                        if (formState.currentState!
                                            .validate()) {
                                          completeGoogleRegisterBloc
                                              .eventController.sink
                                              .add(SubmitGoogleCompleteRegisterEvent(
                                                  address:
                                                      snapshot.data!.address,
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
                                                    googleSignIn: googleSignIn,
                                                    isChangeGoogleAccount:
                                                        false));
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
      ),
    );
  }
}
