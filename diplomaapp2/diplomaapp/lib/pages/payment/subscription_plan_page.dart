import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';
import '../widgets/topbar.dart';
import 'subscription_content.dart';

class SubscriptionPlanPage extends StatelessWidget {
  const SubscriptionPlanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Row(
        children: [
          const Sidebar(selectedMenu: "Payment"),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0), // ✅ Одинаковый паддинг как на Dashboard
              child: Column(
                children: [
                  const TopBar(pageTitle: "Subscription Plan"),
                  const SizedBox(height: 24),
                  Expanded(
                    child: SingleChildScrollView(
                      child: SubscriptionContent(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



// import 'package:flutter/material.dart';
// import '../widgets/sidebar.dart';
// import '../widgets/topbar.dart';
// import '../payment/subscription_plan_page.dart';

// class SubscriptionPlanPage extends StatelessWidget {
//   const SubscriptionPlanPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     bool isMobile = MediaQuery.of(context).size.width < 800;
//     drawer: isMobile ? Sidebar(selectedMenu: "Payment") : null, // на мобилке открывается Drawer

//     return Scaffold(
//       backgroundColor: const Color(0xFFF9F9F9), // Светлый фон для красоты
//       appBar: AppBar(
//         title: const Text('Subscription Plan'),
//         actions: [
//           IconButton(icon: const Icon(Icons.notifications), onPressed: () {}),
//           IconButton(icon: const Icon(Icons.shopping_bag), onPressed: () {}),
//           IconButton(icon: const Icon(Icons.account_circle), onPressed: () {}),
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Planning',
//                 style: Theme.of(context)
//                     .textTheme
//                     .headlineMedium
//                     ?.copyWith(fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 20),
//               GridView.count(
//                 crossAxisCount: 3,
//                 shrinkWrap: true,
//                 mainAxisSpacing: 15,
//                 crossAxisSpacing: 15,
//                 childAspectRatio: 1,
//                 physics: const NeverScrollableScrollPhysics(),
//                 children: [
//                   buildPlanCard("Free", "\$0", Colors.orange, false),
//                   buildPlanCard("Pro", "\$59", Colors.green, true),
//                   buildPlanCard("Expertise", "\$129", Colors.red, false),
//                 ],
//               ),
//               const SizedBox(height: 30),
//               Text(
//                 'Planning Features',
//                 style: Theme.of(context)
//                     .textTheme
//                     .headlineSmall
//                     ?.copyWith(fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 20),
//               DataTable(
//                 columns: const [
//                   DataColumn(label: Text('Features')),
//                   DataColumn(label: Text('Free')),
//                   DataColumn(label: Text('Pro')),
//                   DataColumn(label: Text('Expertise')),
//                 ],
//                 rows: [
//                   buildFeatureRow('Community Forum Participation', true, true, true),
//                   buildFeatureRow('Certification of Completion', true, true, true),
//                   buildFeatureRow('Ad-Free Experience', false, true, true),
//                   buildFeatureRow('Downloadable Resources', false, true, true),
//                   buildFeatureRow('Priority Access to Events', false, false, true),
//                   buildFeatureRow('Personalized Learning Paths', false, false, true),
//                   buildFeatureRow('Advanced Analytics', false, false, true),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildPlanCard(String title, String price, Color color, bool recommended) {
//     return Card(
//       elevation: recommended ? 10 : 3,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Icon(Icons.favorite, color: color),
//                 if (recommended)
//                   Chip(
//                     label: const Text('Recommended'),
//                     backgroundColor: Colors.deepPurple.shade100,
//                   ),
//               ],
//             ),
//             Text(title,
//                 style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//             Text(price, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Colors.deepPurple,
//                 foregroundColor: Colors.white,
//                 minimumSize: const Size.fromHeight(40),
//               ),
//               onPressed: () {},
//               child: const Text('Try for free 7 Days'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   DataRow buildFeatureRow(String feature, bool free, bool pro, bool expertise) {
//     return DataRow(cells: [
//       DataCell(Text(feature)),
//       DataCell(Checkbox(value: free, onChanged: null)),
//       DataCell(Checkbox(value: pro, onChanged: null)),
//       DataCell(Checkbox(value: expertise, onChanged: null)),
//     ]);
//   }
// }
