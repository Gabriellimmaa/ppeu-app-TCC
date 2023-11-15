import 'dart:convert';

class HospitalUnitModel {
  String name;
  String surname;
  bool status;
  int id;
  String image;
  int amount;
  final AddressModel address;

  HospitalUnitModel({
    required this.name,
    required this.surname,
    required this.status,
    required this.id,
    required this.address,
    required this.image,
    required this.amount,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'surname': surname,
      'status': status,
      'id': id,
      'image': image,
      'amount': amount,
    };
  }

  factory HospitalUnitModel.fromJson(Map<String, dynamic> json) {
    return HospitalUnitModel(
      name: json['name'],
      surname: json['surname'],
      address: AddressModel.fromJson(json['address']),
      status: json['status'],
      id: json['id'],
      image: json['image'],
      amount: json['amount'],
    );
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }
}

class AddressModel {
  String city;
  String state;
  String number;
  String street;
  String zipCode;
  String complement;

  AddressModel({
    required this.city,
    required this.state,
    required this.number,
    required this.street,
    required this.zipCode,
    required this.complement,
  });

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'state': state,
      'number': number,
      'street': street,
      'zipCode': zipCode,
      'complement': complement,
    };
  }

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      city: json['city'],
      state: json['state'],
      number: json['number'],
      street: json['street'],
      zipCode: json['zipCode'],
      complement: json['complement'],
    );
  }
}
