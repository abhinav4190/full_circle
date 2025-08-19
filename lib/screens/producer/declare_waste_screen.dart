import 'package:flutter/material.dart';
import 'package:full_circle/controllers/auth_controller.dart';
import 'package:full_circle/controllers/producer_controller.dart';
import 'package:full_circle/utils/colors.dart';
import 'package:get/get.dart';

class DeclareWasteScreen extends StatefulWidget {
  @override
  _DeclareWasteScreenState createState() => _DeclareWasteScreenState();
}

class _DeclareWasteScreenState extends State<DeclareWasteScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthController authController = Get.find();
  final ProducerController producerController = Get.find();
  
  // Form controllers
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  final TextEditingController _customWasteController = TextEditingController();
  
  // Form state
  String selectedWasteType = '';
  bool useCurrentLocation = false;
  bool isLoading = false;
  bool showCustomWasteField = false;
  
  // Waste types with recommended prices
  final Map<String, double> wasteTypes = {
    'Plastic': 12.0,
    'Paper': 8.0,
    'Glass': 5.0,
    'Metal': 25.0,
    'Cardboard': 6.0,
    'Electronics': 15.0,
  };

  @override
  void initState() {
    super.initState();
    _priceController.addListener(_updatePrice);
  }

  void _updatePrice() {
    if (selectedWasteType.isNotEmpty && wasteTypes.containsKey(selectedWasteType)) {
      if (_priceController.text.isEmpty) {
        _priceController.text = wasteTypes[selectedWasteType]!.toString();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Declare Waste',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              
              // Select Waste Type
              _buildSectionContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select Waste Type',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _showWasteTypeBottomSheet,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade500,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      ),
                      child: Text(
                        'Select',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Show selected waste type
              if (selectedWasteType.isNotEmpty) ...[
                SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green.shade200),
                  ),
                  child: Text(
                    'Selected: ${selectedWasteType == "Custom" ? _customWasteController.text : selectedWasteType}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.green.shade700,
                    ),
                  ),
                ),
              ],
              
              SizedBox(height: 20),
              
              // Quantity
              _buildSectionContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quantity (kg)',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: _quantityController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter quantity in kg',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.green.shade500),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter quantity';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter valid number';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 20),
              
              // Price per kg
              _buildSectionContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price per kg',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 12),
                    if (selectedWasteType.isNotEmpty && wasteTypes.containsKey(selectedWasteType))
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12),
                        margin: EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.amber.shade200),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.lightbulb_outline, color: Colors.amber.shade700, size: 18),
                            SizedBox(width: 8),
                            Text(
                              'Recommended: ₹${wasteTypes[selectedWasteType]} per kg',
                              style: TextStyle(
                                color: Colors.amber.shade800,
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                    TextFormField(
                      controller: _priceController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter price per kg',
                        prefixText: '₹ ',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.green.shade500),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter price';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Please enter valid price';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 20),
              
              // Pickup Address
              _buildSectionContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Pickup Address',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              useCurrentLocation = !useCurrentLocation;
                              if (useCurrentLocation) {
                                _addressController.text = 'Using current location...';
                              } else {
                                _addressController.clear();
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green.shade500,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          ),
                          child: Text(
                            useCurrentLocation ? 'Manual' : 'Current',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    if (useCurrentLocation)
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.green.shade200),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.my_location, color: Colors.green.shade600, size: 20),
                            SizedBox(width: 8),
                            Text(
                              'Using current location',
                              style: TextStyle(
                                color: Colors.green.shade700,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Enter pickup address',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          SizedBox(height: 8),
                          TextFormField(
                            controller: _addressController,
                            maxLines: 3,
                            decoration: InputDecoration(
                              hintText: 'Enter complete pickup address',
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.grey.shade300),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(color: Colors.green.shade500),
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            ),
                            validator: (value) {
                              if (!useCurrentLocation && (value == null || value.isEmpty)) {
                                return 'Please enter pickup address';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              
              SizedBox(height: 20),
              
              // Add Any Remarks
              _buildSectionContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Add Any Remarks or Message',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 12),
                    TextFormField(
                      controller: _remarksController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: 'Add any special instructions or remarks...',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.grey.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: Colors.green.shade500),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 40),
              
              // Submit Button
              Container(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _submitWasteDeclaration,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.shade400,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: isLoading
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          'Submit Waste',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
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

  Widget _buildSectionContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }

  void _showWasteTypeBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select Waste Type',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close),
                ),
              ],
            ),
            SizedBox(height: 20),
            ...wasteTypes.entries.map((entry) => 
              ListTile(
                title: Text(entry.key),
                subtitle: Text('Recommended: ₹${entry.value}/kg'),
                trailing: selectedWasteType == entry.key
                    ? Icon(Icons.check_circle, color: Colors.green.shade500)
                    : null,
                onTap: () {
                  setState(() {
                    selectedWasteType = entry.key;
                    showCustomWasteField = false;
                    _customWasteController.clear();
                    _priceController.text = entry.value.toString();
                  });
                  Navigator.pop(context);
                },
              ),
            ),
            Divider(),
            ListTile(
              title: Text('Other (Specify)'),
              trailing: selectedWasteType == 'Custom'
                  ? Icon(Icons.check_circle, color: Colors.green.shade500)
                  : null,
              onTap: () {
                setState(() {
                  selectedWasteType = 'Custom';
                  showCustomWasteField = true;
                  _priceController.clear();
                });
                Navigator.pop(context);
                _showCustomWasteDialog();
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showCustomWasteDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Specify Waste Type'),
        content: TextField(
          controller: _customWasteController,
          decoration: InputDecoration(
            hintText: 'Enter waste type',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                selectedWasteType = '';
                _customWasteController.clear();
              });
              Navigator.pop(context);
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_customWasteController.text.isNotEmpty) {
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green.shade500,
            ),
            child: Text('Done', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _submitWasteDeclaration() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    
    if (selectedWasteType.isEmpty) {
      Get.snackbar(
        'Error',
        'Please select a waste type',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 12,
        margin: EdgeInsets.all(16),
      );
      return;
    }

    if (selectedWasteType == 'Custom' && _customWasteController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please specify the custom waste type',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 12,
        margin: EdgeInsets.all(16),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // Prepare waste declaration data
      Map<String, dynamic> wasteData = {
        'wasteType': selectedWasteType == 'Custom' 
            ? _customWasteController.text 
            : selectedWasteType,
        'quantity': double.parse(_quantityController.text),
        'pricePerKg': double.parse(_priceController.text),
        'totalAmount': double.parse(_quantityController.text) * double.parse(_priceController.text),
        'pickupAddress': useCurrentLocation 
            ? 'Current Location' 
            : _addressController.text,
        'useCurrentLocation': useCurrentLocation,
        'remarks': _remarksController.text,
        'status': 'pending',
        'createdAt': DateTime.now().toIso8601String(),
        'producerId': authController.currentUserId.value,
      };

      // Use ProducerController to save data
      bool success = await producerController.declareWaste(wasteData);

      if (success) {
        Get.snackbar(
          'Success',
          'Waste declared successfully!',
          backgroundColor: Colors.green.shade500,
          colorText: Colors.white,
          borderRadius: 12,
          margin: EdgeInsets.all(16),
          icon: Icon(Icons.check_circle, color: Colors.white),
        );
        
        // Navigate back
        Get.back();
      } else {
        Get.snackbar(
          'Error',
          'Failed to declare waste. Please try again.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          borderRadius: 12,
          margin: EdgeInsets.all(16),
        );
      }

    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to declare waste: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 12,
        margin: EdgeInsets.all(16),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _quantityController.dispose();
    _priceController.dispose();
    _addressController.dispose();
    _remarksController.dispose();
    _customWasteController.dispose();
    super.dispose();
  }
}