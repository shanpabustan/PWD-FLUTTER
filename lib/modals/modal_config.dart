// lib/config/modal_config.dart
import 'package:flutter/material.dart';
import 'modal_types.dart';

class ModalConfig {
  static const Duration _animationDuration = Duration(milliseconds: 300);
  static const double _borderRadius = 16.0;
  static const EdgeInsets _padding = EdgeInsets.all(20.0);
  static const EdgeInsets _margin = EdgeInsets.symmetric(horizontal: 20.0);

  static Duration get animationDuration => _animationDuration;
  static double get borderRadius => _borderRadius;
  static EdgeInsets get padding => _padding;
  static EdgeInsets get margin => _margin;

  static Color getBackgroundColor(ModalType type) {
    switch (type) {
      case ModalType.success:
        return Colors.green.shade50;
      case ModalType.error:
        return Colors.red.shade50;
      case ModalType.warning:
        return Colors.orange.shade50;
      case ModalType.validation:
        return Colors.blue.shade50;
    }
  }

  static Color getIconColor(ModalType type) {
    switch (type) {
      case ModalType.success:
        return Colors.green.shade600;
      case ModalType.error:
        return Colors.red.shade600;
      case ModalType.warning:
        return Colors.orange.shade600;
      case ModalType.validation:
        return Colors.blue.shade600;
    }
  }

  static Color getBorderColor(ModalType type) {
    switch (type) {
      case ModalType.success:
        return Colors.green.shade200;
      case ModalType.error:
        return Colors.red.shade200;
      case ModalType.warning:
        return Colors.orange.shade200;
      case ModalType.validation:
        return Colors.blue.shade200;
    }
  }

  static IconData getIcon(ModalType type) {
    switch (type) {
      case ModalType.success:
        return Icons.check_circle;
      case ModalType.error:
        return Icons.error;
      case ModalType.warning:
        return Icons.warning;
      case ModalType.validation:
        return Icons.info;
    }
  }
}