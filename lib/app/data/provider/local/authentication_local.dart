

import 'dart:convert';
import 'package:get/get.dart';

import 'package:cubanfood_mobile_flutter/app/data/model/Customer.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthenticationLocal {

  static const SESSION = 'session';

  final FlutterSecureStorage _storage = Get.find<FlutterSecureStorage>();

  Future<void> setSession(Customer customer) async {
    await _storage.write(key: SESSION, value: jsonEncode(customer.toJson()));
  }

  Future<Customer> getSession() async {
    final String data = await _storage.read(key: SESSION);
    if(data != null){
      final Customer customer = Customer.fromJson(jsonDecode(data));
      if(DateTime.now().isBefore(customer.expirationAt)){
        return customer;
      }
      return null;
    }
    return null;
  }

  Future<String> getToken() async {
    final String data = await _storage.read(key: SESSION);
    if(data != null){
      final Customer customer = Customer.fromJson(jsonDecode(data));
      if(DateTime.now().isBefore(customer.expirationAt)){
        return customer.token;
      }
      return '';
    }
    return '';
  }
  
}