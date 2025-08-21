import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class EditProfileScreen extends StatefulWidget {
  final Map<String, String> userInfo;

  EditProfileScreen({required this.userInfo});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> 
    with TickerProviderStateMixin {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController addressController;
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  bool _isLoading = false;
  bool _hasChanges = false;
  
  // Focus nodes for better UX
  final FocusNode _nameFocus = FocusNode();
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _addressFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    
    // Initialize controllers
    nameController = TextEditingController(text: widget.userInfo['name']);
    emailController = TextEditingController(text: widget.userInfo['email']);
    phoneController = TextEditingController(text: widget.userInfo['phone']);
    addressController = TextEditingController(text: widget.userInfo['address']);
    
    // Initialize animations
    _fadeController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );
    
    _slideController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));
    
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutBack,
    ));
    
    // Start animations
    _fadeController.forward();
    _slideController.forward();
    
    // Add listeners to detect changes
    _addChangeListeners();
  }

  void _addChangeListeners() {
    nameController.addListener(_onFieldChanged);
    emailController.addListener(_onFieldChanged);
    phoneController.addListener(_onFieldChanged);
    addressController.addListener(_onFieldChanged);
  }

  void _onFieldChanged() {
    final hasChanges = nameController.text != widget.userInfo['name'] ||
        emailController.text != widget.userInfo['email'] ||
        phoneController.text != widget.userInfo['phone'] ||
        addressController.text != widget.userInfo['address'];
    
    if (hasChanges != _hasChanges) {
      setState(() {
        _hasChanges = hasChanges;
      });
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    _addressFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: _buildAppBar(),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                _buildProfileImageSection(),
                SizedBox(height: 24),
                _buildFormSection(),
                SizedBox(height: 32),
                _buildSaveButton(),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      title: Text(
        'Edit Profile',
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
      ),
      iconTheme: IconThemeData(color: Colors.black),
      actions: [
        if (_hasChanges)
          TextButton(
            onPressed: _resetForm,
            child: Text(
              'Reset',
              style: TextStyle(color: Colors.red.shade400),
            ),
          ),
      ],
    );
  }

  Widget _buildProfileImageSection() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Hero(
                tag: 'profile_image',
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [Colors.green.shade400, Colors.green.shade600],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.3),
                        blurRadius: 20,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Icon(Icons.person, size: 60, color: Colors.white),
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: _changeProfileImage,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.green.shade600, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      size: 18,
                      color: Colors.green.shade600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'Tap to change photo',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormSection() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Personal Information',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 20),
          _buildTextField(
            'Full Name',
            nameController,
            Icons.person_outline,
            _nameFocus,
            _emailFocus,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your full name';
              }
              if (value!.length < 2) {
                return 'Name must be at least 2 characters';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          _buildTextField(
            'Email Address',
            emailController,
            Icons.email_outlined,
            _emailFocus,
            _phoneFocus,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your email';
              }
              if (!GetUtils.isEmail(value!)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          _buildTextField(
            'Phone Number',
            phoneController,
            Icons.phone_outlined,
            _phoneFocus,
            _addressFocus,
            keyboardType: TextInputType.phone,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your phone number';
              }
              if (value!.length < 10) {
                return 'Please enter a valid phone number';
              }
              return null;
            },
          ),
          SizedBox(height: 20),
          _buildTextField(
            'Address',
            addressController,
            Icons.location_on_outlined,
            _addressFocus,
            null,
            maxLines: 3,
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter your address';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    IconData icon,
    FocusNode currentFocus,
    FocusNode? nextFocus, {
    int maxLines = 1,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: currentFocus,
      maxLines: maxLines,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      textInputAction: nextFocus != null ? TextInputAction.next : TextInputAction.done,
      onFieldSubmitted: (value) {
        if (nextFocus != null) {
          FocusScope.of(context).requestFocus(nextFocus);
        }
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Container(
          margin: EdgeInsets.only(right: 12).copyWith(bottom: icon == Icons.location_on_outlined ? 45:0),
          child: Icon(
            icon,
            color: currentFocus.hasFocus ? Colors.green.shade600 : Colors.grey.shade500,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.green.shade600, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.red.shade400),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.red.shade400, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        labelStyle: TextStyle(
          color: currentFocus.hasFocus ? Colors.green.shade600 : Colors.grey.shade600,
        ),
      ),
    );
  }

  Widget _buildSaveButton() {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _hasChanges && !_isLoading ? _saveProfile : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: _hasChanges ? Colors.green.shade600 : Colors.grey.shade400,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: _hasChanges ? 8 : 0,
          shadowColor: Colors.green.withOpacity(0.3),
        ),
        child: _isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.save_outlined, size: 22),
                  SizedBox(width: 8),
                  Text(
                    'Save Changes',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  void _changeProfileImage() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Change Profile Picture',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: _buildImageOption(
                      Icons.camera_alt,
                      'Camera',
                      () {
                        Navigator.pop(context);
                        _pickImageFromCamera();
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _buildImageOption(
                      Icons.photo_library,
                      'Gallery',
                      () {
                        Navigator.pop(context);
                        _pickImageFromGallery();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImageOption(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 28, color: Colors.green.shade600),
            ),
            SizedBox(height: 12),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _pickImageFromCamera() {
    // Add your camera picking logic here
    HapticFeedback.selectionClick();
    Get.snackbar(
      'Camera',
      'Camera functionality would be implemented here',
      backgroundColor: Colors.blue.shade500,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void _pickImageFromGallery() {
    // Add your gallery picking logic here
    HapticFeedback.selectionClick();
    Get.snackbar(
      'Gallery',
      'Gallery functionality would be implemented here',
      backgroundColor: Colors.blue.shade500,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void _resetForm() {
    setState(() {
      nameController.text = widget.userInfo['name'] ?? '';
      emailController.text = widget.userInfo['email'] ?? '';
      phoneController.text = widget.userInfo['phone'] ?? '';
      addressController.text = widget.userInfo['address'] ?? '';
      _hasChanges = false;
    });
    
    HapticFeedback.lightImpact();
    Get.snackbar(
      'Form Reset',
      'All changes have been discarded',
      backgroundColor: Colors.orange.shade500,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 2),
    );
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isLoading = false;
      _hasChanges = false;
    });

    // HapticFeedback.notificationFeedback();
    Get.back();
    Get.snackbar(
      'Success',
      'Profile updated successfully!',
      backgroundColor: Colors.green.shade500,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 3),
      icon: Icon(Icons.check_circle, color: Colors.white),
    );
  }

  Future<bool> _onWillPop() async {
    if (_hasChanges) {
      return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Discard Changes?'),
          content: Text('You have unsaved changes. Are you sure you want to leave?'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: Text('Discard'),
            ),
          ],
        ),
      ) ?? false;
    }
    return true;
  }
}