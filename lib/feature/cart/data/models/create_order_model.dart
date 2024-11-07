class CreateOrderModel {
  late final String paymentMethodTitle;
  late final String paymentMethod;
  late final Billing billing;
  late final Shipping shipping;
  late final String email;
  late final List<LineItems> lineItems;
  late final bool setPaid;
  late final int? customerId;
  CreateOrderModel(
      {required this.paymentMethodTitle,
      required this.billing,
      required this.shipping,
      required this.lineItems,
      required this.setPaid,
      required this.email,
      required this.paymentMethod,
      this.customerId});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['payment_method_title'] = paymentMethodTitle;
    data['billing'] = billing;
    data['email'] = email;
    data['shipping'] = shipping;
    data['currency'] = 'EGP';
    data['line_items'] = lineItems;
    data['set_paid'] = setPaid;
    data['payment_method'] = paymentMethod;
    if (customerId != null) {
      data['customer_id'] = customerId;
    }
    return data;
  }

  CreateOrderModel.fromJson(Map<String, dynamic> json) {
    paymentMethodTitle = json['payment_method_title'];
    billing = json['billing'];
    email = json['email'];
    shipping = json['shipping'];
    lineItems = json['line_items'];
  }
}

class Billing {
  late final String firstName;
  late final String lastName;
  late final String city;
  late final String address;
  late final String postalCode;
  late final String phone;
  Billing(
      {required this.firstName,
      required this.lastName,
      required this.city,
      required this.address,
      required this.postalCode,
      required this.phone});

  Billing.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    city = json['city'];
    address = json['address_1'];
    postalCode = json['postcode'];
    phone = json['phone'];
  }

  Map toJson() {
    Map data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['city'] = city;
    data['address_1'] = address;
    data['postcode'] = postalCode;
    data['phone'] = phone;
    return data;
  }
}

class Shipping {
  late final String firstName;
  late final String lastName;
  late final String city;
  late final String address;
  late final String postalCode;
  late final String phone;
  Shipping(
      {required this.firstName,
      required this.lastName,
      required this.city,
      required this.address,
      required this.postalCode,
      required this.phone});

  Shipping.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    city = json['city'];
    address = json['address_1'];
    postalCode = json['postcode'];
    phone = json['phone'];
  }

  Map toJson() {
    Map data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['city'] = city;
    data['address_1'] = address;
    data['postcode'] = postalCode;
    data['phone'] = phone;
    return data;
  }
}

class LineItems {
  late final int quantity;
  late final int productId;
  late final int variationId;
  LineItems(
      {required this.quantity,
      required this.productId,
      required this.variationId});

  LineItems.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    productId = json['product_id'];
    variationId = json['variation_id'];
  }

  Map toJson() {
    Map data = <String, dynamic>{};
    data['quantity'] = quantity;
    data['product_id'] = productId;
    if (variationId != 0) {
      data['variation_id'] = variationId;
    }
    return data;
  }
}
