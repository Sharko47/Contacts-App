import 'package:contactsassignment/objectbox.g.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../main.dart';
import '../model/contact_model.dart';

class FavoriteContactListProvider extends StateNotifier<List<ContactModel>> {
  FavoriteContactListProvider() : super([]);

  static final provider =
      StateNotifierProvider<FavoriteContactListProvider, List<ContactModel>>(
          (ref) {
    return FavoriteContactListProvider();
  });

  updateFavoriteContactList() {
    Query<ContactModel> query = store
        .box<ContactModel>()
        .query(ContactModel_.isFavourite.equals(true))
        .build();
    state = query.find();
    state.sort(((a, b) =>
        a.firstName.toLowerCase().compareTo(b.firstName.toLowerCase())));
  }
}
