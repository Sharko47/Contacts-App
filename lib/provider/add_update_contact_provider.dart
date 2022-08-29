import 'package:contactsassignment/model/contact_model.dart';
import 'package:flutter/material.dart';

class AddOrUpdateContactProvider extends ChangeNotifier {
  bool isNameExpanded = false;
  String selectBirthDate = "";
  String imageUrl = "";
  bool hasSetInitialData = false;
  TextEditingController namePrefixController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController middleNameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController nameSuffixController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  toggleNameUI(bool value) {
    isNameExpanded = value;
    notifyListeners();
  }

  setBirthDate(String date) {
    selectBirthDate = date;
    notifyListeners();
  }

  setImageUrl(String url) {
    imageUrl = url;
    notifyListeners();
  }

  isAllFieldsAreEmpty() {
    return (namePrefixController.text.trim().isEmpty &&
        firstNameController.text.trim().isEmpty &&
        middleNameController.text.trim().isEmpty &&
        surnameController.text.trim().isEmpty &&
        nameSuffixController.text.trim().isEmpty &&
        phoneController.text.trim().isEmpty &&
        emailController.text.trim().isEmpty &&
        companyController.text.trim().isEmpty &&
        titleController.text.trim().isEmpty &&
        selectBirthDate.trim().isEmpty);
  }

  setFormDataForEditing(ContactModel? model) {
    namePrefixController.text = model?.namePrefix ?? "";
    firstNameController.text = model?.firstName ?? "";
    middleNameController.text = model?.middleName ?? "";
    surnameController.text = model?.surname ?? "";
    nameSuffixController.text = model?.nameSuffix ?? "";
    phoneController.text = model?.phone ?? "";
    emailController.text = model?.email ?? "";
    companyController.text = model?.company ?? "";
    titleController.text = model?.title ?? "";
    selectBirthDate = model?.birthDate ?? "";
    imageUrl = model?.profileUrl ?? "";
    // notifyListeners();
  }

  @override
  void dispose() {
    namePrefixController.dispose();
    firstNameController.dispose();
    middleNameController.dispose();
    surnameController.dispose();
    nameSuffixController.dispose();
    phoneController.dispose();
    emailController.dispose();
    companyController.dispose();
    titleController.dispose();
    super.dispose();
  }
}
