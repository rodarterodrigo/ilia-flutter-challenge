import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:unicons/unicons.dart';

class MovieListCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final double voteAverage;
  final String overview;
  final GestureTapCallback onTap;

  const MovieListCard(
      {Key? key,
      required this.imagePath,
      required this.title,
      required this.voteAverage,
      required this.overview,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.only(left: 16, right: 16, bottom: 8, top: 8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 110,
                height: 162,
                child: imagePath.isEmpty?
                const SizedBox():
                Hero(
                  tag: '$title$imagePath',
                  child: CachedNetworkImage(
                    imageUrl: imagePath,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 190,
                        child: Text(
                          title,
                          maxLines: 2,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Shimmer.fromColors(
                              highlightColor: Colors.white,
                              baseColor: Colors.amber,
                              child: const Icon(UniconsSolid.star,
                                  color: Colors.amber, size: 16)),
                          const SizedBox(height: 2),
                          Text(
                            voteAverage.toString(),
                            style: const TextStyle(
                              color: Colors.amber,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(
                      overview,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 7,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
