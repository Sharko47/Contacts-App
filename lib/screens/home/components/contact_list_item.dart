import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constant/app_color.dart';
import '../../../helper/navigation_helper.dart';
import '../../../main.dart';
import '../../../model/contact_model.dart';
import '../../../provider/contact_list_provider.dart';
import '../../../widgets/my_text.dart';
import '../../contact_detail/contact_detail.dart';

class ContactListItem extends StatelessWidget {
  const ContactListItem(
      {Key? key,
      required this.contactModel,
      required this.ref,
      required this.onCallClick})
      : super(key: key);

  final ContactModel contactModel;
  final WidgetRef ref;
  final VoidCallback onCallClick;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      shadowColor: Colors.black38,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          navigatorPush(
              context,
              ContactDetailScreen(
                contactData: contactModel,
              ));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                      text: "${contactModel.firstName} ${contactModel.surname}",
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    ),
                    MyText(
                      text: contactModel.phone,
                      fontSize: 14.0,
                      color: darkGrey,
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  contactModel.isFavourite = !contactModel.isFavourite;
                  store.box<ContactModel>().put(contactModel);
                  ref
                      .read(ContactListProvider.provider.notifier)
                      .updateContactList();
                },
                child: Icon(
                  Icons.favorite_rounded,
                  color: contactModel.isFavourite
                      ? Colors.red
                      : Colors.grey.shade300,
                ),
              ),
              const SizedBox(
                width: 8.0,
              ),
              InkWell(
                onTap: onCallClick,
                child: const Icon(
                  Icons.call_rounded,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
