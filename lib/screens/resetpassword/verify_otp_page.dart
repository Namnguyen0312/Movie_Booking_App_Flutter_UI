import 'package:flutter/material.dart';
import 'package:movie_ticker_app_flutter/provider/user_provider.dart';
import 'package:movie_ticker_app_flutter/screens/resetpassword/change_password_page.dart';
import 'package:movie_ticker_app_flutter/utils/animate_left_curve.dart';
import 'package:provider/provider.dart';

class VerifyOtpPage extends StatefulWidget {
  const VerifyOtpPage({super.key});

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  final List<TextEditingController> _otpControllers =
      List.generate(6, (index) => TextEditingController());
  Future<void>? _verifyOtpFuture;
  late List<FocusNode> _focusNodes;
  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(6, (index) => FocusNode());
  }

  @override
  void dispose() {
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              textDirection: TextDirection.ltr,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Xác thực OTP',
                  style: TextStyle(
                    color: Color(0xFF755DC1),
                    fontSize: 27,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) {
                    return SizedBox(
                      height: 60,
                      width: 40,
                      child: TextField(
                        controller: _otpControllers[index],
                        autofocus: index == 0,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        style: const TextStyle(
                          color: Color(0xFF393939),
                          fontSize: 18,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: const InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Color(0xFF9F7BFF),
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 5) {
                            FocusScope.of(context).nextFocus();
                          } else if (value.isEmpty && index > 0) {
                            FocusScope.of(context).previousFocus();
                          }
                        },
                      ),
                    );
                  }),
                ),
                const SizedBox(
                  height: 30,
                ),
                FutureBuilder<void>(
                  future: _verifyOtpFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(307, 56),
                          backgroundColor: const Color(0xFF755DC1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            _verifyOtpFuture = _verifyOtp();
                          });
                        },
                        child: const Text(
                          'Xác Nhận',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getOtp() {
    String otp = _otpControllers.map((controller) => controller.text).join();

    return otp;
  }

  Future<void> _verifyOtp() async {
    String otp = _getOtp();

    if (otp.length == 6) {
      try {
        final userProvider = Provider.of<UserProvider>(context, listen: false);
        final email = userProvider.email;
        print(int.tryParse(otp));
        await userProvider.verifyOtp(int.tryParse(otp)!, email!);
        if (!mounted) return;
        Navigator.of(context).push(
          AnimateLeftCurve.createRoute(const ChangePasswordPage()),
        );
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Mã OTP không đúng. Vui lòng thử lại'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng nhập đầy đủ thông tin đăng nhập.'),
        ),
      );
    }
  }
}
