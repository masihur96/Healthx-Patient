import 'package:flutter/material.dart';
import 'package:healthx_patient/features/profile/data/models/country_model.dart';
import 'package:healthx_patient/features/profile/data/models/division_model.dart';
import 'package:healthx_patient/features/profile/data/models/profile_response_model.dart';
import 'package:healthx_patient/shared/providers/language_provider.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  final UserProfile? userProfile;

  const EditProfileScreen({super.key, this.userProfile});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _addressLine1Controller = TextEditingController();
  final TextEditingController _addressLine2Controller = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  List<Country> countries = [];
  List<Division> divisions = [];
  Country? selectedCountry;
  Division? selectedDivision;
  String? selectedGender; // Add gender selection variable
  bool isLoadingCountries = true;
  bool isLoadingDivisions = false;

  // Gender options
  final List<String> genderOptions = ['MALE', 'FEMALE', 'OTHERS'];

  @override
  void initState() {
    setPreviousData();
    // getCountries();
    super.initState();
  }

  // getCountries() async {
  //   setState(() {
  //     isLoadingCountries = true;
  //   });
  //
  //   UserProfileViewModel userProfileViewModel = UserProfileViewModel();
  //   await userProfileViewModel.fetchCountries();
  //   countries = userProfileViewModel.countryResponseData?.data ?? [];
  //   // Set initial country if user has one
  //   if (widget.userProfile?.country != null && countries.isNotEmpty) {
  //     selectedCountry = countries.firstWhere(
  //       (country) => country.name == widget.userProfile?.country,
  //       orElse: () => countries.first,
  //     );
  //     // Fetch divisions for the selected country
  //     if (selectedCountry != null) {
  //       await getDivisions(alpha3: selectedCountry!.alpha3Code);
  //     }
  //   } else if (countries.isNotEmpty) {
  //     selectedCountry = countries.first;
  //     await getDivisions(alpha3: selectedCountry!.alpha3Code);
  //   }
  //
  //   setState(() {
  //     isLoadingCountries = false;
  //   });
  // }

  // getDivisions({required String alpha3}) async {
  //   setState(() {
  //     isLoadingDivisions = true;
  //   });
  //
  //   UserProfileViewModel userProfileViewModel = UserProfileViewModel();
  //   await userProfileViewModel.fetchDivisions(alpha3: alpha3);
  //   divisions = userProfileViewModel.divisionResponseData?.data ?? [];
  //   print("divisions:: ${divisions.length}");
  //
  //   // Set initial division if user has one
  //   if (widget.userProfile?.state != null && divisions.isNotEmpty) {
  //     selectedDivision = divisions.firstWhere(
  //       (division) => division.name == widget.userProfile?.state,
  //       orElse: () => divisions.first,
  //     );
  //   } else if (divisions.isNotEmpty) {
  //     selectedDivision = divisions.first;
  //   }
  //
  //   setState(() {
  //     isLoadingDivisions = false;
  //   });
  // }

  setPreviousData() {
    if (widget.userProfile == null) {
      return;
    }
    _fullNameController.text = widget.userProfile?.fullName ?? "";
    selectedGender = widget.userProfile?.gender?.toUpperCase() ??
        "MALE"; // Set selected gender
    _dobController.text = widget.userProfile?.dateOfBirth ?? "";
    _addressLine1Controller.text = widget.userProfile?.addressLine1 ?? "";
    _addressLine2Controller.text = widget.userProfile?.addressLine2 ?? "";
    _cityController.text = widget.userProfile?.city ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: const Icon(Icons.arrow_back_ios),
            ),
          ),
          title: Text(languageProvider.isBangla
              ? "প্রোফাইল সম্পাদনা"
              : "Edit Profile")),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              SizedBox(
                height: 10,
              ),
              _buildField(
                  _fullNameController,
                  languageProvider.isBangla ? "পূর্ণ নাম" : "Full Name",
                  Icons.person,
                  false),
              const SizedBox(height: 12),
              _buildGenderDropdown(
                  languageProvider), // Replace gender field with dropdown
              const SizedBox(height: 12),
              _buildField(
                  _dobController,
                  languageProvider.isBangla ? "জন্মতারিখ" : "Date of Birth",
                  Icons.calendar_today,
                  true,
                  isOptional: true), // Make DOB optional
              const SizedBox(height: 12),
              _buildField(
                _addressLine1Controller,
                languageProvider.isBangla ? "ঠিকানা লাইন ১" : "Address Line 1",
                Icons.home,
                false,
                isSingleLine: false,
                hint: languageProvider.isBangla
                    ? "উদাহরণ: বাড়ি ১২৩, সড়ক ৪"
                    : "e.g. House 123, Road 4",
              ),

              const SizedBox(height: 12),

// Address Line 2 (textarea + placeholder)
              _buildField(
                _addressLine2Controller,
                languageProvider.isBangla ? "ঠিকানা লাইন ২" : "Address Line 2",
                Icons.home_work,
                false,
                isSingleLine: false,
                hint: languageProvider.isBangla
                    ? "উদাহরণ: ফ্ল্যাট ৪বি, ২য় তলা"
                    : "e.g. Flat 4B, 2nd Floor",
              ),
              const SizedBox(height: 12),
              _buildField(
                  _cityController,
                  languageProvider.isBangla ? "শহর" : "City",
                  Icons.location_city,
                  false),
              const SizedBox(height: 12),

              // Country Dropdown
              _buildCountryDropdown(languageProvider),
              const SizedBox(height: 12),

              // Division Dropdown
              _buildDivisionDropdown(languageProvider),
              const SizedBox(height: 12),

              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  // if (_formKey.currentState!.validate()) {
                  //   final userProfileVM = context.read<UserProfileViewModel>();
                  //   // Perform save action
                  //   final updatedProfile = UserProfile(
                  //     fullName: _fullNameController.text,
                  //     gender: selectedGender ?? "", // Use selected gender
                  //     dateOfBirth: _dobController.text,
                  //     addressLine1: _addressLine1Controller.text,
                  //     addressLine2: _addressLine2Controller.text,
                  //     city: _cityController.text,
                  //     state: selectedDivision?.name ?? "",
                  //     country: selectedCountry?.name ?? "",
                  //   );
                  //
                  //   bool isSuccess = await userProfileVM
                  //       .updateUserProfileAndSave(updatedProfile);
                  //   if (isSuccess) {
                  //     AppSnackBar.show(
                  //       context,
                  //       message: 'Profile updated successfully!',
                  //     );
                  //
                  //     Navigator.pop(context,
                  //         true); // Pass true to indicate successful update
                  //     // Handle save action
                  //   } else {
                  //     AppSnackBar.show(
                  //       context,
                  //       message: 'Failed to update profile. Please try again.',
                  //     );
                  //   }
                  // }
                },
                child: Text(languageProvider.isBangla
                    ? "প্রোফাইল আপডেট করুন"
                    : "Update Profile"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCountryDropdown(LanguageProvider languageProvider) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 1),
      ),
      child: DropdownButtonFormField<Country>(
        value: selectedCountry,
        decoration: InputDecoration(
          labelText: languageProvider.isBangla ? "দেশ" : "Country",
          prefixIcon: Icon(Icons.public),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        ),
        hint: Text(
          languageProvider.isBangla ? "দেশ নির্বাচন করুন" : "Select Country",
          style: TextStyle(color: Colors.grey.shade600),
        ),
        items: countries.map((Country country) {
          return DropdownMenuItem<Country>(
            value: country,
            child: Text(
              languageProvider.isBangla ? country.nameBN : country.name,
              style: TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),
        onChanged: (value) {},
        //isLoadingCountries
        //     ? null
        //     : (Country? newValue) async {
        //         if (newValue != null && newValue != selectedCountry) {
        //           if (newValue.alpha3Code == "BGD") {
        //             setState(() {
        //               selectedCountry = newValue;
        //               selectedDivision =
        //                   null; // Reset division when country changes
        //             });
        //             await getDivisions(alpha3: newValue.alpha3Code);
        //           } else {
        //             AppSnackBar.show(context,
        //                 message: "Divisions are only available for Bangladesh");
        //           }
        //        }
        //    },
        validator: (value) {
          if (value == null) {
            return languageProvider.isBangla
                ? 'দেশ নির্বাচন করুন'
                : 'Please select a country';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDivisionDropdown(LanguageProvider languageProvider) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 1),
      ),
      child: DropdownButtonFormField<Division>(
        value: selectedDivision,
        decoration: InputDecoration(
          labelText:
              languageProvider.isBangla ? "বিভাগ/রাজ্য" : "Division/State",
          prefixIcon: Icon(Icons.map),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        ),
        hint: Text(
          languageProvider.isBangla ? "বিভাগ নির্বাচন করুন" : "Select Division",
          style: TextStyle(color: Colors.grey.shade600),
        ),
        items: divisions.map((Division division) {
          return DropdownMenuItem<Division>(
            value: division,
            child: Text(
              languageProvider.isBangla ? division.nameBN : division.name,
              style: TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          );
        }).toList(),
        onChanged: (selectedCountry == null || isLoadingDivisions)
            ? null
            : (Division? newValue) {
                setState(() {
                  selectedDivision = newValue;
                });
              },
        validator: (value) {
          if (value == null) {
            return languageProvider.isBangla
                ? 'বিভাগ নির্বাচন করুন'
                : 'Please select a division';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildGenderDropdown(LanguageProvider languageProvider) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 1),
      ),
      child: DropdownButtonFormField<String>(
        value: selectedGender,
        decoration: InputDecoration(
          labelText: languageProvider.isBangla ? "লিঙ্গ" : "Gender",
          prefixIcon: Icon(Icons.person),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        ),
        hint: Text(
          languageProvider.isBangla
              ? "লিঙ্গ নির্বাচন করুন (ঐচ্ছিক)"
              : "Select Gender (Optional)",
          style: TextStyle(color: Colors.grey.shade600),
        ),
        items: genderOptions.map((String gender) {
          return DropdownMenuItem<String>(
            value: gender,
            child: Text(
              languageProvider.isBangla ? _getGenderInBangla(gender) : gender,
              style: TextStyle(fontSize: 16),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            selectedGender = newValue;
          });
        },
        // No validator - making it optional
      ),
    );
  }

  String _getGenderInBangla(String gender) {
    switch (gender) {
      case 'Male':
        return 'পুরুষ';
      case 'Female':
        return 'মহিলা';
      case 'Others':
        return 'অন্যান্য';
      default:
        return gender;
    }
  }

  Widget _buildField(
    TextEditingController controller,
    String label,
    IconData icon,
    bool readOnly, {
    bool isSingleLine = true,
    String? hint,
    bool isOptional = false, // Add optional parameter
  }) {
    return TextFormField(
      controller: controller,
      maxLines: isSingleLine ? 1 : 3,
      decoration: InputDecoration(
        labelText: label +
            (isOptional
                ? " (${Provider.of<LanguageProvider>(context).isBangla ? "ঐচ্ছিক" : "Optional"})"
                : ""),
        hintText: hint,
        fillColor: Colors.grey.shade100,
        filled: true,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      readOnly: readOnly,
      onTap: readOnly && (label == "Date of Birth" || label == "জন্মতারিখ")
          ? () async {
              FocusScope.of(context).unfocus();

              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate:
                    DateTime.now().subtract(const Duration(days: 6570)),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: Theme.of(context).colorScheme.copyWith(
                            primary: Theme.of(context).primaryColor,
                          ),
                    ),
                    child: child!,
                  );
                },
              );

              if (pickedDate != null) {
                final formattedDate =
                    "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
                controller.text = formattedDate;
              }
            }
          : null,
      validator: (value) {
        // Skip validation if field is optional
        if (isOptional) {
          return null;
        }
        if (value == null || value.trim().isEmpty) {
          return 'Please enter $label';
        }
        return null;
      },
    );
  }
}
