import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:pxp_flutter/constants/Theme.dart';

import 'state/app_state.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Extension method on [BuildContext] to easily perform snackbar operations.
extension Snackbar on BuildContext {
  /// Removes the current active [SnackBar], and replaces it with a new snackbar
  /// with content of [message].
  void removeAndShowSnackbar(final String message) {
    ScaffoldMessenger.of(this).removeCurrentSnackBar();
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          content: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                height: 90,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: pxpColors.darkElevatedPrimary,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    message,
                    style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              Positioned(
                  top: -15,
                  left: 0,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: pxpColors.darkElevatedTertiary),
                      ),
                      Positioned(
                          top: 10,
                          child: SvgPicture.asset("assets/icons/close.svg"),
                          height: 10)
                    ],
                  ))
            ],
          )),
    );
  }
}

/// Extension method on [BuildContext] to easily retrieve providers.
extension ProviderX on BuildContext {
  /// Returns the application [AppState].
  AppState get appState => read<AppState>();
}
