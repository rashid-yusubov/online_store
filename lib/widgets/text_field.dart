import 'package:flutter/material.dart';

/// Перечисление (enum) типов полей ввода.
/// Позволяет централизованно задать тип валидации и поведение для разных полей
/// без дублирования кода виджетов (принцип DRY - Don't Repeat Yourself).
enum InputFieldType {
  /// Поле ввода имени пользователя
  name,

  /// Поле ввода адреса электронной почты
  email,

  /// Поле ввода пароля
  password,

  /// Поле подтверждения пароля
  confirmPassword,
}

/// Универсальный переиспользуемый компонент поля ввода с валидацией (CustomTextFormField).
/// 
/// Является `StatefulWidget`, так как для полей типа пароль необходимо хранить
/// и изменять внутреннее состояние видимости текста (`_hidePassword`) при нажатии на иконку глаза.
class CustomTextFormField extends StatefulWidget {
  /// Тип поля (определяет логику валидации и тип клавиатуры)
  final InputFieldType inputType;

  /// Текст метки (заголовок над полем или внутри)
  final String labelText;

  /// Текст подсказки (плейсхолдер)
  final String hintText;

  /// Иконка в начале поля (Prefix Icon)
  final Widget prefixIcon;

  /// Контроллер для чтения и изменения введенного текста
  final TextEditingController controller;

  /// Контроллер основного пароля (нужен только для поля confirmPassword, чтобы сравнить пароли)
  final TextEditingController? passwordController;

  /// Узел управления фокусом ввода (FocusNode)
  final FocusNode? focusNode;

  /// Callback-функция при нажатии "Далее" на клавиатуре (переключение на следующее поле)
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
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  /// Флаг скрытия текста пароля (звездочки / точки)
  bool _hidePassword = true;

  /// Функция валидации значения поля (Validator).
  /// Возвращает:
  /// - `null`, если значение валидно;
  /// - `String` с текстом ошибки, если значение некорректно.
  String? _validator(String? value) {
    // Проверка на пустое значение или строку только из пробелов
    if (value == null || value.trim().isEmpty) {
      return 'Поле не может быть пустым';
    }

    // Проверка по типу поля с использованием регулярных выражений (RegExp)
    switch (widget.inputType) {
      case InputFieldType.name:
        // Регулярное выражение: только русские и английские буквы и пробелы
        final reg = RegExp(
          r'^[A-Za-zА-Яа-яЁё\s]+$',
        );
        if (!reg.hasMatch(value.trim())) {
          return 'Используйте только буквы и пробелы';
        }
        return null;

      case InputFieldType.email:
        // Регулярное выражение для проверки формата email (name@domain.com)
        final reg = RegExp(
          r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
        );
        if (!reg.hasMatch(value.trim())) {
          return 'Введите корректный email';
        }
        return null;

      case InputFieldType.password:
        // Требования к паролю:
        // - Минимум 6 символов
        // - Хотя бы одна буква (?=.*[A-Za-zА-Яа-яЁё])
        // - Хотя бы одна цифра (?=.*\d)
        // - Хотя бы один спецсимвол: +, _, или - (?=.*[+_-])
        final reg = RegExp(
          r'^(?=.*[A-Za-zА-Яа-яЁё])(?=.*\d)(?=.*[+_-]).{6,}$',
        );
        if (!reg.hasMatch(value)) {
          return 'Минимум 6 символов: буквы, цифры и +, _ или -';
        }
        return null;

      case InputFieldType.confirmPassword:
        // Проверка совпадения подтверждения пароля с основным паролем
        if (widget.passwordController != null &&
            value != widget.passwordController!.text) {
          return 'Пароли не совпадают';
        }
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Определяем, является ли текущее поле полем ввода пароля
    final isPassword =
        widget.inputType == InputFieldType.password ||
            widget.inputType == InputFieldType.confirmPassword;

    return TextFormField(
      // Привязываем контроллер управления текстом
      controller: widget.controller,

      // Привязываем узел фокуса для программного перехода между полями
      focusNode: widget.focusNode,

      // Скрывать ли символы ввода (актуально для паролей при _hidePassword == true)
      obscureText: isPassword && _hidePassword,

      // Настройка раскладки клавиатуры (для email открывается клавиатура с символом '@')
      keyboardType: widget.inputType == InputFieldType.email
          ? TextInputType.emailAddress
          : TextInputType.text,

      // Кнопка действия на клавиатуре: "Далее" (next) или "Готово" (done)
      textInputAction: widget.onNext != null
          ? TextInputAction.next
          : TextInputAction.done,

      // Событие при отправке поля с клавиатуры (переводит фокус на следующее поле)
      onFieldSubmitted: (_) {
        widget.onNext?.call();
      },

      // Оформление поля ввода
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        prefixIcon: widget.prefixIcon,

        // Кнопка-иконка в конце поля для переключения видимости пароля (глаз)
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
                  // Вызываем setState, чтобы перерисовать виджет с обновленным флагом _hidePassword
                  setState(() {
                    _hidePassword = !_hidePassword;
                  });
                },
              )
            : null,
      ),

      // Функция валидации
      validator: _validator,
    );
  }
}
