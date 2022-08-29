import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';

import '../../../constant/app_color.dart';
import '../../../widgets/custom_container.dart';
import '../../../widgets/my_text.dart';
import '../../../widgets/primary_button.dart';

class CallLogListItem extends StatelessWidget {
  final CallLogEntry callLogEntry;
  final VoidCallback onCallClick;
  const CallLogListItem(
      {Key? key, required this.callLogEntry, required this.onCallClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      horizontalPadding: 0,
      verticalPadding: 0,
      boxShadows: const [
        BoxShadow(blurRadius: 8.0, offset: Offset(2, 0), color: Colors.black12),
      ],
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    text: callLogEntry.name ?? "N/A",
                    fontSize: 18.0,
                    textMaxLines: 1,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  MyText(
                    text: callLogEntry.number ?? "N/A",
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  MyText(
                    text: callLogEntry.simDisplayName ?? "",
                    fontSize: 14.0,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
          ),
          if (callLogEntry.callType == CallType.missed)
            const Icon(
              Icons.call_missed_rounded,
              color: Colors.red,
              size: 32,
            )
          else if (callLogEntry.callType == CallType.outgoing)
            const Icon(
              Icons.call_missed_outgoing_rounded,
              color: Colors.blue,
              size: 32,
            )
          else if (callLogEntry.callType == CallType.incoming)
            const Icon(
              Icons.call_received_rounded,
              color: Colors.green,
              size: 32,
            )
          else if (callLogEntry.callType == CallType.rejected)
            const Icon(
              Icons.call_end_rounded,
              color: Colors.yellow,
              size: 32,
            )
          else if (callLogEntry.callType == CallType.unknown)
            const Icon(
              Icons.device_unknown,
              color: Colors.redAccent,
              size: 32,
            ),
          const SizedBox(
            width: 8.0,
          ),
          PrimaryButton(
            disablePadding: true,
            onPressed: onCallClick,
            height: 90.0,
            width: 50.0,
            gradientColorOne: greenGradientLeft,
            gradientColorTwo: greenGradientRight,
            child: const Icon(
              Icons.call_rounded,
              color: white,
            ),
          )
        ],
      ),
    );
  }
}
