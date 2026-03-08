import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:fantasy_baseball_app/notifiers/FavoritePlayersModel.dart';

class FavoriteButton extends StatefulWidget
{
  final String id;
  final String name;
  final String position;
  final String team;

  final double marginLeft;
  final double marginRight;
  final double marginTop;
  final double marginBottom;

  const FavoriteButton({super.key, required this.id, required this.name, required this.position, required this.team, required this.marginLeft, required this.marginRight, required this.marginTop, required this.marginBottom});

  @override
  FavoriteButtonState createState() => FavoriteButtonState();
}

class FavoriteButtonState extends State<FavoriteButton>
{
  bool starHovered = false;

  @override
  Widget build(BuildContext context)
  {
    return Consumer<FavoritePlayersModel>(
      builder: (context, favoritePlayersModel, child) {
        return InkWell(
          onTap: ()
          {
            final splitName = widget.name.split(" ");

            Provider.of<FavoritePlayersModel>(context, listen: false).updatePlayerFavoritism(widget.id, splitName[0], splitName[1], widget.position, widget.team);
          },
          onHover: (bool? isHovering)
          {
            setState(() {
              starHovered = isHovering!;
            });
          },
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          child: Container(
              margin: EdgeInsets.fromLTRB(widget.marginLeft, widget.marginTop, widget.marginLeft, widget.marginBottom),
              alignment: Alignment.center,
              color: Colors.transparent,
              child: Center(child: Icon(Icons.star, color: getStarColor(favoritePlayersModel)))
          )
        );
      }
    );
  }

  Color getStarColor(FavoritePlayersModel favoritePlayersModel)
  {
    if (starHovered)
    {
      return favoritePlayersModel.containsPlayer(widget.id) ? Colors.grey : Colors.yellow;
    }
    else
    {
      return favoritePlayersModel.containsPlayer(widget.id) ? Colors.yellow : Colors.grey;
    }
  }
}