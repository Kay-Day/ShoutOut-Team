import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shoutout_shop_app/controllers/categories_controller.dart';

class CategoryItemWidget extends StatelessWidget {
  const CategoryItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final CategoryController _categoryController =
        Get.find<CategoryController>();
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Danh mục',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Xem tất cả',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          GridView.builder(
            itemCount: _categoryController.categories.length,
            shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, crossAxisSpacing: 8, mainAxisSpacing: 8),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width *0.18,
                      height: MediaQuery.of(context).size.width*0.18,

                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          MediaQuery.of(context).size.width * 0.18/2,
                        ) ,
                        border: Border.all(color: Colors.grey,),
                      ),
                      child: Image.network(
                        _categoryController.categories[index].categoryImage,
                        // fit: BoxFit.cover,
                      ),
                    ),
                    Text(_categoryController.categories[index].categoryName.toUpperCase(), style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),),

                  ],
                );

              })
        ],
      );
    });
  }
}
