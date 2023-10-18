import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:synapsis_challenge/config/colors.dart';

class SurveiView extends StatelessWidget {
  const SurveiView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
              child: ListView(
                children: [
                  surveiTile('Survei 1', 'Deskripsi Survei 1'),
                  surveiTile('Survei 1', 'Deskripsi Survei 1'),
                  surveiTile('Survei 1', 'Deskripsi Survei 1')
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  ListTile surveiTile(String name, String desc) {
    return ListTile(
      minVerticalPadding: 1.5.h,
      contentPadding: EdgeInsets.symmetric(
        horizontal: 1.5.h,
      ),
      shape: BeveledRectangleBorder(
        side: const BorderSide(color: Color(0xFFD9D9D9)),
        borderRadius: BorderRadius.circular(4),
      ),
      title: Text(
        name,
        style: const TextStyle(
            color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        desc,
        style: const TextStyle(
            color: Color(0xFF107C41),
            fontSize: 12,
            fontWeight: FontWeight.w500),
      ),
      leading: const Icon(Icons.abc),
    );
  }
}
