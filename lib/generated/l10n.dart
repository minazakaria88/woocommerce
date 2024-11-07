// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Home`
  String get Home {
    return Intl.message(
      'Home',
      name: 'Home',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get Search {
    return Intl.message(
      'Search',
      name: 'Search',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get Cart {
    return Intl.message(
      'Cart',
      name: 'Cart',
      desc: '',
      args: [],
    );
  }

  /// `Pay`
  String get Pay {
    return Intl.message(
      'Pay',
      name: 'Pay',
      desc: '',
      args: [],
    );
  }

  /// `More`
  String get More {
    return Intl.message(
      'More',
      name: 'More',
      desc: '',
      args: [],
    );
  }

  /// `Checkout`
  String get checkOut {
    return Intl.message(
      'Checkout',
      name: 'checkOut',
      desc: '',
      args: [],
    );
  }

  /// `Your Cart is empty`
  String get cartIsEmpty {
    return Intl.message(
      'Your Cart is empty',
      name: 'cartIsEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Products`
  String get products {
    return Intl.message(
      'Products',
      name: 'products',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: '',
      args: [],
    );
  }

  /// `Successfully added to cart`
  String get SuccessfullyAddedToCart {
    return Intl.message(
      'Successfully added to cart',
      name: 'SuccessfullyAddedToCart',
      desc: '',
      args: [],
    );
  }

  /// `Billing Details`
  String get BillingDetails {
    return Intl.message(
      'Billing Details',
      name: 'BillingDetails',
      desc: '',
      args: [],
    );
  }

  /// `First name`
  String get firstname {
    return Intl.message(
      'First name',
      name: 'firstname',
      desc: '',
      args: [],
    );
  }

  /// `first name must not be empty`
  String get firstNameMustNotBeEmpty {
    return Intl.message(
      'first name must not be empty',
      name: 'firstNameMustNotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Last name`
  String get lastname {
    return Intl.message(
      'Last name',
      name: 'lastname',
      desc: '',
      args: [],
    );
  }

  /// `first name must not be empty`
  String get lastNameMustNotBeEmpty {
    return Intl.message(
      'first name must not be empty',
      name: 'lastNameMustNotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Email must not be empty`
  String get emailMustNotBeEmpty {
    return Intl.message(
      'Email must not be empty',
      name: 'emailMustNotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `City`
  String get city {
    return Intl.message(
      'City',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `City must not be empty`
  String get cityMustNotBeEmpty {
    return Intl.message(
      'City must not be empty',
      name: 'cityMustNotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Street Address`
  String get address {
    return Intl.message(
      'Street Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Address must not be empty`
  String get addressMustNotBeEmpty {
    return Intl.message(
      'Address must not be empty',
      name: 'addressMustNotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Zip code`
  String get zipCode {
    return Intl.message(
      'Zip code',
      name: 'zipCode',
      desc: '',
      args: [],
    );
  }

  /// `Zip code must not be empty`
  String get zipCodeMustNotBeEmpty {
    return Intl.message(
      'Zip code must not be empty',
      name: 'zipCodeMustNotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Phone must not be empty`
  String get phoneMustNotBeEmpty {
    return Intl.message(
      'Phone must not be empty',
      name: 'phoneMustNotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country {
    return Intl.message(
      'Country',
      name: 'country',
      desc: '',
      args: [],
    );
  }

  /// `Country must not be empty`
  String get countryMustNotBeEmpty {
    return Intl.message(
      'Country must not be empty',
      name: 'countryMustNotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `State`
  String get state {
    return Intl.message(
      'State',
      name: 'state',
      desc: '',
      args: [],
    );
  }

  /// `State must not be empty`
  String get stateMustNotBeEmpty {
    return Intl.message(
      'State must not be empty',
      name: 'stateMustNotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Payment`
  String get payment {
    return Intl.message(
      'Payment',
      name: 'payment',
      desc: '',
      args: [],
    );
  }

  /// `order success`
  String get orderSuccess {
    return Intl.message(
      'order success',
      name: 'orderSuccess',
      desc: '',
      args: [],
    );
  }

  /// `please try again`
  String get pleaseTryAgain {
    return Intl.message(
      'please try again',
      name: 'pleaseTryAgain',
      desc: '',
      args: [],
    );
  }

  /// `Show all`
  String get ShowAll {
    return Intl.message(
      'Show all',
      name: 'ShowAll',
      desc: '',
      args: [],
    );
  }

  /// `Add To Cart`
  String get AddToCart {
    return Intl.message(
      'Add To Cart',
      name: 'AddToCart',
      desc: '',
      args: [],
    );
  }

  /// `place order`
  String get placeOrder {
    return Intl.message(
      'place order',
      name: 'placeOrder',
      desc: '',
      args: [],
    );
  }

  /// `orders history`
  String get ordersHistory {
    return Intl.message(
      'orders history',
      name: 'ordersHistory',
      desc: '',
      args: [],
    );
  }

  /// `orders`
  String get orders {
    return Intl.message(
      'orders',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  /// `create ِAccount`
  String get createCustomer {
    return Intl.message(
      'create ِAccount',
      name: 'createCustomer',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Password must not be empty`
  String get passwordMustNotBeEmpty {
    return Intl.message(
      'Password must not be empty',
      name: 'passwordMustNotBeEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Logged In Successfully`
  String get LoggedIn {
    return Intl.message(
      'Logged In Successfully',
      name: 'LoggedIn',
      desc: '',
      args: [],
    );
  }

  /// `Some thing went wrong`
  String get Somethingwentwrong {
    return Intl.message(
      'Some thing went wrong',
      name: 'Somethingwentwrong',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get Donthaveanaccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'Donthaveanaccount',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get SignUp {
    return Intl.message(
      'Sign Up',
      name: 'SignUp',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get Login {
    return Intl.message(
      'Login',
      name: 'Login',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure?`
  String get areyousure {
    return Intl.message(
      'Are you sure?',
      name: 'areyousure',
      desc: '',
      args: [],
    );
  }

  /// `Confirm`
  String get confirm {
    return Intl.message(
      'Confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `No Internet Connection`
  String get noInternet {
    return Intl.message(
      'No Internet Connection',
      name: 'noInternet',
      desc: '',
      args: [],
    );
  }

  /// `Please select payment method`
  String get pleaseSelectPaymentMethod {
    return Intl.message(
      'Please select payment method',
      name: 'pleaseSelectPaymentMethod',
      desc: '',
      args: [],
    );
  }

  /// `Orders History`
  String get OrdersHistory {
    return Intl.message(
      'Orders History',
      name: 'OrdersHistory',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get CreateAccount {
    return Intl.message(
      'Create Account',
      name: 'CreateAccount',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get Logout {
    return Intl.message(
      'Logout',
      name: 'Logout',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Email`
  String get InvalidEmail {
    return Intl.message(
      'Invalid Email',
      name: 'InvalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `You are already logged in`
  String get YouArealreadyloggedin {
    return Intl.message(
      'You are already logged in',
      name: 'YouArealreadyloggedin',
      desc: '',
      args: [],
    );
  }

  /// `orders history is empty`
  String get ordershistoryisempty {
    return Intl.message(
      'orders history is empty',
      name: 'ordershistoryisempty',
      desc: '',
      args: [],
    );
  }

  /// `Status`
  String get Status {
    return Intl.message(
      'Status',
      name: 'Status',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get Name {
    return Intl.message(
      'Name',
      name: 'Name',
      desc: '',
      args: [],
    );
  }

  /// `Total`
  String get Total {
    return Intl.message(
      'Total',
      name: 'Total',
      desc: '',
      args: [],
    );
  }

  /// `ID`
  String get ID {
    return Intl.message(
      'ID',
      name: 'ID',
      desc: '',
      args: [],
    );
  }

  /// `Please select variant`
  String get PleaseSelectVariant {
    return Intl.message(
      'Please select variant',
      name: 'PleaseSelectVariant',
      desc: '',
      args: [],
    );
  }

  /// `no products in this Category`
  String get emptyCategory {
    return Intl.message(
      'no products in this Category',
      name: 'emptyCategory',
      desc: '',
      args: [],
    );
  }

  /// `logout Successfully`
  String get logoutSuccessfully {
    return Intl.message(
      'logout Successfully',
      name: 'logoutSuccessfully',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
