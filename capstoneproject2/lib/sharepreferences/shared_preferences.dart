import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart  ';
import 'package:flutter/material.dart';

class SPref{
  SPref._internal();
  static final SPref instance = SPref._internal();
  Future set(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    print("key: ${key} , value: ${value}");
    return prefs.setString(key, value);
  }

  dynamic get(String key) async {
    final prefs = await SharedPreferences.getInstance();
    print("dadadada  ${prefs.get(key)}");
    return prefs.get(key);
  }

  dynamic getOrDefault(String key, Object defaultValue) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.get(key) ?? defaultValue;
  }

}