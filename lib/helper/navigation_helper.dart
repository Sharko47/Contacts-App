import 'package:flutter/material.dart';

Future navigatorPush(context, widgetScreen) async {
  await Future.delayed(const Duration(milliseconds: 20));
  return await Navigator.push(
      context, MaterialPageRoute(builder: (_) => widgetScreen));
}

navigatorPushReplaceUntil(context, widgetScreen) async {
  return await Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => widgetScreen),
      (Route<dynamic> route) => false);
}

navigatorPushRepace(context, widgetScreen) async {
  return await Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => widgetScreen));
}

goBack(context) {
  if (Navigator.canPop(context)) {
    Navigator.pop(context);
  }
}

goPreviousScreen(context, {int popCount = 0}) {
  int count = 0;
  Navigator.of(context).popUntil((_) => count++ >= popCount);
}
