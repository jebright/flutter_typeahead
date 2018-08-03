import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'search.dart';
import 'service_state.dart';

class TypeAhead<T> extends StatelessWidget {
  final Search<T> search;
  //final SearchApi<T> api;

  TypeAhead({
    Key key,
    @required this.search,
  }) : super(key: key) {
   // _search = new Search(api);
  }

  Widget buildState(ServiceState serviceState) {
    if(serviceState.isProcessing)
    {
      print('state: processing');
      return new Center(child: new Container( margin: const EdgeInsets.all(10.0), child: new CircularProgressIndicator()));
    }
    else if (serviceState.result?.model != null) {
      ListView lb = new ListView.builder(
          shrinkWrap: true,
          itemCount: serviceState.result?.model?.length ?? 0,
          itemBuilder: (c, i) {
            String item = serviceState.result.model[i];
            return new Container(
              child: new Text(
                item,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            );
          });
      return lb;
    } else {
      return new Text("no results");
    }
  }

  @override
  build(BuildContext context) {
    return new StreamBuilder<ServiceState>(
        stream: search.state,
        initialData: new ServiceState.initial(),
        builder: (BuildContext context, AsyncSnapshot<ServiceState> snapshot) {
          final serviceState = snapshot.data;

          return new Column(children: [
            new TextField(                
                onChanged: (String s) => search.onTextChanged.add(s)),
            new Row(
              children: <Widget>[
                new Expanded(child: buildState(serviceState))
              ],
            )
          ]);
        });

    /*
          body: new Stack(
            children: <Widget>[
              new Flex(direction: Axis.vertical, children: <Widget>[
                new Container(
                  padding: new EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 4.0),
                  child: new TextField(
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search...',
                    ),
                    style: new TextStyle(
                      fontSize: 36.0,
                      fontFamily: "Hind",
                      decoration: TextDecoration.none,
                    ),
                    onChanged: (String s) => search.onTextChanged.add(s),
                  ),
                ),
                new Expanded(
                  child: new Stack(
                    children: <Widget>[
                      // // Fade in an intro screen if no term has been entered
                      // new SearchIntroWidget(model.result?.isNoTerm ?? false),

                      // // Fade in an Empty Result screen if the search contained
                      // // no items
                      // new EmptyResultWidget(model.result?.isEmpty ?? false),

                      // // Fade in a loading screen when results are being fetched
                      // // from Github
                      // new SearchLoadingWidget(model.isLoading ?? false),

                      // // Fade in an error if something went wrong when fetching
                      // // the results
                      // new SearchErrorWidget(model.hasError ?? false),

                      // // Fade in the Result if available
                      // new SearchResultWidget(model.result),
                    ],
                  ),
                )
              ])
            ],
          ),
      },
    );*/
  }
}

