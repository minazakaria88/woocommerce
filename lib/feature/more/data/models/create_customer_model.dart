import 'package:khoyout/feature/cart/data/models/create_order_model.dart';

class CreateCustomerModel {
  late final String email;
  late final String firstName;
  late final String lastName;
  late final Billing billing;
  late final Shipping shipping;
  int ?id;
  late final String password;

  CreateCustomerModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    id=json['id'];
    billing = Billing.fromJson(json['billing']);
    shipping = Shipping.fromJson(json['shipping']);
  }

  CreateCustomerModel(
      {required this.email,
      required this.firstName,
      required this.lastName,
      required this.billing,
        required this.password,
      required this.shipping});

  Map<String,dynamic> toJson() {
    Map<String, dynamic> data = {};
    data['email'] = email;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['billing'] = billing;
    data['shipping'] = shipping;
    data['role']='customer';
    return data;
  }
}
