import 'package:clean_arch/core/theme/bloc/theme_bloc.dart';
import 'package:clean_arch/core/theme/bloc/theme_state.dart';
import 'package:clean_arch/feature/auth/presentation/bloc/auth_event.dart';
import 'package:clean_arch/feature/auth/presentation/bloc/auth_state.dart';
import 'package:clean_arch/feature/auth/presentation/bloc/bloc_auth.dart';
import 'package:clean_arch/feature/auth/presentation/widget/auth_field.dart';
import 'package:clean_arch/feature/auth/presentation/widget/auth_gradient_button.dart';
import 'package:clean_arch/feature/courses/presentation/pages/CoursePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return Theme(
          data: themeState.themeData,
          child: Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthAuthenticated) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => CoursePage()),
                    );
                  } else if (state is AuthError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return Center(child: CircularProgressIndicator());
                  }
                  return Form(
                    key: formKey,
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          SizedBox(height: 100),
                          AuthField(
                            controller: _emailController,
                            hintText: "Email:",
                          ),
                          AuthField(
                            controller: _passwordController,
                            isObscureText: true,
                            hintText: "Password:",
                          ),
                          SizedBox(height: 16),
                          AuthGradientButton(
                            onPressed: () {
                              context.read<AuthBloc>().add(
                                LoginEvent(
                                  _emailController.text,
                                  _passwordController.text,
                                ),
                              );
                            },
                            buttonText: 'Login',
                          ),
                          TextButton(
                            onPressed: (){},
                            // onPressed: () => Navigator.push(
                            //   context,
                            //   MaterialPageRoute(builder: (_) => SignupPage()),
                            // ),
                            child: Text('Don\'t have an account? Sign up'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}