import 'package:flutter/material.dart';
import 'package:pacegotwo/providers/dropprovider.dart';
import 'package:provider/provider.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List category = [
    "Clothings",
    "Shoes",
    "Electronics",
    "Jewellery/Accessories",
    "Documents",
    "Health",
    "Products",
    "Computer Accessories",
    "Phone",
    "Food",
    "Frozen Food",
    "Others"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1E4854),
      appBar: AppBar(
        title: Text(
          "Item(s) Category",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xFF1E4854),
        elevation: 0.0,
      ),
      body: ListView.builder(
          shrinkWrap: true,
          itemCount: category.length,
          itemBuilder: (BuildContext context, index) {
            return Row(
              children: [
                Checkbox(
                  side: BorderSide(
                    color: Color(0xFF049FA3),
                    width: 2.0,
                  ),
                  value: context
                      .watch<DropoffProvider>()
                      .getCategoryList
                      .contains(category[index]),
                  onChanged: (value) {
                    context
                        .read<DropoffProvider>()
                        .updateCategoryList(category[index]);
                  },
                ),
                Text(
                  category[index].toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            );
          }),
    );
  }
}
