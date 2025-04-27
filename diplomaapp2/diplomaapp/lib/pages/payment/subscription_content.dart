import 'package:flutter/material.dart';

class SubscriptionContent extends StatelessWidget {
  const SubscriptionContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Planning',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Set payment planning for your customizable dashboard to find out how much spending each month',
                style: TextStyle(color: Colors.grey[600], fontSize: 16),
              ),
              const SizedBox(height: 24),
              GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                mainAxisSpacing: 35,
                crossAxisSpacing: 35,
                childAspectRatio: 0.99,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  buildPlanCard(
                    context,
                    "Free",
                    "\$0 /month",
                    "There are some limitations that make your productive days ineffective",
                    Colors.orange,
                    false,
                    isCurrentPlan: true,
                  ),
                  buildPlanCard(
                    context,
                    "Pro",
                    "\$19 /month",
                    "Enjoy many features that fit for your work space.",
                    Colors.green,
                    true,
                  ),
                  buildPlanCard(
                    context,
                    "Expertise",
                    "\$59 /month",
                    "Enjoy all the features without limitations and boost up your productivity.",
                    Colors.red,
                    false,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'Planning Features',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              DataTable(
                columns: [
                  const DataColumn(label: Text('Features')),
                  DataColumn(
                    label: Row(
                      children: const [
                        Icon(Icons.favorite, color: Colors.orange, size: 18),
                        SizedBox(width: 4),
                        Text('Free'),
                      ],
                    ),
                  ),
                  DataColumn(
                    label: Row(
                      children: const [
                        Icon(Icons.favorite, color: Colors.green, size: 18),
                        SizedBox(width: 4),
                        Text('Pro'),
                      ],
                    ),
                  ),
                  DataColumn(
                    label: Row(
                      children: const [
                        Icon(Icons.favorite, color: Colors.red, size: 18),
                        SizedBox(width: 4),
                        Text('Expertise'),
                      ],
                    ),
                  ),
                ],
                rows: [
                  buildFeatureRow('Community Forum Participation', true, true, true),
                  buildFeatureRow('Certification of Completion', true, true, true),
                  buildFeatureRow('Ad-Free Experience', false, true, true),
                  buildFeatureRow('Downloadable Resources', false, true, true),
                  buildFeatureRow('Priority Access to Events', false, false, true),
                  buildFeatureRow('Personalized Learning Paths', false, false, true),
                  buildFeatureRow('Advanced Analytics', false, false, true),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget buildPlanCard(
    BuildContext context,
    String title,
    String price,
    String description,
    Color color,
    bool recommended, {
    bool isCurrentPlan = false,
  }) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.favorite, color: color),
                if (recommended)
                  Chip(
                    label: const Text('Recommended'),
                    backgroundColor: Colors.deepPurple.shade100,
                  ),
              ],
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            const SizedBox(height: 16),
            Text(
              price,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isCurrentPlan ? Colors.grey[300] : Colors.deepPurple,
                  foregroundColor: isCurrentPlan ? Colors.black : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  minimumSize: const Size(0, 45),
                ),
                onPressed: isCurrentPlan ? null : () {},
                child: Text(
                  isCurrentPlan ? 'Your current plan' : 'Try for free 7 Days',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DataRow buildFeatureRow(String feature, bool free, bool pro, bool expertise) {
    return DataRow(cells: [
      DataCell(Text(feature)),
      DataCell(Checkbox(value: free, onChanged: null)),
      DataCell(Checkbox(value: pro, onChanged: null)),
      DataCell(Checkbox(value: expertise, onChanged: null)),
    ]);
  }
}
