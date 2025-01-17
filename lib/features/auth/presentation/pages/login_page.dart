import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkyou_task/core/widgets/custom_elevated_button.dart';
import 'package:linkyou_task/core/widgets/custom_text_field.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../todos/presentation/bloc/bloc/task_bloc.dart';
import '../../../todos/presentation/pages/task_page.dart';
import '../bloc/bloc/auth_bloc.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: 'Login',
            hasActions: false,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextField(
                  controller: _usernameController,
                  labelText: 'Username',
                  validator: null,
                ),
                  const SizedBox(height: 20),
                CustomTextField(
                  controller: _passwordController,
                  labelText: 'Password',
                  validator: null,
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthSuccess) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => 
                           
                            getIt<TaskBloc>(param1: state.user.id)..add(FetchTasksEvent()),
                            child: const TaskPage(),
                          ),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const CircularProgressIndicator();
                    }
                    if (state is AuthError) {
                      return Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      );
                    }
                    return CustomElevatedButon(
                      onPressed: () {
                        context.read<AuthBloc>().add(
                              LoginEvent(
                                username: _usernameController.text,
                                password: _passwordController.text,
                              ),
                            );
                      },
                      buttonText: 'Log In',
                      buttonColor: Colors.blue,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
