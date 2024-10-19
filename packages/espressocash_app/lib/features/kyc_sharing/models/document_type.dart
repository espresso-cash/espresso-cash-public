enum DocumentType {
  bvn('BVN', 'BVN'),
  nin('NIN', 'NIN'),
  ninV2('NIN V2', 'NIN_V2'),
  ninSlip('NIN SLIP', 'NIN_SLIP'),
  driversLicense('Driver\'s License', 'DRIVERS_LICENSE'),
  voterId('Voter ID', 'VOTER_ID');

  const DocumentType(this.name, this.value);

  final String name;
  final String value;
}
