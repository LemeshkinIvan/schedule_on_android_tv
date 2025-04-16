import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tv_shedule/ui/schedule/provider/data_provider.dart';

class CustomSearchBar extends StatefulWidget {
  final ScheduleViewModel model;

  const CustomSearchBar({super.key, required this.model});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 350.w,
        child: ListenableBuilder(
            listenable: widget.model,
            builder: (context, _){
              return SearchAnchor(
                builder: (BuildContext context, SearchController controller) {
                  return SearchBar(
                      overlayColor: WidgetStateProperty.all<Color>(Colors.blue.withOpacity(0.09)),
                      backgroundColor: WidgetStateProperty.resolveWith<Color>(
                            (Set<WidgetState> states) {
                          if (states.contains(WidgetState.hovered)) {
                            return Colors.blue.withValues(alpha: 0.09); // Цвет при наведении
                          }
                          return Colors.white; // Обычный цвет
                        },
                      ),
                      side: WidgetStateProperty.all(const BorderSide(color: Colors.blue)),
                      elevation: const WidgetStatePropertyAll<double>(0),
                      controller: controller,
                      hintText: "Поиск",
                      hintStyle: WidgetStateProperty.all<TextStyle?>(
                        TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 4.sp,
                            color: Colors.black
                        ),
                      ),
                      trailing: [buildCancelButton(controller)],
                      surfaceTintColor: const WidgetStatePropertyAll<Color>(Colors.black),
                      padding: WidgetStatePropertyAll<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 6.w)
                      ),
                      onChanged: (value){
                        widget.model.enteredKeyWord = value;
                        widget.model.applyFilter();
                      },
                      leading: Icon(Icons.search),
                      textStyle: WidgetStateProperty.all<TextStyle?>(
                        TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 5.sp,
                            color: Colors.black
                        ),
                      )
                  );
                },
                suggestionsBuilder: (BuildContext context, SearchController controller) { return []; },
              );
            })
    );
  }

  Widget buildCancelButton(SearchController controller){
    return IconButton(
      onPressed: (){
        widget.model.enteredKeyWord = "";
        controller.value = TextEditingValue(
            text: "",
            selection: TextSelection.collapsed(offset: 0)
        );
        widget.model.applyFilter();
      },
      icon: Icon(Icons.highlight_remove_sharp, color: Colors.black),
    );
  }
}
