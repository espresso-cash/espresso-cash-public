enum IdType { driversLicense, voterId }

extension IdTypeExtension on IdType {
  String get name {
    switch (this) {
      case IdType.driversLicense:
        return 'Driver\'s License';
      case IdType.voterId:
        return 'Voter ID';
    }
  }

  String get value {
    switch (this) {
      case IdType.driversLicense:
        return 'DRIVERS_LICENSE';
      case IdType.voterId:
        return 'VOTER_ID';
    }
  }
}
