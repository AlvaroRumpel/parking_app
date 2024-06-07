import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../components/components.dart';
import '../../../core/extensions/extensions.dart';
import '../../blocs/parking_space/parking_space_cubit.dart';
import 'widgets/add_parking_space_bottom_sheet.dart';
import 'widgets/edit_parking_space_bottom_sheet.dart';
import 'widgets/parking_space_widget.dart';
import 'widgets/price_calculated_bottom_sheet.dart';
import 'widgets/settings_bottom_sheet.dart';

class ParkingSpacePage extends StatelessWidget {
  const ParkingSpacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estacionamento'),
        actions: [
          IconButton(
            onPressed: () => showModalBottomSheet(
              context: context,
              builder: (_) => SettingsBottomSheet(
                onSave: context.read<ParkingSpaceCubit>().updatePrice,
                price: context.read<ParkingSpaceCubit>().actualPrice,
              ),
            ),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: BlocListener<ParkingSpaceCubit, ParkingSpaceState>(
        listenWhen: (previous, current) => current is ParkingSpacePrice,
        listener: (context, state) {
          state.maybeWhen(
            price: (price) => showModalBottomSheet(
              context: context,
              builder: (context) => PriceCalculatedBottomSheet(
                price: price.toMoney(),
              ),
            ),
            orElse: () {},
          );
        },
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: BlocBuilder<ParkingSpaceCubit, ParkingSpaceState>(
                  builder: (context, state) {
                    final bloc = context.read<ParkingSpaceCubit>();

                    return state.maybeWhen(
                      data: (spaces) => GridView.builder(
                        itemCount: spaces.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2 / 1,
                          crossAxisSpacing: context.spacing.sp4,
                          mainAxisSpacing: context.spacing.sp4,
                        ),
                        itemBuilder: (context, index) {
                          final item = spaces[index];
                          return ParkingSpaceWidget(
                            parkingSpace: item,
                            index: index,
                            onLongPress: bloc.deleteParkingSpace,
                            onPressed: (parkingSpace) {
                              showModalBottomSheet(
                                context: context,
                                builder: (dialogContext) {
                                  return EditParkingSpaceBottomSheet(
                                    onPressedEdit: (
                                      name,
                                      isOccupied,
                                      licensePlate,
                                    ) {
                                      bloc
                                          .editParkingSpace(
                                            item,
                                            name,
                                            isOccupied,
                                            licensePlate,
                                          )
                                          .then(
                                            (_) => Navigator.pop(dialogContext),
                                          );
                                    },
                                    onPressedRelease: () {
                                      Navigator.pop(dialogContext);
                                      bloc.releaseParkingSpace(item);
                                    },
                                    parkingSpace: parkingSpace,
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                      empty: () => Center(
                        child: Text(
                          'Nenhuma vaga encontrada!',
                          style: context.textHierarchy.h6,
                        ),
                      ),
                      error: (error) => Center(
                        child: Text(error, style: context.textHierarchy.h6),
                      ),
                      orElse: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  },
                ),
              ),
            ),
            CustomButton(
              width: context.width * .6,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(child: Text('Adicionar vaga')),
                  CustomSpace.sp3(),
                  Icon(Icons.add),
                ],
              ),
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (_) => AddParkingSpaceBottomSheet(
                    onPressedAdd: (name, isOccupied, licensePlate) {
                      context
                          .read<ParkingSpaceCubit>()
                          .addParkingSpace(name, isOccupied, licensePlate)
                          .then((e) => Navigator.pop(context));
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
