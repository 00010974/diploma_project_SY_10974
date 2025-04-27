import 'dart:html' as html;

class PaymeService {
  static void openPayment(double amount) {
    final int amountInTiyins = (amount * 100).toInt();

    const String merchantId = "ВАШ_MERCHANT_ID";

    final successUrl = "https://yourapp.com/payment_success";
    final cancelUrl = "https://yourapp.com/payment_cancel";

    final paymentUrl = Uri.https(
      'checkout.paycom.uz',
      '',
      {
        'merchant': merchantId,
        'amount': amountInTiyins.toString(),
        'account[order_id]': DateTime.now().millisecondsSinceEpoch.toString(),
        'lang': 'ru',
        'callback': successUrl,
        'cancel': cancelUrl,
      },
    ).toString();

    html.window.open(paymentUrl, '_blank');
  }
}
