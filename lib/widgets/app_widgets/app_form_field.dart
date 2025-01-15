import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:society_management/constants/constant.dart';
import 'package:society_management/theme/app_colors.dart';
import 'package:society_management/theme/fonts.dart';
import 'package:society_management/widgets/app_widgets/app_text.dart';
import '../misc/reuseable_widget.dart';

class AppFormField extends StatefulWidget {
  final String placeholder;
  final String? title;
  final TextEditingController? controller;
  final bool obsecureText;
  final Image? image;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final String name;
  final bool showTitle;
  final TextInputType inputType;
  final int maxLength;
  final FocusNode? focusNode;
  final double fontSize;
  final List<TextInputFormatter> formatters;
  final VoidCallback? onCompleted;
  final bool? enabled;
  final InputBorder? border;
  final String? icon;
  final Color color;
  final bool showFocusedBorder;
  final double prefixIconPadding;
  final bool digitsOnly;
  final double? width;
  final Function(String?)? onChanged;
  const AppFormField(
      {super.key,
      required this.placeholder,
      this.inputType = TextInputType.text,
      this.maxLength = 10000,
      this.showTitle = false,
      this.name = "",
      this.title,
      this.controller,
      this.image,
      this.suffixIcon,
      this.prefixIcon,
      this.validator,
      this.focusNode,
      this.fontSize = 15,
      this.formatters = const [],
      this.onCompleted,
      this.obsecureText = false,
      this.border,
      this.enabled = true,
      this.showFocusedBorder = true,
      this.icon,
      this.color = Colors.white,
      this.prefixIconPadding = 12,
      this.digitsOnly = false,
      this.width,
      this.onChanged});

  @override
  State<AppFormField> createState() => _AppFormFieldState();
}

class _AppFormFieldState extends State<AppFormField> {
  getOutlinedBorder({Color? color}) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(width: 1, color: color ?? AppColors.border));

  _AppFormFieldState();

  bool _obsecureText = false;

  @override
  void initState() {
    super.initState();
    _obsecureText = widget.obsecureText;
  }

  Widget _buildSuffixIcon() => IconButton(
      onPressed: () => setState(() => _obsecureText = !_obsecureText),
      icon: ReusableWidget.loadSvg(_obsecureText ? "eye" : "eye_slash",
          color: AppColors.lightGray));

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showTitle)
          Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: AppText(
              text: widget.title ?? widget.placeholder,
              style: AppText.defaultFontStyle.copyWith(
                  color: const Color(0xFF4A4A4A), fontFamily: Fonts.medium),
            ),
          ),
        SizedBox(
          width: widget.width,
          child: FormBuilderTextField(
            name: widget.name,
            controller: widget.controller,
            enableInteractiveSelection: true,
            expands: false,
            cursorColor: AppColors.secondary,
            validator: widget.validator,
            obscureText: _obsecureText,
            onChanged: widget.onChanged,
            keyboardType: widget.inputType,
            focusNode: widget.focusNode,
            maxLength: widget.maxLength,
            inputFormatters: widget.digitsOnly
                ? [FilteringTextInputFormatter.digitsOnly]
                : widget.formatters,
            enabled: widget.enabled ?? true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: TextStyle(fontSize: widget.fontSize),
            onEditingComplete: () {
              FocusManager.instance.primaryFocus?.unfocus();
              widget.onCompleted?.call();
            },
            decoration: InputDecoration(
                enabledBorder: widget.border ?? getOutlinedBorder(),
                disabledBorder: widget.border ?? getOutlinedBorder(),
                border: widget.border ?? getOutlinedBorder(),
                focusedBorder: widget.showFocusedBorder
                    ? widget.border ??
                        getOutlinedBorder(color: AppColors.primary)
                    : null,
                counterText: "",
                hintText: widget.placeholder,
                filled: true,
                fillColor: widget.color,
                hintStyle: TextStyle(
                    color: AppColors.placeholder, fontFamily: Fonts.light),
                suffixIcon: widget.obsecureText
                    ? _buildSuffixIcon()
                    : widget.suffixIcon,
                prefixIcon: widget.prefixIcon ??
                    (widget.icon != null
                        ? Padding(
                            padding: EdgeInsets.all(widget.prefixIconPadding),
                            child: ReusableWidget.loadSvg(widget.icon!,
                                color: AppColors.lightGray,
                                width: 20,
                                height: 20))
                        : null)),
          ),
        ),
      ],
    );
  }
}
