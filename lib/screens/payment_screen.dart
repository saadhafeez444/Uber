import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/screens/change_card.dart';
import 'package:project/screens/offer.dart';
import 'package:project/screens/tracking.dart';

class Offers {
  final String driverName;
  final String truckSize;
  final double price;

  Offers({
    required this.driverName,
    required this.truckSize,
    required this.price,
  });
}

// Payment Screen
class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments;
    Offer? offer;
    if (arg is Offer) offer = arg;

    const primaryOrange = Color(0xFFFF9800);
    final price = offer?.price ?? 5000.0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(186, 255, 184, 77), Color(0xFFFF9800)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(36),
              bottomRight: Radius.circular(36),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12,
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 80),
                  Text(
                    'Payment',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Driver & Price Card
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: primaryOrange.withOpacity(0.3)),
                boxShadow: [
                  BoxShadow(
                    color: primaryOrange.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                leading: CircleAvatar(
                  backgroundColor: primaryOrange,
                  radius: 24,
                  child: const Icon(
                    Icons.local_shipping_outlined,
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  offer?.driverName ?? 'Selected Driver',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  offer != null ? offer.truckSize : 'Truck details',
                  style: GoogleFonts.montserrat(fontSize: 13),
                ),
                trailing: Text(
                  '₹ ${price.toStringAsFixed(0)}',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w800,
                    color: primaryOrange,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Payment Method & Summary Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: primaryOrange.withOpacity(0.3)),
                boxShadow: [
                  BoxShadow(
                    color: primaryOrange.withOpacity(0.08),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment Method',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: primaryOrange.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.credit_card_outlined,
                        color: primaryOrange,
                      ),
                    ),
                    title: Text(
                      'Card •••• 4242',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    subtitle: const Text('Stripe'),
                    trailing: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ChangeCardScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        'Change',
                        style: TextStyle(color: primaryOrange),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Summary',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Base Fare'),
                      Text('₹ ${price.toStringAsFixed(0)}'),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text('Insurance & Service'),
                      Text('₹ 150'),
                    ],
                  ),
                  const Divider(height: 24, thickness: 0.8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        '₹ ${(price + 150).toStringAsFixed(0)}',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w800,
                          color: primaryOrange,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),

            // Pay Now Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromARGB(210, 255, 184, 77),
                      Color(0xFFFF9800), // Darker orange
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(26),
                ),
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.payment, color: Colors.white),
                  label: Text(
                    'Pay Now — ₹ ${(price + 150).toStringAsFixed(0)}',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent, // make it transparent
                    shadowColor: Colors.transparent, // remove shadow
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        title: Row(
                          children: const [
                            Icon(
                              Icons.check_circle_outline,
                              color: Colors.orangeAccent,
                              size: 26,
                            ),
                            SizedBox(width: 8),
                            Text('Payment Successful'),
                          ],
                        ),
                        content: Text(
                          'Your payment was processed successfully',
                          style: GoogleFonts.montserrat(),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'Close',
                              style: TextStyle(color: Colors.orangeAccent),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orangeAccent,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TrackingScreen(),
                                ),
                              );
                            },
                            child: const Text('Track Truck'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
