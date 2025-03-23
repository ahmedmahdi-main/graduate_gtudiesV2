class Addresses {
  int? addressId;
  int? sPIId;
  String? state;
  String? district;
  String? neighborhood;
  String? mahalla;
  String? alley;
  int? houseNumber;

  Addresses(
      {this.addressId,
        this.sPIId,
        this.state,
        this.district,
        this.neighborhood,
        this.mahalla,
        this.alley,
        this.houseNumber});

  Addresses.fromJson(Map<String, dynamic> json) {
    addressId = json['AddressId'];
    sPIId = json['SPIId'];
    state = json['State'];
    district = json['District'];
    neighborhood = json['Neighborhood'];
    mahalla = json['Mahalla'];
    alley = json['Alley'];
    houseNumber = json['HouseNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AddressId'] = addressId;
    data['SPIId'] = sPIId;
    data['State'] = state;
    data['District'] = district;
    data['Neighborhood'] = neighborhood;
    data['Mahalla'] = mahalla;
    data['Alley'] = alley;
    data['HouseNumber'] = houseNumber;
    return data;
  }
}
