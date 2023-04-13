import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../values/colors.dart';

class BlockHeader extends StatelessWidget {
  final double? width;
  final String? title;
  final String? linkText;
  final VoidCallback? onLinkTap;
  const BlockHeader({this.width, this.title, this.linkText, this.onLinkTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            title!,
            style: GoogleFonts.tajawal(
                textStyle:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ),
          const Spacer(),
          Row(
            children: [
              GestureDetector(
                onTap: onLinkTap,
                child: Text(
                  linkText!,
                  style: GoogleFonts.tajawal(
                      textStyle: const TextStyle(color: Colors.black)),
                ),
              ),
              const SizedBox(
                width: 5,
              ),
              CircleAvatar(
                radius: 15,
                backgroundColor: samaColor,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 15,
                  ),
                  onPressed: onLinkTap,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
