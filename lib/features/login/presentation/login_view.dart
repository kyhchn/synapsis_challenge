import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:synapsis_challenge/config/colors.dart';
import 'package:synapsis_challenge/features/login/presentation/bloc/login_bloc.dart';
import 'package:synapsis_challenge/features/survei/presentation/survei_view.dart';
import 'package:synapsis_challenge/widgets/button.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final key = GlobalKey<FormState>();
  bool isObscure = true;
  bool isRememberMe = false;
  void obscureHandler() {
    setState(() {
      isObscure = !isObscure;
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) async {
        if (state is LoginSuccess) {
          context.pushReplacement('/');
        }

        if (state is LoginError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.exception!.message!),
            backgroundColor: Colors.red,
          ));
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                separator(),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 1.25.h),
                  child: const Text(
                    'Login to Synapsis',
                    style: TextStyle(
                        color: SynapsisColor.primaryColorDark,
                        fontSize: 21,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                separator(),
                inputField(
                    emailController, 'Email', TextInputType.emailAddress),
                SizedBox(
                  height: 2.h,
                ),
                inputField(passwordController, 'Password',
                    TextInputType.visiblePassword,
                    obscureText: isObscure, obscureHandler: obscureHandler),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 2.h,
                      height: 2.h,
                      child: Checkbox(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                          side: const BorderSide(
                              width: 1, color: Color(0xFFD0D7DE)),
                          value: isRememberMe,
                          onChanged: (value) {
                            setState(() {
                              isRememberMe = value!;
                            });
                          }),
                    ),
                    SizedBox(
                      width: 1.5.h,
                    ),
                    const Text(
                      'Remember me',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                          color: Color(0xFF757575)),
                    )
                  ],
                ),
                separator(),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        child: SynapsisButton(
                          content: 'Log in',
                          type: SynapsisButtonType.primary,
                          onclick: () {
                            context.read<LoginBloc>().add(Login(
                                isRemember: isRememberMe,
                                email: emailController.text,
                                password: passwordController.text));
                          },
                        ),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      const Text(
                        'or',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: SynapsisColor.primaryColor),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: SynapsisButton(
                          content: 'Fingerprint',
                          type: SynapsisButtonType.secondary,
                          onclick: () {},
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column inputField(TextEditingController controller, String label,
      TextInputType keyboardType,
      {bool obscureText = false, void Function()? obscureHandler}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Color(0xFFB9B9B9), fontSize: 13),
        ),
        SizedBox(
          height: 0.5.h,
        ),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            suffixIcon: keyboardType == TextInputType.visiblePassword
                ? IconButton(
                    onPressed: obscureHandler,
                    icon: Icon(
                      obscureText
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: const Color(0xFF9DA7AD),
                    ),
                  )
                : null,
          ),
          style: const TextStyle(
              color: Color(0xFF757575),
              fontWeight: FontWeight.w400,
              fontSize: 15),
        )
      ],
    );
  }

  SizedBox separator() {
    return SizedBox(
      height: 3.h,
    );
  }
}
