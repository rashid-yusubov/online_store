import 'package:flutter/material.dart';

enum InputFieldType {
  name,
  email,
  password,
  confirmPassword,
}

class CustomTextFormField extends StatefulWidget {
  final InputFieldType inputType;
  final String labelText;
  final String hintText;
  final Widget prefixIcon;
  final TextEditingController controller;
  final TextEditingController? passwordController;
  final FocusNode? focusNode;
  final VoidCallback? onNext;

  const CustomTextFormField({
    super.key,
    required this.inputType,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    this.passwordController,
    this.focusNode,
    this.onNext,
  });

  @override
  State<CustomTextFormField> createState() =>
      _CustomTextFormFieldState();
}

class _CustomTextFormFieldState
    extends State<CustomTextFormField> {
  bool _hidePassword = true;

  String? _validator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Поле не может быть пустым';
    }

    switch (widget.inputType) {
      case InputFieldType.name:
        final reg = RegExp(
          r'^[A-Za-zА-Яа-яЁё\s]+$',
        );
        if (!reg.hasMatch(value.trim())) {
          return 'Используйте только буквы и пробелы';
        }
        return null;

      case InputFieldType.email:
        final reg = RegExp(
          r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
        );
        if (!reg.hasMatch(value.trim())) {
          return 'Введите корректный email';
        }
        return null;

      case InputFieldType.password:
        final reg = RegExp(
          r'^(?=.*[A-Za-zА-Яа-яЁё])(?=.*\d)(?=.*[+_-]).{6,}$',
        );
        if (!reg.hasMatch(value)) {
          return 'Минимум 6 символов: буквы, цифры и +, _ или -';
        }
        return null;

      case InputFieldType.confirmPassword:
        if (widget.passwordController != null &&
            value != widget.passwordController!.text) {
          return 'Пароли не совпадают';
        }
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isPassword =
        widget.inputType == InputFieldType.password ||
            widget.inputType == InputFieldType.confirmPassword;

    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText: isPassword && _hidePassword,
      keyboardType:
      widget.inputType == InputFieldType.email
          ? TextInputType.emailAddress
          : TextInputType.text,
      textInputAction:
      widget.onNext != null
          ? TextInputAction.next
          : TextInputAction.done,
      onFieldSubmitted: (_) {
        widget.onNext?.call();
      },
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: isPassword
            ? IconButton(
          tooltip: _hidePassword
              ? 'Показать пароль'
              : 'Скрыть пароль',
          icon: Icon(
            _hidePassword
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
          onPressed: () {
            setState(() {
              _hidePassword = !_hidePassword;
            });
          },
        )
            : null,
      ),
      validator: _validator,
    );
  }
}
