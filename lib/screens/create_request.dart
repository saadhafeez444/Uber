import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:project/screens/offer.dart';

enum MoveType { house, medical, office, vehicle }

class CreateRequestScreen extends StatefulWidget {
  const CreateRequestScreen({super.key});

  @override
  _CreateRequestScreenState createState() => _CreateRequestScreenState();
}

class _CreateRequestScreenState extends State<CreateRequestScreen> {
  MoveType? _selectedType;
  final _pickupController = TextEditingController();
  final _dropController = TextEditingController();
  final _itemsController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  bool _fragile = false;

  final List<File> _selectedImages = [];

  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _pickupController.dispose();
    _dropController.dispose();
    _itemsController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFiles = await _picker.pickMultiImage(imageQuality: 70);
    if (pickedFiles.isNotEmpty) {
      setState(() {
        _selectedImages.addAll(pickedFiles.map((x) => File(x.path)));
      });
    }
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final res = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.orange, // 🟧 selected date and header color
              onPrimary: Colors.white, // text color on orange
              onSurface: Colors.black87, // text color on surface
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.orange, // 🟧 'CANCEL' and 'OK' buttons
              ),
            ),
            datePickerTheme: const DatePickerThemeData(
              headerBackgroundColor: Colors.orange,
              headerForegroundColor: Colors.white,
              todayBackgroundColor: WidgetStatePropertyAll(Colors.orangeAccent),
              todayForegroundColor: WidgetStatePropertyAll(Colors.white),
              dayForegroundColor: WidgetStatePropertyAll(Colors.black87),
              dayOverlayColor: WidgetStatePropertyAll(Colors.orangeAccent),
            ),
            dialogTheme: DialogThemeData(backgroundColor: Colors.white),
          ),
          child: child!,
        );
      },
    );

    if (res != null) setState(() => _selectedDate = res);
  }

  Future<void> _pickTime() async {
    final res = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 10, minute: 0),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color.fromARGB(
                255,
                192,
                185,
                174,
              ), // 🟧 main highlight color
              onPrimary: Colors.white, // text/icon color on orange
              onSurface: Colors.black87, // general text color
            ),
            timePickerTheme: TimePickerThemeData(
              dialBackgroundColor: Color(0xFFFFF3E0), // light orange background
              hourMinuteTextColor: Colors.black,
              dialHandColor: Color.fromARGB(255, 192, 185, 174),
              helpTextStyle: GoogleFonts.montserrat(
                color: Color.fromARGB(255, 192, 185, 174),
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (res != null) setState(() => _selectedTime = res);
  }

  void _submit() {
    final dateStr = _selectedDate != null
        ? DateFormat.yMMMd().format(_selectedDate!)
        : 'Not set';
    final timeStr = _selectedTime != null
        ? _selectedTime!.format(context)
        : 'Not set';

    showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 10,
        backgroundColor: Colors.transparent, // for shadow effect
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 15,
                offset: Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header with gradient
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                  gradient: LinearGradient(
                    colors: [Color(0xFFFFB84D), Color(0xFFFF9800)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Text(
                  'Confirm Request',
                  style: GoogleFonts.montserrat(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),

              // Content
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow(
                        'Type',
                        '${_selectedType ?? 'Not selected'}',
                      ),
                      _buildDetailRow('Pickup', _pickupController.text),
                      _buildDetailRow('Drop-off', _dropController.text),
                      _buildDetailRow('Items', _itemsController.text),
                      _buildDetailRow('Date', dateStr),
                      _buildDetailRow('Time', timeStr),
                      _buildDetailRow('Fragile', _fragile ? 'Yes' : 'No'),
                      if (_selectedImages.isNotEmpty) ...[
                        const SizedBox(height: 12),
                        Text(
                          'Attached Photos:',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 80,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _selectedImages.length,
                            itemBuilder: (context, i) => Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 6,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Image.file(
                                    _selectedImages[i],
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              // Action Buttons
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.orange.shade400),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Edit',
                          style: GoogleFonts.montserrat(
                            color: Colors.orange,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 5,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          backgroundColor: Colors.orangeAccent,
                          elevation: 4,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OffersScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Proceed to Offers',
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function for label-value row
  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              '$label:',
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade800,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateText = _selectedDate != null
        ? DateFormat.yMMMd().format(_selectedDate!)
        : 'Select date';
    final timeText = _selectedTime != null
        ? _selectedTime!.format(context)
        : 'Select time';

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(210, 255, 184, 77), Color(0xFFFF9800)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new_outlined,
                color: Colors.white,
              ),
            ),
            title: Text(
              "Create Moving Request",
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select Move Type',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            const SizedBox(height: 12),

            // Move type dropdown
            _buildMoveTypeDropdown(),

            const SizedBox(height: 20),

            _buildTextFieldCard(
              controller: _pickupController,
              label: "Pickup Location",
              hint: "Enter pickup address",
              icon: Icons.location_on_outlined,
            ),
            const SizedBox(height: 12),

            _buildTextFieldCard(
              controller: _dropController,
              label: "Drop-off Location",
              hint: "Enter drop-off address",
              icon: Icons.location_city_outlined,
            ),
            const SizedBox(height: 12),

            _buildTextFieldCard(
              controller: _itemsController,
              label: "Items (brief list)",
              hint: "e.g., 2 sofas, 1 fridge, boxes...",
              icon: Icons.inventory_2_outlined,
              maxLines: 3,
            ),

            const SizedBox(height: 20),

            // 📸 Add Pictures of Items
            const Text(
              'Add Photos of Items',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ..._selectedImages.map(
                  (file) => Stack(
                    alignment: Alignment.topRight,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          file,
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 2,
                        right: 2,
                        child: GestureDetector(
                          onTap: () {
                            setState(() => _selectedImages.remove(file));
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.black54,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Colors.orange.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.orange.shade300),
                    ),
                    child: const Icon(
                      Icons.add_a_photo_outlined,
                      color: Colors.orange,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Date & Time pickers
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(
                      Icons.calendar_today_outlined,
                      color: Colors.orange,
                    ),
                    label: Text(
                      dateText,
                      style: const TextStyle(color: Colors.black87),
                    ),
                    onPressed: _pickDate,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.orange.shade200),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(
                      Icons.access_time_outlined,
                      color: Colors.orange,
                    ),
                    label: Text(
                      timeText,
                      style: const TextStyle(color: Colors.black87),
                    ),
                    onPressed: _pickTime,
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.orange.shade200),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            Row(
              children: [
                Checkbox(
                  activeColor: Colors.orange,
                  value: _fragile,
                  onChanged: (v) => setState(() => _fragile = v ?? false),
                ),
                Expanded(
                  child: Text(
                    'Contains fragile or medical-sensitive items',
                    style: GoogleFonts.montserrat(color: Colors.grey.shade800),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(210, 255, 184, 77),
                      Color(0xFFFF9800),
                    ], // Example orange gradient
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent, // remove default shadow
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: _submit,
                  child: Text(
                    'Search Offers',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildMoveTypeDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.orange.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<MoveType>(
          value: _selectedType,
          hint: Text(
            'Select Move Type',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          isExpanded: true,
          icon: const Icon(
            Icons.arrow_drop_down_rounded,
            color: Colors.orange,
            size: 28,
          ),
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(14),
          items: const [
            DropdownMenuItem(
              value: MoveType.house,
              child: Row(
                children: [
                  Icon(Icons.home_outlined, color: Colors.orange),
                  SizedBox(width: 10),
                  Text('House Shifting'),
                ],
              ),
            ),
            DropdownMenuItem(
              value: MoveType.medical,
              child: Row(
                children: [
                  Icon(Icons.local_hospital_outlined, color: Colors.orange),
                  SizedBox(width: 10),
                  Text('Medical Transport'),
                ],
              ),
            ),
            DropdownMenuItem(
              value: MoveType.office,
              child: Row(
                children: [
                  Icon(Icons.business_center_outlined, color: Colors.orange),
                  SizedBox(width: 10),
                  Text('Office Move'),
                ],
              ),
            ),
            DropdownMenuItem(
              value: MoveType.vehicle,
              child: Row(
                children: [
                  Icon(Icons.local_shipping_outlined, color: Colors.orange),
                  SizedBox(width: 10),
                  Text('Vehicle Transport'),
                ],
              ),
            ),
          ],
          onChanged: (value) => setState(() => _selectedType = value),
        ),
      ),
    );
  }

  Widget _buildTextFieldCard({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        cursorColor: Colors.orange,
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.orange),
          labelText: label,
          hintText: hint,
          labelStyle: GoogleFonts.montserrat(
            color: Colors.grey.shade700,
            fontWeight: FontWeight.w600,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: 16,
          ),
        ),
      ),
    );
  }
}
