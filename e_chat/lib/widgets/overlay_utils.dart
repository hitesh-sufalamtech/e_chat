import 'dart:async';

import 'package:flutter/material.dart';

class OverlayUtils {
  static Timer _toastTimer;
  static OverlayEntry _overlayEntry;

  static void overlay(
      {BuildContext context,
      Widget child,
      Alignment alignment,
      Duration duration,
      Color color}) {
    if (_overlayEntry == null) if (_toastTimer == null ||
        !_toastTimer.isActive) {
      _overlayEntry = createOverlayEntry(context, child, alignment, color);
      Overlay.of(context).insert(_overlayEntry);
    }
  }

  static removeOverlay() {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
  }

  static hasOverlay() => _overlayEntry != null;

  static OverlayEntry createOverlayEntry(
      BuildContext context, Widget child, Alignment alignment, Color color) {
    return OverlayEntry(
      builder: (context) => Align(
        alignment: alignment,
        child: Material(
          color: Colors.transparent,
          child: child,
        ),
      ),
    );
  }
}
