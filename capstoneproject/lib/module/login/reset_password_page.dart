import 'package:capstoneproject/ui_kit/cubit/loading_cubit.dart';
import 'package:capstoneproject/ui_kit/widget/air_18_button.dart';
import 'package:capstoneproject/ui_kit/widget/air_18_loading_view.dart';
import 'package:capstoneproject/ui_kit/widget/air_18_password_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../data/repository/forgot_password_repository.dart';
import '../../data/service/forgot_password_service.dart';
import '../../ui_kit/colors.dart';
import '../../ui_kit/widget/air_18_loading.dart';
import '../../ui_kit/widget/air_18_notification_dialog.dart';
import '../../utils/utils.dart';
import 'cubit/reset_password_cubit.dart';

class ResetPasswordPage extends StatefulWidget {
  final String phone;

  const ResetPasswordPage(this.phone, {Key? key}) : super(key: key);

  static Route route({required String phone}) {
    return MaterialPageRoute<void>(builder: (_) => ResetPasswordPage(phone));
  }

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode repeatPasswordFocusNode = FocusNode();
  ValueNotifier<bool> passwordNotifier = ValueNotifier(false);
  ValueNotifier<bool> repeatPasswordNotifier = ValueNotifier(false);
  ValueNotifier<bool> actionNotifier = ValueNotifier(false);

  // ResetPasswordCubit cubit = getIt<ResetPasswordCubit>();
  late ForgotPasswordService forgotPasswordService = ForgotPasswordService();
  late ForgotPasswordRepository forgotPasswordRepository =
      ForgotPasswordRepository(forgotPasswordService: forgotPasswordService);
  late ResetPasswordCubit cubit = ResetPasswordCubit(forgotPasswordRepository);
  late LoadingCubit loadingCubit = LoadingCubit();

  @override
  void initState() {
    passwordController.addListener(() {
      if (passwordController.text == repeatPasswordController.text) {
        repeatPasswordNotifier.value = true;
      } else if (repeatPasswordController.text.isNotEmpty) {
        repeatPasswordNotifier.value = false;
      }
      actionNotifier.value =
          passwordNotifier.value && repeatPasswordNotifier.value;
    });

    passwordNotifier.addListener(() {
      actionNotifier.value =
          passwordNotifier.value && repeatPasswordNotifier.value;
    });
    repeatPasswordNotifier.addListener(() {
      actionNotifier.value =
          passwordNotifier.value && repeatPasswordNotifier.value;
    });
    cubit.stream.listen((state) {
      if (state is ResetPasswordStateFailed) {
        // dialogUtil.showToast(state.error);
        loadingCubit.hideLoading();
        showDialog(
            context: context,
            builder: (context) => Air18NotificationDialog(
                  title: "Notification",
                  content: "Reset password failed, please try again.",
                  onPositiveTap: () {
                    Navigator.pop(context);
                  },
                  onNegativeTap: () {},
                  isShowNegative: false,
                  positive: "Ok",
                ));
      }
      else if (state is ResetPasswordStateSuccess) {
        loadingCubit.hideLoading();
        showDialog(
            context: context,
            builder: (context) => Air18NotificationDialog(
                  title: "Notification",
                  content: "Reset password successfully, please login again.",
                  onPositiveTap: () {
                    cubit.completed();
                    Navigator.pop(context);
                  },
                  onNegativeTap: () {},
                  isShowNegative: false,
                  positive: "Let's go",
                ));
      }
      else if (state is ResetPasswordStateLoading){
        loadingCubit.showLoading();
      }else if(state is ResetPasswordStateCompleted){
        loadingCubit.hideLoading();
        Navigator.pop(context);
        Navigator.pop(context);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SafeArea(
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.white,
              body: Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 32),
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: SvgPicture.asset(
                                  'assets/images/arrow-left-icon.svg')),
                          const SizedBox(height: 48),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Reset password',
                                      style: GoogleFonts.poppins(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: darkBlueColor),
                                    ),
                                    const SizedBox(width: 8),
                                    SvgPicture.asset(
                                      'assets/images/synchronize-icon.svg',
                                      height: 42,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  'Your new password must be different from previous used password',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 24),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 16),
                                    Form(
                                      child: Column(
                                        children: [
                                          Air18PasswordTextField(
                                            validator: validatorPassword,
                                            focusNode: passwordFocusNode,
                                            nextFocusNode: repeatPasswordFocusNode,
                                            controller: passwordController,
                                            labelText: 'Password',
                                            validNotifier: passwordNotifier,
                                            textInputAction: TextInputAction.next,
                                            image: 'assets/images/password.svg',
                                          ),
                                          const SizedBox(height: 24),
                                          Air18PasswordTextField(
                                            validator: (String? value) {
                                              if (passwordController.text ==
                                                  value &&
                                                  value != null &&
                                                  value.isNotEmpty)
                                                return null;
                                              else {
                                                return 'Must be same password above.';
                                              }
                                            },
                                            validNotifier: repeatPasswordNotifier,
                                            controller: repeatPasswordController,
                                            labelText: 'Repeat password',
                                            textInputAction: TextInputAction.done,
                                            focusNode: repeatPasswordFocusNode,
                                            isRepeat: true,
                                            image: 'assets/images/password.svg',
                                          ),
                                          const SizedBox(
                                            height: 72,
                                          ),
                                          ValueListenableBuilder(
                                              valueListenable: actionNotifier,
                                              builder:
                                                  (context, bool value, widget) {
                                                return makeAir18Button(
                                                    'UPDATE PASSWORD',
                                                    isEnable: value,
                                                    onTap: _onPressed,
                                                    height: 60);
                                              }),
                                          const SizedBox(height: 24),
                                          Image.asset(
                                            'assets/images/character-vector.png',
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Air18Loading(
                    loadingCubit: loadingCubit,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }



  Future<void> _onPressed() async {
    cubit.resetPassword(widget.phone, passwordController.text);
  }
}