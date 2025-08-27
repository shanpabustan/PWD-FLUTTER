// lib/services/modal_service.dart
import 'package:flutter/material.dart';
import 'responsive_modal.dart';
import 'modal_types.dart';
import 'modal_config.dart';

class ModalService {
  static Future<T?> _showModal<T>(
    BuildContext context,
    ResponsiveModal modal,
  ) {
    return showGeneralDialog<T>(
      context: context,
      barrierDismissible: modal.barrierDismissible,
      barrierLabel: 'Modal',
      barrierColor: Colors.black54,
      transitionDuration: ModalConfig.animationDuration,
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, -1),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          )),
          child: FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
      },
      pageBuilder: (context, animation, secondaryAnimation) => modal,
    );
  }

  /// Show success modal
  static Future<void> showSuccess(
    BuildContext context, {
    required String title,
    required String message,
    String? primaryButtonText = 'OK',
    String? secondaryButtonText,
    VoidCallback? onPrimaryPressed,
    VoidCallback? onSecondaryPressed,
    Widget? customContent,
    bool barrierDismissible = true,
  }) {
    return _showModal(
      context,
      ResponsiveModal(
        type: ModalType.success,
        title: title,
        message: message,
        primaryButtonText: primaryButtonText,
        secondaryButtonText: secondaryButtonText,
        onPrimaryPressed: onPrimaryPressed,
        onSecondaryPressed: onSecondaryPressed,
        customContent: customContent,
        barrierDismissible: barrierDismissible,
      ),
    );
  }

  /// Show error modal
  static Future<void> showError(
    BuildContext context, {
    required String title,
    required String message,
    String? primaryButtonText = 'OK',
    String? secondaryButtonText,
    VoidCallback? onPrimaryPressed,
    VoidCallback? onSecondaryPressed,
    Widget? customContent,
    bool barrierDismissible = true,
  }) {
    return _showModal(
      context,
      ResponsiveModal(
        type: ModalType.error,
        title: title,
        message: message,
        primaryButtonText: primaryButtonText,
        secondaryButtonText: secondaryButtonText,
        onPrimaryPressed: onPrimaryPressed,
        onSecondaryPressed: onSecondaryPressed,
        customContent: customContent,
        barrierDismissible: barrierDismissible,
      ),
    );
  }

  /// Show warning modal
  static Future<void> showWarning(
    BuildContext context, {
    required String title,
    required String message,
    String? primaryButtonText = 'OK',
    String? secondaryButtonText,
    VoidCallback? onPrimaryPressed,
    VoidCallback? onSecondaryPressed,
    Widget? customContent,
    bool barrierDismissible = true,
  }) {
    return _showModal(
      context,
      ResponsiveModal(
        type: ModalType.warning,
        title: title,
        message: message,
        primaryButtonText: primaryButtonText,
        secondaryButtonText: secondaryButtonText,
        onPrimaryPressed: onPrimaryPressed,
        onSecondaryPressed: onSecondaryPressed,
        customContent: customContent,
        barrierDismissible: barrierDismissible,
      ),
    );
  }

  /// Show validation modal
  static Future<void> showValidation(
    BuildContext context, {
    required String title,
    required String message,
    required List<String> validationErrors,
    String? primaryButtonText = 'Fix Issues',
    String? secondaryButtonText = 'Cancel',
    VoidCallback? onPrimaryPressed,
    VoidCallback? onSecondaryPressed,
    Widget? customContent,
    bool barrierDismissible = true,
  }) {
    return _showModal(
      context,
      ResponsiveModal(
        type: ModalType.validation,
        title: title,
        message: message,
        validationErrors: validationErrors,
        primaryButtonText: primaryButtonText,
        secondaryButtonText: secondaryButtonText,
        onPrimaryPressed: onPrimaryPressed,
        onSecondaryPressed: onSecondaryPressed,
        customContent: customContent,
        barrierDismissible: barrierDismissible,
      ),
    );
  }

  /// Show info modal
  static Future<void> showInfo(
    BuildContext context, {
    required String title,
    required String message,
    String? primaryButtonText = 'OK',
    String? secondaryButtonText,
    VoidCallback? onPrimaryPressed,
    VoidCallback? onSecondaryPressed,
    Widget? customContent,
    bool barrierDismissible = true,
  }) {
    return _showModal(
      context,
      ResponsiveModal(
        type: ModalType.validation, // Using validation type for info modals
        title: title,
        message: message,
        primaryButtonText: primaryButtonText,
        secondaryButtonText: secondaryButtonText,
        onPrimaryPressed: onPrimaryPressed,
        onSecondaryPressed: onSecondaryPressed,
        customContent: customContent,
        barrierDismissible: barrierDismissible,
      ),
    );
  }

  /// Show confirmation modal
  static Future<bool> showConfirmation(
    BuildContext context, {
    required String title,
    required String message,
    String primaryButtonText = 'Confirm',
    String secondaryButtonText = 'Cancel',
    ModalType type = ModalType.warning,
  }) async {
    bool? result = await _showModal<bool>(
      context,
      ResponsiveModal(
        type: type,
        title: title,
        message: message,
        primaryButtonText: primaryButtonText,
        secondaryButtonText: secondaryButtonText,
        onPrimaryPressed: () => Navigator.of(context).pop(true),
        onSecondaryPressed: () => Navigator.of(context).pop(false),
        barrierDismissible: false,
      ),
    );
    return result ?? false;
  }
}