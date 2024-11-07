import 'package:khoyout/feature/cart/data/models/create_order_model.dart';

class OrderModel
{
  late final int id;
  late final String currency;
  late final String status;
  late final String  total;
  late final Billing billing;
  late final Shipping shipping;
  late final List<LineItems> lineItems;
  late final String paymentURl;
  late final int customerId;

  OrderModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    currency = json['currency'];
    status = json['status'];
    total = json['total'];
    customerId = json['customer_id'];
    billing = Billing.fromJson(json['billing']);
    shipping = Shipping.fromJson(json['shipping']);
    paymentURl = json['payment_url'];
    if(json['line_items'] != null)
    {
      lineItems = [];
      json['line_items'].forEach((v) {
        lineItems.add(LineItems.fromJson(v));
      });
    }
  }


  Map<String, dynamic> toJson()
  {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['currency'] = currency;
    data['status'] = status;
    data['total'] = total;
    return data;
  }
}