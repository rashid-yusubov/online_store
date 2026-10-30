import 'package:flutter/material.dart';
import '../widgets/text_field.dart';

class ProfilePage extends StatefulWidget {
  final String name;
  final String email;

  const ProfilePage({
    super.key,
    required this.name,
    required this.email,
  });

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // FocusNode для каждого поля.
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _confirmPasswordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.name,
    );
    _emailController = TextEditingController(
      text: widget.email,
    );
  }

  @override
  void dispose() {
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

  void _save() {
    if (_formKey.currentState?.validate() ?? false) {
      FocusScope.of(context).unfocus();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Данные профиля сохранены',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Профиль'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 10),
                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    size: 50,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 25),
                // ФИО
                CustomTextFormField(
                  inputType: InputFieldType.name,
                  labelText: 'ФИО',
                  hintText: 'Введите ФИО',
                  prefixIcon: const Icon(
                    Icons.person_outline,
                  ),
                  controller: _nameController,
                  focusNode: _nameFocusNode,
                  // ФИО -> Email
                  onNext: () {
                    _emailFocusNode.requestFocus();
                  },
                ),
                const SizedBox(height: 16),
                // Email
                CustomTextFormField(
                  inputType: InputFieldType.email,
                  labelText: 'Email',
                  hintText: 'example@mail.ru',
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                  ),
                  controller: _emailController,
                  focusNode: _emailFocusNode,
                  // Email -> Пароль
                  onNext: () {
                    _passwordFocusNode.requestFocus();
                  },
                ),
                const SizedBox(height: 16),
                // Пароль
                CustomTextFormField(
                  inputType: InputFieldType.password,
                  labelText: 'Пароль',
                  hintText: 'Введите новый пароль',
                  prefixIcon: const Icon(
                    Icons.security,
                  ),
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  // Пароль -> Повторить пароль
                  onNext: () {
                    _confirmPasswordFocusNode.requestFocus();
                  },
                ),
                const SizedBox(height: 16),
                // Повтор пароля
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
                const SizedBox(height: 30),
                SizedBox(
                  width: 180,
                  child: ElevatedButton(
                    onPressed: _save,
                    child: const Text(
                      'Сохранить',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
