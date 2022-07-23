import 'package:capstoneproject/injection/injection.dart';
import 'package:capstoneproject/module/profile/profile_cubit.dart';
import 'package:capstoneproject/module/profile/profile_page.dart';
import 'package:capstoneproject/ui_kit/cubit/loading_cubit.dart';
import 'package:capstoneproject/ui_kit/widget/air_18_loading.dart';
import 'package:capstoneproject/ui_kit/widget/air_18_notification_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../data/repository/register_repository.dart';
import '../../data/repository/user_repository.dart';
import '../../data/service/register_service.dart';
import '../../data/service/user_service.dart';
import '../../ui_kit/colors.dart';
import '../../ui_kit/cubit/switch_cubit.dart';
import '../../ui_kit/styles.dart';
import '../../ui_kit/widget/air_18_button.dart';
import '../../ui_kit/widget/air_18_date_time.dart';
import '../../ui_kit/widget/air_18_text_field.dart';
import '../../ui_kit/widget/one_state_switch.dart';
import '../../utils/utils.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key, required this.profileCubit}) : super(key: key);
  final ProfileCubit profileCubit;
  static Route route({required ProfileCubit profileCubit}) {
    return MaterialPageRoute(builder: (_) => EditProfilePage(profileCubit: profileCubit));
  }

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();
  final birthDateController = TextEditingController();

  final ValueNotifier<bool> firstNameNotifier = ValueNotifier(true);
  final ValueNotifier<bool> lastNameNotifier = ValueNotifier(true);
  final ValueNotifier<bool> phoneNotifier = ValueNotifier(true);
  final ValueNotifier<bool> birthDateNotifier = ValueNotifier(true);

  FocusNode lastNameFocusNode = FocusNode();
  FocusNode birthDateFocusNode = FocusNode();
  late LoadingCubit loadingCubit = LoadingCubit();

  late RegisterService registerService = RegisterService();
  late RegisterRepository registerRepository =
      RegisterRepository(registerService: registerService);
  late SwitchCubit genderCubit =
      SwitchCubit(registerRepository: registerRepository);

  // late UserService userService = UserService();
  // late UserRepository repository = UserRepository(userService: userService);
  late ProfileCubit profileCubit = widget.profileCubit;

  @override
  void initState() {
    setUp();
    profileCubit.stream.listen((state) {
      if (state is ProfileStateLoading) {
        loadingCubit.showLoading();
      } else if (state is UpdateProfileStateSucessull) {
        loadingCubit.hideLoading();
        showDialog(
          context: context,
          builder: (context) => Air18NotificationDialog(
            title: "Notification",
            content: "Update profile sucessfull.",
            onNegativeTap: () {},
            onPositiveTap: () {
              Navigator.pop(context);
            },
            isShowNegative: false,
            positive: "Ok",
          ),
        );
      }
      else if(state is UpdateProfileStateFailure){
        loadingCubit.hideLoading();
        showDialog(
          context: context,
          builder: (context) => Air18NotificationDialog(
            title: "Notification",
            content: "Update profile failure. Please try again",
            onNegativeTap: () {},
            onPositiveTap: () {
              Navigator.pop(context);
            },
            isShowNegative: false,
            positive: "Ok",
          ),
        );
      }
      else {
        loadingCubit.hideLoading();
      }
    });
  }

  // Future<void> setUp() async {
  //   await genderCubit.setUpGender();
  //   profileCubit.getUserInfo();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: BlocBuilder<ProfileCubit, ProfileState>(
              bloc: profileCubit,
              builder: (context, state) => state.maybeWhen(
                success: (user) {
                  emailController.text = user.email!;
                  phoneNumberController.text = user.phoneNumber!;
                  firstNameController.text = user.firstName!;
                  lastNameController.text = user.lastName!;
                  genderCubit.selected(user.sex!);
                  birthDateController.text = formatDate(user.birthday!);
                  return Container(
                    margin: const EdgeInsets.only(top: 64, left: 24, right: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            const Text(
                              "Edit Profile",
                              style: TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.bold),
                            ),
                            Container()
                          ],
                        ),
                        const SizedBox(height: 32),
                        buildTitle(title: "Email", isBlur: true),
                        Air18TextField(
                          controller: emailController,
                          isEnable: false,
                        ),
                        buildTitle(title: "Phone Number", isBlur: true),
                        Air18TextField(
                          controller: phoneNumberController,
                          isEnable: false,
                        ),
                        buildTitle(title: "First Name"),
                        Air18TextField(
                          validator: validatorFirstName,
                          validNotifier: firstNameNotifier,
                          controller: firstNameController,
                          labelText: 'First Name',
                          nextFocusNode: lastNameFocusNode,
                        ),
                        buildTitle(title: "Last Name"),
                        Air18TextField(
                          validator: validatorLastName,
                          validNotifier: lastNameNotifier,
                          controller: lastNameController,
                          labelText: 'Last Name',
                          focusNode: lastNameFocusNode,
                          nextFocusNode: birthDateFocusNode,
                        ),
                        buildTitle(title: "Gender"),
                        BlocBuilder<SwitchCubit, SwitchState>(
                          bloc: genderCubit,
                          builder: (context, state) => state.maybeWhen(
                            loaded: (list, item) => OneStateSwitch(
                              data: genderCubit.getMap(list),
                              selected: item,
                              onChanged: (value) {
                                genderCubit.selected(value);
                              },
                            ),
                            orElse: () => Container(),
                          ),
                        ),
                        buildTitle(title: "Birth date"),
                        ValueListenableBuilder<bool>(
                          valueListenable: birthDateNotifier,
                          builder: (context, isBlue, _) => Air18DateTime(
                            currentDateTime: DateTime.now(),
                            isBirthDate: true,
                            isBlueColor: isBlue,
                            focusNode: birthDateFocusNode,
                            validNotifier: birthDateNotifier,
                            labelText: 'Birthday',
                            controller: birthDateController,
                          ),
                        ),
                        const SizedBox(height: 24),
                        makeAir18Button(
                          'Edit',
                          onTap: _onPressed,
                          height: 60,
                          isEnable: true,
                        ),
                      ],
                    ),
                  );
                },
                updateProfileSucessfull: (user) {
                  emailController.text = user.email!;
                  phoneNumberController.text = user.phoneNumber!;
                  firstNameController.text = user.firstName!;
                  lastNameController.text = user.lastName!;
                  genderCubit.selected(user.sex!);
                  birthDateController.text = formatDate(user.birthday!);
                  return Container(
                    margin: const EdgeInsets.only(top: 64, left: 24, right: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            const Text(
                              "Edit Profile",
                              style: TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.bold),
                            ),
                            Container()
                          ],
                        ),
                        const SizedBox(height: 32),
                        buildTitle(title: "Email", isBlur: true),
                        Air18TextField(
                          controller: emailController,
                          isEnable: false,
                        ),
                        buildTitle(title: "Phone Number", isBlur: true),
                        Air18TextField(
                          controller: phoneNumberController,
                          isEnable: false,
                        ),
                        buildTitle(title: "First Name"),
                        Air18TextField(
                          validator: validatorFirstName,
                          validNotifier: firstNameNotifier,
                          controller: firstNameController,
                          labelText: 'First Name',
                          nextFocusNode: lastNameFocusNode,
                        ),
                        buildTitle(title: "Last Name"),
                        Air18TextField(
                          validator: validatorLastName,
                          validNotifier: lastNameNotifier,
                          controller: lastNameController,
                          labelText: 'Last Name',
                          focusNode: lastNameFocusNode,
                          nextFocusNode: birthDateFocusNode,
                        ),
                        buildTitle(title: "Gender"),
                        BlocBuilder<SwitchCubit, SwitchState>(
                          bloc: genderCubit,
                          builder: (context, state) => state.maybeWhen(
                            loaded: (list, item) => OneStateSwitch(
                              data: genderCubit.getMap(list),
                              selected: item,
                              onChanged: (value) {
                                genderCubit.selected(value);
                              },
                            ),
                            orElse: () => Container(),
                          ),
                        ),
                        buildTitle(title: "Birth date"),
                        ValueListenableBuilder<bool>(
                          valueListenable: birthDateNotifier,
                          builder: (context, isBlue, _) => Air18DateTime(
                            currentDateTime: DateTime.now(),
                            isBirthDate: true,
                            isBlueColor: isBlue,
                            focusNode: birthDateFocusNode,
                            validNotifier: birthDateNotifier,
                            labelText: 'Birthday',
                            controller: birthDateController,
                          ),
                        ),
                        const SizedBox(height: 24),
                        makeAir18Button(
                          'Edit',
                          onTap: _onPressed,
                          height: 60,
                          isEnable: true,
                        ),
                      ],
                    ),
                  );
                },
                failure: (error) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 64, left: 24, right: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              const Text(
                                "Edit Profile",
                                style: TextStyle(
                                    fontSize: 26, fontWeight: FontWeight.bold),
                              ),
                              Container()
                            ],
                          ),
                        ),
                        Center(
                          child: Text(
                            "$error. Please try again.",
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 24),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                orElse: () => Container(
                    margin: const EdgeInsets.only(top: 64, left: 24, right: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        const Text(
                          "Edit Profile",
                          style: TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                        Container()
                      ],
                    ),
                  ),
              ),
            ),
          ),
          Air18Loading(loadingCubit: loadingCubit)
        ],
      ),
    );
  }

  Widget buildTitle({required String title, bool isBlur = false}) {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 2),
      child: Text(
        title,
        style: isBlur == true
            ? textTitleStyle.copyWith(
                fontWeight: FontWeight.bold, color: darkBlueColorOpacity)
            : textTitleStyle.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  void _onPressed() {
    FocusScope.of(context).unfocus();
    if (firstNameNotifier.value &&
        lastNameNotifier.value &&
        birthDateNotifier.value) {
      Map<String, dynamic> data = {
        "firstName": firstNameController.value.text,
        "lastName": lastNameController.value.text,
        "gender": genderCubit.item!,
        "birthday": formatDate(birthDateController.value.text),
      };
      profileCubit.updateUser(data);
    }
  }
}
