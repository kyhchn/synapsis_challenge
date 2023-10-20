import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sizer/sizer.dart';
import 'package:synapsis_challenge/config/routes/routes.dart';
import 'package:synapsis_challenge/config/themes/theme_data.dart';
import 'package:synapsis_challenge/features/login/presentation/bloc/login_bloc.dart';
import 'package:synapsis_challenge/features/survei-detail/presentation/bloc/survei_detail_bloc.dart';
import 'package:synapsis_challenge/features/survei/presentation/bloc/survei_bloc.dart';
import 'package:synapsis_challenge/injection_container.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await initializeDependencies();
  await Future.delayed(const Duration(seconds: 2));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.wk

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) => MultiBlocProvider(
        providers: [
          BlocProvider<LoginBloc>(
            create: (context) => sl()..add(CheckLocalUser()),
          ),
          BlocProvider<SurveiBloc>(
            create: (context) => sl(),
          ),
          BlocProvider<SurveiDetailBloc>(
            create: (context) => sl(),
          ),
        ],
        child: MaterialApp.router(
          routerDelegate: router.routerDelegate,
          routeInformationParser: router.routeInformationParser,
          routeInformationProvider: router.routeInformationProvider,
          title: 'Flutter Demo',
          theme: theme(),
        ),
      ),
    );
  }
}
