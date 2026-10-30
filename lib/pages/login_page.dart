import 'package:flutter/material.dart';
import '../widgets/text_field.dart';
import '../routes.dart';

/// Экран авторизации пользователя.
/// 
/// Содержит форму ввода с проверкой валидности полей (Email и Пароль),
/// управление переходами фокуса клавиатуры и навигацию.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // GlobalKey<FormState> служит уникальным ключом для формы Form.
  // Позволяет получить доступ к состоянию FormState и вызвать метод validate().
  final _formKey = GlobalKey<FormState>();

  // Контроллеры для считывания текста из полей ввода
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // FocusNode управляют тем, какое текстовое поле сейчас активно (в фокусе).
  // Используются для программного перемещения курсора по нажатию кнопки «Next».
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // Обязательное освобождение ресурсов при уничтожении виджета (Memory Management):
    // предотвращает утечки памяти (memory leaks).
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  /// Обработчик входа в приложение
  void _login() {
    // FormState.validate() запускает валидаторы (validator) у всех дочерних полей формы.
    // Возвращает true, если все поля прошли проверку регулярными выражениями.
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    // Снятие фокуса с полей и закрытие экранной клавиатуры
    FocusScope.of(context).unfocus();

    // Переход на главный экран с заменой экрана авторизации (pushReplacementNamed),
    // чтобы после входа пользователь не мог кнопкой «Назад» вернуться на экран логина.
    // Через arguments передаем имя и email пользователя в следующий экран.
    Navigator.pushReplacementNamed(
      context,
      Routes.home,
      arguments: {
        'name': 'Юсубов Рашид Хазеинович',
        'email': _emailController.text.trim(),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 32,
            ),
            // ConstrainedBox ограничивает максимальную ширину формы на широких экранах (Desktop/Web/Tablet),
            // чтобы форма не растягивалась неестественно на всю ширину монитора.
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 430,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Центрированная брендовая иконка
                    Center(
                      child: Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE9EDFF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.shopping_bag_outlined,
                          size: 32,
                          color: Color(0xFF3157D5),
                        ),
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Центрированный главный заголовок
                    const Center(
                      child: Text(
                        'Добро пожаловать!',
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
                        'Войдите в свой аккаунт\nили создайте новый',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          color: Color(0xFF747B8F),
                        ),
                      ),
                    ),
                    const SizedBox(height: 36),

                    // Поле ввода Email с валидацией по регулярному выражению
                    CustomTextFormField(
                      inputType: InputFieldType.email,
                      labelText: 'Email',
                      hintText: 'example@mail.ru',
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                      ),
                      controller: _emailController,
                      focusNode: _emailFocusNode,
                      // По нажатию кнопки «Next» на клавиатуре передаем фокус на поле пароля
                      onNext: () {
                        _passwordFocusNode.requestFocus();
                      },
                    ),
                    const SizedBox(height: 16),

                    // Поле ввода Пароля с возможностью скрытия/отображения символов
                    CustomTextFormField(
                      inputType: InputFieldType.password,
                      labelText: 'Пароль',
                      hintText: 'Введите пароль',
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                      ),
                      controller: _passwordController,
                      focusNode: _passwordFocusNode,
                    ),
                    const SizedBox(height: 8),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('Забыли пароль?'),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Кнопка авторизации
                    ElevatedButton(
                      onPressed: _login,
                      child: const Text('Войти'),
                    ),
                    const SizedBox(height: 28),

                    // Разделитель «или»
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            color: Color(0xFFE1E4EC),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                          ),
                          child: Text(
                            'или',
                            style: TextStyle(
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Divider(
                            color: Color(0xFFE1E4EC),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Ссылка перехода к экрану регистрации
                    Center(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          const Text(
                            'Нет аккаунта? ',
                            style: TextStyle(
                              color: Color(0xFF747B8F),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Навигация на экран регистрации через именованный маршрут Navigator.pushNamed
                              Navigator.pushNamed(context, Routes.register);
                            },
                            child: const Text(
                              'Зарегистрируйтесь',
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
