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
                  builder: (BuildContext context, SearchController controller){
                    return SearchBar(
                      controller: controller,
                      hintText: "Поиск по названию группы",
                      hintStyle: WidgetStatePropertyAll<TextStyle>(
                          TextStyle(fontStyle: FontStyle.italic, color: Colors.grey)
                      ),
                      padding: const WidgetStatePropertyAll<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 16.0)
                      ),
                      onTap: (){
                        controller.openView();
                      },
                      onChanged: (_){
                        controller.openView();
                      },
                      leading: const Icon(Icons.search),
                    );
                  },
                  suggestionsBuilder: (BuildContext context, SearchController controller){
                    var data = widget.model.suggestion;
                    return List<ListTile>.generate(data.length, (int index){
                      return ListTile(
                        title: Text(data[index]),
                        onTap: (){
                          setState(() {
                            widget.model.enteredKeyWord = data[index];
                            widget.model.applyFilter();
                            controller.closeView(data[index]);
                          });
                        },
                      );
                    });
                  }
              );
            })
    );
  }
}
