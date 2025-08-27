// lib/enums/modal_types.dart
enum ModalType {
  success,
  error,
  warning,
  validation,
}

extension ModalTypeExtension on ModalType {
  String get name {
    switch (this) {
      case ModalType.success:
        return 'Success';
      case ModalType.error:
        return 'Error';
      case ModalType.warning:
        return 'Warning';
      case ModalType.validation:
        return 'Validation';
    }
  }
}