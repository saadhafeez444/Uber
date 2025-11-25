import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/widgets/offer_card.dart';

class Offer {
  final String driverName;
  final double price;
  final double rating;
  final String availability;
  final String truckSize;

  Offer({
    required this.driverName,
    required this.price,
    required this.rating,
    required this.availability,
    required this.truckSize,
  });
}

final mockOffers = [
  Offer(
    driverName: 'Ravi Kumar',
    price: 4200.0,
    rating: 4.8,
    availability: 'Available now',
    truckSize: '6 ton',
  ),
  Offer(
    driverName: 'Ayesha Patel',
    price: 4800.0,
    rating: 4.5,
    availability: 'In 20 min',
    truckSize: '3 ton',
  ),
  Offer(
    driverName: 'S. Verma',
    price: 5100.0,
    rating: 4.9,
    availability: 'Available now',
    truckSize: '10 ton',
  ),
];

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen> {
  List<Offer> filteredOffers = List.from(mockOffers);
  String selectedFilter = 'None';
  static const primaryOrange = Color(0xFFFF9800);

  void showFilterDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Filter Offers",
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: primaryOrange,
                ),
              ),
              const SizedBox(height: 16),
              _filterOption("Price: Low to High", () {
                setState(() {
                  filteredOffers.sort((a, b) => a.price.compareTo(b.price));
                  selectedFilter = "Price: Low to High";
                });
                Navigator.pop(context);
              }),
              _filterOption("Price: High to Low", () {
                setState(() {
                  filteredOffers.sort((a, b) => b.price.compareTo(a.price));
                  selectedFilter = "Price: High to Low";
                });
                Navigator.pop(context);
              }),
              _filterOption("Rating: High to Low", () {
                setState(() {
                  filteredOffers.sort((a, b) => b.rating.compareTo(a.rating));
                  selectedFilter = "Rating: High to Low";
                });
                Navigator.pop(context);
              }),
              _filterOption("Clear Filter", () {
                setState(() {
                  filteredOffers = List.from(mockOffers);
                  selectedFilter = "None";
                });
                Navigator.pop(context);
              }),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  Widget _filterOption(String title, VoidCallback onTap) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: GoogleFonts.montserrat(
          color: Colors.black,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.chevron_right, color: primaryOrange),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(110),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(210, 255, 184, 77), Color(0xFFFF9800)],
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
                vertical: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Compare Offers',
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: showFilterDialog,
                    icon: const Icon(
                      Icons.filter_list,
                      color: Colors.white,
                      size: 18,
                    ),
                    label: Text(
                      'Filter',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white, width: 1.3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (selectedFilter != 'None')
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: primaryOrange.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Filtered by: $selectedFilter',
                  style: GoogleFonts.montserrat(
                    color: primaryOrange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            Expanded(
              child: ListView.separated(
                itemCount: filteredOffers.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, i) {
                  final o = filteredOffers[i];
                  return OfferCard(offer: o);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
