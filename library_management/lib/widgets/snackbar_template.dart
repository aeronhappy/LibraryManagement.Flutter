import 'package:flutter/material.dart';

OverlayEntry? _activeTopSnackbar;

void showTopSnackbar(
  BuildContext context,
  Widget content,
  Color bgColor, {
  Duration duration = const Duration(seconds: 2),
  VoidCallback? onTap,
}) {
  _activeTopSnackbar?.remove();
  _activeTopSnackbar = null;

  final overlay = Overlay.of(context);

  final width = MediaQuery.of(context).size.width;

  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) => SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: Material(
          color: Colors.transparent,
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            constraints: BoxConstraints(
              maxWidth: width > 700 ? 400 : width - 50,
            ),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: InkWell(
              onTap: () {
                if (_activeTopSnackbar == overlayEntry) {
                  overlayEntry.remove();
                  _activeTopSnackbar = null;
                }
                if (onTap != null) {
                  onTap();
                }
              },
              child: content,
            ),
          ),
        ),
      ),
    ),
  );

  _activeTopSnackbar = overlayEntry;
  overlay.insert(overlayEntry);

  // Automatically remove after duration
  Future.delayed(duration, () {
    if (_activeTopSnackbar == overlayEntry) {
      overlayEntry.remove();
      _activeTopSnackbar = null;
    }
  });
}
