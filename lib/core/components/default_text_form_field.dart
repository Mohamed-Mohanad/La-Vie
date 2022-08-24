import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:la_vie_app/core/style/colors/app_colors.dart';
import 'package:la_vie_app/core/style/texts/app_text_styles.dart';


class DefaultTextFormField extends StatefulWidget {
  int? maxLength;
  int? maxLines;
  bool isEnabled;
  bool required;
  bool isPassword;
  bool isFilled;
  bool hasBorder;
  bool autoFocus;
  bool readOnly;
  double contentPaddingVertical;
  double contentPaddingHorizontal;
  double borderRadius;
  double borderSideWidth;
  double enabledBorderRadius;
  Color enabledBorderRadiusColor;
  final String? validationMsg;
  final TextInputType textInputType;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Function? onPressSuffixIcon;
  final Function? onFilledSubmit;
  final Function? onChange;
  final Function? validation;
  final Function? onTap;
  final String? labelText;
  final TextEditingController controller;
  Color? fillColor;

  DefaultTextFormField(
      {Key? key,
      this.isPassword = false,
      this.autoFocus = false,
      this.readOnly = false,
      this.isFilled = false,
      this.hasBorder = true,
      this.required = true,
      this.isEnabled = true,
      this.borderSideWidth = 1.0,
      this.contentPaddingHorizontal = 10.0,
      this.contentPaddingVertical = 10.0,
      this.borderRadius = 5,
      this.enabledBorderRadius = 5,
      this.enabledBorderRadiusColor = Colors.grey,
      this.maxLength,
      this.maxLines,
      this.labelText,
      required this.textInputType,
      required this.controller,
      this.onFilledSubmit,
      this.onChange,
      this.onTap,
      this.onPressSuffixIcon,
      this.validation,
      this.suffixIcon,
      this.prefixIcon,
      this.validationMsg,
      this.fillColor})
      : super(key: key);

  @override
  State<DefaultTextFormField> createState() => _DefaultTextFormFieldState();
}

class _DefaultTextFormFieldState extends State<DefaultTextFormField> {
  late FocusNode myFocusNode;
  bool hidePassword = true;
  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    myFocusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      style: AppTextStyle.bodyText(),
      readOnly: widget.readOnly,
      obscureText: widget.isPassword && hidePassword,
      focusNode: myFocusNode,
      autofocus: widget.autoFocus,
      enabled: widget.isEnabled,
      controller: widget.controller,
      keyboardType: widget.textInputType,
      onFieldSubmitted: (String? value) {
        if (widget.onFilledSubmit != null) {
          widget.onFilledSubmit!();
        }
      },
      onChanged: (String? value) {
        if (widget.onChange != null) {
          widget.onChange!(value);
        }
      },
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      validator: (String? value) {
        if (widget.validation != null) {
          return widget.validation!(value);
        } else if (value!.isEmpty && widget.required) {
          return widget.validationMsg ?? "this field can`t be empty";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          vertical: widget.contentPaddingVertical.h,
          horizontal: widget.contentPaddingHorizontal.w,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              widget.borderRadius.r,
            ),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              widget.enabledBorderRadius.r,
            ),
          ),
          borderSide: (!widget.hasBorder)
              ? BorderSide.none
              : BorderSide(
                  color: widget.enabledBorderRadiusColor,
                  width: widget.borderSideWidth,
                ),
        ),
        filled: widget.isFilled,
        fillColor: widget.fillColor ?? Colors.grey.shade100,
        labelText: widget.labelText,
        errorMaxLines: 2,
        labelStyle: TextStyle(
          color: myFocusNode.hasFocus ? AppColors.primaryColor : Colors.grey,
        ),
        suffixIcon: widget.suffixIcon != null
            ? IconButton(
                onPressed: () {
                  widget.onPressSuffixIcon!();
                },
                icon: Icon(
                  widget.suffixIcon,
                  color: myFocusNode.hasFocus
                      ? AppColors.primaryColor
                      : Colors.grey,
                ),
              )
            : widget.isPassword
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                    icon: Icon(
                      hidePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: myFocusNode.hasFocus
                          ? AppColors.primaryColor
                          : Colors.grey,
                    ),
                  )
                : null,
        prefixIcon: widget.prefixIcon != null
            ? Icon(
                widget.prefixIcon,
                color:
                    myFocusNode.hasFocus ? AppColors.primaryColor : Colors.grey,
              )
            : null,
      ),
    );
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }
}
