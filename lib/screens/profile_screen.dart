import 'package:colorie/providers/member_provider.dart';
import 'package:colorie/theme/brand_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<MemberProvider>(builder: (BuildContext context, MemberProvider memberProvider, _) {
          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      child: Icon(
                        Icons.arrow_back,
                        color: black,
                      ),
                      onTap: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Material(
                      child: Hero(
                        tag: 'profile',
                        child: Placeholder(
                          fallbackHeight: 60,
                          fallbackWidth: 60,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            memberProvider.name,
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${memberProvider.age}',
                            style: TextStyle(fontSize: 20, color: grey_2),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
