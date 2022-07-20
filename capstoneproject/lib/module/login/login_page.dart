import 'package:capstoneproject/data/repository/login_repository.dart';
import 'package:capstoneproject/data/service/login_service.dart';
import 'package:capstoneproject/hive/hive_service.dart';
import 'package:capstoneproject/injection/injection.dart';
import 'package:capstoneproject/module/login/register_page.dart';
import 'package:capstoneproject/ui_kit/cubit/loading_cubit.dart';
import 'package:capstoneproject/ui_kit/widget/air_18_loading.dart';
import 'package:capstoneproject/ui_kit/widget/air_18_notification_dialog.dart';
import 'package:capstoneproject/ui_kit/widget/air_18_password_text_field.dart';
import 'package:capstoneproject/ui_kit/widget/air_18_text_field.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../common/common.dart';
import '../../data/shared_preferences/shared_preferences.dart';
import '../../ui_kit/colors.dart';
import '../../ui_kit/widget/air_18_button.dart';
import '../../utils/materials/constant.dart';
import '../../utils/utils.dart';
import '../bottom_nav_bar/bottom_nav_bar.dart';
import 'cubit/login_cubit.dart';
import 'forgot_password_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const LoginPage());
  }
}

class _LoginPageState extends State<LoginPage> {
  late LoginService loginService = LoginService();
  late LoginRepository loginRepository =
      LoginRepository(loginService: loginService);
  late LoginCubit cubit = LoginCubit(repository: loginRepository);
  LoadingCubit loadingCubit = LoadingCubit();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  ValueNotifier<bool> phoneNotifier = ValueNotifier(false);
  ValueNotifier<bool> emailNotifier = ValueNotifier(false);
  ValueNotifier<bool> passwordNotifier = ValueNotifier(false);
  ValueNotifier<bool> loginNotifier = ValueNotifier(false);

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    emailController.text = "devXXX@gmail.com";
    passwordController.text = "Passlagi123";
    phoneNotifier.addListener(() {
      loginNotifier.value = phoneNotifier.value && passwordNotifier.value;
    });
    passwordNotifier.addListener(() {
      loginNotifier.value = phoneNotifier.value && passwordNotifier.value;
    });
    cubit.stream.listen((state) {
      if (state is LoginStateSuccess) {
        SPref.instance.set(SPrefCache.KEY_ACCESS_TOKEN, state.user.cookie!);
        var hive = getIt<HiveService>();
        hive.updateToken(state.user.cookie!);
        hive.updateAvatar(state.user.avatarPath ?? '');
        // print(hive.user);
        SPref.instance.set(SPrefCache.USER_NAME, state.user.email!);
        if(hive.showSelectionPage()){
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (_, __, ___) => const BottomNavBar(
                userID: "11",
              ),
            ),
          );
        }else{
          Navigator.pushReplacementNamed(context, Route_Named_HomePage);
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            BlocListener<LoginCubit, LoginState>(
              bloc: cubit,
              listener: (context, state) {
                handleLoginState(context, state);
              },
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.only(top: 48),
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 16),
                        Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(),
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
                        const SizedBox(height: 16),
                        Air18TextField(
                          validator: validatorEmail,
                          validNotifier: emailNotifier,
                          controller: emailController,
                          labelText: 'Email address',
                          focusNode: emailFocusNode,
                          nextFocusNode: passwordFocusNode,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Air18PasswordTextField(
                          validator: validatorPassword,
                          controller: passwordController,
                          labelText: 'Password',
                          textInputAction: TextInputAction.done,
                          validNotifier: passwordNotifier,
                          image: "assets/images/password.svg",
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context, ForgotPasswordPage.route());
                                // Navigator.push(context, OtpPage.route());
                              },
                              child: Text(
                                'Forget Password',
                                style: GoogleFonts.poppins(
                                    color: orangeColor,
                                    fontSize: 14,
                                    letterSpacing: 0.1,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterPage()));
                              },
                              child: Text(
                                'Register',
                                style: GoogleFonts.poppins(
                                    color: orangeColor,
                                    fontSize: 14,
                                    letterSpacing: 0.1,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        makeAir18Button(
                          'Login',
                          onTap: _onPressed,
                        ),
                        const SizedBox(height: 32),
                        Image.asset(
                          "assets/images/banner.png",
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Air18Loading(loadingCubit: loadingCubit)
          ],
        ),
      ),
    );
  }

  // Widget buildContent(String icon, String content,
  //     {required VoidCallback onTap, bool enable = false}) {
  //   return InkWell(
  //     onTap: () => onTap(),
  //     child: Opacity(
  //       opacity: enable ? 1 : 0.5,
  //       child: Container(
  //         height: 60,
  //         padding: const EdgeInsets.symmetric(horizontal: 16),
  //         decoration: BoxDecoration(
  //             borderRadius: BorderRadius.circular(16), color: Colors.white),
  //         child: Row(
  //           children: [
  //             SizedBox(
  //               height: 30,
  //               child: SvgPicture.asset(
  //                 icon,
  //                 height: 30,
  //                 color: blueColor,
  //               ),
  //             ),
  //             const SizedBox(
  //               width: 32,
  //             ),
  //             Text(
  //               content,
  //               style: GoogleFonts.poppins(
  //                   fontSize: 14, fontWeight: FontWeight.w500),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Future<void> _onPressed() async {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      final email = emailController.text;
      final password = passwordController.text;
      loadingCubit.showLoading();
      await Future.delayed(const Duration(seconds: 1));
      await cubit.login(email: email, password: password);
      loadingCubit.hideLoading();
    }
  }

  // String? validatorPassword(String? password) {
  //   if (password != null && password.length >= 6) {
  //     return null;
  //   } else {
  //     return 'Password is at least 6 character';
  //   }
  // }

  void handleLoginState(BuildContext context, LoginState state) {
    if (state is LoginStateFailure) {
      showDialog(
        context: context,
        builder: (context) => Air18NotificationDialog(
          title: "Login Failure",
          content: "Email or password is incorrect. Please try again.",
          positive: "Ok",
          onPositiveTap: () => Navigator.pop(context),
          isShowNegative: false,
          onNegativeTap: () => {},
        ),
      );
    }
  }

  String? validatorEmail(String? email) {
    RegExp regex = RegExp(
        r'^[^_ÀÁÂÃÈÉÊÌÍÒÓÔÕÙÚĂĐĨŨƠàáâãèéêìíòóôõùúăđĩũơƯĂẠẢẤẦẨẪẬẮẰẲẴẶẸẺẼỀỀỂưăạảấầẩẫậắằẳẵặẹẻẽềềểỄỆỈỊỌỎỐỒỔỖỘỚỜỞỠỢỤỦỨỪễệỉịọỏốồổỗộớờởỡợụủứừỬỮỰỲỴÝỶỸửữựỳỵỷỹ]*$');
    if (email != null &&
        EmailValidator.validate(email) &&
        regex.hasMatch(email)) {
      return null;
    } else {
      return 'Invalid Email';
    }
  }
}
