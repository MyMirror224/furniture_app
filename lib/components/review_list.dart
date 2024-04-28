import 'package:flutter/material.dart';
import 'package:furniture_app/state/review/review_provider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProductReviewList extends ConsumerWidget {

  const ProductReviewList({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviews = ref.watch(productReviewsProvider);
    return Expanded(
      child: ListView.builder(
        itemCount: reviews.reviewList.length,
        itemBuilder: (context, index) {
          final review = reviews.reviewList[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(review.userImageUrl),
                        ),
                        const SizedBox(width: 8.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              review.userName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: List.generate(
                                5,
                                (index) => Icon(
                                  index < review.rating
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Colors.amber,
                                  size: 16.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Text(review.reviewText),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

