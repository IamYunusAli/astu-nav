// flutter map 
// developed by Yunus ali
//yunus.ali.hassen@gmail.com
//google map


import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_tracker/aboutus.dart';

import 'models.dart';
import 'place.dart';
import 'lists.dart';
import 'place_map.dart';
import 'datas.dart';


enum PlaceTrackerViewType {
  map,
  list,
}

class PlaceTrackerApp extends StatefulWidget {
  @override
  _PlaceTrackerAppState createState() => _PlaceTrackerAppState();
}

class _PlaceTrackerAppState extends State<PlaceTrackerApp> {
  AppState appState = AppState();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (BuildContext context, Widget child) {
        return AppModel<AppState>(
          initialState: AppState(),
          child: child,
        );
      },
      home: _PlaceTrackerHomePage(),
    );
  }
}

class _PlaceTrackerHomePage extends StatelessWidget {
  const _PlaceTrackerHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     drawer: new Drawer(
        elevation: (0.0),
        child: ListView(
          children: <Widget>[
            new Container(
            child: new UserAccountsDrawerHeader(
              accountName: new Text('Maed Technologies'),
              accountEmail: new Text('aliyunus291@gmail.com'),
              currentAccountPicture: new CircleAvatar(
                backgroundImage: AssetImage('assets/maed.png'),
              ),
            ),
            ),
            new ListTile(
              title: new Text('About Page',style: new TextStyle(fontSize: 18.0),),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    new MaterialPageRoute(
                        builder: (BuildContext context) => new AboutPage()));
              },
              leading: Icon(
                Icons.done,
                color: Colors.deepOrange,
              ),
            ),
            new ListTile(
              title: new Text('Contacts', style: new TextStyle(fontSize: 18.0),),
            )
          ],
        ),
      ),
          // appBar: AppBar(
      //   title: Row(
      //     crossAxisAlignment: CrossAxisAlignment.center,
      //     children: const <Widget>[
      //       Padding(
      //         padding: EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 0.0),
             
      //       ),
      //       Text('ASTU Nav'),
      //     ],
      //   ),
      //   backgroundColor: Colors.transparent,
      //   actions: <Widget>[
      //     Padding(
      //       padding: EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 0.0),
      //       child: IconButton(
      //         icon: Icon(
      //           AppState.of(context).viewType == PlaceTrackerViewType.map
      //               ? Icons.list
      //               : Icons.arrow_back,
      //           size: 32.0,
      //         ),
      //         onPressed: () {
      //           AppState.updateWith(
      //             context,
      //             viewType:
      //                 AppState.of(context).viewType == PlaceTrackerViewType.map
      //                     ? PlaceTrackerViewType.list
      //                     : PlaceTrackerViewType.map,
      //           );
      //         },
      //       ),
      //     ),
      //   ],
      // ),
   
      body: IndexedStack(
        index:
            AppState.of(context).viewType == PlaceTrackerViewType.map ? 0 : 1,
        children: <Widget>[
          PlaceMap(center: const LatLng(8.562717, 39.290678)),
          PlaceList(),
        ],
      ),


      

      // bottomNavigationBar: new bottomNavigationBar(
      //   items[
      //     new bottomNavigationBar(icon: new Icon.menu, title: new text("Menu")),
      //     new bottomNavigationBar(icon: new Icon.home, title: new text("Home")),
      //     new bottomNavigationBar(icon: new Icon.menu, title: new text("Menu")),
      //   ],

    bottomNavigationBar: new BottomAppBar(

    child: IconButton(
              icon: Icon(
                AppState.of(context).viewType == PlaceTrackerViewType.map
                    ? Icons.list
                    : Icons.arrow_back,
                size: 32.0,
              ),
              onPressed: () {
                AppState.updateWith(
                  context,
                  viewType:
                      AppState.of(context).viewType == PlaceTrackerViewType.map
                          ? PlaceTrackerViewType.list
                          : PlaceTrackerViewType.map,
                );
                
                },
               )
    ),
    );
  }
}

class AppState {
  const AppState({
    this.places = StubData.places,
    this.selectedCategory = PlaceCategory.blocks,
    this.viewType = PlaceTrackerViewType.map,
  })  : assert(places != null),
        assert(selectedCategory != null);

  final List<Place> places;
  final PlaceCategory selectedCategory;
  final PlaceTrackerViewType viewType;

  AppState copyWith({
    List<Place> places,
    PlaceCategory selectedCategory,
    PlaceTrackerViewType viewType,
  }) {
    return AppState(
      places: places ?? this.places,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      viewType: viewType ?? this.viewType,
    );
  }

  static AppState of(BuildContext context) => AppModel.of<AppState>(context);

  static void update(BuildContext context, AppState newState) {
    AppModel.update<AppState>(context, newState);
  }

  static void updateWith(
    BuildContext context, {
    List<Place> places,
    PlaceCategory selectedCategory,
    PlaceTrackerViewType viewType,
  }) {
    update(
      context,
      AppState.of(context).copyWith(
        places: places,
        selectedCategory: selectedCategory,
        viewType: viewType,
      ),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    final AppState otherAppState = other;
    return otherAppState.places == places &&
        otherAppState.selectedCategory == selectedCategory &&
        otherAppState.viewType == viewType;
  }

  @override
  int get hashCode => hashValues(places, selectedCategory, viewType);
}
