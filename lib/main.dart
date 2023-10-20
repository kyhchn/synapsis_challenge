import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:synapsis_challenge/config/colors.dart';
import 'package:synapsis_challenge/features/login/presentation/bloc/login_bloc.dart';
import 'package:synapsis_challenge/features/login/presentation/login_view.dart';
import 'package:synapsis_challenge/features/survei-detail/presentation/bloc/survei_detail_bloc.dart';
import 'package:synapsis_challenge/features/survei/presentation/bloc/home_bloc.dart';
import 'package:synapsis_challenge/features/survei/presentation/survei_view.dart';
import 'package:synapsis_challenge/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
            create: (context) => sl()..add(CheckLocalUser()),
          ),
          BlocProvider<HomeBloc>(
            create: (context) => sl(),
          ),
          BlocProvider<SurveiDetailBloc>(
            create: (context) => sl(),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            radioTheme: RadioThemeData(
              fillColor: MaterialStateProperty.all(SynapsisColor.primaryColor),
            ),
            primarySwatch: SynapsisColor.primaryColor,
            colorScheme: ColorScheme.fromSeed(
                seedColor: SynapsisColor.primaryColor,
                background: Colors.white),
            visualDensity: VisualDensity.adaptivePlatformDensity,
            fontFamily: 'Inter',
            inputDecorationTheme: InputDecorationTheme(
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Color(0xFFD6E4EC)),
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(width: 2, color: SynapsisColor.primaryColor),
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1, color: Colors.red.shade300),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.red.shade300),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.h),
              suffixIconColor: const Color(0xFF9DA7AD),
            ),
            useMaterial3: true,
          ),
          home: BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              if (state is LoginSuccess) {
                return const SurveiView();
              }
              return const LoginView();
            },
          ),
        ),
      ),
    );
  }
}
