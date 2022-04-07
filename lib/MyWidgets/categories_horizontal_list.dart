import 'package:eshoppie/AppCubits/UserHomeCubit/user_home_cubit.dart';
import 'package:eshoppie/Models/categories.dart';
import 'package:eshoppie/MyWidgets/my_text.dart';
import 'package:eshoppie/constants.dart';
import 'package:flutter/material.dart';

class CategoriesHorizontalList extends StatelessWidget {
  const CategoriesHorizontalList(
      {Key? key, required this.cateList, required this.userHomeCubit})
      : super(key: key);

  final List<Category> cateList;
  final UserHomeCubit userHomeCubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 35.0,
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: cateList.length,
          separatorBuilder: (context, index) => const SizedBox(
            width: 10.0,
          ),
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsetsDirectional.only(
                  start: index == 0 ? 15.0 : 0.0,
                  end: index == cateList.length - 1 ? 15.0 : 0.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(K_radius),
                    border: Border.all(color: K_blackColor, width: 2.0)),
                child: InkWell(
                  onTap: () {
                    userHomeCubit.getAllProductsOrSpecificCategory(
                        cateList[index].categoryID);
                  },
                  borderRadius: BorderRadius.circular(K_radius),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MyText(
                      text:
                          cateList[index].categoryName.toString().toUpperCase(),
                      size: K_fontSizeM - 4.0,
                      color: K_blackColor,
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }
}
