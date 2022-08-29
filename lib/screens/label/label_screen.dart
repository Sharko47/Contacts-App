import 'package:contactsassignment/widgets/my_text.dart';
import 'package:flutter/material.dart';

class LabelScreen extends StatelessWidget {
  const LabelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: MyText(text: "Will be available soon."),
      ),
    );
  }
}
