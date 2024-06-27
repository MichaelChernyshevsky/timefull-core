import 'package:flutter/material.dart';

enum SnackBarType { info, warn, error, success }

final class DialogService {
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  GlobalKey<ScaffoldMessengerState> get scaffoldMessengerKey => _scaffoldMessengerKey;

  Color _getColor(SnackBarType type) {
    return Colors.red;
  }

  void showSnackBar({required String text, required SnackBarType type}) {
    _scaffoldMessengerKey.currentState
      ?..clearSnackBars()
      ..showSnackBar(SnackBar(
        elevation: 1,
        behavior: SnackBarBehavior.floating,
        backgroundColor: _getColor(type),
        content: Text(text),
      ));
  }

  Future<void> showAlertDialog() async {
    await showDialog(
      context: _scaffoldMessengerKey.currentState!.context,
      builder: (BuildContext context) => const Text("data"),
    );
  }
}
