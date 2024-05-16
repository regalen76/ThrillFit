import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/screens/feeds/feeds_view_model.dart';
import 'package:firebase_pagination/firebase_pagination.dart';
import 'package:thrill_fit/shared/media_type.dart';
import 'package:dots_indicator/dots_indicator.dart';

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
                  body: SizedBox(
                    child: FirestorePagination(
                        query: model.getPostsQuery,
                        viewType: ViewType.list,
                        separatorBuilder: (context, index) {
                          return const SizedBox(height: 25);
                        },
                        itemBuilder: (context, dataSnapshot, index) {
                          final postData = model.mapToPostModel(dataSnapshot);

                          return Container(
                              color: Colors.blue,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                      alignment: Alignment.topCenter,
                                      child: Container(
                                          width: 60,
                                          height: 60,
                                          margin:
                                              const EdgeInsets.only(left: 7.5),
                                          color: Colors.pink,
                                          child: SizedBox(
                                              width: 50,
                                              height: 50,
                                              child: FutureBuilder(
                                                  future: model
                                                      .fetchProfilePictureUrl(
                                                          postData.author),
                                                  builder: (context, snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return const CircleAvatar(
                                                        radius: (82),
                                                        backgroundColor:
                                                            Colors.black,
                                                        child:
                                                            CircularProgressIndicator(),
                                                      );
                                                    } else {
                                                      return CircleAvatar(
                                                        radius: (82),
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                snapshot.data!),
                                                      );
                                                    }
                                                  })))), //profile image
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Container(
                                        color: Colors.pink,
                                        margin: const EdgeInsets.only(left: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: FutureBuilder(
                                                  future: model.getUserName(
                                                      postData.author),
                                                  builder: (context, snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return const SizedBox(
                                                        height: 20,
                                                      );
                                                    } else {
                                                      return SizedBox(
                                                        height: 20,
                                                        child: Text(
                                                          snapshot.data!,
                                                          textAlign:
                                                              TextAlign.start,
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 18),
                                                        ),
                                                      );
                                                    }
                                                  }), //Nama
                                            ),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.80,
                                                child: Text(
                                                  postData.body,
                                                  style: const TextStyle(
                                                      fontSize: 16),
                                                )),
                                            Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.80,
                                                color: Colors.green,
                                                margin: const EdgeInsets.only(
                                                    top: 15),
                                                height: 250,
                                                child: PageView.builder(
                                                    itemCount: postData
                                                        .content!.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final content = postData
                                                          .content![index];

                                                      if (MediaType()
                                                          .isImage(content)) {
                                                        return FutureBuilder(
                                                            future: model
                                                                .fetchPostImage(
                                                                    content),
                                                            builder: (context,
                                                                snapshot) {
                                                              if (snapshot
                                                                      .connectionState ==
                                                                  ConnectionState
                                                                      .waiting) {
                                                                return const Center(
                                                                    child:
                                                                        CircularProgressIndicator());
                                                              } else {
                                                                return Column(
                                                                  children: [
                                                                    Expanded(
                                                                        child:
                                                                            Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              20),
                                                                          image:
                                                                              DecorationImage(image: NetworkImage(snapshot.data!))),
                                                                    )),
                                                                    postData.content!.length !=
                                                                            1
                                                                        ? Container(
                                                                            width:
                                                                                MediaQuery.of(context).size.width * 0.80,
                                                                            margin:
                                                                                const EdgeInsets.only(top: 10),
                                                                            child: Center(
                                                                                child: DotsIndicator(
                                                                              dotsCount: postData.content!.length,
                                                                              position: index,
                                                                              decorator: const DotsDecorator(
                                                                                color: Colors.white, // Inactive color
                                                                                activeColor: Colors.lightBlue,
                                                                              ),
                                                                            )),
                                                                          )
                                                                        : Container()
                                                                  ],
                                                                );
                                                              }
                                                            });
                                                      } else if (MediaType()
                                                          .isVideo(content)) {}
                                                      throw Exception(
                                                          "Unsupported Content");
                                                    })), //content
                                          ],
                                        ),
                                      ))
                                ],
                              ));
                        }),
                  ));
        });
  }
}
