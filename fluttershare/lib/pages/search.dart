import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttershare/models/user.dart';
import 'package:fluttershare/pages/activity_feed.dart';
import 'package:fluttershare/pages/home.dart';
import 'package:fluttershare/widgets/progress.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final searchEditingController = TextEditingController();
  bool showSuffixIcon = false;
  Future<QuerySnapshot> searchResultsFuture;

  void handleSearch(String query) {
    Future<QuerySnapshot> users = userRef
        .where("displayName", isGreaterThanOrEqualTo: query)
        .getDocuments();
    setState(() {
      searchResultsFuture = users;
    });
  }

  Widget buildSearchField() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Center(
        child: TextFormField(
          style: TextStyle(fontSize: 18),
          controller: searchEditingController,
          decoration: InputDecoration(
              hintText: 'Search for the user..',
//          filled: true,
              icon: Icon(Icons.search),
              border: InputBorder.none,
              suffixIcon: showSuffixIcon
                  ? IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          searchEditingController.clear();
                          showSuffixIcon = false;
                          FocusScope.of(context).unfocus();
                        });
                      },
                    )
                  : null),
          onChanged: (value) {
            if (value.isEmpty) {
              setState(() {
                showSuffixIcon = false;
              });
            } else {
              setState(() {
                showSuffixIcon = true;
              });
            }

          },
          onFieldSubmitted: handleSearch,
        ),
      ),
    );
  }

  Widget buildNoContent() {
    final Orientation orientation = MediaQuery.of(context).orientation;
    return Container(
      child: Center(
        child: ListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            SvgPicture.asset(
              'assets/images/search.svg',
              height: orientation == Orientation.portrait ? 200 : 150,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Find Users',
              textAlign: TextAlign.center,
              style: TextStyle(
                  letterSpacing: 1.5,
                  color: Colors.deepOrange[500],
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }

  buildSearchResults() {
    return FutureBuilder(
      future: searchResultsFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return circularProgress();
        }
        List<UserResult> searchResults = [];
        snapshot.data.documents.forEach((doc) {
          User user = User.fromDocument(doc);
          UserResult searchResult = UserResult(user);
          searchResults.add(searchResult);
        });
        return ListView(
          children: searchResults,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: buildSearchField(),
        body: searchResultsFuture == null
            ? buildNoContent()
            : buildSearchResults(),
      ),
    );
  }
}

class UserResult extends StatelessWidget {
  final User user;

  UserResult(this.user);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: ()=>showProfile(context,profileId: user.id),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey,
              backgroundImage: CachedNetworkImageProvider(user.photoUrl),
            ),
            title: Text(
              user.displayName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(user.username),
          ),
        ),
        Divider(),
      ],
    );
  }
}
