import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';
import '../widgets/topbar.dart';
import '../../services/payme_service.dart';


class BasketPage extends StatefulWidget {
  const BasketPage({super.key});

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
  List<BasketItem> basketItems = [
    BasketItem(title: "Master Class: React JS and Tailwind CSS", price: 59.5),
    BasketItem(title: "Learn from Basic: React Javascript", price: 75),
    BasketItem(title: "Full-Stack Laravel Streaming Website", price: 30),
    BasketItem(title: "Web Security for Penetration Tester", price: 45.5),
    BasketItem(title: "Figma Freelancer Bootcamp", price: 63.7),
  ];

  double get subtotal => basketItems
      .where((item) => item.selected)
      .fold(0, (sum, item) => sum + item.price);

  double get serviceFee => subtotal * 0.03;

  double get total => subtotal + serviceFee;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: Row(
        children: [
          const Sidebar(selectedMenu: ""),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const TopBar(pageTitle: "Basket"),
                  const SizedBox(height: 24),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Basket Summary',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    basketItems.clear();
                                  });
                                },
                                child: const Text('Remove All'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Expanded(
                            child: ListView(
                              children: basketItems.map((item) => basketItem(item)).toList(),
                            ),
                          ),
                          const Divider(),
                          const SizedBox(height: 16),
                          rowText("Sub Total", "\$${subtotal.toStringAsFixed(2)}"),
                          const SizedBox(height: 8),
                          rowText("Service Fee (3%)", "\$${serviceFee.toStringAsFixed(2)}"),
                          const SizedBox(height: 16),
                          rowText(
                            "Total",
                            "\$${total.toStringAsFixed(2)}",
                            isBold: true,
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: 300,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 16),
                              ),
                              onPressed: subtotal > 0
                                  ? () {
                                    PaymeService.openPayment(total);
                                  }
                                : null,
                              child: const Text(
                                'Continue to Payment Method',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
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

  Widget basketItem(BasketItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Checkbox(
            value: item.selected,
            onChanged: (value) {
              setState(() {
                item.selected = value ?? false;
              });
            },
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.title,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                const Text(
                  "IT & Software • 16 Modules • 41 Videos",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
          Text("\$${item.price.toStringAsFixed(1)}"),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: () {
              setState(() {
                basketItems.remove(item);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget rowText(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}

class BasketItem {
  final String title;
  final double price;
  bool selected;

  BasketItem({
    required this.title,
    required this.price,
    this.selected = true,
  });
}
