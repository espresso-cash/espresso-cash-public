enum IdType {
  bvn('BVN', 'BVN'),
  nin('NIN', 'NIN'),
  ninV2('NIN V2', 'NIN_V2'),
  ninSlip('NIN V2', 'NIN_SLIP'),
  driversLicense('Driver\'s License', 'DRIVERS_LICENSE'),
  voterId('Voter ID', 'VOTER_ID');

  const IdType(this.name, this.value);

  final String name;
  final String value;
}
