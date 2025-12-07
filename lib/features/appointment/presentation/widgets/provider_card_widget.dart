import 'package:flutter/material.dart';
import 'package:healthx_patient/configs/custom_theme.dart';
import 'package:healthx_patient/core/constants/app_colors.dart';
import '../../data/models/provider_model.dart';

class ProviderCardWidget extends StatelessWidget {
  final Provider provider;
  final VoidCallback onBookNow;

  const ProviderCardWidget({
    super.key,
    required this.provider,
    required this.onBookNow,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: boxStyle(),
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Provider photo
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                provider.photo,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: AppColors.grey,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.person, size: 40),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            // Provider info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    provider.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    provider.specialty,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Rating and experience
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Colors.amber,
                        size: 18,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${provider.rating}',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        ' (${provider.reviewCount})',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(
                        Icons.badge_rounded,
                        size: 16,
                        color: AppColors.buttonColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${provider.experience}+ Years',
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Location and hospital
                  if (provider.hospital != null)
                    Row(
                      children: [
                        Icon(
                          Icons.local_hospital,
                          size: 14,
                          color: Colors.grey.shade600,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            provider.hospital!,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 12),
                  // Fee and Book button
                  Row(
                    children: [
                      Text(
                        '৳${provider.fee.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.buttonColor,
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        onPressed: onBookNow,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                        ),
                        child: const Text(
                          'Book Now',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
