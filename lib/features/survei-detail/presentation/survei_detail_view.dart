import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:synapsis_challenge/config/colors.dart';
import 'package:synapsis_challenge/features/survei-detail/presentation/bloc/survei_detail_bloc.dart';
import 'package:synapsis_challenge/features/survei/domain/entity/survei.dart';
import 'package:synapsis_challenge/pages/widgets/button.dart';

class SurveiDetailView extends StatefulWidget {
  final SurveiEntity survei;
  const SurveiDetailView({super.key, required this.survei});

  @override
  State<SurveiDetailView> createState() => _SurveiDetailViewState();
}

class _SurveiDetailViewState extends State<SurveiDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<SurveiDetailBloc, SurveiDetailState>(
          listener: (context, state) {
            if (state is SurveiDetailError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ));
            }
          },
          builder: (context, state) {
            if (state is SurveiDetailLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is SurveiDetailLoaded) {
              return Text(state.surveiDetail.surveyName);
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 3.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 1.h,
                          horizontal: 3.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: SynapsisColor.primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const Text(
                          '45 Second left',
                          style: TextStyle(
                              color: SynapsisColor.primaryColor,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 1.h, horizontal: 2.h),
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.list_alt_outlined,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 0.5.h,
                            ),
                            const Text(
                              '1/3',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                      top: 1.h, bottom: 2.h, left: 3.h, right: 3.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        'Survei A',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 2.h,
                      ),
                      const Text(
                        '1. Apakah anda tertarik bergabung ke synapsis',
                        style: TextStyle(
                          color: Color(0xFF6D6D6D),
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 1.5.h,
                  color: const Color(0xFFEEF6F9),
                ),
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 3.h),
                  child: const Text(
                    'Answer',
                    style: TextStyle(
                        color: SynapsisColor.primaryColorDark, fontSize: 15),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: const Color(0xFFF0ECEC),
                ),
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 3.h),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('tertarik',
                          style: TextStyle(
                              fontSize: 15,
                              color: SynapsisColor.primaryColorDark)),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 3.h),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 35.w,
                        child: SynapsisButton(
                            content: 'Back',
                            type: SynapsisButtonType.secondary,
                            onclick: () {}),
                      ),
                      SizedBox(
                        width: 2.h,
                      ),
                      Expanded(
                        child: SynapsisButton(
                            content: 'Next',
                            type: SynapsisButtonType.primary,
                            onclick: () {}),
                      )
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
