import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/components.dart';
import '../../../core/extensions/extensions.dart';
import '../../../core/routes/routes.dart';
import '../../../core/utils/mixins/mixin.dart';
import '../../../core/utils/validation.dart';
import '../../blocs/login/login_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with MessageMixin, LoadingMixin {
  final _formKey = GlobalKey<FormState>();

  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(
              flex: 4,
              child: Placeholder(),
            ),
            const CustomSpace.sp2(),
            Expanded(
              flex: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: context.colors.accent.withOpacity(.05),
                  borderRadius: BorderRadius.circular(
                    context.borderRadius.large,
                  ),
                ),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: BlocListener<LoginCubit, LoginState>(
                      listener: (context, state) {
                        state.maybeWhen(
                          error: (message) {
                            showError(context, message);
                            hideLoading();
                          },
                          loading: () => showLoading(context),
                          success: (user) {
                            hideLoading();
                            Navigator.pushReplacementNamed(
                              context,
                              PARKING_SPACE,
                            );
                          },
                          orElse: () => hideLoading(),
                        );
                      },
                      child: Column(
                        children: [
                          Text(
                            'Login',
                            style: context.textHierarchy.h3,
                          ),
                          const CustomSpace.sp4(),
                          CustomTextField(
                            controller: _emailEC,
                            labelText: 'E-mail',
                            hintText: 'Insira seu e-mail',
                            prefixIcon: Icons.email_outlined,
                            validators: [Required(), Email()],
                          ),
                          const CustomSpace.sp4(),
                          CustomTextField(
                            controller: _passwordEC,
                            labelText: 'Senha',
                            hintText: 'Insira sua senha',
                            prefixIcon: Icons.lock_outline,
                            obscureText: true,
                            validators: [Required()],
                          ),
                          Row(
                            children: [
                              const CustomSpace.sp4(),
                              Expanded(
                                child: InkWell(
                                  onTap: () {},
                                  borderRadius: BorderRadius.circular(
                                    context.borderRadius.small,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4,
                                    ),
                                    child: Text(
                                      'Esqueceu a senha?',
                                      style: context.textHierarchy.caption,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const CustomSpace.sp4(),
                          CustomButton(
                            onPressed: () => login(context),
                            child: const Text('Entrar'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void login(BuildContext context) {
    if ((_formKey.currentState?.validate() ?? false)) {
      context
          .read<LoginCubit>()
          .login(email: _emailEC.text, password: _passwordEC.text);
    }
  }
}
