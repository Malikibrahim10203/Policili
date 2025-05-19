import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: width * 0.5,
              height:  width * 1,
              decoration: BoxDecoration(
                color: Colors.white
              ),
              child: Card(),
            )
          ],
        ),
      ),
    );
  }
}
