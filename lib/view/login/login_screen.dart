import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meteo_sncf/app_colors.dart';
import 'package:meteo_sncf/view/city_weather/city_weather_screen.dart';
import 'package:meteo_sncf/view/login/login_cubit.dart';
import 'package:meteo_sncf/view/login/login_state.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final _loginCubit = LoginCubit();
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: BlocConsumer<LoginCubit, LoginState>(
            bloc: _loginCubit,
            builder: (context, state) {
              switch (state) {
                case LoginLoadStarted():
                  return const Center(child: CircularProgressIndicator());
                default:
                  return _buildLoginForm();
              }
            },
            listener: (context, state) {
              if (state is LoginFailed) {
                _showErrorSnackbar(context);
              }
              if (state is LoginFinished) {
                _pushWeatherScreen(context, userName: state.userName);
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset('assets/logo.png', height: 60),
          Text(
            'météo',
            style: TextStyle(
              color: AppColors.actionLightBlue,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 30),
          TextFormField(
            autocorrect: false,
            controller: _emailController,
            style: const TextStyle(color: Colors.white),
            cursorColor: AppColors.actionLightBlue,
            decoration: const InputDecoration(hintText: 'Email'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez saisir votre adresse mail';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            controller: _passwordController,
            style: const TextStyle(color: Colors.white),
            cursorColor: AppColors.actionLightBlue,
            decoration: const InputDecoration(hintText: 'Mot de passe'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez saisir votre mot de passe';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),
          OutlinedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                _loginCubit.login(
                  email: _emailController.text,
                  password: _passwordController.text,
                );
              }
            },
            child: const Text('Se connecter'),
          ),
        ],
      ),
    );
  }

  void _showErrorSnackbar(BuildContext context) {
    const snackBar = SnackBar(
      content: Text('Une erreur est survenue lors de l\'authentification'),
      showCloseIcon: true,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _pushWeatherScreen(BuildContext context, {required String userName}) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => CityWeatherScreen(userName: userName),
    ));
  }
}
