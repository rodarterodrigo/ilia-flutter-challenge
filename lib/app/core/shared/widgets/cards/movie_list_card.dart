import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MovieListCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final double voteAverage;
  final String overview;

  const MovieListCard(
      {Key? key,
      required this.imagePath,
      required this.title,
      required this.voteAverage,
      required this.overview})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 110,
              height: 162,
              child: CachedNetworkImage(
                imageUrl: imagePath,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Text(title, maxLines: 2),
                    ),
                    Text(voteAverage.toString())
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: 200,
                  child: Text(
                    overview,
                    maxLines: 7,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
