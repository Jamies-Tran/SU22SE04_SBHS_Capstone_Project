import 'package:capstoneproject/data/repository/forgot_password_repository.dart';
import 'package:capstoneproject/data/repository/otp_repository.dart';
import 'package:capstoneproject/data/service/forgot_password_service.dart';
import 'package:capstoneproject/data/service/otp_service.dart';
import 'package:capstoneproject/module/login/cubit/otp_cubit.dart';
import 'package:capstoneproject/module/login/cubit/reset_password_cubit.dart';
import 'package:capstoneproject/module/login/otp_page.dart';
import 'package:capstoneproject/ui_kit/cubit/loading_cubit.dart';
import 'package:capstoneproject/ui_kit/widget/air_18_button.dart';
import 'package:capstoneproject/ui_kit/widget/air_18_loading.dart';
import 'package:capstoneproject/ui_kit/widget/air_18_phone_number_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/utils.dart';
import '../../ui_kit/colors.dart';
import '../../ui_kit/widget/air_18_notification_dialog.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const ForgotPasswordPage());
  }

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final phoneNumberController = TextEditingController();
  ValueNotifier<bool> phoneNotifier = ValueNotifier(false);
  late OTPService otpService = OTPService();
  late OTPRepository otpRepository = OTPRepository(otpService: otpService);
  late OtpCubit otpCubit = OtpCubit(otpRepository) ;
  late LoadingCubit loadingCubit = LoadingCubit();


  @override
  void initState() {
    otpCubit.stream.listen((state) {
      if(state is OtpStateValidPhone){
        loadingCubit.hideLoading();
        showDialog(
          context: context,
          builder: (context) =>
              Air18NotificationDialog(
                title: "Forgot Password Error",
                content: "Phone number is not registered.",
                onPositiveTap: () {
                  Navigator.pop(context);
                },
                onNegativeTap: () {},
                positive: "Ok",
                isShowNegative: false,
              ),
        );
      }
      else if(state is OtpStateInValidPhone){
        loadingCubit.hideLoading();
        otpCubit.sendOtp("+84"+phoneNumberController.text.substring(1));
      } else if(state is OtpStateSendSuccess){
        loadingCubit.hideLoading();
        Navigator.push(context, OtpPage.route(
            isRegister: false, otpCubit: otpCubit,
            data: {"phoneNumber": phoneNumberController.text}));
      } else if(state is OtpStateSendFailed){
        loadingCubit.hideLoading();
        showDialog(
          context: context,
          builder: (context) =>
              Air18NotificationDialog(
                title: "Forgot Password Error",
                content: state.error,
                onPositiveTap: () {
                  Navigator.pop(context);
                },
                onNegativeTap: () {},
                positive: "Ok",
                isShowNegative: false,
              ),
        );
      }
      else if(state is OtpStateLoading){
        loadingCubit.showLoading();
      } else {
        loadingCubit.hideLoading();
      }
    });
    /*otpCubit.stream.listen((state) {
      if (state is OtpStateSendFailed) {
        if(state.error=="You have reached the limit of receiving OTP codes. Please try again in 30 minutes.") {
          showDialog(context: context, builder: (context) =>
              NotificationDialog(
                title: labels.oTPFailedTitle,
                content: labels.oTPFailedText,
                onPositiveTap: () {
                  Navigator.pop(context);
                },
                onNegativeTap: () {},
                isShowNegative: false,
                positive: labels.oTPChoose03,
              ));
        }
        else showDialog(context: context, builder: (context) => NotificationDialog(
          title: labels.forgotpasswordText03,
          content: labels.forgotpasswordText04,
          onPositiveTap: (){
            Navigator.pop(context);
          },
          onNegativeTap: (){},
          isShowNegative: false,
          positive: labels.popupErrorText02,
        ),);
      } else if (state is OtpStateSendSuccess) {
        Navigator.pushReplacement(
            context,
            OtpPage.route(
                isResetPassword: true,
                data: {'phone': trimStart(phoneNumberController.text)}));
      }
    });*/
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
              backgroundColor: Colors.white,
              resizeToAvoidBottomInset: false,
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
                              child: SvgPicture.asset('assets/images/arrow-left-icon.svg',
                                color: orangeColor,)),
                          const SizedBox(height: 48),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Forgot password?',
                                        maxLines: 2,
                                        style: GoogleFonts.poppins(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: darkBlueColor),
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    SvgPicture.asset(
                                      'assets/images/forgot-icon.svg',
                                      height: 40,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                Text(
                                  'Enter your registered phone number, a message with OTP code will be sent to you',
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
                                          Air18PhoneNumberTextField(
                                            validator: (String? value) {
                                              final nineNumberPhone =
                                              trimStart(value);
                                              if (nineNumberPhone.length == 12 && RegExp(r'^[0-9]*$').hasMatch(value!))
                                                return null;
                                              else
                                                return 'Enter your registered phone number, a message with OTP code will be sent to you';
                                            },
                                            textInputAction: TextInputAction.done,
                                            controller: phoneNumberController,
                                            labelText: 'Phone number',
                                            validNotifier: phoneNotifier,
                                          ),
                                          const SizedBox(
                                            height: 160,
                                          ),
                                          ValueListenableBuilder(
                                              valueListenable: phoneNotifier,
                                              builder:
                                                  (context, bool value, widget) {
                                                return makeAir18Button(
                                                    'Send Otp',
                                                    isEnable: value, onTap: () async {
                                                    otpCubit.checkPhone(phoneNumberController.text);
                                                }, height: 60);
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
                  Air18Loading(loadingCubit: loadingCubit)
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
