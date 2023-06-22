import 'package:flutter/material.dart';

import 'package:flutter_restaurant_fic5/data/models/responses/add_product_response_model.dart';
import 'package:flutter_restaurant_fic5/presentation/pages/detail_restaurant_page.dart';
import 'package:go_router/go_router.dart';

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({
    Key? key,
    required this.data,
  }) : super(key: key);
  final Restaurant data;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.push('${DetailRestaurantPage.routeName}/${data.id}'),
      child: Card(
        child: ListTile(
          title: Text(data.attributes.name),
          subtitle: Text(data.attributes.description),
          leading: CircleAvatar(
            radius: 18,
            child: Image.network(data.attributes.photo),
          ),
        ),
      ),
    );
  }
}
