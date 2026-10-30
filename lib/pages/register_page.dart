import 'package:flutter/material.dart';
import '../widgets/text_field.dart';
import '../routes.dart';

/// Экран регистрации нового пользователя.
/// 
/// Содержит форму с 4 полями: ФИО, Email, Пароль, Подтверждение пароля.
/// Оформлен в едином визуальном стиле с экраном входа и ограничен по ширине (maxWidth: 430).
class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Ключ формы для валидации
  final _formKey = GlobalKey<FormState>();

  // Контроллеры полей ввода
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // FocusNode для программного перехода между полями (ФИО -> Email -> Пароль -> Подтверждение)
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  @override
  void dispose() {
    // Освобождение ресурсов контроллеров и фокусов
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  /// Обработчик регистрации нового аккаунта
  void _register() {
    // Проверка корректности всех полей
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();

      // Очищаем стек навигации и переходим на главный экран,
      // передавая введенные ФИО и Email
      Navigator.pushNamedAndRemoveUntil(
        context,
        Routes.home,
        (route) => false,
        arguments: {
          'name': _nameController.text.trim(),
          'email': _emailController.text.trim(),
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Прозрачный AppBar с кнопкой «Назад» без лишнего цветного фона
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: const Color(0xFF192252),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          // Возврат на экран авторизации через Navigator.pop
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            // Ограничение ширины формы для адаптивности на десктопе и вебе
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 430,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Центрированная иконка добавления пользователя
                    Center(
                      child: Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE9EDFF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.person_add_outlined,
                          size: 32,
                          color: Color(0xFF3157D5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Центрированный заголовок
                    const Center(
                      child: Text(
                        'Регистрация',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF192252),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Центрированный подзаголовок
                    const Center(
                      child: Text(
                        'Создайте новый аккаунт\nдля покупок',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          color: Color(0xFF747B8F),
                        ),
                      ),
                    ),
                    const SizedBox(height: 36),

                    // 1. Поле ФИО (валидация: только буквы и пробелы)
                    CustomTextFormField(
                      inputType: InputFieldType.name,
                      labelText: 'ФИО',
                      hintText: 'Иванов Иван Иванович',
                      prefixIcon: const Icon(
                        Icons.person_outline,
                      ),
                      controller: _nameController,
                      focusNode: _nameFocusNode,
                      // Переход на Email по кнопке Next
                      onNext: () {
                        _emailFocusNode.requestFocus();
                      },
                    ),
                    const SizedBox(height: 16),

                    // 2. Поле Email (валидация: регулярное выражение формата email)
                    CustomTextFormField(
                      inputType: InputFieldType.email,
                      labelText: 'Email',
                      hintText: 'example@mail.ru',
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                      ),
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      // Переход на Пароль по кнопке Next
                      onNext: () {
                        _passwordFocusNode.requestFocus();
                      },
                    ),
                    const SizedBox(height: 16),

                    // 3. Поле Пароля (валидация: буквы, цифры и знаки +, _, -)
                    CustomTextFormField(
                      inputType: InputFieldType.password,
                      labelText: 'Пароль',
                      hintText: 'Минимум 6 символов',
                      prefixIcon: const Icon(
                        Icons.security,
                      ),
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      // Переход на Подтверждение пароля по кнопке Next
                      onNext: () {
                        _confirmPasswordFocusNode.requestFocus();
                      },
                    ),
                    const SizedBox(height: 16),

                    // 4. Поле Подтверждения пароля (валидация: совпадение с полем _passwordController)
                    CustomTextFormField(
                      inputType: InputFieldType.confirmPassword,
                      labelText: 'Повторите пароль',
                      hintText: 'Повторите пароль',
                      prefixIcon: const Icon(
                        Icons.security,
                      ),
                      controller: _confirmPasswordController,
                      focusNode: _confirmPasswordFocusNode,
                      passwordController: _passwordController,
                    ),
                    const SizedBox(height: 28),

                    // Кнопка отправки формы регистрации
                    ElevatedButton(
                      onPressed: _register,
                      child: const Text('Зарегистрироваться'),
                    ),
                    const SizedBox(height: 20),

                    // Кнопка возврата к авторизации
                    Center(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          const Text(
                            'Уже есть аккаунт? ',
                            style: TextStyle(
                              color: Color(0xFF747B8F),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Возврат на экран входа по схеме навигации методических указаний
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Войдите',
                              style: TextStyle(
                                color: Color(0xFF3157D5),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
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
