import 'package:capstoneproject/api/model/data_repsonse.dart';
import 'package:capstoneproject/data/repository/otp_repository.dart';
import 'package:capstoneproject/data/repository/user_repository.dart';
import 'package:capstoneproject/data/service/otp_service.dart';
import 'package:capstoneproject/data/service/register_service.dart';
import 'package:capstoneproject/data/service/user_service.dart';
import 'package:capstoneproject/module/login/cubit/otp_cubit.dart';
import 'package:capstoneproject/module/login/cubit/register_cubit.dart';
import 'package:capstoneproject/module/login/otp_page.dart';
import 'package:capstoneproject/ui_kit/cubit/loading_cubit.dart';
import 'package:capstoneproject/ui_kit/widget/air_18_button.dart';
import 'package:capstoneproject/ui_kit/widget/air_18_checkbox.dart';
import 'package:capstoneproject/ui_kit/widget/air_18_date_time.dart';
import 'package:capstoneproject/ui_kit/widget/air_18_loading.dart';
import 'package:capstoneproject/ui_kit/widget/air_18_loading_view.dart';
import 'package:capstoneproject/ui_kit/widget/air_18_notification_dialog.dart';
import 'package:capstoneproject/ui_kit/widget/air_18_password_text_field.dart';
import 'package:capstoneproject/ui_kit/widget/air_18_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/repository/register_repository.dart';
import '../../ui_kit/colors.dart';
import '../../ui_kit/cubit/switch_cubit.dart';
import '../../ui_kit/styles.dart';
import '../../ui_kit/widget/air_18_phone_number_text_field.dart';
import '../../ui_kit/widget/one_state_switch.dart';
import '../../utils/utils.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const RegisterPage());
  }

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();
  final birthDateController = TextEditingController();

  final ValueNotifier<bool> firstNameNotifier = ValueNotifier(false);
  final ValueNotifier<bool> lastNameNotifier = ValueNotifier(false);
  final ValueNotifier<bool> emailNotifier = ValueNotifier(false);
  final ValueNotifier<bool> passwordNotifier = ValueNotifier(false);
  final ValueNotifier<bool> repeatPasswordNotifier = ValueNotifier(false);
  final ValueNotifier<bool> phoneNotifier = ValueNotifier(false);
  final ValueNotifier<bool> birthDateNotifier = ValueNotifier(false);
  final ValueNotifier<bool> checkNotifier = ValueNotifier(false);
  final ValueNotifier<bool> checkErrorNotifier = ValueNotifier(false);
  final ValueNotifier<bool> createAccountNotifier = ValueNotifier(false);

  FocusNode lastNameFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode repeatPasswordFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();

  late RegisterService registerService = RegisterService();
  late RegisterRepository registerRepository =
      RegisterRepository(registerService: registerService);
  late RegisterCubit registerCubit =
      RegisterCubit(repository: registerRepository);

  late OTPService otpService = OTPService();
  late OTPRepository otpRepository = OTPRepository(otpService: otpService);
  late OtpCubit otpCubit = OtpCubit(otpRepository);

  late LoadingCubit loadingCubit = LoadingCubit();

  late SwitchCubit genderCubit =
      SwitchCubit(registerRepository: registerRepository);

  bool phoneExisted = false;
  bool emailExisted = false;
  var isTheFirst = true;

  // late SwitchCubit genderCubit = SwitchCubit(userRepository);
  late String? genderSaved;
  late Map<String, dynamic> data;

  @override
  void initState() {
    mock();
    init();
    passwordNotifier.addListener(() {
      final text = repeatPasswordController.text;
      repeatPasswordController.text = '';
      repeatPasswordController.text = text;
      final status = isValid();
      createAccountNotifier.value = status;
    });
    repeatPasswordNotifier.addListener(() {
      final status = isValid();
      createAccountNotifier.value = status;
    });
    emailNotifier.addListener(() {
      final status = isValid();
      createAccountNotifier.value = status;
    });
    phoneNotifier.addListener(() {
      final status = isValid();
      createAccountNotifier.value = status;
    });
    checkNotifier.addListener(() {
      final status = isValid();
      createAccountNotifier.value = status;
    });
    passwordController.addListener(() {
      debugPrint(passwordController.text);
      if (passwordController.text == repeatPasswordController.text) {
        repeatPasswordNotifier.value = true;
      } else if (repeatPasswordController.text.isNotEmpty) {
        repeatPasswordNotifier.value = false;
      }
    });

    otpCubit.stream.listen((state) {
      if (state is OtpStateInValidEmail) {
        print("Email Existed");
        loadingCubit.hideLoading();

        showDialog(
          context: context,
          builder: (context) => Air18NotificationDialog(
            title: "Notification",
            content: "Email has been used by anyone yet.",
            positive: "Ok",
            onPositiveTap: () => Navigator.pop(context),
            onNegativeTap: () {},
            isShowNegative: false,
          ),
        );
      } else if (state is OtpStateValidEmail) {
        print("Calling Api Check Phone");
        otpCubit.checkPhone(phoneNumberController.text);
      } else if (state is OtpStateValidPhone) {
        print("Send Otp");
        otpCubit.sendOtp("+84" + phoneNumberController.text.substring(1));
      } else if (state is OtpStateInValidPhone) {
        Fluttertoast.showToast(msg: "Phone Existed");
        print("Phone Existed");
        loadingCubit.hideLoading();
        showDialog(
          context: context,
          builder: (context) => Air18NotificationDialog(
            title: "Notification",
            content: "Phone number has already been taken.",
            positive: "Ok",
            onPositiveTap: () => Navigator.pop(context),
            onNegativeTap: () {},
            isShowNegative: false,
          ),
        );
      } else if (state is OtpStateSendSuccess) {
        loadingCubit.hideLoading();
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                OtpPage(isRegister: true, data: data, otpCubit: otpCubit)));
      } else if (state is OtpStateSendFailed) {
        print("Send Otp Failed");
        loadingCubit.hideLoading();
        showDialog(
          context: context,
          builder: (context) => Air18NotificationDialog(
            title: "Notification",
            content: "Send Otp Failed. Please try again.",
            positive: "Ok",
            onPositiveTap: () => Navigator.pop(context),
            onNegativeTap: () {},
            isShowNegative: false,
          ),
        );
      } else if (state is OtpStateVerifySuccess) {
        loadingCubit.showLoading();
        registerCubit.register(data);
      } else if (state is OtpStateLoading) {
        loadingCubit.showLoading();
      } else {
        loadingCubit.hideLoading();
      }

      registerCubit.stream.listen((state) {
        if (state is RegisterStateSuccessful && isTheFirst) {
          isTheFirst = false;
          loadingCubit.hideLoading();
          showDialog(
            context: context,
            builder: (context) => Air18NotificationDialog(
              title: "Notification",
              content:
                  "You registered account successfully. Let's login and enjoy my app.",
              positive: "Let's go",
              onPositiveTap: () {
                Navigator.pop(context);
                // Navigator.popUntil(context, (route) => route.isFirst);
                registerCubit.completed();
              },
              onNegativeTap: () {},
              isShowNegative: false,
            ),
          );
        } else if (state is RegisterStateCompleted) {
          // Navigator.pop(context);
          Navigator.popUntil(context, (route) => route.isFirst);
        }else{
          loadingCubit.hideLoading();
        }
      });
    });
    super.initState();
  }

  Future<void> init() async {
    await genderCubit.setUpGender();
  }

  void mock() {
    firstNameController.text = 'a';
    lastNameController.text = 'a';
    emailController.text = 'devXXX@gmail.com';
    phoneNumberController.text = '0382916020';
    passwordController.text = 'Passlagi123';
    repeatPasswordController.text = 'Passlagi123';
    birthDateController.text = "08/10/2000";
    emailNotifier.value = true;
    passwordNotifier.value = true;
    repeatPasswordNotifier.value = true;
    phoneNotifier.value = true;
  }

  bool isValid() {
    return lastNameNotifier.value &&
        firstNameNotifier.value &&
        emailNotifier.value &&
        phoneNotifier.value &&
        passwordNotifier.value &&
        repeatPasswordNotifier.value &&
        checkNotifier.value;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocBuilder<OtpCubit, OtpState>(
          bloc: otpCubit,
          builder: (context, state) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.only(top: 80, left: 24, right: 24),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 32),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: SvgPicture.asset(
                                        'assets/images/arrow-left-icon.svg',
                                        color: orangeColor,
                                      ),
                                  ),
                                  Container(
                                    child: Image.asset(
                                      "assets/images/logo_app.png",
                                      width: 96,
                                      height: 96,
                                      fit: BoxFit.scaleDown,
                                    ),
                                  ),
                                  Container()
                                ]),
                          ),
                          Air18TextField(
                            validator: validatorFirstName,
                            validNotifier: firstNameNotifier,
                            controller: firstNameController,
                            labelText: 'First Name',
                            nextFocusNode: lastNameFocusNode,
                          ),
                          const SizedBox(height: 24),
                          Air18TextField(
                            validator: validatorLastName,
                            validNotifier: lastNameNotifier,
                            controller: lastNameController,
                            labelText: 'Last Name',
                            focusNode: lastNameFocusNode,
                            nextFocusNode: emailFocusNode,
                          ),
                          const SizedBox(height: 24),
                          Air18TextField(
                            validator: validatorEmail,
                            validNotifier: emailNotifier,
                            controller: emailController,
                            labelText: 'Email Address',
                            focusNode: emailFocusNode,
                            nextFocusNode: passwordFocusNode,
                          ),
                          const SizedBox(height: 24),
                          Air18PasswordTextField(
                            validator: validatorPassword,
                            validNotifier: passwordNotifier,
                            controller: passwordController,
                            labelText: 'Password',
                            textInputAction: TextInputAction.next,
                            focusNode: passwordFocusNode,
                            nextFocusNode: repeatPasswordFocusNode,
                            image: 'assets/images/password.svg',
                          ),
                          const SizedBox(height: 24),
                          ValueListenableBuilder<bool>(
                            valueListenable: repeatPasswordNotifier,
                            builder: (context, value, _) =>
                                Air18PasswordTextField(
                              validator: (String? value) {
                                if (passwordController.text == value &&
                                    value != null) {
                                  return null;
                                } else {
                                  return 'Password must similar above';
                                }
                              },
                              validNotifier: repeatPasswordNotifier,
                              controller: repeatPasswordController,
                              labelText: 'Repeat Password',
                              textInputAction: TextInputAction.next,
                              focusNode: repeatPasswordFocusNode,
                              nextFocusNode: phoneFocusNode,
                              isRepeat: true,
                              image: 'assets/images/password.svg',
                            ),
                          ),
                          const SizedBox(height: 24),
                          Air18PhoneNumberTextField(
                            validator: (String? value) {
                              final nineNumberPhone = trimStart(value);
                              if (nineNumberPhone.length == 12 &&
                                  RegExp(r'^[0-9]*$').hasMatch(value!)) {
                                return null;
                              } else {
                                return 'Phone incorrect';
                              }
                            },
                            controller: phoneNumberController,
                            labelText: 'Phone',
                            validNotifier: phoneNotifier,
                            focusNode: phoneFocusNode,
                            textInputAction: TextInputAction.done,
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 16, bottom: 2),
                            child: Text(
                              'Gender',
                              style: textTitleStyle.copyWith(
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          BlocBuilder<SwitchCubit, SwitchState>(
                              bloc: genderCubit,
                              builder: (context, state) => state.maybeWhen(
                                  loaded: (list, item) => OneStateSwitch(
                                        data: genderCubit.getMap(list),
                                        selected: item,
                                        onChanged: (value) {
                                          genderCubit.selected(value);
                                          print(genderCubit.item!);
                                        },
                                      ),
                                  orElse: () => Container())),
                          const SizedBox(
                            height: 12,
                          ),
                          ValueListenableBuilder<bool>(
                            valueListenable: birthDateNotifier,
                            builder: (context, isBlue, _) => Air18DateTime(
                              currentDateTime: DateTime.now(),
                              isBirthDate: true,
                              isBlueColor: isBlue,
                              validNotifier: birthDateNotifier,
                              labelText: 'Birthday',
                              controller: birthDateController,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              ValueListenableBuilder(
                                builder: (BuildContext context, bool value,
                                    Widget? child) {
                                  return Air18CheckBox(
                                      valueChanged: (v) {
                                        checkErrorNotifier.value = false;
                                      },
                                      isCheck: value,
                                      checkNotifier: checkNotifier);
                                },
                                valueListenable: checkNotifier,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 0.5),
                                child: Text(
                                  'Please agree to our ',
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: Text(
                                    'Terms and conditions',
                                    overflow: TextOverflow.clip,
                                    softWrap: false,
                                    style: GoogleFonts.poppins(
                                        decoration: TextDecoration.underline,
                                        color: blueColor,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ValueListenableBuilder(
                              valueListenable: checkErrorNotifier,
                              builder: (context, bool value, widget) {
                                return value
                                    ? Row(
                                        children: [
                                          const SizedBox(
                                            width: 24,
                                          ),
                                          Expanded(
                                            child: Text(
                                              'Please agree with our terms and conditions.',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .errorColor,
                                                  fontSize: 12),
                                            ),
                                          ),
                                        ],
                                      )
                                    : const SizedBox();
                              }),
                          const SizedBox(height: 24),
                          Column(
                            children: [
                              ValueListenableBuilder(
                                valueListenable: createAccountNotifier,
                                builder: (context, bool value, widget) {
                                  return makeAir18Button('Register',
                                      onTap: _onPressed,
                                      height: 60,
                                      isEnable: true);
                                },
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              // TextButton(
                              //     onPressed: () {
                              //       Navigator.pop(context);
                              //     },
                              //     child: RichText(
                              //       text: TextSpan(
                              //         text: '${labels.registerText08} ',
                              //         style: GoogleFonts.poppins(
                              //             fontWeight: FontWeight.w600,
                              //             fontSize: 14,
                              //             color: Colors.black),
                              //         children: <TextSpan>[
                              //           TextSpan(
                              //               text: labels.registerChoose03,
                              //               style: GoogleFonts.poppins(
                              //                   fontWeight: FontWeight.w600,
                              //                   color: orangeColor,
                              //                   fontSize: 14)),
                              //         ],
                              //       ),
                              //     )),
                              SvgPicture.asset(
                                  'assets/images/character-vector.svg'),
                              const SizedBox(
                                height: 40,
                              )
                            ],
                          ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),
                Air18Loading(loadingCubit: loadingCubit)
              ],
            );
          },
        ),
      ),
    );
  }

  void _onPressed() async {
    FocusScope.of(context).unfocus();
    if (!checkNotifier.value) {
      checkErrorNotifier.value = true;
    }
    if (_formKey.currentState!.validate() && checkNotifier.value) {
      // loadingCubit.showLoading();
      // await
      // loadingCubit.hideLoading();
      // loadingCubit.fetchData(otpCubit.checkAndSendOtp(
      //   context,
      //   userController.text.trim(),
      //   emailController.text.trim(),
      //   trimStart(phoneNumberController.text),
      //   passwordController.text,
      // ));
      data = {
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "phoneNumber": phoneNumberController.text,
        "email": emailController.text,
        "password": passwordController.text,
        "sex": genderCubit.item,
        "birthday": formatDate(birthDateController.text)
      };
      print(data);
      await otpCubit.checkEmail(emailController.text);
    }
  }

// void showNotificationDialog({
//   required String title,
//   required String content,
//   required String positive,
//   VoidCallback? onPositive
// }) {
//   showDialog(
//     context: context,
//     builder: (context) =>
//         Air18NotificationDialog(
//           title: title,
//           content: content,
//           onPositiveTap: () {
//             onPositive!();
//           },
//           onNegativeTap: () {},
//           positive: positive,
//           isShowNegative: false,
//         ),
//   );
// }
}
