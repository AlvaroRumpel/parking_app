import 'package:flutter/material.dart';

import '../../../../core/extensions/extensions.dart';
import '../../../../data/models/parking_space_dto.dart';

class ParkingSpaceWidget extends StatelessWidget {
  final ParkingSpaceCompleteDTO parkingSpace;
  final int index;
  final void Function(ParkingSpaceCompleteDTO parkingSpace) onPressed;
  final void Function(ParkingSpaceCompleteDTO parkingSpace) onLongPress;

  const ParkingSpaceWidget({
    super.key,
    required this.parkingSpace,
    required this.index,
    required this.onPressed,
    required this.onLongPress,
  });

  bool get isLeftSide => (index + 1) % 2 == 0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(parkingSpace),
      onLongPress: () => onLongPress(parkingSpace),
      borderRadius: BorderRadius.circular(context.borderRadius.medium),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(context.borderRadius.medium),
          border: Border(
            left: isLeftSide
                ? BorderSide(color: context.colors.secondary)
                : BorderSide.none,
            top: BorderSide(color: context.colors.secondary),
            bottom: BorderSide(color: context.colors.secondary),
            right: !isLeftSide
                ? BorderSide(color: context.colors.secondary)
                : BorderSide.none,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              parkingSpace.name,
              style: context.textHierarchy.subtitle2,
            ),
            Visibility(
              visible: parkingSpace.isOccupied,
              replacement: const Text('Livre'),
              child: Text(
                'Ocupado por\n${parkingSpace.licensePlate}',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
