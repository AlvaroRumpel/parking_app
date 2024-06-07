import 'package:flutter/material.dart';

import '../../../../components/components.dart';
import '../../../../core/extensions/extensions.dart';

class PriceCalculatedBottomSheet extends StatelessWidget {
  final String price;
  const PriceCalculatedBottomSheet({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.borderRadius.large),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Valor a ser cobrado pelo estacionamento'),
          const CustomSpace.sp4(),
          Text(
            price,
            style: context.textHierarchy.h4,
          ),
          const CustomSpace.sp4(),
          CustomButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }
}
