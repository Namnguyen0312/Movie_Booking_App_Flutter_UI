import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:movie_ticker_app_flutter/models/request/address_request.dart';
import 'package:movie_ticker_app_flutter/models/request/create_user_request.dart';
import 'package:movie_ticker_app_flutter/provider/user_provider.dart';
import 'package:movie_ticker_app_flutter/screens/homepage/home_page.dart';
import 'package:movie_ticker_app_flutter/screens/login/login_screen.dart';
import 'package:movie_ticker_app_flutter/utils/animate_left_curve.dart';
import 'package:movie_ticker_app_flutter/utils/animate_right_curve.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const String routeName = '/register';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _repassController = TextEditingController();

  String? _selectedProvinceId;
  String? _selectedDistrictId;
  String? _selectedWardId;

  String? _selectedProvince;
  String? _selectedDistrict;
  String? _selectedWard;

  bool isProvinceSelected = false;
  bool isDistrictSelected = false;
  bool isWardSelected = false;

  bool _loadingProvinces = false;
  bool _loadingDistricts = false;
  bool _loadingWards = false;
  Future<void>? _registrationFuture;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadProvinces();
    });
  }

  void _loadProvinces() async {
    setState(() {
      _loadingProvinces = true;
    });
    await Provider.of<UserProvider>(context, listen: false).getAllProvince();
    setState(() {
      _loadingProvinces = false;
    });
  }

  void _loadDistricts(String? provinceId) async {
    setState(() {
      _loadingDistricts = true;
    });
    await Provider.of<UserProvider>(context, listen: false)
        .getAllDistrictByProvinceId(provinceId!);
    setState(() {
      _loadingDistricts = false;
    });
  }

  void _loadWards(String? districtId) async {
    setState(() {
      _loadingWards = true;
    });
    await Provider.of<UserProvider>(context, listen: false)
        .getAllWardByDistrictId(districtId!);
    setState(() {
      _loadingWards = false;
    });
  }

  void selectProvince(String? provinceId, String? provinceName) {
    setState(() {
      _selectedProvinceId = provinceId;
      _selectedProvince = provinceName;
      _selectedDistrictId = null;
      _selectedDistrict = null;
      _selectedWardId = null;
      _selectedWard = null;
      isProvinceSelected = true;
      isDistrictSelected = false;
      isWardSelected = false;
    });
    _loadDistricts(provinceId);
  }

  void selectDistrict(String? districtId, String? districtName) {
    if (isProvinceSelected) {
      setState(() {
        _selectedDistrictId = districtId;
        _selectedDistrict = districtName;
        _selectedWardId = null;
        _selectedWard = null;
        isDistrictSelected = true;
        isWardSelected = false;
      });
      _loadWards(districtId);
    }
  }

  void selectWard(String? wardId, String? wardName) {
    if (isDistrictSelected) {
      setState(() {
        _selectedWardId = wardId;
        _selectedWard = wardName;
        isWardSelected = true;
      });
    }
  }

  bool _allFieldsFilled() {
    return _userNameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty &&
        _streetController.text.isNotEmpty &&
        _passController.text.isNotEmpty &&
        _repassController.text.isNotEmpty &&
        _selectedProvince != null &&
        _selectedDistrict != null &&
        _selectedWard != null;
  }

  Future<void> _registerUser() async {
    if (_allFieldsFilled()) {
      try {
        if (_passController.text != _repassController.text) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Mật khẩu không khớp!'),
            ),
          );
        } else {
          final AddressRequest address = AddressRequest(
            city: _selectedProvince!,
            ward: _selectedDistrict!,
            district: _selectedWard!,
            street: _streetController.text,
          );

          final UserCreationRequest user = UserCreationRequest(
            name: _userNameController.text,
            email: _emailController.text,
            phone: _phoneController.text,
            password: _passController.text,
            address: address,
          );
          await Provider.of<UserProvider>(context, listen: false)
              .createUser(user);
          if (!mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Đăng ký thành công'),
            ),
          );
          Navigator.of(context).push(
            AnimateRightCurve.createRoute(const LoginScreen()),
          );
        }
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Đăng ký thất bại. Vui lòng thử lại sau.'),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng nhập đầy đủ thông tin đăng ký.'),
        ),
      );
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool obscureText = false,
  }) {
    return TextField(
      style: const TextStyle(
        color: Color(0xFF393939),
        fontSize: 13,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w400,
      ),
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: Color(0xFF755DC1),
          fontSize: 15,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 1, color: Color(0xFF837E93)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 1, color: Color(0xFF9F7BFF)),
        ),
      ),
    );
  }

  Widget _buildDropdownButtonFormField({
    required String? value,
    required List<DropdownMenuItem<String>> items,
    required String label,
    required ValueChanged<String?> onChanged,
    bool isLoading = false,
  }) {
    return Stack(
      children: [
        AbsorbPointer(
          absorbing: isLoading,
          child: DropdownButtonFormField<String>(
            value: value,
            items: items,
            onChanged: onChanged,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: const TextStyle(
                color: Color(0xFF755DC1),
                fontSize: 15,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w600,
              ),
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(width: 1, color: Color(0xFF837E93)),
              ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(width: 1, color: Color(0xFF9F7BFF)),
              ),
            ),
          ),
        ),
        if (isLoading)
          Positioned.fill(
            child: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 10),
              child: const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final provinces = Provider.of<UserProvider>(context).province;
    final districts = Provider.of<UserProvider>(context).district;
    final wards = Provider.of<UserProvider>(context).ward;
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                AnimateLeftCurve.createRoute(const HomeScreen()),
                (route) => false,
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: EdgeInsets.only(top: size.height / 12),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Đăng ký',
                  style: TextStyle(
                    color: Color(0xFF755DC1),
                    fontSize: 27,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  controller: _userNameController,
                  label: 'Họ và tên',
                ),
                const SizedBox(height: 17),
                _buildTextField(
                  controller: _emailController,
                  label: 'Email',
                ),
                const SizedBox(height: 17),
                _buildTextField(
                  controller: _phoneController,
                  label: 'Điện thoại',
                ),
                const SizedBox(height: 17),
                _buildDropdownButtonFormField(
                  value: _selectedProvinceId,
                  items: provinces?.map((province) {
                        return DropdownMenuItem<String>(
                          value: province.provinceId,
                          child: Text(
                            province.provinceName ?? '',
                            style: GoogleFonts.beVietnamPro(
                              textStyle: const TextStyle(color: Colors.black),
                            ),
                          ),
                        );
                      }).toList() ??
                      [],
                  label: 'Thành phố',
                  isLoading: _loadingProvinces,
                  onChanged: (String? newValue) {
                    final selectedProvince = provinces?.firstWhere(
                        (province) => province.provinceId == newValue);
                    selectProvince(newValue, selectedProvince?.provinceName);
                  },
                ),
                const SizedBox(height: 17),
                _buildDropdownButtonFormField(
                  value: _selectedDistrictId,
                  items: isProvinceSelected
                      ? districts?.map((district) {
                            return DropdownMenuItem<String>(
                              value: district.districtId,
                              child: Text(
                                district.districtName ?? '',
                                style: GoogleFonts.beVietnamPro(
                                  textStyle:
                                      const TextStyle(color: Colors.black),
                                ),
                              ),
                            );
                          }).toList() ??
                          []
                      : [],
                  label: 'Quận/Huyện',
                  isLoading: _loadingDistricts,
                  onChanged: (String? newValue) {
                    final selectedDistrict = districts?.firstWhere(
                        (district) => district.districtId == newValue);
                    selectDistrict(newValue, selectedDistrict?.districtName);
                  },
                ),
                const SizedBox(height: 17),
                _buildDropdownButtonFormField(
                  value: _selectedWardId,
                  isLoading: _loadingWards,
                  items: isDistrictSelected
                      ? wards?.map((ward) {
                            return DropdownMenuItem<String>(
                              value: ward.wardId,
                              child: Text(
                                ward.wardName ?? '',
                                style: GoogleFonts.beVietnamPro(
                                  textStyle:
                                      const TextStyle(color: Colors.black),
                                ),
                              ),
                            );
                          }).toList() ??
                          []
                      : [],
                  label: 'Phường/Xã/Thị Trấn',
                  onChanged: (String? newValue) {
                    final selectedWard =
                        wards?.firstWhere((ward) => ward.wardId == newValue);
                    selectWard(newValue, selectedWard?.wardName);
                  },
                ),
                const SizedBox(height: 17),
                _buildTextField(
                  controller: _streetController,
                  label: 'Đường',
                ),
                const SizedBox(height: 17),
                _buildTextField(
                  controller: _passController,
                  label: 'Mật khẩu',
                  obscureText: true,
                ),
                const SizedBox(height: 17),
                _buildTextField(
                  controller: _repassController,
                  label: 'Nhập lại mật khẩu',
                  obscureText: true,
                ),
                const SizedBox(height: 17),
                FutureBuilder<void>(
                  future: _registrationFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
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
                            _registrationFuture = _registerUser();
                          });
                        },
                        child: const Text(
                          'Đăng ký',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
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
                            _registrationFuture = _registerUser();
                          });
                        },
                        child: const Text(
                          'Đăng ký',
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
                const SizedBox(height: 30),
                Row(
                  children: [
                    const Text(
                      'Không có tài khoản? ',
                      style: TextStyle(
                        color: Color(0xFF232323),
                        fontSize: 15,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          AnimateLeftCurve.createRoute(const LoginScreen()),
                        );
                      },
                      child: const Text(
                        'Đăng Ký',
                        style: TextStyle(
                          color: Color(0xFF755DC1),
                          fontSize: 15,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
