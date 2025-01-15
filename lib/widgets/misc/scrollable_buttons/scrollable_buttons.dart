import 'package:flutter/material.dart';
import 'package:society_management/core/app_export.dart';
import 'package:society_management/theme/app_colors.dart';
import 'package:society_management/theme/fonts.dart';
import 'package:society_management/widgets/app_widgets/app_text.dart';

class ScrollableButtons extends StatefulWidget {
  const ScrollableButtons(
      {super.key,
      required this.data,
      this.selectedIndex = 0,
      this.onSelected,
      this.selectedColor,
      this.unselectedColor,
      this.width});
  final List<dynamic> data;
  final int selectedIndex;
  final Function(int)? onSelected;
  final Color? selectedColor;
  final Color? unselectedColor;
  final double? width;

  @override
  State<ScrollableButtons> createState() => _ScrollableButtonsState();
}

class _ScrollableButtonsState extends State<ScrollableButtons> {
  int _selectedIndex = 0;
  late Color _selectedColor;
  late Color _unselectedColor;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
    _selectedColor = widget.selectedColor ?? AppColors.primary;
    _unselectedColor = widget.unselectedColor ?? Colors.grey.shade300;
    if (_selectedIndex != 0) {
      Future.delayed(const Duration(milliseconds: 100)).then((value) {
        double itemWidth = 50.0; // Height of each item in ListView
        double targetScrollOffset = _selectedIndex * itemWidth;
        _scrollController.animateTo(
          targetScrollOffset,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? SizeUtils.width * 0.9,
      height: 32,
      child: ListView.builder(
          controller: _scrollController,
          itemCount: widget.data.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, index) {
            var item = widget.data[index];
            var isSelected = index == _selectedIndex;
            return InkWell(
              onTap: () {
                if (_selectedIndex != index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                  if (widget.onSelected != null) {
                    widget.onSelected!(index);
                  }
                }
              },
              child: Container(
                height: 32,
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: index != 0 ? 10 : 0),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: isSelected ? _selectedColor : _unselectedColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: AppText(
                  text: item['title'],
                  style: AppText.defaultFontStyle.copyWith(
                      fontSize: 12.5,
                      color: isSelected
                          ? Colors.white
                          : Colors.black.withOpacity(0.7),
                      fontFamily: isSelected ? Fonts.medium : Fonts.regular),
                ),
              ),
            );
          }),
    );
  }
}
