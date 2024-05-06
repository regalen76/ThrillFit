import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/screens/feeds/feeds_view_model.dart';
import 'package:firebase_pagination/firebase_pagination.dart';

class FeedsView extends StatelessWidget {
  const FeedsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => FeedsViewModel(),
        builder: (context, model, _) {
          return model.isBusy
              ? const Center(child: CircularProgressIndicator())
              : Scaffold(
                  appBar: AppBar(),
                  body: FirestorePagination(
                      query: model.getPostsQuery,
                      viewType: ViewType.list,
                      itemBuilder: (context, dataSnapshot, index) {
                        final Map<String, dynamic>? data =
                            dataSnapshot.data() as Map<String, dynamic>?;

                        if (data == null) return Container();

                        return Column(
                          children: [
                            Text(data['body']),
                            Divider(
                              height: 350,
                            ),
                            Text(data['timestamp'].toString())
                          ],
                        );
                      }),
                );
        });
  }
}
