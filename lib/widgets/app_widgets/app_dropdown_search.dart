import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:society_management/theme/app_colors.dart';
import 'package:society_management/widgets/app_widgets/app_text.dart';

class AppDropdownSearch extends StatelessWidget {
  const AppDropdownSearch(
      {super.key,
      required this.name,
      required this.items,
      required this.placeholder,
      this.onChanged,
      this.searchPlaceholder = "Search",
      this.displayKey = "name",
      this.width,
      this.title,
      this.showTitle = true,
      this.validator});
  final String name;
  final String displayKey;
  final List<Map> items;
  final Function(Map)? onChanged;
  final String placeholder;
  final String searchPlaceholder;
  final double? width;
  final bool showTitle;
  final String? title;
  final String? Function(dynamic)? validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        children: [
          if (showTitle && title != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: AppText(
                text: title!,
                style: AppText.defaultFontStyle
                    .copyWith(color: const Color(0xFF4A4A4A)),
              ),
            ),
          FormBuilderField(
              name: name,
              validator: validator,
              builder: (FormFieldState<dynamic> field) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownSearch<Map>(
                      itemAsString: (Map data) => data[displayKey],
                      popupProps: PopupProps.menu(
                        // showSelectedItems: true,
                        showSearchBox: true,

                        searchFieldProps: TextFieldProps(
                            decoration: InputDecoration(
                                focusedBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.border),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.border),
                                ),
                                hintText: searchPlaceholder)),
                        // disabledItemFn: (String s) => s.startsWith('I'),
                      ),
                      items: (val, props) => items,

                      decoratorProps: DropDownDecoratorProps(
                        decoration: InputDecoration(
                          hintText: placeholder,
                          hintStyle: AppText.defaultFontStyle,
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: AppColors.border)),
                        ),
                      ),
                      onChanged: (val) {
                        field.didChange(val!['id']);
                        if (onChanged != null) {
                          onChanged!(val);
                        }
                      },
                      // selectedItem: field.value,
                    ),
                    if (field.errorText != null)
                      AppText(
                        text: field.errorText!,
                        style: AppText.defaultFontStyle
                            .copyWith(color: Colors.redAccent),
                      ),
                  ],
                );
              }),
        ],
      ),
    );
  }
}
