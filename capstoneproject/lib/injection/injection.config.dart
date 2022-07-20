// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/repository/forgot_password_repository.dart' as _i10;
import '../data/repository/login_repository.dart' as _i6;
import '../data/repository/otp_repository.dart' as _i8;
import '../hive/hive_service.dart' as _i3;
import '../module/login/cubit/login_cubit.dart' as _i5;
import '../module/login/cubit/otp_cubit.dart' as _i7;
import '../module/login/cubit/reset_password_cubit.dart' as _i9;
import '../ui_kit/cubit/loading_cubit.dart'
    as _i4; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.singleton<_i3.HiveService>(_i3.HiveService());
  gh.factory<_i4.LoadingCubit>(() => _i4.LoadingCubit());
  gh.factory<_i5.LoginCubit>(
      () => _i5.LoginCubit(repository: get<_i6.LoginRepository>()));
  gh.factory<_i7.OtpCubit>(() => _i7.OtpCubit(get<_i8.OTPRepository>()));
  gh.factory<_i9.ResetPasswordCubit>(
      () => _i9.ResetPasswordCubit(get<_i10.ForgotPasswordRepository>()));
  return get;
}
