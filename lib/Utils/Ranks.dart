import 'package:flutter/material.dart';

class Rank
{
  static final ranks = {
    1 : "assets/Ranks/rank1.png",
    2 : "assets/Ranks/rank2.png",
    3 : "assets/Ranks/rank3.png",
    4 : "assets/Ranks/rank4.png",
    5 : "assets/Ranks/rank5.png",
    6 : "assets/Ranks/rank6.png",
    7 : "assets/Ranks/rank7.png",
    8 : "assets/Ranks/rank8.png",
    9 : "assets/Ranks/rank9.png",
    10 : "assets/Ranks/rank10.png",
    11 : "assets/Ranks/rank11.png"
  };

  static final requirement = {
    1 : 5,
    2 : 10,
    3 : 15,
    4 : 20,
    5 : 25,
    6 : 30,
    7 : 40,
    8 : 50,
    9 : 65,
    10 : 85 , 
    11 : 100, 
  };

  static Color getRankColor(int rank)
  {
    switch (rank) {
      case 1:
      case 2:
      case 3:
        return Colors.blue;
        break;
      case 4:
      case 5:
      case 6:
        return Colors.red;
        break;
      case 7:
      case 8:
      case 9:
        return Colors.yellow;
        break;
      default:
        return Colors.black;
    }
  }


  static int getRankFromEventCount(int eventCount)
  {
    if(eventCount >= 0 && eventCount < requirement[1]) return 1;
    else if(eventCount < requirement[2]) return 2;
    else if(eventCount < requirement[3]) return 3;
    else if(eventCount < requirement[4]) return 4;
    else if(eventCount < requirement[5]) return 5;
    else if(eventCount < requirement[6]) return 6;
    else if(eventCount < requirement[7]) return 7;
    else if(eventCount < requirement[8]) return 8;
    else if(eventCount < requirement[9]) return 9;
    else if(eventCount < requirement[10]) return 10;
    else if(eventCount < requirement[11]) return 11;
    else return 0;
  }

  static String getMedalFromEventCount(int eventCount)
  {
    if(eventCount >= 0 && eventCount < requirement[1]) return ranks[1];
    else if(eventCount < requirement[2]) return ranks[2];
    else if(eventCount < requirement[3]) return ranks[3];
    else if(eventCount < requirement[4]) return ranks[4];
    else if(eventCount < requirement[5]) return ranks[5];
    else if(eventCount < requirement[6]) return ranks[6];
    else if(eventCount < requirement[7]) return ranks[7];
    else if(eventCount < requirement[8]) return ranks[8];
    else if(eventCount < requirement[9]) return ranks[9];
    else if(eventCount < requirement[10]) return ranks[10];
    else if(eventCount < requirement[11]) return ranks[11];
    else return "assets/emptyProfile.png";
  
  }

}