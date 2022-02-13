import 'package:animate_do/animate_do.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:eShoppie/AppCubits/%D9%8DSearchPageScreenCubit/search_page_cubit.dart';
import 'package:eShoppie/AppCubits/%D9%8DSearchPageScreenCubit/search_page_states.dart';
import 'package:eShoppie/AppCubits/UserHomeCubit/user_home_cubit.dart';
import 'package:eShoppie/AppCubits/UserHomeCubit/user_home_states.dart';
import 'package:eShoppie/MyWidgets/list_view_with_separator.dart';
import 'package:eShoppie/MyWidgets/my_button.dart';
import 'package:eShoppie/MyWidgets/my_text.dart';
import 'package:eShoppie/MyWidgets/my_text_field.dart';
import 'package:eShoppie/MyWidgets/no_connection.dart';
import 'package:eShoppie/MyWidgets/no_search_results.dart';
import 'package:eShoppie/MyWidgets/search_for.dart';
import 'package:eShoppie/Shared/functions.dart';
import 'package:eShoppie/constants.dart';
import 'package:eShoppie/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);

  final searchText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchPageCubit(),
      child: BlocConsumer<SearchPageCubit, SearchPageStates>(
          listener: (context, state) {},
          builder: (context, state) {
            SearchPageCubit searchPageCubit = SearchPageCubit.get(context);
            return Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                backgroundColor: K_whiteColor.withOpacity(0.8),
                elevation: 0.0,
                leading: IconButton(
                    onPressed: () {
                      navigateBack(context);
                    },
                    icon: const Icon(
                      CupertinoIcons.back,
                      color: K_blackColor,
                      size: 28.0,
                    )),
              ),
              body: Stack(
                children: [
                  ConditionalBuilder(
                    condition: state is SearchPageInitState,
                    builder: (context) => const SearchForState(),
                    fallback: (context) => ConditionalBuilder(
                      condition: state is SearchPageLoadingProductsState,
                      builder: (context) => K_progressIndicator,
                      fallback: (context) => ConditionalBuilder(
                        condition: state is SearchPageGetProductsState &&
                            searchPageCubit.searchedProducts.isNotEmpty,
                        builder: (context) => SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              children: [
                                ListViewWithSeparator(
                                  list: searchPageCubit.searchedProducts,
                                  userHomeCubit: searchPageCubit,
                                ),
                                K_vSpace20,
                                K_vSpace20,
                                K_vSpace20,
                                K_vSpace20,
                              ],
                            ),
                          ),
                        ),
                        fallback: (context) => ConditionalBuilder(
                          condition: searchPageCubit.searchedProducts.isEmpty &&
                              state is! SearchPageErrorState,
                          builder: (context) => NoResultsState(
                            searchTextController: searchText,
                          ),
                          fallback: (context) => const NoConnectionState(),
                        ),
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SlideInUp(
                        duration: const Duration(milliseconds: 500),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: shadow,
                            color: K_whiteColor,
                          ),
                          height: 70.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: MyTextField(
                                    borderRadius: K_radius,
                                    borderColor: K_blackColor,
                                    validatorText: '',
                                    hintText: 'Search for a product...',
                                    hintTextColor:
                                        K_blackColor.withOpacity(0.7),
                                    textController: searchText,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: FloatingActionButton(
                                    backgroundColor: K_blackColor,
                                    child: const Icon(
                                      CupertinoIcons.search,
                                      color: K_whiteColor,
                                      size: 28.0,
                                    ),
                                    onPressed: () async {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      await searchPageCubit
                                          .getSearchedProducts(searchText.text);
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
