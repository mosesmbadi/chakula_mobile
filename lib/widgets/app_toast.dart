import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_colors.dart';

enum ToastType { success, warning, error }

class AppToast {
  static OverlayEntry? _current;

  static void show(
    BuildContext context,
    String message, {
    ToastType type = ToastType.success,
    Duration duration = const Duration(seconds: 3),
  }) {
    _current?.remove();
    _current = null;

    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (_) => _ToastWidget(
        message: message,
        type: type,
        onDismiss: () {
          entry.remove();
          if (_current == entry) _current = null;
        },
        duration: duration,
      ),
    );

    _current = entry;
    overlay.insert(entry);
  }
}

class _ToastWidget extends StatefulWidget {
  final String message;
  final ToastType type;
  final VoidCallback onDismiss;
  final Duration duration;

  const _ToastWidget({
    required this.message,
    required this.type,
    required this.onDismiss,
    required this.duration,
  });

  @override
  State<_ToastWidget> createState() => _ToastWidgetState();
}

class _ToastWidgetState extends State<_ToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slide;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _slide = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();

    Future.delayed(widget.duration, _dismiss);
  }

  Future<void> _dismiss() async {
    if (!mounted) return;
    await _controller.reverse();
    widget.onDismiss();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color get _bgColor {
    switch (widget.type) {
      case ToastType.success:
        return AppColors.toastSuccess;
      case ToastType.warning:
        return AppColors.toastWarning;
      case ToastType.error:
        return AppColors.toastError;
    }
  }

  Color get _textColor {
    // Red background needs white; brown/green backgrounds use dark text
    return widget.type == ToastType.error ? Colors.white : AppColors.darkBrown;
  }

  IconData get _icon {
    switch (widget.type) {
      case ToastType.success:
        return Icons.check_circle_outline;
      case ToastType.warning:
        return Icons.warning_amber_outlined;
      case ToastType.error:
        return Icons.error_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Positioned(
      top: topPadding + 12,
      left: 16,
      right: 16,
      child: SlideTransition(
        position: _slide,
        child: FadeTransition(
          opacity: _fade,
          child: Material(
            color: Colors.transparent,
            child: GestureDetector(
              onTap: _dismiss,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: _bgColor,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: _bgColor.withValues(alpha: 0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Icon(_icon, color: _textColor, size: 22),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        widget.message,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: _textColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.close, color: _textColor.withValues(alpha: 0.6), size: 18),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
