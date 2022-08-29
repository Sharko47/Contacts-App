import 'package:flutter/material.dart';

import '../constant/app_color.dart';
import 'my_text.dart';
import 'primary_button.dart';

class BottomModalSheet {
  static void logoutConfirmBottomSheet(context, onConfirm) {
    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
        ),
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: MyText(
                    text: 'Are you sure you want to log out?',
                    textAlignment: TextAlign.center,
                    fontSize: 18.0,
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: MaterialButton(
                      child: MyText(
                        text: 'Cancel',
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      color: Colors.grey[100],
                      colorBrightness: Brightness.light,
                      elevation: 2,
                      highlightElevation: 12,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                      onPressed: () {
                        //Do something
                        Navigator.pop(context);
                      },
                    )),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: MaterialButton(
                        child: MyText(
                          text: 'Logout',
                          color: white,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        color: appBarColor,
                        colorBrightness: Brightness.dark,
                        highlightElevation: 12,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          onConfirm();
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24.0,
                )
              ],
            ),
          );
        });
  }

  static void confirmBottomSheet(context, message,
      {confirmText = "Confirm",
      onConfirm,
      cancelText = "Cancel",
      onCancel,
      bool isCancellable = false}) {
    showModalBottomSheet<void>(
        context: context,
        isDismissible: isCancellable,
        enableDrag: isCancellable,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
        ),
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () async {
              return isCancellable;
            },
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32.0),
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: MaterialButton(
                          child: Text(confirmText),
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                          color: appBarColor,
                          highlightElevation: 12,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            if (onConfirm != null) onConfirm();
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                          child: MaterialButton(
                        child: Text(cancelText),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        color: Colors.grey[100],
                        colorBrightness: Brightness.light,
                        elevation: 2,
                        highlightElevation: 12,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32.0)),
                        onPressed: () {
                          //Do something
                          Navigator.pop(context);
                          if (onCancel != null) onCancel();
                        },
                      )),
                    ],
                  ),
                  const SizedBox(
                    height: 24.0,
                  )
                ],
              ),
            ),
          );
        });
  }

  static void pickerBottomSheet(context,
      {String message = "Pick image from", onCameraSelect, onGallerySelect}) {
    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
        ),
        builder: (BuildContext context) {
          return Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 32.0),
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: MaterialButton(
                        child: Text(
                          "Camera",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 18.0,
                        ),
                        color: appBarColor,
                        // colorBrightness: Brightness.dark,
                        highlightElevation: 12,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14.0)),
                        onPressed: () {
                          Navigator.pop(context);
                          if (onCameraSelect != null) onCameraSelect();
                          //Do something
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 18,
                    ),
                    Expanded(
                        child: MaterialButton(
                      child: Text("Gallery",
                          style: Theme.of(context).textTheme.headline3),
                      padding: const EdgeInsets.symmetric(
                        vertical: 18.0,
                      ),
                      color: Colors.grey[100],
                      colorBrightness: Brightness.light,
                      elevation: 2,
                      highlightElevation: 12,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0)),
                      onPressed: () {
                        //Do something
                        Navigator.pop(context);
                        if (onGallerySelect != null) onGallerySelect();
                      },
                    )),
                  ],
                ),
                const SizedBox(
                  height: 24.0,
                )
              ],
            ),
          );
        });
  }

  static void customChildSheet(context, child,
      {isCancelable = true,
      horizontalPadding = 16.0,
      verticalPadding = 16.0,
      isFormSheet = false}) {
    showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        isDismissible: isCancelable,
        enableDrag: isCancelable,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async {
                return isCancelable;
              },
              child: SingleChildScrollView(
                child: Container(
                    width: double.infinity,
                    padding: isFormSheet
                        ? MediaQuery.of(context).viewInsets
                        : EdgeInsets.symmetric(
                            horizontal: horizontalPadding,
                            vertical: verticalPadding),
                    decoration: const BoxDecoration(
                        color: white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(24.0))),
                    child: child),
              ));
        });
  }

  static void openOkActionSheet(context, message,
      {okButtonText = "Ok", isCancelable = true, okClickListener}) {
    showModalBottomSheet<void>(
        enableDrag: isCancelable,
        context: context,
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
        ),
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async {
                return isCancelable;
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 100.0,
                    height: 8.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: white),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(18.0),
                            topLeft: Radius.circular(18.0)),
                        color: white),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Text(
                            message ?? "",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        PrimaryButton(
                          btnText: okButtonText,
                          width: MediaQuery.of(context).size.width,
                          onPressed: () {
                            Navigator.pop(context);
                            okClickListener();
                          },
                        ),
                        const SizedBox(
                          height: 18.0,
                        )
                      ],
                    ),
                  ),
                ],
              ));
        });
  }

  static void okBottomSheet(context, message, {isCancelable = true}) {
    showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
        ),
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async {
                return isCancelable;
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 100.0,
                    height: 8.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: white),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(18.0),
                            topLeft: Radius.circular(18.0)),
                        color: white),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24.0),
                          child: Text(
                            message ?? "",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        PrimaryButton(
                          btnText: "Okay",
                          width: MediaQuery.of(context).size.width,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        const SizedBox(
                          height: 16.0,
                        )
                      ],
                    ),
                  ),
                ],
              ));
        });
  }
}
