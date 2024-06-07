class ParkingSpace {
  final int id;
  final String name;
  final bool isOccupied;
  final DateTime? startTime;
  final String? licensePlate;

  ParkingSpace({
    required this.id,
    required this.name,
    required this.isOccupied,
    this.startTime,
    this.licensePlate,
  });

  ParkingSpace copyWith({
    int? id,
    String? name,
    bool? isOccupied,
    DateTime? startTime,
    String? licensePlate,
  }) {
    return ParkingSpace(
      id: id ?? this.id,
      name: name ?? this.name,
      isOccupied: isOccupied ?? this.isOccupied,
      startTime: startTime ?? this.startTime,
      licensePlate: licensePlate ?? this.licensePlate,
    );
  }

  ParkingSpace copyWithReleaseSpace({
    int? id,
    String? name,
    bool? isOccupied,
  }) {
    return ParkingSpace(
      id: id ?? this.id,
      name: name ?? this.name,
      isOccupied: isOccupied ?? this.isOccupied,
      startTime: null,
      licensePlate: null,
    );
  }
}
