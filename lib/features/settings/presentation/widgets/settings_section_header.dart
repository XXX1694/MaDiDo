import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsSectionHeader extends StatelessWidget {
  const SettingsSectionHeader({required this.title, super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        title.toUpperCase(),
        style: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.primary,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
