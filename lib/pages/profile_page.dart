import 'package:flutter/material.dart';
import '../widgets/text_field.dart';

/// Экран профиля пользователя (Profile Page).
/// 
/// Может отображаться:
/// 1. Как вкладка в IndexedStack внутри HomePage (при этом showAppBar: false).
/// 2. Как самостоятельный экран по маршруту Routes.profile (при этом showAppBar: true, showBackButton: true).
class ProfilePage extends StatefulWidget {
  /// Имя пользователя, полученное после авторизации или регистрации
  final String name;

  /// Email пользователя
  final String email;

  /// Флаг показа собственного AppBar (скрывается при встраивании в HomePage)
  final bool showAppBar;

  /// Флаг отображения стрелки «Назад» в AppBar
  final bool showBackButton;

  const ProfilePage({
    super.key,
    required this.name,
    required this.email,
    this.showAppBar = true,
    this.showBackButton = false,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // Ключ для валидации формы профиля
  final _formKey = GlobalKey<FormState>();

  // Контроллеры полей формы
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Фокусы полей формы
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Инициализация контроллеров начальными данными, переданными в виджет
    _nameController = TextEditingController(text: widget.name);
    _emailController = TextEditingController(text: widget.email);
  }

  @override
  void didUpdateWidget(covariant ProfilePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Обновление значений в полях ввода, если родительский виджет передал новые данные
    if (widget.name != oldWidget.name && _nameController.text.isEmpty) {
      _nameController.text = widget.name;
    }
    if (widget.email != oldWidget.email && _emailController.text.isEmpty) {
      _emailController.text = widget.email;
    }
  }

  @override
  void dispose() {
    // Освобождение ресурсов памяти
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

  /// Обработчик сохранения данных профиля
  void _save() {
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();

      // Показ всплывающего уведомления SnackBar об успешном сохранении
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Данные профиля сохранены'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar отображается только при самостоятельном вызове экрана,
      // чтобы избежать эффекта "двух шапок" при отображении во вкладке NavigationBar
      appBar: widget.showAppBar
          ? AppBar(
              leading: widget.showBackButton
                  ? IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    )
                  : null,
              automaticallyImplyLeading: widget.showBackButton,
              title: const Text('Профиль'),
              centerTitle: true,
            )
          : null,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Center(
            // Ограничение ширины формы (430 px) для единого стиля со страницами входа и регистрации
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 10),

                    // Аватар профиля
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE9EDFF),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          color: const Color(0xFF3157D5),
                          width: 1.5,
                        ),
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 60,
                        color: Color(0xFF3157D5),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Поле ФИО
                    CustomTextFormField(
                      inputType: InputFieldType.name,
                      labelText: 'ФИО',
                      hintText: 'Введите ФИО',
                      prefixIcon: const Icon(Icons.person_outline),
                      controller: _nameController,
                      focusNode: _nameFocusNode,
                      onNext: () {
                        _emailFocusNode.requestFocus();
                      },
                    ),
                    const SizedBox(height: 16),

                    // Поле Email
                    CustomTextFormField(
                      inputType: InputFieldType.email,
                      labelText: 'Email',
                      hintText: 'example@mail.ru',
                      prefixIcon: const Icon(Icons.email_outlined),
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      onNext: () {
                        _passwordFocusNode.requestFocus();
                      },
                    ),
                    const SizedBox(height: 16),

                    // Поле нового пароля
                    CustomTextFormField(
                      inputType: InputFieldType.password,
                      labelText: 'Пароль',
                      hintText: 'Введите новый пароль',
                      prefixIcon: const Icon(Icons.security),
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                      onNext: () {
                        _confirmPasswordFocusNode.requestFocus();
                      },
                    ),
                    const SizedBox(height: 16),

                    // Поле подтверждения пароля
                    CustomTextFormField(
                      inputType: InputFieldType.confirmPassword,
                      labelText: 'Повторите пароль',
                      hintText: 'Повторите пароль',
                      prefixIcon: const Icon(Icons.security),
                      controller: _confirmPasswordController,
                      focusNode: _confirmPasswordFocusNode,
                      passwordController: _passwordController,
                    ),
                    const SizedBox(height: 30),

                    // Кнопка сохранения изменений
                    SizedBox(
                      width: 200,
                      child: ElevatedButton(
                        onPressed: _save,
                        child: const Text('Сохранить'),
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
