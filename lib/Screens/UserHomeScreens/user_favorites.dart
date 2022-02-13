import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:eShoppie/AppCubits/UserHomeCubit/user_home_cubit.dart';
import 'package:eShoppie/AppCubits/UserHomeCubit/user_home_states.dart';
import 'package:eShoppie/MyWidgets/list_view_with_separator.dart';
import 'package:eShoppie/MyWidgets/my_text.dart';
import 'package:eShoppie/MyWidgets/no_connection.dart';
import 'package:eShoppie/MyWidgets/no_favorites.dart';
import 'package:eShoppie/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserFavorite extends StatelessWidget {
  const UserFavorite({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) =>
            UserHomeCubit()..getFavoritesProducts(),
        child: BlocConsumer<UserHomeCubit, UserHomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            UserHomeCubit userHomeCubit = UserHomeCubit.get(context);
            return ConditionalBuilder(
              condition: state is GotProductsLoadingState,
              builder: (context) => K_progressIndicator,
              fallback: (context) => ConditionalBuilder(
                condition: state is GotProductsState,
                builder: (context) => SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 15.0, bottom: 10.0),
                        child: MyText(
                            text: 'Your favorites', size: K_fontSizeL + 5),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.all(15.0),
                        child: ListViewWithSeparator(
                          list: userHomeCubit.products,
                          userHomeCubit: userHomeCubit,
                        ),
                      ),
                    ],
                  ),
                ),
                fallback: (context) => state is! NoFavoritesState
                    ? const NoConnectionState()
                    : const NoFavoritesWidget(),
              ),
            );
          },
        ));
  }
}
