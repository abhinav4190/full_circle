import 'package:flutter/material.dart';
import 'package:full_circle/screens/producer/waste_declaration_success_screen.dart';
import 'package:get/get.dart';

class DeclareWasteScreen extends StatefulWidget {
  @override
  _DeclareWasteScreenState createState() => _DeclareWasteScreenState();
}

class _DeclareWasteScreenState extends State<DeclareWasteScreen> {
  final TextEditingController _customWasteController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();

  String? selectedWasteType;
  bool isCustomWaste = false;
  double recommendedPrice = 0.0;

  // Predefined waste types with recommended prices (per kg)
  final Map<String, double> wasteTypes = {
    'Plastic Bottles': 25.0,
    'Cardboard': 15.0,
    'Newspaper': 12.0,
    'Aluminum Cans': 120.0,
    'Glass Bottles': 8.0,
    'Electronic Waste': 80.0,
    'Paper': 10.0,
    'Metal Scraps': 45.0,
  };

  @override
  void dispose() {
    _customWasteController.dispose();
    _quantityController.dispose();
    _priceController.dispose();
    _addressController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  void _selectWasteType(String wasteType) {
    setState(() {
      selectedWasteType = wasteType;
      isCustomWaste = false;
      recommendedPrice = wasteTypes[wasteType] ?? 0.0;
      _priceController.text = recommendedPrice.toString();
    });
  }

  void _selectCustomWaste() {
    setState(() {
      isCustomWaste = true;
      selectedWasteType = null;
      recommendedPrice = 0.0;
      _priceController.clear();
    });
  }

  void _useCurrentLocation() {
    // In a real app, you would use location services here
    setState(() {
      _addressController.text = "Using current location...";
    });
    Get.snackbar(
      'Location',
      'Current location will be used for pickup',
      backgroundColor: Colors.green.shade500,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void _submitWaste() {
    if (_validateForm()) {
      Get.snackbar(
        'Success',
        'Waste declared successfully! You will be notified when a buyer is found.',
        backgroundColor: Colors.green.shade500,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 3),
      );
      Get.to(() => WasteDeclarationSuccessScreen());
      Get.back();
    }
  }

  bool _validateForm() {
    if (selectedWasteType == null && !isCustomWaste) {
      Get.snackbar('Error', 'Please select a waste type');
      return false;
    }
    if (isCustomWaste && _customWasteController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter custom waste type');
      return false;
    }
    if (_quantityController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter quantity');
      return false;
    }
    if (_priceController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter price');
      return false;
    }
    if (_addressController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter pickup address');
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back, color: Colors.black),
        //   onPressed: () => Get.back(),
        // ),
        title: Text(
          'Declare Waste',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Waste Type Selection
              _buildSectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Select Waste Type',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        if (selectedWasteType != null && !isCustomWaste)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.green.shade500,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Selected',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ...wasteTypes.keys.map((type) => _buildWasteTypeChip(type)),
                        _buildCustomWasteChip(),
                      ],
                    ),
                    if (isCustomWaste) ...[
                      SizedBox(height: 16),
                      TextField(
                        controller: _customWasteController,
                        decoration: InputDecoration(
                          hintText: 'Enter custom waste type',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(color: Colors.green.shade500),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              SizedBox(height: 16),

              // Quantity Section
              _buildSectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quantity (kg)',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: _quantityController,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        hintText: 'Enter quantity in kg',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.green.shade500),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        suffixIcon: Icon(Icons.scale, color: Colors.grey.shade500),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),

              // Price Section
              _buildSectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Price per kg',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        if (recommendedPrice > 0)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.green.shade200),
                            ),
                            child: Text(
                              'Recommended: ₹${recommendedPrice.toStringAsFixed(0)}',
                              style: TextStyle(
                                color: Colors.green.shade700,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: _priceController,
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        hintText: 'Enter price per kg',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.green.shade500),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        prefixText: '₹ ',
                        prefixStyle: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),

              // Pickup Address Section
              _buildSectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pickup Address',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: _addressController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Enter pickup address',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.green.shade500),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      ),
                    ),
                    SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: _useCurrentLocation,
                        icon: Icon(Icons.my_location, color: Colors.green.shade500),
                        label: Text(
                          'Use Current Location',
                          style: TextStyle(color: Colors.green.shade500),
                        ),
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.green.shade500),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),

              // Remarks Section
              _buildSectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add Any Remarks or Message',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade800,
                      ),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: _remarksController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Optional: Add any special instructions or remarks...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide(color: Colors.green.shade500),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitWaste,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade500,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: Text(
                    'Submit Waste Declaration',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildWasteTypeChip(String type) {
    final isSelected = selectedWasteType == type && !isCustomWaste;
    return GestureDetector(
      onTap: () => _selectWasteType(type),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green.shade500 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected ? Colors.green.shade500 : Colors.grey.shade300,
          ),
        ),
        child: Text(
          type,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey.shade700,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildCustomWasteChip() {
    final isSelected = isCustomWaste;
    return GestureDetector(
      onTap: _selectCustomWaste,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green.shade500 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: isSelected ? Colors.green.shade500 : Colors.grey.shade300,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.add,
              color: isSelected ? Colors.white : Colors.grey.shade600,
              size: 18,
            ),
            SizedBox(width: 6),
            Text(
              'Custom Type',
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey.shade700,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}