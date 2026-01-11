import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CircularPercentWidget extends StatelessWidget {
  final String percentText;
  final String label;
  final double percent;
  final List<Color> gradientColors;
  final Color textColor;

  const CircularPercentWidget({
    Key? key,
    required this.percentText,
    required this.label,
    required this.percent,
    required this.gradientColors,
    this.textColor = const Color(0xFFAAAAAB),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircularPercentIndicator(
          radius: 40.0,
          lineWidth: 6.0,
          percent: percent,
          center: Text(
            percentText,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: textColor,
            ),
          ),
          linearGradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          backgroundColor: Colors.grey.shade300,
          circularStrokeCap: CircularStrokeCap.round,
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
      ],
    );
  }
}