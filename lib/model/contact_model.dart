// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:objectbox/objectbox.dart';

@Entity()
class ContactModel extends Equatable {
  int id;
  String namePrefix;
  String firstName;
  String middleName;
  String surname;
  String nameSuffix;
  String company;
  String title;
  String phone;
  String email;
  String birthDate;
  String profileUrl;
  bool isFavourite;

  ContactModel(
      {this.id = 0,
      required this.namePrefix,
      required this.firstName,
      required this.middleName,
      required this.surname,
      required this.nameSuffix,
      required this.company,
      required this.title,
      required this.phone,
      required this.email,
      required this.birthDate,
      this.isFavourite = false,
      required this.profileUrl});

  @override
  List<Object?> get props => [
        namePrefix,
        firstName,
        middleName,
        surname,
        nameSuffix,
        company,
        title,
        phone,
        email,
        birthDate,
        profileUrl,
        isFavourite
      ];
}
