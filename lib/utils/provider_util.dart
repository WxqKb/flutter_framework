import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProviderUtil {
  static ChangeNotifierProvider<T> _buildProvider<T extends ChangeNotifier>(T value) {
    return ChangeNotifierProvider<T>(create: (_) => value);
  }

  static List<ChangeNotifierProvider> get providersUtil => _providers as List<ChangeNotifierProvider<ChangeNotifier>>;

  static final _providers = [];
}
