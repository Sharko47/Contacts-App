import 'package:contactsassignment/helper/navigation_helper.dart';
import 'package:contactsassignment/model/contact_model.dart';
import 'package:contactsassignment/screens/add_contact/add_update_contact_screen.dart';
import 'package:contactsassignment/utils/utility.dart';
import 'package:contactsassignment/widgets/my_text.dart';
import 'package:contactsassignment/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../constant/app_color.dart';
import '../../main.dart';
import '../../provider/contact_list_provider.dart';

var favouriteStateProvider = StateProvider.autoDispose((ref) => false);

class ContactDetailScreen extends ConsumerWidget {
  final ContactModel contactData;
  const ContactDetailScreen({Key? key, required this.contactData})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var name =
        "${contactData.namePrefix} ${contactData.firstName} ${contactData.surname}";
    var favouriteState = ref.watch(favouriteStateProvider.state);
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      favouriteState.state = contactData.isFavourite;
    });
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
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
                      text: "${contactData.firstName} ${contactData.surname}",
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  PrimaryButton(
                    color: Colors.grey.shade300,
                    width: 42,
                    disablePadding: true,
                    cornerRadius: 32.0,
                    height: 42,
                    onPressed: () {
                      contactData.isFavourite = !contactData.isFavourite;
                      favouriteState.state = contactData.isFavourite;
                      store.box<ContactModel>().put(contactData);
                      ref
                          .read(ContactListProvider.provider.notifier)
                          .updateContactList();
                    },
                    child: Icon(
                      Icons.favorite_rounded,
                      color: favouriteState.state ? Colors.red : Colors.grey,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  PrimaryButton(
                    color: Colors.grey.shade300,
                    width: 42,
                    disablePadding: true,
                    cornerRadius: 32.0,
                    height: 42,
                    onPressed: () {
                      navigatorPush(
                          context,
                          AddOrUpdateContactScreen(
                            contactModel: contactData,
                          ));
                    },
                    child: const Icon(Icons.edit_rounded),
                  )
                ],
              ),
              const SizedBox(
                height: 24.0,
              ),
              CircleAvatar(
                radius: 72.0,
                backgroundColor: Colors.grey.shade200,
                child: MyText(
                  text: name.getInitials(),
                  fontSize: 32,
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              MyText(
                text: name,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  PrimaryButton(
                    height: 50,
                    width: 50,
                    btnText: "Call",
                    color: Colors.grey.shade300,
                    disablePadding: true,
                    onPressed: () {
                      launchContactAction(url: "tel:${contactData.phone}");
                    },
                    child: const Icon(Icons.call_rounded),
                  ),
                  PrimaryButton(
                    height: 50,
                    width: 50,
                    btnText: "Message",
                    color: Colors.grey.shade300,
                    disablePadding: true,
                    onPressed: () {
                      launchContactAction(url: "sms:${contactData.phone}");
                    },
                    child: const Icon(Icons.message_rounded),
                  ),
                  PrimaryButton(
                    height: 50,
                    width: 50,
                    btnText: "Email",
                    color: Colors.grey.shade300,
                    disablePadding: true,
                    onPressed: () {
                      if (contactData.email.isEmpty) {
                        showToast("Email not available");
                      } else {
                        launchContactAction(url: "mailto:${contactData.email}");
                      }
                    },
                    child: const Icon(Icons.email_rounded),
                  )
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              buildContactDetailUI("Phone", contactData.phone),
              buildContactDetailUI("Email", contactData.email),
              buildContactDetailUI("Company", contactData.company),
              buildContactDetailUI("Title", contactData.title),
              buildContactDetailUI("Birthdate", contactData.birthDate),
              const SizedBox(
                height: 24,
              ),
              PrimaryButton(
                width: double.infinity,
                btnText: "Delete",
                gradientColorOne: redGradientLeft,
                gradientColorTwo: redGradientRight,
                onPressed: () {
                  store.box<ContactModel>().remove(contactData.id);
                  ref
                      .read(ContactListProvider.provider.notifier)
                      .updateContactList();
                  showToast("Contact deleted successfully");
                  goBack(context);
                },
              ),
              const SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      )),
    );
  }

  buildContactDetailUI(var label, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          MyText(
            text: label,
            fontWeight: FontWeight.normal,
          ),
          MyText(
            text: text.isEmpty ? "N/A" : text,
            fontSize: 20,
            textAlignment: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Future<void> launchContactAction({required String url}) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      showToast("Unable to perform opetarion");
    }
  }
}
