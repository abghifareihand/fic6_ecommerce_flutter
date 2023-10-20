import 'package:fic6_ecommerce_flutter/bloc/auth/auth_bloc.dart';
import 'package:fic6_ecommerce_flutter/common/snackbar.dart';
import 'package:fic6_ecommerce_flutter/data/datasources/auth_local_datasource.dart';
import 'package:fic6_ecommerce_flutter/data/models/request/login_request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFromKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Login Page'),
      ),
      body: Form(
        key: _loginFromKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              controller: _emailController,
                  
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
                hintText: 'Enter your email',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
                hintText: 'Enter your password',
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) async {
                if (state is AuthSuccess) {
                  await AuthLocalDatasource().saveAuthData(state.model);
                  if (!mounted) return;

                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false);
                  showCustomSnackbar(context, 'berhasil Login', true);
                }

                if (state is AuthError) {
                  if (!mounted) return;
                  showCustomSnackbar(context, 'gagal Login', false);
                }
              },
              builder: (context, state) {
                return SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      if (_loginFromKey.currentState!.validate()) {
                        final model = LoginRequestModel(
                          identifier: _emailController.text,
                          password: _passwordController.text,
                        );
                        context
                            .read<AuthBloc>()
                            .add(AuthLoginEvent(model: model));
                      }
                    },
                    child: Text(
                      state is AuthLoading ? 'Loading...' : 'Login',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
