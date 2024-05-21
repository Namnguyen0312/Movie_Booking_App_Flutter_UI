import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/screens/login/login_page.dart';

import '../../common/widgets/stateless/my_button.dart';
import '../../common/widgets/stateless/my_textfield.dart';
import '../../common/widgets/stateless/square_tile.dart';

// ignore: must_be_immutable
class RegisterPage extends StatefulWidget {
  static const String routeName = '/register';

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controller
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // sign up method
  void signUserUp() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  void incorrect() {
    showDialog(
        context: context,
        anchorPoint: const Offset(10, 10),
        builder: (context) {
          return const AlertDialog(
            title: Text('Login Success'),
          );
        });
  }

  // error message show dialog
  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.blue,
            title: Text(
              message,
              style: const TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //icon
                const SizedBox(
                  height: 12,
                ),
                const Icon(
                  Icons.ac_unit,
                  size: 100,
                ),

                //welcome
                const SizedBox(
                  height: 38,
                ),

                //username
                const SizedBox(
                  height: 26,
                ),
                MyTextField(
                  controller: usernameController,
                  hintText: "Nhập Email",
                  obscureText: false,
                ),

                //password
                const SizedBox(
                  height: 16,
                ),
                MyTextField(
                  controller: passwordController,
                  hintText: "Nhập Mật Khẩu",
                  obscureText: true,
                ),

                //confirm password
                const SizedBox(
                  height: 16,
                ),
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: "Nhập Lại Mật Khẩu",
                  obscureText: true,
                ),

                //Btn Sign In
                const SizedBox(
                  height: 45,
                ),
                MyButton(
                  onTap: signUserUp,
                  textBtn: 'Đăng Ký',
                ),

                //divider continue
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      Text(
                        " hoặc tiếp tục với ",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ],
                  ),
                ),

                // google + apple signin button
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google
                    SquareTile(
                      onTap: () {},
                      imgPath: 'assets/images/google.png',
                    ),

                    //Image(image: AssetImage('lib/images/apple.png'), height: 30,),
                    const SizedBox(
                      width: 24,
                    ),

                    // apple
                    SquareTile(
                      onTap: () {},
                      imgPath: "assets/images/apple.png",
                    ),
                  ],
                ),

                // not a member? register
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Đã có tài khoản ?',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(LoginPage.routeName);
                      },
                      child: const Text(
                        'Đăng nhập',
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
