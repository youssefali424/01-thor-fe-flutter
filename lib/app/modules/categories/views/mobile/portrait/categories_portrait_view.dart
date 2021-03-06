import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:thor_flutter/app/global_widgets/animation/fade_animation.dart';
import 'package:thor_flutter/app/global_widgets/animation/side_animation.dart';
import 'package:thor_flutter/app/global_widgets/app/category_circle_widget.dart';
import 'package:thor_flutter/app/global_widgets/app/loading_widget.dart';
import 'package:thor_flutter/app/global_widgets/app/product_grid_card_widget.dart';
import 'package:thor_flutter/app/modules/categories/categories_controller.dart';
import 'package:thor_flutter/app/modules/categories/views/mobile/portrait/local_widgets/breadcrumd_categories.dart';
import 'package:thor_flutter/app/routes/app_routes.dart';
import 'package:thor_flutter/app/utils/constants.dart';

class CategoriesPortraitView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoriesController>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text(_.categoryName,
              style: Theme.of(context).textTheme.bodyText2),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
          ],
        ),
        body: Stack(
          children: [
            Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: Constants.SPACING_S,
                    ),
                    _.breadcrumb.length > 1
                        ? BreadCrumbCategories()
                        : Container(),
                    SizedBox(
                      height: Constants.SPACING_S,
                    ),
                    _.categories.length > 0
                        ? GridView.builder(
                            itemCount: _.categories.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 18.0),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 15.0,
                              mainAxisSpacing: 15.0,
                              childAspectRatio: 4.0 / 6.0,
                            ),
                            itemBuilder: (context, index) {
                              var category = _.categories[index];
                              double duration = index / 2;
                              return FadeInAnimation(
                                duration.toInt(),
                                child: CategoryCircle(
                                  category: category,
                                  onTap: () {
                                    _.fetchCategories(
                                        id: category.id, name: category.name);
                                  },
                                ),
                              );
                            },
                          )
                        : Container(),
                    _.products.length == 0
                        ? Container()
                        : SideInAnimation(
                            2,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18.0, vertical: 15.0),
                              child: Text(
                                'Productos',
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ),
                          ),
                    StaggeredGridView.countBuilder(
                      itemCount: _.products.length,
                      crossAxisCount: 4,
                      staggeredTileBuilder: (int index) => StaggeredTile.fit(2),
                      mainAxisSpacing: 15.0,
                      crossAxisSpacing: 15.0,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                      itemBuilder: (context, index) {
                        var product = _.products[index];
                        return FadeInAnimation(
                          index,
                          child: ProductGridCard(
                            product: product,
                            onTap: () {
                              _.appCtl.navigateToRoute(AppRoutes.PRODUCTDETAIL,
                                  arguments: product.id);
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Obx(() => LoadingOverlay(
                  isLoading: _.isLoading.value,
                )),
          ],
        ),
      );
    });
  }
}
