import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class PopoverMenu extends StatelessWidget {
  const PopoverMenu(
      {super.key,
      required this.menus,
      required this.onMenuSelected,
      required this.builder});
  final List<dynamic> menus;
  final Function(int) onMenuSelected;
  final Widget Function(BuildContext, MenuController, Widget?) builder;

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
      menuChildren: menus
          .mapIndexed<Widget>((i, e) => MenuItemButton(
                child: Text(e['title']),
                onPressed: () => onMenuSelected(i),
              ))
          .toList(),
      builder: builder,
    );
  }
}
