import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:synapsis_challenge/features/login/presentation/bloc/login_bloc.dart';
import 'package:synapsis_challenge/features/login/presentation/login_view.dart';
import 'package:synapsis_challenge/features/survei/presentation/survei_view.dart';

class Tree extends StatelessWidget {
  const Tree({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is LoginSuccess) {
          return const SurveiView();
        }
        return const LoginView();
      },
    );
  }
}
