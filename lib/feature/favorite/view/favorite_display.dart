import 'package:flutter/material.dart';
import 'package:recipe_app/data/remote_data_sources/current_user_repo.dart';

import '../../../utils/const.dart';

class FavoriteDisplay extends StatelessWidget {
  const FavoriteDisplay({
    Key? key,
    required this.currentUserRepo,
  }) : super(key: key);

  final CurrentUserRepo currentUserRepo;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
            width: MediaQuery.of(context).size.width,
            height: 180,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.6),
                  offset: const Offset(
                    0.0,
                    10.0,
                  ),
                  blurRadius: 10.0,
                  spreadRadius: -6.0,
                ),
              ],
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.35),
                  BlendMode.multiply,
                ),
                image: NetworkImage(linkDrinkPicture),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                const Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      'drink name',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
              ],
            ),
          );
        });
  }
}
