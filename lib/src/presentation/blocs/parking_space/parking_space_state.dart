part of 'parking_space_cubit.dart';

@immutable
sealed class ParkingSpaceState {
  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(List<ParkingSpaceCompleteDTO> parkingSpace) data,
    required T Function() empty,
    required T Function(double price) price,
    required T Function(String message) error,
  }) {
    if (this is ParkingSpaceInitial) {
      return initial();
    } else if (this is ParkingSpaceLoading) {
      return loading();
    } else if (this is ParkingSpaceData) {
      return data((this as ParkingSpaceData).parkingSpace);
    } else if (this is ParkingSpaceEmpty) {
      return empty();
    } else if (this is ParkingSpacePrice) {
      return price((this as ParkingSpacePrice).price);
    } else if (this is ParkingSpaceError) {
      return error((this as ParkingSpaceError).message);
    }
    throw Exception('Unhandled state: $this');
  }

  T maybeWhen<T>({
    T Function()? initial,
    T Function()? loading,
    T Function(List<ParkingSpaceCompleteDTO> parkingSpace)? data,
    T Function()? empty,
    T Function(String message)? error,
    T Function(double price)? price,
    required T Function() orElse,
  }) {
    if (this is ParkingSpaceInitial && initial != null) {
      return initial();
    } else if (this is ParkingSpaceLoading && loading != null) {
      return loading();
    } else if (this is ParkingSpaceData && data != null) {
      return data((this as ParkingSpaceData).parkingSpace);
    } else if (this is ParkingSpaceEmpty && empty != null) {
      return empty();
    } else if (this is ParkingSpacePrice && price != null) {
      return price((this as ParkingSpacePrice).price);
    } else if (this is ParkingSpaceError && error != null) {
      return error((this as ParkingSpaceError).message);
    }
    return orElse();
  }
}

final class ParkingSpaceInitial extends ParkingSpaceState {}

final class ParkingSpaceLoading extends ParkingSpaceState {}

final class ParkingSpaceData extends ParkingSpaceState {
  final List<ParkingSpaceCompleteDTO> parkingSpace;

  ParkingSpaceData({required this.parkingSpace});
}

final class ParkingSpaceEmpty extends ParkingSpaceState {}

final class ParkingSpaceError extends ParkingSpaceState {
  final String message;

  ParkingSpaceError({required this.message});
}

final class ParkingSpacePrice extends ParkingSpaceState {
  final double price;

  ParkingSpacePrice({required this.price});
}
