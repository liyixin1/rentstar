class RegionData {
  final String regionName;
  final List<String> districts;

  RegionData({required this.regionName, required this.districts});

  factory RegionData.fromJson(Map<String, dynamic> json) {
    return RegionData(
      regionName: json.keys.first,
      districts: List<String>.from(json.values.first),
    );
  }
}