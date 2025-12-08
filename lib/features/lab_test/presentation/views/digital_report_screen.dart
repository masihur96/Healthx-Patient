import 'package:flutter/material.dart';
import 'package:healthx_patient/core/constants/app_colors.dart';

class DigitalReportScreen extends StatelessWidget {
  const DigitalReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final reports = [
      {'name': 'CBC', 'date': '12 Nov 2025', 'status': 'Available'},
      {'name': 'Lipid Profile', 'date': '08 Nov 2025', 'status': 'Pending'},
      {'name': 'Thyroid Profile', 'date': '02 Nov 2025', 'status': 'Available'},
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text('Digital Reports'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_outlined)),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: reports.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final r = reports[index];
          final available = r['status'] == 'Available';
          return Material(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
            child: ListTile(
              title: Text(r['name']!),
              subtitle: Text('${r['date']}  •  ${r['status']}'),
              trailing: Wrap(
                spacing: 8,
                children: [
                  if (available)
                    IconButton(
                      tooltip: 'Download PDF',
                      icon: const Icon(Icons.download_outlined),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Downloading...')));
                      },
                    ),
                  IconButton(
                    tooltip: 'Share with Doctor',
                    icon: const Icon(Icons.share_outlined),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Sharing...')));
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
