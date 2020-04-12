import 'package:app/constants/stay_home_stay_safe_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class StayHomeStaySafeDetailsScreen extends StatefulWidget {
  static const ROOTNAME = '/stayHomeStaySafeDetailsScreen';
  final String screenTitle;
  final String markdownBodyData;
  final String assetPath;

  StayHomeStaySafeDetailsScreen(
      {this.screenTitle, this.markdownBodyData, this.assetPath});

  @override
  _StayHomeStaySafeDetailsScreenState createState() =>
      _StayHomeStaySafeDetailsScreenState();
}

class _StayHomeStaySafeDetailsScreenState
    extends State<StayHomeStaySafeDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Colors.transparent,
            expandedHeight: 300,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              background: _backgroundImage(),
              title: Text(widget.screenTitle),
            ),
          ),
          SliverToBoxAdapter(
            child: (widget.screenTitle == 'Symptoms')
                ? _symptomsBody()
                : _markDownBody(),
          )
        ],
      ),
    );
  }

  Widget _markDownBody() {
    return Container(
      margin: const EdgeInsets.only(top: 100, bottom: 100, left: 20, right: 20),
      child: MarkdownBody(
          styleSheet: MarkdownStyleSheet(
              strong: Theme.of(context)
                  .primaryTextTheme
                  .headline6
                  .copyWith(fontWeight: FontWeight.w100),
              p: Theme.of(context)
                  .primaryTextTheme
                  .headline6
                  .copyWith(fontWeight: FontWeight.w300)),
          data: widget.markdownBodyData),
    );
  }

  Widget _symptomsBody() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 100,
          ),
          RichText(
              text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: '''
            People may be sick with the virus for 1 to 14 days before developing symptoms. 
The most common symptoms of coronavirus disease (COVID-19) are fever, tiredness, and dry cough. 
Most people (about 80%) recover from the disease without needing special treatment.

More rarely, the disease can be serious and even fatal. 
Older people, and people with other medical conditions (such as asthma, diabetes, or heart disease), 
may be more vulnerable to becoming severely ill.
            ''',
                  style: Theme.of(context)
                      .primaryTextTheme
                      .headline6
                      .copyWith(fontWeight: FontWeight.w300))
            ],
          )),
          Text(
            'People may Experience\n',
            style: Theme.of(context)
                .primaryTextTheme
                .headline6
                .copyWith(fontWeight: FontWeight.w500),
          ),
          _item(SymptomsInfo.PEOPLE_MAY_EXPERIENCE_OPTIONS_ICONS_PATHS[0],
              SymptomsInfo.PEOPLE_MAY_EXPERIENCE_OPTIONS[0]),
          _item(SymptomsInfo.PEOPLE_MAY_EXPERIENCE_OPTIONS_ICONS_PATHS[1],
              SymptomsInfo.PEOPLE_MAY_EXPERIENCE_OPTIONS[1]),
          _item(SymptomsInfo.PEOPLE_MAY_EXPERIENCE_OPTIONS_ICONS_PATHS[2],
              SymptomsInfo.PEOPLE_MAY_EXPERIENCE_OPTIONS[2]),
          _item(SymptomsInfo.PEOPLE_MAY_EXPERIENCE_OPTIONS_ICONS_PATHS[3],
              SymptomsInfo.PEOPLE_MAY_EXPERIENCE_OPTIONS[3]),
          const SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }

  Widget _item(String iconPath, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage(iconPath),
          ),
          Container(
            // width: MediaQuery.of(context).size.width - 100,
            child: Text(
              ' $title',
              style: Theme.of(context)
                  .primaryTextTheme
                  .headline6
                  .copyWith(fontWeight: FontWeight.w300),
            ),
          ),
        ],
      ),
    );
  }

  Widget _backgroundImage() {
    return Stack(
      children: <Widget>[
        Positioned.fill(
            child: Image.asset(
          widget.assetPath,
          fit: BoxFit.cover,
        )),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.white10, Colors.black54])),
          ),
        ),
      ],
    );
  }
}
