import 'package:call_log/call_log.dart';
import 'package:contactsassignment/utils/utility.dart';
import 'package:contactsassignment/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'components/call_log_list_item.dart';

var callLogProvider =
    FutureProvider.autoDispose<List<CallLogEntry>>((ref) async {
  final response = await CallLog.get();
  return response.toList();
});

class RecentCallLogScreen extends ConsumerWidget {
  const RecentCallLogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RefreshIndicator(
      onRefresh: () => ref.refresh(callLogProvider.future),
      child: ref.watch(callLogProvider).when(
          data: (data) {
            if (data.isEmpty) {
              return Center(
                child: MyText(text: "No call logs found."),
              );
            }
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) => CallLogListItem(
                callLogEntry: data[index],
                onCallClick: () {
                  if (data[index].number != null) {
                    dialNumber(phoneNumber: data[index].number!);
                  } else {
                    showToast("Failed to call the number");
                  }
                },
              ),
              itemCount: data.length,
            );
          },
          error: (obj, error) => Center(
                child: MyText(text: "No call logs found."),
              ),
          loading: () => const Center(
                child: CircularProgressIndicator(),
              )),
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
