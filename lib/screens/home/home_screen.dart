import 'package:contactsassignment/provider/contact_list_provider.dart';
import 'package:contactsassignment/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../utils/utility.dart';
import '../../widgets/primary_text_field.dart';
import 'components/contact_list_item.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var contactList = ref.watch(ContactListProvider.provider);
    contactList.sort(((a, b) =>
        a.firstName.toLowerCase().compareTo(b.firstName.toLowerCase())));
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          PrimaryTextField(
            leading: const Icon(Icons.search_rounded),
            radius: 32,
            backgroundColor: Colors.grey.shade200,
            onChanged: (str) {
              ref
                  .read(ContactListProvider.provider.notifier)
                  .updateContactList(searchQuery: str);
            },
            hintText: "Search in contacts",
          ),
          if (contactList.isEmpty)
            Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .3,
                ),
                child: MyText(
                  text: "No contact has been added",
                )),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => ContactListItem(
                contactModel: contactList[index],
                ref: ref,
                onCallClick: () =>
                    dialNumber(phoneNumber: contactList[index].phone),
              ),
              itemCount: contactList.length,
            ),
          )
        ],
      ),
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
