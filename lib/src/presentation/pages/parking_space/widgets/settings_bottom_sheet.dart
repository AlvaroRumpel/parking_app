import 'package:flutter/material.dart';

import '../../../../components/components.dart';
import '../../../../core/extensions/extensions.dart';

class SettingsBottomSheet extends StatefulWidget {
  final void Function(double value) onSave;
  final double price;
  const SettingsBottomSheet({
    super.key,
    required this.onSave,
    required this.price,
  });

  @override
  State<SettingsBottomSheet> createState() => _SettingsBottomSheetState();
}

class _SettingsBottomSheetState extends State<SettingsBottomSheet> {
  final _priceEC = TextEditingController();

  @override
  void initState() {
    _priceEC.text = widget.price.toMoney();
    super.initState();
  }

  @override
  void dispose() {
    _priceEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.borderRadius.large),
      ),
      child: Column(
        children: [
          Text(
            'Configurar preço',
            style: context.textHierarchy.h6,
          ),
          const CustomSpace.sp2(),
          CustomTextField(
            controller: _priceEC,
            hintText: 'Insira o preço por hora',
            labelText: 'Preço por hora',
          ),
          const CustomSpace.sp2(),
          Row(
            children: [
              Flexible(
                flex: 6,
                child: CustomButton.cancel(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancelar',
                    style: context.textHierarchy.button.copyWith(
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              const CustomSpace.sp2(),
              Flexible(
                flex: 8,
                child: CustomButton(
                  onPressed: () {
                    final newPrice = _priceEC.text.fromMoney();
                    widget.onSave(newPrice);
                  },
                  child: const Text('Salvar'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
