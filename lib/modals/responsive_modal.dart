// lib/widgets/responsive_modal.dart
import 'package:flutter/material.dart';
import 'modal_types.dart';
import 'modal_config.dart';

class ResponsiveModal extends StatelessWidget {
  final ModalType type;
  final String title;
  final String message;
  final String? primaryButtonText;
  final String? secondaryButtonText;
  final VoidCallback? onPrimaryPressed;
  final VoidCallback? onSecondaryPressed;
  final Widget? customContent;
  final bool barrierDismissible;
  final List<String>? validationErrors;

  const ResponsiveModal({
    Key? key,
    required this.type,
    required this.title,
    required this.message,
    this.primaryButtonText,
    this.secondaryButtonText,
    this.onPrimaryPressed,
    this.onSecondaryPressed,
    this.customContent,
    this.barrierDismissible = true,
    this.validationErrors,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: _getInsetPadding(context),
      child: _buildModalContent(context),
    );
  }

  EdgeInsets _getInsetPadding(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    if (screenWidth < 600) {
      // Mobile
      return EdgeInsets.symmetric(
        horizontal: 16,
        vertical: screenHeight * 0.1,
      );
    } else if (screenWidth < 1200) {
      // Tablet
      return EdgeInsets.symmetric(
        horizontal: screenWidth * 0.2,
        vertical: screenHeight * 0.15,
      );
    } else {
      // Desktop
      return EdgeInsets.symmetric(
        horizontal: screenWidth * 0.3,
        vertical: screenHeight * 0.2,
      );
    }
  }

  Widget _buildModalContent(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 1200;
    final isTablet = screenWidth >= 600 && screenWidth < 1200;

    return Container(
      constraints: BoxConstraints(
        maxWidth: isDesktop ? 500 : (isTablet ? 400 : double.infinity),
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ModalConfig.borderRadius),
        border: Border.all(
          color: ModalConfig.getBorderColor(type),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(context),
          _buildBody(context),
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final iconSize = screenWidth < 600 ? 40.0 : 48.0;
    final titleFontSize = screenWidth < 600 ? 18.0 : 20.0;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ModalConfig.getBackgroundColor(type),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(ModalConfig.borderRadius),
          topRight: Radius.circular(ModalConfig.borderRadius),
        ),
      ),
      child: Column(
        children: [
          Icon(
            ModalConfig.getIcon(type),
            color: ModalConfig.getIconColor(type),
            size: iconSize,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final messageFontSize = screenWidth < 600 ? 14.0 : 16.0;

    return Flexible(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (message.isNotEmpty)
              Text(
                message,
                style: TextStyle(
                  fontSize: messageFontSize,
                  color: Colors.grey.shade700,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
            if (type == ModalType.validation && validationErrors != null)
              ..._buildValidationErrors(context),
            if (customContent != null) ...[
              const SizedBox(height: 16),
              customContent!,
            ],
          ],
        ),
      ),
    );
  }

  List<Widget> _buildValidationErrors(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final errorFontSize = screenWidth < 600 ? 13.0 : 14.0;

    if (validationErrors == null || validationErrors!.isEmpty) {
      return [];
    }

    return [
      const SizedBox(height: 16),
      Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.red.shade200),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please fix the following issues:',
              style: TextStyle(
                fontSize: errorFontSize,
                fontWeight: FontWeight.w600,
                color: Colors.red.shade700,
              ),
            ),
            const SizedBox(height: 8),
            ...validationErrors!.map(
              (error) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.circle,
                      size: 6,
                      color: Colors.red.shade600,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        error,
                        style: TextStyle(
                          fontSize: errorFontSize,
                          color: Colors.red.shade700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ];
  }

  Widget _buildFooter(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    if (primaryButtonText == null && secondaryButtonText == null) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(20),
      child: isMobile
          ? _buildMobileButtons(context)
          : _buildDesktopButtons(context),
    );
  }

  Widget _buildMobileButtons(BuildContext context) {
    return Column(
      children: [
        if (primaryButtonText != null)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onPrimaryPressed ?? () => Navigator.of(context).pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: ModalConfig.getIconColor(type),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(primaryButtonText!),
            ),
          ),
        if (secondaryButtonText != null) ...[
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: onSecondaryPressed ?? () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey.shade600,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(secondaryButtonText!),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDesktopButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (secondaryButtonText != null) ...[
          TextButton(
            onPressed: onSecondaryPressed ?? () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              foregroundColor: Colors.grey.shade600,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: Text(secondaryButtonText!),
          ),
          const SizedBox(width: 8),
        ],
        if (primaryButtonText != null)
          ElevatedButton(
            onPressed: onPrimaryPressed ?? () => Navigator.of(context).pop(),
            style: ElevatedButton.styleFrom(
              backgroundColor: ModalConfig.getIconColor(type),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(primaryButtonText!),
          ),
      ],
    );
  }
}