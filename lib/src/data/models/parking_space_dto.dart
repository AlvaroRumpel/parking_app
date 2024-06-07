import 'dart:convert';

class ParkingSpaceDTO {
  final String name;
  final bool isOccupied;
  final DateTime? startTime;
  final String? licensePlate;

  ParkingSpaceDTO({
    required this.name,
    required this.isOccupied,
    this.startTime,
    this.licensePlate,
  });
}

class ParkingSpaceToCreateDTO extends ParkingSpaceDTO {
  ParkingSpaceToCreateDTO({
    required super.name,
    super.isOccupied = false,
    super.licensePlate,
    super.startTime,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'isOccupied': isOccupied,
      'licensePlate': licensePlate,
      'startTime': startTime,
    };
  }

  String toJson() => json.encode(toMap());
}

class ParkingSpaceCompleteDTO extends ParkingSpaceDTO {
  final int id;

  ParkingSpaceCompleteDTO({
    required super.name,
    required super.isOccupied,
    super.startTime,
    super.licensePlate,
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'isOccupied': isOccupied,
      'startTime': startTime?.millisecondsSinceEpoch,
      'licensePlate': licensePlate,
    };
  }

  factory ParkingSpaceCompleteDTO.fromMap(Map<String, dynamic> map) {
    return ParkingSpaceCompleteDTO(
      id: map['id']?.toInt(),
      isOccupied: map['isOccupied'],
      name: map['name'],
      startTime: map['startTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['startTime'])
          : null,
      licensePlate: map['licensePlate'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ParkingSpaceCompleteDTO.fromJson(String source) =>
      ParkingSpaceCompleteDTO.fromMap(json.decode(source));

  ParkingSpaceCompleteDTO copyWith({
    String? name,
    bool? isOccupied,
    DateTime? startTime,
    String? licensePlate,
    int? id,
  }) {
    return ParkingSpaceCompleteDTO(
      name: name ?? this.name,
      isOccupied: isOccupied ?? this.isOccupied,
      startTime: startTime ?? this.startTime,
      licensePlate: licensePlate ?? this.licensePlate,
      id: id ?? this.id,
    );
  }
}
