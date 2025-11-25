import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/screens/offer.dart';
import 'package:project/screens/payment_screen.dart';

class OfferCard extends StatelessWidget {
  final Offer offer;
  const OfferCard({super.key, required this.offer});

  @override
  Widget build(BuildContext context) {
    const primaryOrange = Color(0xFFFF9800);

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: primaryOrange.withOpacity(0.4), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: primaryOrange.withOpacity(0.08),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔸 Avatar with orange background
          CircleAvatar(
            radius: 26,
            backgroundColor: primaryOrange,
            child: Text(
              offer.driverName.split(' ').first[0],
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(width: 14),

          // 🔸 Driver Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  offer.driverName,
                  style: GoogleFonts.montserrat(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(
                      Icons.local_shipping_outlined,
                      size: 16,
                      color: primaryOrange,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      offer.truckSize,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.timer, size: 16, color: primaryOrange),
                    const SizedBox(width: 4),
                    Text(
                      offer.availability,
                      style: GoogleFonts.montserrat(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, size: 16, color: primaryOrange),
                    const SizedBox(width: 4),
                    Text(
                      offer.rating.toString(),
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // 🔸 Price + Select button
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '₹ ${offer.price.toStringAsFixed(0)}',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w800,
                  fontSize: 17,
                  color: primaryOrange,
                ),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryOrange,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 8,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PaymentScreen()),
                  );
                },
                child: Text(
                  'Select',
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
