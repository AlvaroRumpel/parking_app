import 'package:flutter/material.dart';

import '../../../../components/components.dart';
import '../../../../core/extensions/extensions.dart';
import '../../../../core/utils/validation.dart';
import '../../../../data/models/parking_space_dto.dart';

class EditParkingSpaceBottomSheet extends StatefulWidget {
  final void Function(
    String name,
    bool isOccupied,
    String? licensePlate,
  ) onPressedEdit;

  final void Function() onPressedRelease;
  final ParkingSpaceCompleteDTO parkingSpace;

  const EditParkingSpaceBottomSheet({
    super.key,
    required this.onPressedEdit,
    required this.parkingSpace,
    required this.onPressedRelease,
  });

  @override
  State<EditParkingSpaceBottomSheet> createState() =>
      _EditParkingSpaceBottomSheetState();
}

class _EditParkingSpaceBottomSheetState
    extends State<EditParkingSpaceBottomSheet> {
  final _nameEC = TextEditingController();
  final _licensePlateEC = TextEditingController();
  var _isOccupied = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _nameEC.text = widget.parkingSpace.name;
    _licensePlateEC.text = widget.parkingSpace.licensePlate ?? '';
    _isOccupied = widget.parkingSpace.isOccupied;

    super.initState();
  }

  @override
  void dispose() {
    _nameEC.dispose();
    _licensePlateEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(context.borderRadius.large),
      ),
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Editar vaga',
                style: context.textHierarchy.h6,
              ),
              const CustomSpace.sp2(),
              CustomTextField(
                controller: _nameEC,
                hintText: 'Insira o nome da vaga',
                labelText: 'Nome da vaga',
                validators: [Required()],
              ),
              const CustomSpace.sp2(),
              InkWell(
                onTap: () {
                  setState(() {
                    _isOccupied = !_isOccupied;
                  });
                },
                borderRadius:
                    BorderRadius.circular(context.borderRadius.medium),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Está vaga está ocupada?',
                        style: context.textHierarchy.body1,
                      ),
                      IgnorePointer(
                        child: Switch(
                          value: _isOccupied,
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: _isOccupied,
                child: Column(
                  children: [
                    const CustomSpace.sp2(),
                    CustomTextField(
                      controller: _licensePlateEC,
                      hintText: 'Insira a placa do veiculo',
                      labelText: 'Placa do veiculo',
                      validators: [Required(), LicensePlate()],
                    ),
                  ],
                ),
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
                      onPressed: validationOnPressed,
                      child: const Text('Salvar'),
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: widget.parkingSpace.isOccupied,
                child: CustomButton.outlined(
                  onPressed: widget.onPressedRelease,
                  child: const Text('Liberar Vaga'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void validationOnPressed() {
    if ((_formKey.currentState?.validate() ?? false)) {
      widget.onPressedEdit(_nameEC.text, _isOccupied, _licensePlateEC.text);
    }
  }
}
