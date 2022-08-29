import 'package:contactsassignment/provider/contact_list_provider.dart';
import 'package:contactsassignment/provider/favotire_contact_provider.dart';
import 'package:contactsassignment/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../utils/utility.dart';
import '../home/components/contact_list_item.dart';

class FavoriteScreen extends ConsumerWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var favContactList = ref.watch(FavoriteContactListProvider.provider);
    Future.delayed(const Duration(milliseconds: 100)).then((value) => ref
        .read(FavoriteContactListProvider.provider.notifier)
        .updateFavoriteContactList());
    if (favContactList.isEmpty) {
      return Center(
        child: MyText(text: "No favourites contact found."),
      );
    }
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => ContactListItem(
        contactModel: favContactList[index],
        ref: ref,
        onCallClick: () => dialNumber(phoneNumber: favContactList[index].phone),
      ),
      itemCount: favContactList.length,
    );
  }

  Future<void> dialNumber({required String phoneNumber}) async {
    final url = "tel:$phoneNumber";
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      showToast("Unable to call $phoneNumber");
    }
  }
}
