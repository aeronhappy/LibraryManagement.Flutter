import 'package:flutter/material.dart';
import 'package:library_management/design/app_colors.dart';
import 'package:library_management/design/text_style.dart';
import 'package:library_management/widgets/snackbar_template.dart';

void showLoggingInSnackbar(BuildContext context) {
  showTopSnackbar(
    context,
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Logging in...',
          style: titleSmallDark.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
        ),
        SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            color: darkCardColor,
            strokeWidth: 1.5,
          ),
        ),
      ],
    ),
    navBarIconColor,
    duration: const Duration(seconds: 60),
  );
}

void showLoginSuccessSnackbar(BuildContext context) {
  showTopSnackbar(
    context,
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Login successful',
          style: titleSmallDark.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 15,
          ),
        ),
        Icon(Icons.check, size: 20, color: Colors.white),
      ],
    ),
    primaryColor,
    duration: const Duration(seconds: 1),
  );
}

void showLoginFailedSnackbar(BuildContext context) {
  showTopSnackbar(
    context,
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Login failed.',
              style: titleSmallDark.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
            ),
            Text('Please try again.', style: labelLargeDark),
          ],
        ),
        Icon(Icons.error_outline_rounded, size: 20, color: Colors.white),
      ],
    ),
    errorColor,
    duration: const Duration(seconds: 1),
  );
}

void showNoCurrentPermissionActiveSnackbar(BuildContext context) {
  showTopSnackbar(
    context,
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Permission Failed.',
              style: titleSmallDark.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
            ),
            Text('Contact Admin to get permission.', style: labelLargeDark),
          ],
        ),
        Icon(Icons.error_outline_rounded, size: 20, color: Colors.white),
      ],
    ),
    errorColor,
    duration: const Duration(seconds: 1),
  );
}

void showSessionExpired(BuildContext context, String message) {
  showTopSnackbar(
    context,
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              style: titleSmallDark.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 15,
              ),
            ),
            Text('Please try again.', style: labelLargeDark),
          ],
        ),
        Icon(Icons.error_outline_rounded, size: 20, color: Colors.white),
      ],
    ),
    errorColor,
    duration: const Duration(seconds: 1),
  );
}
