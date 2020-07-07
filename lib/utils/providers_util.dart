/**
 * File : providers_util
 * tips :
 * @author : karl.wei
 * @date : 2020-06-29 08:27
 **/

import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../viewModel/homeViewModel.dart';
import '../viewModel/loginViewModel.dart';
import '../viewModel/animationViewModel.dart';

class ProviderUtil {
  static ChangeNotifierProvider<T> _buildProvider<T extends ChangeNotifier>(
      T value) {
    return ChangeNotifierProvider<T>(
      create: (_) => value,
    );
  }

  static List<SingleChildWidget> get providersUtil => _providers;

  static final _providers = [
    _buildProvider<LoginViewModel>(LoginViewModel()),
    _buildProvider<HomeViewModel>(HomeViewModel()),
    _buildProvider<AnimationViewModel>(AnimationViewModel())
  ];
}
