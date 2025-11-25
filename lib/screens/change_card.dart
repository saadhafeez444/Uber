import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangeCardScreen extends StatelessWidget {
  const ChangeCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryOrange = Color(0xFFFF9800);

    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: AppBar(
        backgroundColor: primaryOrange,
        title: Text(
          'Change Card',
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildCardOption(context, 'Visa', '4242', primaryOrange, true),
            _buildCardOption(context, 'Mastercard', '1234', Colors.blue, false),
            _buildCardOption(context, 'Amex', '9876', Colors.purple, false),
            const Spacer(),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add_card_outlined, size: 22),
                label: Text(
                  'Add New Card',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryOrange,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                  elevation: 5,
                  shadowColor: primaryOrange.withOpacity(0.5),
                ),
                onPressed: () {},
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildCardOption(
    BuildContext context,
    String type,
    String last4,
    Color color,
    bool selected,
  ) {
    return GestureDetector(
      onTap: () {},
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          gradient: selected
              ? LinearGradient(
                  colors: [color.withOpacity(0.3), color.withOpacity(0.1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          color: selected ? null : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
          border: Border.all(
            color: selected ? color : Colors.grey.shade300,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withOpacity(0.1),
              ),
              child: Icon(Icons.credit_card, size: 36, color: color),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                '$type •••• $last4',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.grey.shade900,
                ),
              ),
            ),
            if (selected) Icon(Icons.check_circle, color: color, size: 28),
          ],
        ),
      ),
    );
  }
}
