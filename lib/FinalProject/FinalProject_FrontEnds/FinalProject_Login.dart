import 'package:flutter/material.dart';
import 'package:second_application/FinalProject/FinalProject_Backends/FinalProject_RegistrationAuthentication.dart';
import 'package:second_application/FinalProject/FinalProject_Backends/FinalProject_LoginAuthentication.dart';
import 'package:second_application/FinalProject/FinalProject_FrontEnds/FinalProject_Home(1).dart';

class FinalprojectLogin extends StatefulWidget {
  const FinalprojectLogin({super.key});

  @override
  State<FinalprojectLogin> createState() => _FinalprojectLoginState();
}

class _FinalprojectLoginState extends State<FinalprojectLogin> {
  final Registration_Authentication = AuthService();
  final Login_Authentication = LoginService();

  final _login_email_controller = TextEditingController();
  final _login_password_controller = TextEditingController();

  final _registration_name = TextEditingController();
  final _register_email = TextEditingController();
  final _register_password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _login_email_controller.dispose();
    _login_password_controller.dispose();
    _register_email.dispose();
    _register_password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/Bugnaw.gif'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              color: Colors.black.withOpacity(0.6),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'INCREDI-BOOK',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: _login_email_controller,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        labelText: 'Email or mobile number',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _login_password_controller,
                      style: const TextStyle(color: Colors.white),
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.red),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          _logIn();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: const Text('Sign In',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        _showRegistrationModal(context);
                      },
                      child: const Text(
                        'New to Incredi-Book? Sign up now.',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRegistrationModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black.withOpacity(0.5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Sign Up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _registration_name,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _register_email,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _register_password,
                  style: const TextStyle(color: Colors.white),
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      _signUp();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Register',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showRegistrationSuccessModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black.withOpacity(0.1),
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 2), () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        });
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: const Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Registered Successfully!',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showRegistrationUnsuccessModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black.withOpacity(0.1),
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 2), () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        });
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: const Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Registered Unsuccessful!',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showRegistrationIncompleteModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black.withOpacity(0.1),
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 2), () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        });
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: const Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Please complete the information!',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showLoginUnsuccessModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black.withOpacity(0.1),
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 2), () {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
        });
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: const Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Incorrect Information!',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _logIn() async {
    try {
      final loginUser = await LoginService.loginUserWithEmailAndPassword(
          _login_email_controller.text, _login_password_controller.text);

      if (loginUser != null) {
        // ignore: avoid_print
        print("User ID: ${loginUser.uid}");
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
      } else {
        // ignore: use_build_context_synchronously
        _showLoginUnsuccessModal(context);
        return false;
      }
    } catch (e) {
      // ignore: avoid_print
      print("Login error: $e");
      // ignore: use_build_context_synchronously
      _showLoginUnsuccessModal(context);
    }
  }

  _signUp() async {
    if (_register_email.text.isEmpty || _register_password.text.isEmpty) {
      _showRegistrationIncompleteModal(context);
      return;
    }
    final registerUser =
        await Registration_Authentication.createUserWithEmailAndPassword(
      _register_email.text,
      _register_password.text,
      _registration_name.text,
    );

    if (registerUser != null) {
      _showRegistrationSuccessModal(context);
    } else {
      _showRegistrationUnsuccessModal(context);
    }
  }
}
