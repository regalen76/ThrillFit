import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:thrill_fit/screens/navigator_view_model.dart';

class NavigatorView extends StatelessWidget {
  const NavigatorView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => NavigatorViewModel(),
        onViewModelReady: (viewModel) => viewModel.initState(context),
        builder: (context, model, _) {
          return model.isBusy
              ? const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                )
              : Scaffold(
                  body: model.getScreens[model.getCurrentTabIndex],
                  bottomNavigationBar: Theme(
                    data: ThemeData(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                    child: BottomNavigationBar(
                      showSelectedLabels: true,
                      showUnselectedLabels: false,
                      currentIndex: model.getCurrentTabIndex,
                      backgroundColor: Colors.black,
                      unselectedItemColor: Colors.grey,
                      selectedItemColor: Colors.blue,
                      onTap: (int index) {
                        model.changeIndex(index);
                      },
                      items: [
                        BottomNavigationBarItem(
                            icon: Icon(MdiIcons.home), label: 'Feeds'),
                        BottomNavigationBarItem(
                            icon: Icon(MdiIcons.dumbbell),
                            label: 'Workout Plans'),
                        BottomNavigationBarItem(
                            icon: Icon(MdiIcons.trophyAward),
                            label: 'Challenges')
                      ],
                    ),
                  ),
                );
        });
  }
}
