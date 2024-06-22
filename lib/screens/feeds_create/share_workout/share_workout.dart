import 'dart:io';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/screens/feeds_create/share_workout/share_workout_model.dart';

class ShareWorkoutView extends StatelessWidget {
  final String workoutId;
  const ShareWorkoutView({super.key, required this.workoutId});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => ShareWorkoutModel(workoutId: workoutId),
        onViewModelReady: (model) => model.initState(),
        onDispose: (model) => model.disposeAll(),
        builder: (context, model, _) {
          return model.isBusy
              ? const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                )
              : Scaffold(
                  appBar: AppBar(
                    title: const Text('Share Workout Plan'),
                    backgroundColor: Colors.black,
                  ),
                  bottomNavigationBar: buttonSection(model, context),
                  body: SizedBox(
                    child: Column(
                      children: [
                        imagePageSection(context, model),
                        commentSection(model),
                      ],
                    ),
                  ));
        });
  }

  Container buttonSection(ShareWorkoutModel model, BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey, width: 2))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(left: 25),
              child: IconButton(
                onPressed: () {
                  model.pickImages();
                },
                icon: Icon(
                  MdiIcons.imagePlusOutline,
                  size: 35,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              margin: const EdgeInsets.only(right: 25),
              child: IconButton(
                onPressed: model.getCommentFieldController.text.isNotEmpty &&
                        model.getImageFileList.isNotEmpty
                    ? () => model.createPost(context)
                    : () => model.getFormKey.currentState!.validate(),
                icon: Icon(MdiIcons.plusCircle,
                    size: 35,
                    color: model.getCommentFieldController.text.isNotEmpty &&
                            model.getImageFileList.isNotEmpty
                        ? Colors.white
                        : Colors.black87),
              ),
            ),
          )
        ],
      ),
    );
  }

  Expanded commentSection(ShareWorkoutModel model) {
    return Expanded(
      child: Form(
        key: model.getFormKey,
        child: Container(
          margin: const EdgeInsets.only(left: 25, right: 25),
          child: TextFormField(
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            textAlign: TextAlign.start,
            maxLines: null,
            style: const TextStyle(fontSize: 18),
            validator: model.validateEmpty,
            controller: model.getCommentFieldController,
            decoration: const InputDecoration(
                hintText: 'Comments something...', border: InputBorder.none),
          ),
        ),
      ),
    );
  }

  SizedBox imagePageSection(BuildContext context, ShareWorkoutModel model) {
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: model.getImageFileList.isEmpty
            ? const Center(
                child: Text(
                  'Pick some images...',
                  style: TextStyle(fontSize: 18),
                ),
              )
            : PageView.builder(
                itemCount: model.getImageFileList.length,
                itemBuilder: (context, index) {
                  final content = model.getImageFileList[index];

                  return Column(
                    children: [
                      Expanded(
                          child: Container(
                        margin: const EdgeInsets.only(left: 25, right: 25),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                fit: BoxFit.contain,
                                image: FileImage(File(content.path)))),
                      )),
                      model.getImageFileList.length != 1
                          ? Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.only(top: 5),
                              child: Center(
                                  child: DotsIndicator(
                                dotsCount: model.getImageFileList.length,
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
                }));
  }
}
