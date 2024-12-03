import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend_presensiv3/data/models/response/cuti_response_model.dart';
import 'package:frontend_presensiv3/ui/home/bloc/presensi/presensi_bloc.dart';
import 'core/constants/colors.dart';
import 'data/datasources/auth_remote_datasource.dart';
import 'package:google_fonts/google_fonts.dart';

import 'data/datasources/cuti_remote_datasource.dart';
import 'data/datasources/presensi_remote_datasource.dart';
import 'data/datasources/riwayatpresensi_datasource.dart';
import 'data/datasources/user_remote_datasource.dart';
import 'ui/auth/bloc/login/login_bloc.dart';
import 'ui/auth/pages/splash_page.dart';

import 'ui/home/bloc/cuti/cuti_bloc.dart';
import 'ui/home/bloc/cuti/cuti_event.dart';
import 'ui/home/bloc/riwayatpresensi/riwayatpresensi_bloc.dart';
import 'ui/home/bloc/user/user_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        BlocProvider(create: (context) => RiwayatPresensiBloc(riwayatPresensiRemoteDataSource: RiwayatPresensiRemoteDataSource())),
        BlocProvider(create: (context) => CutiBloc(cutiDataSource: CutiDataSource())),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
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
      ),
    );
  }
}