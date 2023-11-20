import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class CommonSearchableList extends StatefulWidget {
  final String title;
  final List<String> streetList;

  const CommonSearchableList(
      {super.key, required this.title, required this.streetList});

  @override
  CommonSearchableListState createState() => CommonSearchableListState();
}

class CommonSearchableListState extends State<CommonSearchableList> {
  List<String> filteredList = [];
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    filteredList = widget.streetList;
  }

  void filterList(String query) {
    setState(() {
      filteredList = widget.streetList
          .where((string) => string.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: AlertDialog(
        titlePadding: const EdgeInsets.all(10),
        contentPadding: const EdgeInsets.all(2),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title),
            const SizedBox(
              height: 10,
            ),
            TextField(
              onChanged: filterList,
              decoration: const InputDecoration(
                  suffixIcon: Icon(Icons.search),
                  contentPadding:
                      EdgeInsets.only(left: 4, right: 0, top: 0, bottom: 0),
                  hintText: 'Search...',
                  border: OutlineInputBorder(gapPadding: 0)),
            ),
          ],
        ),
        content: SizedBox(
          height: 50.h,
          width: double.maxFinite,
          child:widget.streetList.isEmpty||filteredList.isEmpty?const Center(child: Text("no data found !"),): Scrollbar(
            interactive: true,
            trackVisibility: true,
            thickness: 20,
            radius: const Radius.circular(10),
            thumbVisibility: true,
            controller: scrollController,
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: ListView.builder(
                controller: scrollController,
                shrinkWrap: true,
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.all(2),
                    semanticContainer: true,
                    elevation: 1,
                    child: ListTile(
                      onTap: () {
                        Get.back(result: filteredList[index]);
                      },
                      title: Text(
                        filteredList[index],
                        style: const TextStyle(overflow: TextOverflow.ellipsis),
                        maxLines: 1,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text("CANCEL"))
        ],
      ),
    );
  }
}
