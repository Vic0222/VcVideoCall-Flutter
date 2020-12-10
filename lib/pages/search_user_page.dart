import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vc_video_call/blocs/search_user/search_user_bloc.dart';
import 'package:vc_video_call/blocs/search_user/search_user_state.dart';
import 'package:vc_video_call/components/user_card.dart';

class SearchUserPage extends StatefulWidget {
  const SearchUserPage({Key key}) : super(key: key);

  @override
  _SearchUserPageState createState() => _SearchUserPageState();
}

class _SearchUserPageState extends State<SearchUserPage> {
  @override
  void initState() {
    super.initState();
    _searchTextController = TextEditingController();
  }

  @override
  void dispose() {
    _searchTextController?.dispose();
    super.dispose();
  }

  TextEditingController _searchTextController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 90,
              flexibleSpace: FlexibleSpaceBar(
                titlePadding: const EdgeInsets.all(4),
                title: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        height: 34,
                        child: TextField(
                          autofocus: true,
                          controller: _searchTextController,
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            border: InputBorder.none,
                            hintText: "Search",
                            hintStyle:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary
                                          .withOpacity(0.4),
                                    ),
                          ),
                          onChanged: (value) =>
                              _searchTextChange(context, value),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            BlocBuilder<SearchUserBloc, SearchUserState>(
              builder: (context, state) {
                if (state.status == SearchUserStatus.success) {
                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, i) {
                        return UserCard(state.users[i]);
                      },
                      childCount: state.users.length,
                    ),
                  );
                } else if (state.status == SearchUserStatus.initial) {
                  return SliverToBoxAdapter(
                    child: Container(),
                  );
                } else {
                  return SliverToBoxAdapter(
                    child: Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  DateTime _lastSearchTextChange = DateTime.now();

  void _searchTextChange(BuildContext context, String keyword) {
    _lastSearchTextChange = DateTime.now();
    Future.delayed(Duration(milliseconds: 500)).then((value) {
      DateTime now = DateTime.now();
      if (now.difference(_lastSearchTextChange) >=
          Duration(milliseconds: 500)) {
        BlocProvider.of<SearchUserBloc>(context).startSearchUser(keyword);
      }
    });
  }
}
