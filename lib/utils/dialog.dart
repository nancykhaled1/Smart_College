import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

void showOverlayMessage(BuildContext context, String message, {bool isError = true}) {
  final overlay = Overlay.of(context);
  final entry = OverlayEntry(
    builder: (context) => Positioned(
      //top: 100, // المسافة من فوق
      left: 20,
      right: 20,
      bottom: 10,
      child: Material(
        color: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isError ? Colors.redAccent : MyColors.primaryColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    ),
  );

  overlay.insert(entry);

  // يخليه يختفي بعد 3 ثواني
  Future.delayed(const Duration(seconds: 10), () {
    entry.remove();
  });
}