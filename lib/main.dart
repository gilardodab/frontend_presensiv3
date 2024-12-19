import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_presensiv3/data/datasources/kunjungan_remote_datasource.dart';
import 'package:frontend_presensiv3/ui/home/bloc/addkunjungan/selfie_kunjungan_bloc.dart';
import 'package:frontend_presensiv3/ui/home/bloc/history_presensi/history_presensi_bloc.dart';
import 'package:frontend_presensiv3/ui/home/bloc/kunjungan/kunjungan_bloc.dart';
import 'package:frontend_presensiv3/ui/home/bloc/presensi/presensi_bloc.dart';
import 'core/constants/colors.dart';
import 'data/datasources/auth_remote_datasource.dart';
import 'package:google_fonts/google_fonts.dart';

import 'data/datasources/callplan_remote_datasource.dart';
import 'data/datasources/cuti_remote_datasource.dart';
import 'data/datasources/firebase_messaging_datasource.dart';
import 'data/datasources/presensi_remote_datasource.dart';
import 'data/datasources/resetpassword_remote_datasource.dart';
import 'data/datasources/riwayatpresensi_datasource.dart';
import 'data/datasources/user_remote_datasource.dart';
import 'ui/auth/bloc/login/login_bloc.dart';
import 'ui/auth/bloc/logout/logout_bloc.dart';
import 'ui/auth/bloc/resetpassword/resetpassword_bloc.dart';
import 'ui/auth/pages/splash_page.dart';

import 'ui/firebase_options.dart';
import 'ui/home/bloc/addunplan/unplankunjungan_bloc.dart';
import 'ui/home/bloc/callplan/callplan_bloc.dart';
import 'ui/home/bloc/cuti/cuti_bloc.dart';
import 'ui/home/bloc/notification/notification_bloc.dart';
import 'ui/home/bloc/user/user_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessangingRemoteDatasource().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(AuthRemoteDatasource()),
        ),
        //user bloc
        BlocProvider(create: (context) => UserBloc(userRemoteDatasource: UserRemoteDatasource())),
        BlocProvider(
        create: (context) => PresensiBloc(
          presensiRemoteDataSource: PresensiRemoteDataSource(Dio()) // Passing Dio instance
        ),
      ),
        // BlocProvider(create: (context) => RiwayatPresensiBloc(riwayatPresensiRemoteDataSource: RiwayatPresensiRemoteDataSource())),
        BlocProvider(create: (context) => HistoryPresensiBloc(RiwayatPresensiRemoteDataSource())),
        BlocProvider(create: (context) => CutiBloc(CutiRemoteDataSource()),),
        BlocProvider(create: (context) => CallPlanBloc(CallPlanRemoteDataSource()),),
        BlocProvider(
          create: (context) => LogoutBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(create: (context) => KunjunganBloc(KunjunganRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => ResetpasswordBloc(ResetPasswordRemoteDataSource()),
        ),
        BlocProvider(
          create: (context) => NotificationBloc(AuthRemoteDatasource()),
        ),
        BlocProvider(create: (context) => SelfieKunjunganBloc(KunjunganRemoteDatasource()),),
        BlocProvider(create: (context) => UnplanKunjunganBloc(KunjunganRemoteDatasource()),),
      ],
      child: MaterialApp(
        title: 'E-Presensi',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          dividerTheme:
              DividerThemeData(color: AppColors.light.withOpacity(0.5)),
          dialogTheme: const DialogTheme(elevation: 0),
          textTheme: GoogleFonts.kumbhSansTextTheme(
            Theme.of(context).textTheme,
          ),
          appBarTheme: AppBarTheme(
            centerTitle: true,
            color: AppColors.white,
            elevation: 0,
            titleTextStyle: GoogleFonts.kumbhSans(
              color: AppColors.black,
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: const SplashPage(),
        // home: const MainPage(),
      ),
    );
  }
}