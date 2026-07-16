import 'package:flutter/material.dart';
import 'package:ldce_alumni/theme/app_theme.dart';
import 'package:ldce_alumni/theme/themes.dart';

enum FxButtonType { elevated, outlined, text }

class FxButton extends StatelessWidget {
  final FxButtonType? buttonType;

  final ButtonStyle? style;

  final VoidCallback? onPressed;

  final bool? disabled;
  final bool? block;
  final bool soft;

  final WidgetStateProperty<EdgeInsetsGeometry>? msPadding;
  final EdgeInsetsGeometry? padding;

  final WidgetStateProperty<double>? msElevation;
  final double? elevation;

  final WidgetStateProperty<EdgeInsetsGeometry>? msShape;
  final OutlinedBorder? shape;
  final BorderRadiusGeometry? borderRadius;
  final double? borderRadiusAll;

  final WidgetStateProperty<Color>? msBackgroundColor;
  final Color? backgroundColor;

  final WidgetStateProperty<BorderSide>? msSide;
  final BorderSide? side;
  final Color borderColor;

  final WidgetStateProperty<Color>? msShadowColor;
  final Color? shadowColor;

  final Color? splashColor;

  final Widget child;

  const FxButton(
      {this.onPressed,
      required this.child,
      this.msPadding,
      this.padding,
      this.msShape,
      this.shape,
      this.borderRadius,
      this.borderRadiusAll = 0,
      this.msBackgroundColor,
      this.backgroundColor,
      this.buttonType = FxButtonType.elevated,
      this.style,
      this.msShadowColor,
      this.msSide,
      this.side,
      this.borderColor = Colors.transparent,
      this.disabled = false,
      this.block = false,
      this.soft = false,
      this.msElevation,
      this.elevation = 4,
      this.shadowColor,
      this.splashColor});

  const FxButton.rounded(
      {required this.onPressed,
      required this.child,
      this.msPadding,
      this.padding,
      this.msShape,
      this.shape,
      this.borderRadius,
      this.borderRadiusAll,
      this.msBackgroundColor,
      this.backgroundColor,
      this.buttonType = FxButtonType.elevated,
      this.style,
      this.block = false,
      this.msSide,
      this.disabled = false,
      this.side,
      this.soft = false,
      this.borderColor = Colors.transparent,
      this.msShadowColor,
      this.msElevation,
      this.elevation = 4,
      this.shadowColor,
      this.splashColor});

  const FxButton.small(
      {required this.onPressed,
      required this.child,
      this.msPadding,
      this.padding = const EdgeInsets.fromLTRB(8, 4, 8, 4),
      this.msShape,
      this.shape,
      this.borderRadius,
      this.borderRadiusAll,
      this.msBackgroundColor,
      this.backgroundColor,
      this.buttonType = FxButtonType.elevated,
      this.style,
      this.block = false,
      this.msSide,
      this.soft = false,
      this.disabled = false,
      this.side,
      this.borderColor = Colors.transparent,
      this.msShadowColor,
      this.msElevation,
      this.elevation = 4,
      this.shadowColor,
      this.splashColor});

  FxButton.medium(
      {required this.onPressed,
      required this.child,
      this.msPadding,
      this.padding = const EdgeInsets.fromLTRB(24, 16, 24, 16),
      this.msShape,
      this.block = false,
      this.shape,
      this.soft = false,
      this.borderRadius,
      this.borderRadiusAll,
      this.msBackgroundColor,
      this.backgroundColor,
      this.buttonType = FxButtonType.elevated,
      this.style,
      this.msSide,
      this.disabled = false,
      this.side,
      this.borderColor = Colors.transparent,
      this.msShadowColor,
      this.msElevation,
      this.elevation = 4,
      this.shadowColor,
      this.splashColor});

  FxButton.text(
      {required this.onPressed,
      required this.child,
      this.msPadding,
      this.padding = const EdgeInsets.fromLTRB(24, 16, 24, 16),
      this.msShape,
      this.block = false,
      this.shape,
      this.soft = false,
      this.borderRadius,
      this.borderRadiusAll,
      this.msBackgroundColor,
      this.backgroundColor,
      this.buttonType = FxButtonType.text,
      this.style,
      this.msSide,
      this.disabled = false,
      this.side,
      this.borderColor = Colors.transparent,
      this.msShadowColor,
      this.msElevation,
      this.elevation = 4,
      this.shadowColor,
      this.splashColor});

  FxButton.block(
      {required this.onPressed,
      required this.child,
      this.msPadding,
      this.padding = const EdgeInsets.fromLTRB(24, 16, 24, 16),
      this.msShape,
      this.block = true,
      this.shape,
      this.soft = false,
      this.borderRadius,
      this.borderRadiusAll,
      this.msBackgroundColor,
      this.backgroundColor,
      this.buttonType = FxButtonType.elevated,
      this.style,
      this.msSide,
      this.disabled = false,
      this.side,
      this.borderColor = Colors.transparent,
      this.msShadowColor,
      this.msElevation,
      this.elevation = 4,
      this.shadowColor,
      this.splashColor});

  FxButton.outlined(
      {required this.onPressed,
      required this.child,
      this.msPadding,
      this.padding = const EdgeInsets.fromLTRB(24, 16, 24, 16),
      this.msShape,
      this.soft = false,
      this.shape,
      this.borderRadius,
      this.borderRadiusAll,
      this.msBackgroundColor,
      this.backgroundColor,
      this.buttonType = FxButtonType.outlined,
      this.style,
      this.msSide,
      this.block = false,
      this.side,
      this.disabled = false,
      this.borderColor = Colors.transparent,
      this.msShadowColor,
      this.msElevation,
      this.elevation = 4,
      this.shadowColor,
      this.splashColor});

  FxButton.large(
      {required this.onPressed,
      required this.child,
      this.msPadding,
      this.padding = const EdgeInsets.fromLTRB(36, 20, 36, 20),
      this.msShape,
      this.shape,
      this.soft = false,
      this.borderRadius,
      this.borderRadiusAll,
      this.msBackgroundColor,
      this.backgroundColor,
      this.buttonType = FxButtonType.elevated,
      this.style,
      this.disabled = false,
      this.msSide,
      this.side,
      this.block = false,
      this.borderColor = Colors.transparent,
      this.msShadowColor,
      this.msElevation,
      this.elevation = 4,
      this.shadowColor,
      this.splashColor});

  @override
  Widget build(BuildContext context) {
    Widget button;
    Color bgColor = backgroundColor ?? AppTheme.theme.colorScheme.primary;

    if (buttonType == FxButtonType.outlined) {
      button = OutlinedButton(
        onPressed: onPressed,
        child: child,
        style: style ??
            ButtonStyle(
                side: msSide ??
                    WidgetStateProperty.all(side ??
                        BorderSide(
                          color: soft ? borderColor.withAlpha(100) : borderColor,
                          width: soft ? 0.8 : 1,
                        )),
                overlayColor: WidgetStateProperty.all(splashColor ?? (bgColor.withAlpha(40))),
                backgroundColor: soft ? WidgetStateProperty.all(borderColor.withAlpha(40)) : null,
                foregroundColor: WidgetStateProperty.all(borderColor.withAlpha(40)),
                shadowColor: msShadowColor ?? WidgetStateProperty.all(shadowColor),
                padding: msPadding ?? WidgetStateProperty.all(padding),
                shape: WidgetStateProperty.all(shape ??
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadiusAll ?? 8),
                    ))),
      );
    } else if (buttonType == FxButtonType.elevated) {
      button = ElevatedButton(
          style: style ??
              ButtonStyle(
                  elevation: msElevation ??
                      WidgetStateProperty.resolveWith<double>(
                        (Set<WidgetState> states) {
                          if (states.contains(WidgetState.disabled))
                            return 0;
                          else if (states.contains(WidgetState.pressed))
                            return elevation! * 2;
                          else if (states.contains(WidgetState.hovered)) return elevation! * 1.5;
                          return elevation!;
                        },
                      ),
                  backgroundColor: msBackgroundColor ??
                      WidgetStateProperty.resolveWith<Color>(
                        (Set<WidgetState> states) {
                          if (states.contains(WidgetState.disabled)) return bgColor.withAlpha(100);
                          return bgColor;
                        },
                      ),
                  shadowColor: msShadowColor ?? WidgetStateProperty.all(shadowColor ?? bgColor),
                  padding: msPadding ?? WidgetStateProperty.all(padding),
                  overlayColor: WidgetStateProperty.all(splashColor ?? (bgColor.withAlpha(40))),
                  shape: WidgetStateProperty.all(shape ??
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(borderRadiusAll ?? 8),
                      ))),
          onPressed: onPressed,
          child: child);
    } else {
      button = TextButton(
        style: ButtonStyle(
            overlayColor: WidgetStateProperty.all(splashColor ?? (bgColor.withAlpha(40))),
            padding: msPadding ?? WidgetStateProperty.all(padding),
            visualDensity: VisualDensity.compact,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap),
        onPressed: onPressed,
        child: child,
      );
    }

    return block!
        ? Row(
            children: [
              Expanded(child: button),
            ],
          )
        : button;
  }
}
