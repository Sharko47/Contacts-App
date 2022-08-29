import 'package:contactsassignment/constant/app_color.dart';
import 'package:contactsassignment/helper/navigation_helper.dart';
import 'package:contactsassignment/main.dart';
import 'package:contactsassignment/screens/add_contact/add_update_contact_screen.dart';
import 'package:contactsassignment/screens/favorite/favorite_screen.dart';
import 'package:contactsassignment/screens/home/home_screen.dart';
import 'package:contactsassignment/screens/label/label_screen.dart';
import 'package:contactsassignment/screens/recent_log/recent_call_log.dart';
import 'package:contactsassignment/widgets/custom_container.dart';
import 'package:contactsassignment/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/custom_pop_up_menu.dart';
import '../widgets/keep_alive_page.dart';
import '../widgets/primary_button.dart';

var multipleContactSelectStateProvider =
    StateProvider.autoDispose((ref) => false);

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentPage = 0;
  late List<Widget> _widgetOptions;
  late PageController _pageController;
  final pageLabels = ["All Contacts", "Recent Calls", "Favorites", "Label"];

  @override
  void initState() {
    _widgetOptions = <Widget>[
      const KeepAlivePage(child: HomeScreen()),
      const KeepAlivePage(child: RecentCallLogScreen()),
      const KeepAlivePage(child: FavoriteScreen()),
      const KeepAlivePage(child: LabelScreen()),
    ];
    _pageController = PageController();
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page!.toInt();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    if (!store.isClosed()) {
      store.close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (currentPage != 0) {
          _pageController.jumpToPage(0);

          return false;
        }
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Consumer(builder: ((context, ref, child) {
                  if (ref.watch(multipleContactSelectStateProvider)) {
                    return Row(
                      children: [
                        Expanded(
                          child: MyText(
                            text: "0",
                            fontSize: 28.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        PrimaryButton(
                          color: Colors.grey.shade300,
                          width: 42,
                          disablePadding: true,
                          cornerRadius: 32.0,
                          height: 42,
                          onPressed: () {
                            ref
                                .read(
                                    multipleContactSelectStateProvider.notifier)
                                .state = false;
                          },
                          child: const Icon(Icons.close_rounded),
                        )
                      ],
                    );
                  }
                  return buildTopAppBar();
                })),
                const SizedBox(
                  height: 8.0,
                ),
                Expanded(
                  child: PageView.builder(
                    //this is optional
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => _widgetOptions[index],
                    itemCount: _widgetOptions.length,
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          width: double.infinity,
          height: 60.0,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24.0),
              topRight: Radius.circular(
                24.0,
              ),
            ),
            color: appBarColor,
            boxShadow: [
              BoxShadow(
                offset: Offset(
                  0,
                  -8,
                ),
                blurRadius: 8,
                color: Colors.black12,
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildBottomAppBarItem(
                isSelected: currentPage == 0,
                text: "All",
                icon: Icons.contact_page_rounded,
                onPressed: () {
                  jumpToPage(0);
                },
              ),
              buildBottomAppBarItem(
                isSelected: currentPage == 1,
                text: "Recent",
                icon: Icons.call_missed_rounded,
                onPressed: () {
                  jumpToPage(1);
                },
              ),
              buildBottomAppBarItem(
                isSelected: currentPage == 2,
                text: "Favorites",
                icon: Icons.favorite_rounded,
                onPressed: () {
                  jumpToPage(2);
                },
              ),
              buildBottomAppBarItem(
                isSelected: currentPage == 3,
                text: "Label",
                icon: Icons.label_rounded,
                onPressed: () {
                  jumpToPage(3);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  jumpToPage(pageNumber) {
    setState(() {
      _pageController.jumpToPage(pageNumber);
    });
  }

  buildBottomAppBarItem(
      {bool isSelected = false, var text, var icon, var onPressed}) {
    return CustomContainer(
      radius: isSelected ? 16 : 0,
      horizontalPadding: 8,
      verticalPadding: 5,
      onClick: onPressed,
      color: isSelected ? white : appBarColor,
      child: Row(
        children: [
          Icon(
            icon,
            size: isSelected ? 22 : 18,
            color: isSelected ? black : white,
          ),
          const SizedBox(
            width: 4,
          ),
          MyText(
            text: text,
            fontSize: isSelected ? 14 : 12,
            color: isSelected ? black : white,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

  buildTopAppBar() {
    return Row(
      children: [
        Expanded(
          child: MyText(
            text: pageLabels[currentPage],
            fontSize: 28.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        CustomPopUpMenu(
            popMenuItems: const ['Add New Contact', "Exit"],
            onMenuCliked: (index) {
              return () {
                switch (index) {
                  case 0:
                    navigatorPush(context, AddOrUpdateContactScreen());
                    break;
                  case 1:
                    SystemNavigator.pop();
                    break;
                  default:
                }
              };
            }),
      ],
    );
  }
}
