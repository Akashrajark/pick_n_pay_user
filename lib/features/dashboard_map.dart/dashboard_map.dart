import 'package:flutter/material.dart';
import 'package:pick_n_pay_user/common_widgets.dart/custom_search.dart';

class DashboardMap extends StatelessWidget {
  const DashboardMap({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Stack(
          children: [
            SizedBox(
              width: double.infinity,
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                'assets/images/Screenshot 2025-03-01 161740.png',
                fit: BoxFit.cover,
              ),
            ),
            // Search bar on top
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
              child: Align(
                  alignment: Alignment.topCenter,
                  child: CustomSearch(
                    onSearch: (p0) {},
                  )),
            ),
          ],
        ),
      ],
    );
  }
}
