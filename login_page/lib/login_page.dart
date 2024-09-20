import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (_email == "admin@gmail.com" && _password == "admin") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DashboardPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid credentials')),
        );
      }
    }
  }

  String? _validateEmail(String? value) {
    if (value!.isEmpty) return 'Email cannot be empty';
    const pattern = r'\w+@\w+\.\w+';
    return RegExp(pattern).hasMatch(value) ? null : 'Enter a valid email';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            Center(
              child: Icon(
                Icons.lock,
                size: 150.0,
              ),
            ),
            const Center(
              child: Text(
                "Halaman Login",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 40),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (e) => _email = e ?? '',
                    validator: _validateEmail,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      prefixIcon: Icon(Icons.person),
                    ),
                  ),
                  const SizedBox(height: 24),
                  TextFormField(
                    obscureText: true,
                    onSaved: (e) => _password = e ?? '',
                    validator: (value) =>
                        value!.isEmpty ? 'Enter password' : null,
                    decoration: const InputDecoration(
                      labelText: "Password",
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Center(
                      child: ElevatedButton(
                    onPressed: _submit,
                    child: const Text("Login"),
                  )),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Gabisa login? "),
                      TextButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Email: admin@gmail.com\nPassword: admin'),
                            ),
                          );
                        },
                        child: const Text("Lihat di sini"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Dashboard")),
      body: const Center(child: Text("Welcome to the Dashboard")),
    );
  }
}
