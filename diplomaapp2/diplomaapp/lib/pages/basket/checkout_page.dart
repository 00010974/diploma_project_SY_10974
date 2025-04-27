
// import 'package:flutter/material.dart';
// import '../widgets/sidebar.dart';
// import '../widgets/topbar.dart';

// class CheckoutPage extends StatefulWidget {
//   final Map<String, dynamic> course;

//   const CheckoutPage({super.key, required this.course});

//   @override
//   State<CheckoutPage> createState() => _CheckoutPageState();
// }

// class _CheckoutPageState extends State<CheckoutPage> {
//   int selectedPaymentIndex = 0;
//   final promoCodeController = TextEditingController();

//   double getDiscountedPrice(double price) {
//     double discount = price * 0.6;
//     double serviceFee = (price - discount) * 0.03;
//     return price - discount + serviceFee;
//   }

//   @override
//   Widget build(BuildContext context) {
//     final coursePrice = (widget.course['price'] ?? 0) as double;

//     return Scaffold(
//       body: Row(
//         children: [
//           const Sidebar(selectedMenu: "Discover"),
//           Expanded(
//             child: Column(
//               children: [
//                 const TopBar(pageTitle: 'Checkout'),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.all(24),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // LEFT SIDE: Payment
//                         Expanded(
//                           flex: 2,
//                           child: SingleChildScrollView(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text(
//                                   'Payment Method',
//                                   style: TextStyle(
//                                       fontSize: 22,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 const SizedBox(height: 24),
//                                 _buildPaymentOption('Credit/Debit Card', 0),
//                                 _buildPaymentOption('Paypal', 1),
//                                 _buildPaymentOption('Gopay', 2),
//                                 _buildPaymentOption('OVO', 3),
//                                 _buildPaymentOption('Mandiri', 4),
//                                 _buildPaymentOption('Link Aja', 5),
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 24),
//                         // RIGHT SIDE: Order Summary
//                         Expanded(
//                           flex: 1,
//                           child: Container(
//                             padding: const EdgeInsets.all(16),
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(16),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Colors.grey.withOpacity(0.1),
//                                   spreadRadius: 4,
//                                   blurRadius: 8,
//                                 ),
//                               ],
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 _buildOrderItem(widget.course),
//                                 const SizedBox(height: 16),
//                                 _buildPromoField(),
//                                 const SizedBox(height: 8),
//                                 const Text(
//                                   'You saved 60% on this purchase, Hooray!',
//                                   style: TextStyle(color: Colors.purple),
//                                 ),
//                                 const SizedBox(height: 16),
//                                 _buildPriceSummary(coursePrice),
//                                 const SizedBox(height: 16),
//                                 ElevatedButton(
//                                   onPressed: () {},
//                                   style: ElevatedButton.styleFrom(
//                                     backgroundColor: const Color(0xFF6A5AE0),
//                                     minimumSize: const Size(double.infinity, 48),
//                                     shape: RoundedRectangleBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(12)),
//                                   ),
//                                   child: const Text('Pay', style: TextStyle(fontSize: 18)),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       backgroundColor: const Color(0xFFF9F9F9),
//     );
//   }

//   Widget _buildPaymentOption(String name, int index) {
//     bool selected = selectedPaymentIndex == index;
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedPaymentIndex = index;
//         });
//       },
//       child: Container(
//         margin: const EdgeInsets.only(bottom: 16),
//         padding: const EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: selected ? const Color(0xFF6A5AE0) : Colors.white,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//               color: selected ? const Color(0xFF6A5AE0) : Colors.grey.shade300),
//         ),
//         child: Row(
//           children: [
//             Icon(
//               selected ? Icons.radio_button_checked : Icons.radio_button_off,
//               color: selected ? Colors.white : Colors.grey,
//             ),
//             const SizedBox(width: 12),
//             Text(
//               name,
//               style: TextStyle(
//                 fontSize: 16,
//                 color: selected ? Colors.white : Colors.black,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildOrderItem(Map<String, dynamic> course) {
//     return Row(
//       children: [
//         ClipRRect(
//           borderRadius: BorderRadius.circular(8),
//           child: Image.network(
//             course['thumbnail_url'] ?? '',
//             height: 60,
//             width: 60,
//             fit: BoxFit.cover,
//           ),
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 course['title'] ?? 'Course Title',
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 4),
//               Text(
//                 "\$${(course['price'] ?? 0).toString()}",
//                 style: const TextStyle(color: Color(0xFF6A5AE0)),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildPromoField() {
//     return TextField(
//       controller: promoCodeController,
//       decoration: InputDecoration(
//         hintText: 'Enter promo code',
//         suffixIcon: IconButton(
//           icon: const Icon(Icons.check_circle_outline),
//           onPressed: () {},
//         ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       ),
//     );
//   }

//   Widget _buildPriceSummary(double price) {
//     double discount = price * 0.6;
//     double serviceFee = (price - discount) * 0.03;
//     double total = price - discount + serviceFee;

//     return Column(
//       children: [
//         _summaryRow('Sub Total', "\$${price.toStringAsFixed(2)}"),
//         _summaryRow('Discount (60%)', "-\$${discount.toStringAsFixed(2)}", color: Colors.green),
//         _summaryRow('Service Fee (3%)', "\$${serviceFee.toStringAsFixed(2)}"),
//         const Divider(height: 24),
//         _summaryRow('Total', "\$${total.toStringAsFixed(2)}", isTotal: true),
//       ],
//     );
//   }

//   Widget _summaryRow(String title, String value, {bool isTotal = false, Color? color}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 4),
//       child: Row(
//         children: [
//           Text(title,
//               style: TextStyle(
//                 color: color ?? Colors.black54,
//                 fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
//               )),
//           const Spacer(),
//           Text(value,
//               style: TextStyle(
//                 fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
//                 color: color ?? Colors.black,
//                 fontSize: isTotal ? 18 : 14,
//               )),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import '../widgets/sidebar.dart';
import '../widgets/topbar.dart';

class CheckoutPage extends StatefulWidget {
  final Map<String, dynamic> course;

  const CheckoutPage({super.key, required this.course});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  int selectedPaymentIndex = 0;
  final promoCodeController = TextEditingController();
  final nameController = TextEditingController(text: "Peter Parker");
  final cardNumberController = TextEditingController(text: "1234 5678 9012 1345");
  final expiryController = TextEditingController(text: "08/29");
  final cvcController = TextEditingController(text: "123");

  double getDiscountedPrice(double price) {
    double discount = price * 0.6;
    double serviceFee = (price - discount) * 0.03;
    return price - discount + serviceFee;
  }

  @override
  Widget build(BuildContext context) {
    final coursePrice = (widget.course['price'] ?? 0) as double;

    return Scaffold(
      body: Row(
        children: [
          const Sidebar(selectedMenu: "Discover"),
          Expanded(
            child: Column(
              children: [
                const TopBar(pageTitle: 'Checkout'),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // LEFT SIDE: Payment
                        Expanded(
                          flex: 2,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Payment Method',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 24),
                                _buildPaymentOption('Credit/Debit Card', 0),
                                if (selectedPaymentIndex == 0)
                                  _buildCreditCardForm(),
                                _buildPaymentOption('Paypal', 1),
                                _buildPaymentOption('Gopay', 2),
                                _buildPaymentOption('OVO', 3),
                                _buildPaymentOption('Mandiri', 4),
                                _buildPaymentOption('Link Aja', 5),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 24),
                        // RIGHT SIDE: Order Summary
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 4,
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildOrderItem(widget.course),
                                const SizedBox(height: 16),
                                _buildPromoField(),
                                const SizedBox(height: 8),
                                const Text(
                                  'You saved 60% on this purchase, Hooray!',
                                  style: TextStyle(color: Colors.purple),
                                ),
                                const SizedBox(height: 16),
                                _buildPriceSummary(coursePrice),
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    _showSuccessDialog();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF6A5AE0),
                                    minimumSize: const Size(double.infinity, 48),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                  ),
                                  child: const Text('Pay', style: TextStyle(fontSize: 18)),
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
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF9F9F9),
    );
  }

  Widget _buildPaymentOption(String name, int index) {
    bool selected = selectedPaymentIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentIndex = index;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF6A5AE0) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: selected ? const Color(0xFF6A5AE0) : Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: selected ? Colors.white : Colors.grey,
            ),
            const SizedBox(width: 12),
            Text(
              name,
              style: TextStyle(
                fontSize: 16,
                color: selected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreditCardForm() {
    return Column(
      children: [
        const SizedBox(height: 16),
        _textField('Name on Card', nameController),
        const SizedBox(height: 12),
        _textField('Card Number', cardNumberController),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _textField('Expiry Date', expiryController)),
            const SizedBox(width: 12),
            Expanded(child: _textField('CVC/CVV', cvcController)),
          ],
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _textField(String hint, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget _buildOrderItem(Map<String, dynamic> course) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            course['thumbnail_url'] ?? '',
            height: 60,
            width: 60,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                course['title'] ?? 'Course Title',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                "\$${(course['price'] ?? 0).toString()}",
                style: const TextStyle(color: Color(0xFF6A5AE0)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPromoField() {
    return TextField(
      controller: promoCodeController,
      decoration: InputDecoration(
        hintText: 'Enter promo code',
        suffixIcon: IconButton(
          icon: const Icon(Icons.check_circle_outline),
          onPressed: () {},
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  Widget _buildPriceSummary(double price) {
    double discount = price * 0.6;
    double serviceFee = (price - discount) * 0.03;
    double total = price - discount + serviceFee;

    return Column(
      children: [
        _summaryRow('Sub Total', "\$${price.toStringAsFixed(2)}"),
        _summaryRow('Discount (60%)', "-\$${discount.toStringAsFixed(2)}", color: Colors.green),
        _summaryRow('Service Fee (3%)', "\$${serviceFee.toStringAsFixed(2)}"),
        const Divider(height: 24),
        _summaryRow('Total', "\$${total.toStringAsFixed(2)}", isTotal: true),
      ],
    );
  }

  Widget _summaryRow(String title, String value, {bool isTotal = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(title,
              style: TextStyle(
                color: color ?? Colors.black54,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              )),
          const Spacer(),
          Text(value,
              style: TextStyle(
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                color: color ?? Colors.black,
                fontSize: isTotal ? 18 : 14,
              )),
        ],
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Payment Successful!'),
        content: const Text('Thank you for your purchase.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
