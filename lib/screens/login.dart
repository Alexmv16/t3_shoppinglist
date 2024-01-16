import 'package:flutter/material.dart';
import 'package:t3_shoppinglist/screens/products.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  //TODO Act3: Variable para de usuario y contraseña para acceder a la app
  static const String correctUser = "user@ejemplo.com";
  static const String correctPassword = "Password123!";

  Widget _eMailInput() {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: _emailController,
        decoration: InputDecoration(
          labelText: 'User',
          hintText: 'Write your email address',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty || !value.contains('@')) {
            return 'Invalid email address';
            //TODO Act3: si el valor no corresponde a lo que pedimos en la actividad, dara un error de invalid email hasta que esten los datos correctamente
          }
          return null;
        },
      ),
    );
  }
//TODO Act3: metodo para comprobar si la contraseña cumple con los requisitos pedidos
  Widget _passwordInput() {
    return Container(
      margin: EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: _passwordController,
        obscureText: true,
        obscuringCharacter: '*',
        decoration: InputDecoration(
          hintText: 'Write your password',
          labelText: 'Password',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Password cannot be empty';
          }
          if (value.length < 8 ||
              !value.contains(RegExp(r'[A-Z]')) ||
              !value.contains(RegExp(r'[0-9]')) ||
              !value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
            return 'Invalid password format';
          }
          return null;
        },
      ),
    );
  }

  Widget _loginButton() {
    return Container(
      padding: EdgeInsets.all(8.0),
      alignment: Alignment.centerRight,
      child: ElevatedButton(
        child: const Text('Login'),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            final email = _emailController.text;
            final password = _passwordController.text;

            if (email == correctUser && password == correctPassword) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Welcome! Logging in...')),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => ProductsScreen()),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Invalid credentials. Please try again.')),
              );
            }
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _eMailInput(),
              SizedBox(height: 16.0),
              _passwordInput(),
              SizedBox(height: 16.0),
              _loginButton(),
            ],
          ),
        ),
      ),
    );
  }
}
