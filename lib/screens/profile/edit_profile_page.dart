import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_ticker_app_flutter/common/widgets/stateless/custom_back_arrow.dart';
import 'package:movie_ticker_app_flutter/models/request/address_request.dart';
import 'package:movie_ticker_app_flutter/provider/user_provider.dart';
import 'package:movie_ticker_app_flutter/screens/profile/confirm_password_page.dart';
import 'package:movie_ticker_app_flutter/themes/app_colors.dart';
import 'package:movie_ticker_app_flutter/utils/animate_left_curve.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  String? _selectedProvinceId;
  String? _selectedDistrictId;
  String? _selectedWardId;

  String? _selectedProvince;
  String? _selectedDistrict;
  String? _selectedWard;

  bool _loadingProvinces = false;
  bool _loadingDistricts = false;
  bool _loadingWards = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUserData();
    });
  }

  Future<void> _loadUserData() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;

    if (user != null) {
      _userNameController.text = user.name;
      _emailController.text = user.email;
      _phoneController.text = user.phone;
      _streetController.text = user.address.street;

      // Load provinces first
      await _loadProvinces();

      final userProvince = userProvider.province?.firstWhere(
        (province) => province.provinceName == user.address.city,
      );

      if (userProvince != null) {
        _selectedProvinceId = userProvince.provinceId;
        selectProvince(userProvince.provinceId, userProvince.provinceName);
        await _loadDistricts(_selectedProvinceId);

        final userDistrict = userProvider.district?.firstWhere(
          (district) {
            return district.districtName == user.address.ward;
          },
        );

        if (userDistrict != null) {
          _selectedDistrictId = userDistrict.districtId;
          selectDistrict(userDistrict.districtId, userDistrict.districtName);

          await _loadWards(_selectedDistrictId);

          // Find the ward that matches the user's ward
          final userWard = userProvider.ward?.firstWhere(
            (ward) => ward.wardName == user.address.district,
          );

          if (userWard != null) {
            selectWard(userWard.wardId, userWard.wardName);
            _selectedWardId = userWard.wardId;
          }
        }
      }
    }
  }

  Future<void> _loadProvinces() async {
    setState(() {
      _loadingProvinces = true;
    });
    await Provider.of<UserProvider>(context, listen: false).getAllProvince();
    setState(() {
      _loadingProvinces = false;
    });
  }

  Future<void> _loadDistricts(String? provinceId) async {
    setState(() {
      _loadingDistricts = true;
    });
    await Provider.of<UserProvider>(context, listen: false)
        .getAllDistrictByProvinceId(provinceId!);
    setState(() {
      _loadingDistricts = false;
    });
  }

  Future<void> _loadWards(String? districtId) async {
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
    });
    _loadDistricts(provinceId);
  }

  void selectDistrict(String? districtId, String? districtName) {
    setState(() {
      _selectedDistrictId = districtId;
      _selectedDistrict = districtName;
      _selectedWardId = null; // Reset ward selection
      _selectedWard = null;
    });
    _loadWards(districtId);
  }

  void selectWard(String? wardId, String? wardName) {
    setState(() {
      _selectedWardId = wardId;
      _selectedWard = wardName;
    });
  }

  bool _allFieldsFilled() {
    return _userNameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _phoneController.text.isNotEmpty &&
        _streetController.text.isNotEmpty &&
        _selectedProvinceId != null &&
        _selectedDistrictId != null &&
        _selectedWardId != null;
  }

  Future<void> _updateUser() async {
    if (_allFieldsFilled()) {
      final AddressRequest address = AddressRequest(
        city: _selectedProvince!,
        ward: _selectedDistrict!,
        district: _selectedWard!,
        street: _streetController.text,
      );
      Navigator.of(context).push(
        AnimateLeftCurve.createRoute(ConfirmPasswordPage(
          address: address,
          name: _userNameController.text,
          email: _emailController.text,
          phone: _phoneController.text,
          street: _streetController.text,
        )),
      );
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
      style: GoogleFonts.beVietnamPro(
        textStyle: const TextStyle(
            color: Colors.white, fontSize: 13, fontWeight: FontWeight.w400),
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
    return AbsorbPointer(
      absorbing: isLoading,
      child: DropdownButtonFormField<String>(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        dropdownColor: AppColors.darkerBackground,
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
        centerTitle: true,
        title: Text(
          'Chỉnh sửa',
          style: GoogleFonts.beVietnamPro(
            textStyle: const TextStyle(
              fontSize: 18,
            ),
          ),
        ),
        backgroundColor: AppColors.darkerBackground,
        foregroundColor: AppColors.white,
        leading: const CustomBackArrow(),
        elevation: 10,
        shadowColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                            textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w400),
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
                items: _selectedProvinceId != null
                    ? districts?.map((district) {
                          return DropdownMenuItem<String>(
                            value: district.districtId,
                            child: Text(
                              district.districtName ?? '',
                              style: GoogleFonts.beVietnamPro(
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400),
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
                items: _selectedDistrictId != null
                    ? wards?.map((ward) {
                          return DropdownMenuItem<String>(
                            value: ward.wardId,
                            child: Text(
                              ward.wardName ?? '',
                              style: GoogleFonts.beVietnamPro(
                                textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400),
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
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(size.width, size.height / 16),
                  backgroundColor: const Color(0xFF755DC1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: _allFieldsFilled()
                    ? () {
                        _updateUser();
                      }
                    : null,
                child: const Text(
                  'Cập nhật',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
