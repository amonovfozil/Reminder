import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reminder/utils/theme/app_colors.dart';
import 'package:reminder/utils/theme/text_styles.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.validator,
    this.labelText,
    this.keyboardType,
    this.maxLines,
    this.minLines,
    this.suffix,
    this.initialval,
    this.perifix,
    this.onTap,
    this.onChanged,
    this.editComplete,
    this.textInputFormatter,
    this.obscureText,
    this.isEnamled,
    this.hintText,
    this.textCapitaliz,
    this.withBorder = true,
    this.contentPadding = const EdgeInsets.fromLTRB(16, 7, 16, 7),
    this.labelStyle,
    this.cardColor = Colors.transparent,
    this.margin = const EdgeInsets.all(0),
  });

  final TextEditingController controller;
  final String? labelText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final int? minLines;
  final Widget? suffix;
  final Widget? perifix;
  final Function()? onTap;
  final Function(String)? onChanged;
  final Function()? editComplete;
  final String? Function(String?) validator;
  final List<TextInputFormatter>? textInputFormatter;
  final EdgeInsets? contentPadding;
  final bool? obscureText;
  final bool? isEnamled;
  final bool withBorder;
  final String? hintText;
  final String? initialval;
  final TextStyle? labelStyle;
  final Color cardColor;
  final TextCapitalization? textCapitaliz;
  final EdgeInsets margin;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isChanged = true;
  bool isClear = false;
  //new
  bool checkOfErrorOnFocusChange = false;
  bool isError = false;
  String errorString = "";
  FocusNode myFocusNode = FocusNode();

  TextStyle getLabelTextStyle(Color color) {
    return TextStyle(fontSize: 12.0, color: color);
  } //label text style

  TextStyle getTextFieldStyle() {
    return const TextStyle(fontSize: 12.0, color: Colors.black);
  } //textfield style

  TextStyle getErrorTextFieldStyle() {
    return const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      fontFamily: 'sfpro',
      color: Colors.redAccent,
    );
  } // Error text style

  Color getBorderColor(bool isfous) {
    return isfous
        ? context.secondaryColor.withOpacity(0.5)
        : context.borderColor;
  } //Border co

  @override
  void initState() {
    if (widget.initialval != null) {
      widget.controller.text = widget.initialval!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FocusScope(
          child: Focus(
            onFocusChange: (focus) {
              final validationResult = widget.validator(widget.controller.text);
              setState(() {
                getBorderColor(focus);
                final hasError = checkOfErrorOnFocusChange &&
                    (validationResult?.isNotEmpty ?? false);
                isError = hasError;
                errorString = validationResult ?? '';
              });
            },
            child: Container(
              // height: 60,
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 2),
              margin: widget.margin,
              decoration: BoxDecoration(
                color: widget.cardColor,
                borderRadius: const BorderRadius.all(Radius.circular(12)),
                border: widget.withBorder
                    ? Border.all(
                        width: 1,
                        style: BorderStyle.solid,
                        color: isError
                            ? Colors.redAccent
                            : getBorderColor(myFocusNode.hasFocus),
                      )
                    : null,
              ),
              child: TextFormField(
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                textCapitalization:
                    widget.textCapitaliz ?? TextCapitalization.words,
                enabled: widget.isEnamled,
                focusNode: myFocusNode,
                controller: widget.controller,
                style: context.titleTextStyle,
                autofocus: false,
                obscureText: widget.obscureText ?? false,
                keyboardType: widget.keyboardType,
                textInputAction: TextInputAction.next,
                inputFormatters: widget.textInputFormatter ?? [],
                maxLines: widget.maxLines,
                minLines: widget.minLines,
                onChanged: widget.onChanged,
                onSaved: (newValue) {
                  if (widget.controller.text.isNotEmpty) {
                    widget.controller.text = newValue!;
                  }
                },
                validator: (value) {
                  final validationResult =
                      widget.validator(widget.controller.text);
                  if (validationResult?.isNotEmpty ?? false) {
                    setState(() {
                      isError = true;
                      errorString = validationResult ?? '';
                    });
                    return "";
                  } else {
                    setState(() {
                      isError = false;
                      errorString = validationResult ?? '';
                    });
                  }
                  return null;
                },
                onTap: () {
                  widget.onTap;
                  if (widget.keyboardType == TextInputType.datetime) {
                    setState(() {
                      isChanged = false;
                    });
                  }
                },
                decoration: InputDecoration(
                  labelText: widget.labelText,
                  labelStyle: widget.labelStyle ?? context.subTitleTextStyle,
                  contentPadding: widget.contentPadding,
                  focusColor: context.primaryColor,
                  suffixIcon: widget.suffix,
                  prefixIcon: widget.perifix,
                  hintText: widget.hintText,
                  hintStyle: context.subStyle,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  border: InputBorder.none,
                  errorStyle: const TextStyle(fontSize: 0),
                  focusedErrorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 3),
        Visibility(
          visible: isError ? true : false,
          child: Container(
            padding: const EdgeInsets.only(left: 15.0, top: 2.0),
            child: Padding(
              padding: EdgeInsets.only(left: widget.perifix != null ? 35 : 0),
              child: Text(errorString, style: getErrorTextFieldStyle()),
            ),
          ),
        ),
      ],
    );
  }
}
