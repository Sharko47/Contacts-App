import 'package:flutter/material.dart';

import '../constant/app_color.dart';
import 'my_text.dart';

class SingleSelectDropDown extends StatefulWidget {
  final List<dynamic> tagList;
  final bool isCustomObject;

  final Function(dynamic)? selectedTagItem;
  const SingleSelectDropDown({
    Key? key,
    this.isCustomObject = false,
    required this.tagList,
    this.selectedTagItem,
  }) : super(key: key);

  @override
  State<SingleSelectDropDown> createState() => _SingleSelectDropDownState();
}

class _SingleSelectDropDownState extends State<SingleSelectDropDown> {
  late int selectedIndex = -1;
  @override
  void initState() {
    super.initState();
    // if (widget.selected >= 0 && widget.selected < widget.tagList.length) {
    //   selectedIndex = widget.selected;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(
            widget.tagList.length, (index) => chipBuilder(context, index)));
  }

  Widget chipBuilder(context, currentIndex) {
    dynamic tags = widget.tagList[currentIndex];
    bool isActive = selectedIndex == currentIndex;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = currentIndex;
        });
        widget.selectedTagItem!(tags);
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        decoration: BoxDecoration(
          color: isActive ? appBarColor : Colors.white,
          border: Border.all(color: Colors.grey.shade500),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          child: MyText(
            text: widget.isCustomObject ? tags.name : tags,
            color: isActive ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
