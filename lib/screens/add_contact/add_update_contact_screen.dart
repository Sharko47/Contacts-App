import 'package:contactsassignment/model/contact_model.dart';
import 'package:contactsassignment/provider/add_update_contact_provider.dart';
import 'package:contactsassignment/provider/contact_list_provider.dart';
import 'package:contactsassignment/utils/utility.dart';
import 'package:contactsassignment/widgets/custom_container.dart';
import 'package:contactsassignment/widgets/expanded_section.dart';
import 'package:contactsassignment/widgets/primary_button.dart';
import 'package:contactsassignment/widgets/primary_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constant/app_color.dart';
import '../../helper/navigation_helper.dart';
import '../../main.dart';
import '../../widgets/bottom_modal_sheet.dart';
import '../../widgets/custom_pop_up_menu.dart';
import '../../widgets/my_text.dart';

var addContactProvider =
    ChangeNotifierProvider.autoDispose((ref) => AddOrUpdateContactProvider());

// ignore: must_be_immutable
class AddOrUpdateContactScreen extends ConsumerWidget {
  final ContactModel? contactModel;
  AddOrUpdateContactScreen({Key? key, this.contactModel}) : super(key: key);

  DateTime selectedDate = DateTime.utc(2008);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var isNameExpanded = ref.watch(addContactProvider).isNameExpanded;
    var birthDate = ref.watch(addContactProvider).selectBirthDate;
    var imageUrl = ref.watch(addContactProvider).imageUrl;
    var namePrefixController =
        ref.watch(addContactProvider).namePrefixController;
    var firstNameController = ref.watch(addContactProvider).firstNameController;
    var middleNameController =
        ref.watch(addContactProvider).middleNameController;
    var surnameController = ref.watch(addContactProvider).surnameController;
    var nameSuffixController =
        ref.watch(addContactProvider).nameSuffixController;
    var phoneController = ref.watch(addContactProvider).phoneController;
    var emailController = ref.watch(addContactProvider).emailController;
    var companyController = ref.watch(addContactProvider).companyController;
    var titleController = ref.watch(addContactProvider).titleController;
    if (contactModel != null &&
        !ref.watch(addContactProvider).hasSetInitialData) {
      Future.delayed(const Duration(milliseconds: 100)).then((value) {
        ref.read(addContactProvider).imageUrl = contactModel?.profileUrl ?? "";
        ref.read(addContactProvider).setFormDataForEditing(contactModel);
        ref.read(addContactProvider).hasSetInitialData = true;
        ref
            .read(addContactProvider)
            .setBirthDate(contactModel?.birthDate ?? "");
      });
    }
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {
                    goBack(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                  ),
                ),
                const SizedBox(
                  width: 5.0,
                ),
                Expanded(
                  child: MyText(
                    text: (contactModel != null)
                        ? "${contactModel?.firstName} ${contactModel?.surname}"
                        : "Add New Contact",
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CustomPopUpMenu(
                  popMenuItems: const ['Discard', "Save"],
                  onMenuCliked: (index) {
                    return () {
                      switch (index) {
                        case 0:
                          goBack(context);
                          break;
                        case 1:
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (ref
                              .read(addContactProvider)
                              .isAllFieldsAreEmpty()) {
                            showToast("All field are empty");
                          } else if (firstNameController.text.trim().isEmpty) {
                            showToast("First name is required");
                          } else if (phoneController.text.trim().isEmpty) {
                            showToast("Phone number is required");
                          } else if (phoneController.text.trim().length < 10) {
                            showToast("Phone number must be 10 digit");
                          } else {
                            var contact = ContactModel(
                                id: contactModel?.id ?? 0,
                                namePrefix: namePrefixController.text.trim(),
                                firstName: firstNameController.text.trim(),
                                middleName: middleNameController.text.trim(),
                                surname: surnameController.text.trim(),
                                nameSuffix: nameSuffixController.text.trim(),
                                company: companyController.text.trim(),
                                title: titleController.text.trim(),
                                phone: phoneController.text.trim(),
                                email: emailController.text.trim(),
                                isFavourite: false,
                                birthDate: birthDate,
                                profileUrl: imageUrl);
                            saveContact(ref, contact, context);
                          }
                          break;
                        default:
                      }
                    };
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 24.0,
            ),
            CircleAvatar(
              radius: 72,
              backgroundColor: Colors.grey.shade300,
              child: const Icon(
                Icons.add_a_photo_rounded,
                size: 32,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Visibility(
              visible: isNameExpanded,
              child: ExpandedSection(
                expand: isNameExpanded,
                child: PrimaryTextField(
                  hintText: "Prefix : eg. Mr, Miss, Mrs. etc",
                  leading: const Icon(Icons.person_rounded),
                  backgroundColor: Colors.grey.shade200,
                  controller: namePrefixController,
                ),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            PrimaryTextField(
              hintText: "First Name",
              leading: const Icon(Icons.person_rounded),
              length: 50,
              controller: firstNameController,
              trailing: InkWell(
                  onTap: () => ref
                      .read(addContactProvider)
                      .toggleNameUI(!isNameExpanded),
                  child: Icon(isNameExpanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded)),
              backgroundColor: Colors.grey.shade200,
            ),
            Visibility(
              visible: isNameExpanded,
              child: ExpandedSection(
                expand: isNameExpanded,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: PrimaryTextField(
                    hintText: "Middle Name",
                    controller: middleNameController,
                    leading: const Icon(Icons.person_rounded),
                    backgroundColor: Colors.grey.shade200,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            PrimaryTextField(
              hintText: "Surname",
              controller: surnameController,
              leading: const Icon(Icons.person_rounded),
              backgroundColor: Colors.grey.shade200,
              length: 50,
            ),
            Visibility(
              visible: isNameExpanded,
              child: ExpandedSection(
                expand: isNameExpanded,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: PrimaryTextField(
                    hintText: "Suffix",
                    controller: nameSuffixController,
                    leading: const Icon(Icons.person_rounded),
                    backgroundColor: Colors.grey.shade200,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12.0,
            ),
            PrimaryTextField(
              hintText: "Phone",
              inputType: TextInputType.phone,
              length: 10,
              controller: phoneController,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              leading: const Icon(Icons.phone_android_rounded),
              backgroundColor: Colors.grey.shade200,
            ),
            const SizedBox(
              height: 12.0,
            ),
            PrimaryTextField(
              hintText: "Email",
              inputType: TextInputType.emailAddress,
              length: 100,
              controller: emailController,
              leading: const Icon(Icons.email_rounded),
              backgroundColor: Colors.grey.shade200,
            ),
            const SizedBox(
              height: 12.0,
            ),
            PrimaryTextField(
              hintText: "Company",
              controller: companyController,
              inputType: TextInputType.text,
              length: 100,
              leading: const Icon(Icons.work_rounded),
              backgroundColor: Colors.grey.shade200,
            ),
            const SizedBox(
              height: 12.0,
            ),
            PrimaryTextField(
              hintText: "Title",
              controller: titleController,
              inputType: TextInputType.text,
              length: 50,
              leading: const Icon(Icons.title_rounded),
              backgroundColor: Colors.grey.shade200,
            ),
            const SizedBox(
              height: 12.0,
            ),
            CustomContainer(
              radius: 16,
              color: Colors.grey.shade200,
              horizontalPadding: 8,
              verticalPadding: 16,
              onClick: () => _openDatePickerBottomSheet(ref, context),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(
                      Icons.date_range_rounded,
                      size: 20,
                    ),
                  ),
                  Expanded(
                    child: MyText(
                      text: birthDate.isEmpty ? "Birthdate" : birthDate,
                      color: birthDate.isEmpty ? Colors.grey : black,
                      fontWeight: FontWeight.normal,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            PrimaryButton(
              width: double.infinity,
              btnText: "Add",
              gradientColorOne: drawerHeaderGradientLeft,
              gradientColorTwo: drawerHeaderGradientRight,
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                if (ref.read(addContactProvider).isAllFieldsAreEmpty()) {
                  showToast("All field are empty");
                } else if (firstNameController.text.trim().isEmpty) {
                  showToast("First name is required");
                } else if (phoneController.text.trim().isEmpty) {
                  showToast("Phone number is required");
                } else if (phoneController.text.trim().length < 10) {
                  showToast("Phone number must be 10 digit");
                } else {
                  var contact = ContactModel(
                      id: contactModel?.id ?? 0,
                      namePrefix: namePrefixController.text.trim(),
                      firstName: firstNameController.text.trim(),
                      middleName: middleNameController.text.trim(),
                      surname: surnameController.text.trim(),
                      nameSuffix: nameSuffixController.text.trim(),
                      company: companyController.text.trim(),
                      title: titleController.text.trim(),
                      phone: phoneController.text.trim(),
                      email: emailController.text.trim(),
                      isFavourite: false,
                      birthDate: birthDate,
                      profileUrl: imageUrl);
                  saveContact(ref, contact, context);
                }
              },
            ),
            if (contactModel != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: PrimaryButton(
                  width: double.infinity,
                  btnText: "Delete",
                  gradientColorOne: redGradientLeft,
                  gradientColorTwo: redGradientRight,
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    store.box<ContactModel>().remove(contactModel?.id ?? 0);
                    ref
                        .read(ContactListProvider.provider.notifier)
                        .updateContactList();
                    showToast("Contact deleted successfully");
                    goPreviousScreen(context, popCount: 2);
                  },
                ),
              ),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      )),
    );
  }

  void _openDatePickerBottomSheet(WidgetRef ref, BuildContext context) {
    BottomModalSheet.customChildSheet(
      context,
      Column(
        children: [
          SizedBox(
            height: 250,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              minimumYear: DateTime.utc(1970).year,
              maximumYear: DateTime.utc(2008).year,
              initialDateTime: selectedDate,
              onDateTimeChanged: (DateTime newDateTime) {
                // Do something
                selectedDate = newDateTime;
              },
            ),
          ),
          PrimaryButton(
            width: double.infinity,
            btnText: "Confirm",
            textColor: white,
            textSize: 18.0,
            onPressed: () {
              ref.read(addContactProvider).setBirthDate(selectedDate
                  .toLocal()
                  .toString()
                  .split(' ')[0]
                  .convertDate());

              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  void saveContact(WidgetRef ref, ContactModel contact, BuildContext context) {
    store.box<ContactModel>().put(contact);
    ref.read(ContactListProvider.provider.notifier).updateContactList();
    showToast("Contact saved successfully");
    if (contactModel != null) {
      goPreviousScreen(context, popCount: 2);
    } else {
      goBack(context);
    }
  }
}
