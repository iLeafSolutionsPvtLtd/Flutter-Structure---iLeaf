import 'package:flutter/material.dart';
import 'package:flutter_structure/l10n/l10n.dart';

class NoInternetPage extends StatelessWidget {
  const NoInternetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.noInternetConnection),
      ),
    );
  }
}
