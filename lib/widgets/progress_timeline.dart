import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProgressTimeline extends StatelessWidget {
  const ProgressTimeline();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        _StepCircle(isDone: true, label: 'Request'),
        _TimelineLine(isDone: true),
        _StepCircle(isDone: true, label: 'Offer'),
        _TimelineLine(isDone: true),
        _StepCircle(isDone: true, label: 'En Route'),
        _TimelineLine(isDone: false),
        _StepCircle(isDone: false, label: 'Completed'),
      ],
    );
  }
}

class _StepCircle extends StatelessWidget {
  final bool isDone;
  final String label;
  const _StepCircle({required this.isDone, required this.label});

  @override
  Widget build(BuildContext context) {
    const primaryOrange = Color(0xFFFF9800);
    return Column(
      children: [
        CircleAvatar(
          radius: 13,
          backgroundColor: isDone ? primaryOrange : Colors.grey.shade300,
          child: Icon(
            Icons.check,
            size: 14,
            color: isDone ? Colors.white : Colors.grey.shade400,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: GoogleFonts.montserrat(
            fontSize: 12,
            fontWeight: isDone ? FontWeight.bold : FontWeight.w500,
            color: isDone ? primaryOrange : Colors.black45,
          ),
        ),
      ],
    );
  }
}

class _TimelineLine extends StatelessWidget {
  final bool isDone;
  const _TimelineLine({required this.isDone});

  @override
  Widget build(BuildContext context) {
    const primaryOrange = Color(0xFFFF9800);
    return Container(
      height: 2,
      width: 36,
      color: isDone ? primaryOrange : Colors.grey.shade300,
    );
  }
}
