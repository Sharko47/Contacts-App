import 'package:contactsassignment/model/contact_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../main.dart';
import '../objectbox.g.dart';

class ContactListProvider extends StateNotifier<List<ContactModel>> {
  ContactListProvider() : super(store.box<ContactModel>().getAll());

  static final provider =
      StateNotifierProvider<ContactListProvider, List<ContactModel>>((ref) {
    return ContactListProvider();
  });

  updateContactList({String? searchQuery = ""}) {
    if (searchQuery == null && searchQuery?.isEmpty == true) {
      state = store.box<ContactModel>().getAll();
    } else {
      Query<ContactModel> query = store
          .box<ContactModel>()
          .query(ContactModel_.firstName.contains(searchQuery!).or(ContactModel_
              .surname
              .contains(searchQuery)
              .or(ContactModel_.phone.contains(searchQuery))))
          .build();
      state = query.find();
    }
  }
}
