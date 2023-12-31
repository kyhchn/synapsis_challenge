import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:synapsis_challenge/config/themes/colors.dart';
import 'package:synapsis_challenge/features/login/presentation/bloc/login_bloc.dart';
import 'package:synapsis_challenge/features/survei-detail/presentation/bloc/survei_detail_bloc.dart';
import 'package:synapsis_challenge/features/survei/domain/entity/survei.dart';
import 'package:synapsis_challenge/features/survei/presentation/bloc/survei_bloc.dart';

class SurveiView extends StatelessWidget {
  const SurveiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final loginBloc = BlocProvider.of<LoginBloc>(context);
          loginBloc.add(Logout());
        },
        child: const Icon(Icons.logout),
      ),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LogoutSuccess) {
            context.pushReplacement('/login');
          }
        },
        child: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 3.h,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  vertical: 1.25.h,
                ),
                child: const Text(
                  'Halaman Survei',
                  style: TextStyle(
                      color: SynapsisColor.primaryColorDark,
                      fontSize: 17,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Expanded(
                child: BlocConsumer<SurveiBloc, SurveiState>(
                  listener: (context, state) {
                    if (state is SurveiError) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ));
                    }
                  },
                  builder: (context, state) {
                    if (state is SurveiLoaded) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          BlocProvider.of<SurveiBloc>(context).add(
                            LoadSurvei(),
                          );
                        },
                        child: ListView.separated(
                          itemCount: (state).surveis!.length,
                          itemBuilder: (context, index) {
                            final survei = (state).surveis![index];
                            return surveiTile(survei, context);
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 1.h,
                            );
                          },
                        ),
                      );
                    } else if (state is SurveiError) {
                      return Center(child: Text(state.message));
                    } else if (state is SurveiEmpty) {
                      return const Center(child: Text('Tidak ada survei'));
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              )
            ],
          ),
        )),
      ),
    );
  }

  ListTile surveiTile(SurveiEntity survei, BuildContext context) {
    final date = DateFormat('dd MMM yyyy').format(survei.createdAt);
    return ListTile(
      onTap: () {
        final surveiDetailBloc = BlocProvider.of<SurveiDetailBloc>(context);
        surveiDetailBloc.add(LoadDetailEvent(id: survei.id));
        context.push('/survei-detail', extra: survei);
      },
      minVerticalPadding: 1.5.h,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 1.5.h,
      ),
      shape: BeveledRectangleBorder(
        side: const BorderSide(color: Color(0xFFD9D9D9)),
        borderRadius: BorderRadius.circular(4),
      ),
      title: Text(
        survei.surveyName,
        style: const TextStyle(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        'Created At: $date',
        style: const TextStyle(
            color: Color(0xFF107C41),
            fontSize: 12,
            fontWeight: FontWeight.w500),
      ),
      leading: SvgPicture.asset(
        'assets/images/exam.svg',
        width: 7.h,
        height: 7.h,
      ),
    );
  }
}
