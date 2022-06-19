import 'package:flutter/material.dart';

const List likesList = [
  {"icon": Icons.add, "text": "My List"},
  {"icon": Icons.thumb_up_alt_outlined, "text": "Rate"},
  {"icon": Icons.send_outlined, "text": "Share"}
];
const List episodesList = ["SEASONS", "MORE LIKE THIS"];

const List seasonsList = [
  {"season": 1, "lastupdated": "1h"},
  {"season": 2, "lastupdated": "6 days"},
  {"season": 3, "lastupdated": "1 week"},
  {"season": 4, "lastupdated": "May 1, 2022"},
  {"season": 5, "lastupdated": "April 24, 2022"},
  {"season": 6, "lastupdated": "April, 1, 2022"},
];

const List chapterList = [
  {"chapter": 1, "lastupdated": "1h", "coins": 0},
  {"chapter": 2, "lastupdated": "6 days", "coins": 0},
  {"chapter": 3, "lastupdated": "1 week", "coins": 0},
  {"chapter": 4, "lastupdated": "May 1, 2022", "coins": 0},
  {"chapter": 5, "lastupdated": "April 24, 2022", "coins": 0},
  {"chapter": 6, "lastupdated": "April, 1, 2022", "coins": 0},
  {"chapter": 7, "lastupdated": "May 1, 2022", "coins": 3},
  {"chapter": 8, "lastupdated": "June 1, 2022", "coins": 3},
  {"chapter": 9, "lastupdated": "July 1, 2022", "coins": 3},
];

const List userReviewList = [
  {
    "display": "Anya",
    "img": "assets/images/flyanya.jpg",
    "overall": 5,
    "style": 5,
    "story": 5,
    "grammar": 5,
    "content": 5,
    "title": "amazing read!!",
    "review": "loved everything about it \ntruly the best book",
    "helpful": 12,
    "date": "January 01, 2022",
    "location": 6,
    "award": true
  },
  {
    "display": "Anya",
    "img": "assets/images/flyanya.jpg",
    "overall": 5,
    "style": 5,
    "story": 5,
    "grammar": 1,
    "content": 5,
    "title":
        "extremely extremely extremely extremely extremely extremely long title",
    "review": "fix grammar and it would be amazing!!!",
    "helpful": 12,
    "date": "January 01, 2022",
    "location": 2,
    "award": false
  },
  {
    "display": "Anya",
    "img": "assets/images/flyanya.jpg",
    "overall": 5,
    "style": 5,
    "story": 5,
    "grammar": 5,
    "content": 5,
    "title": "amazing read!!",
    "review": "loved everything about it \ntruly the best book",
    "helpful": 12,
    "date": "January 01, 2022",
    "location": 6,
    "award": false
  },
  {
    "display": "Anya",
    "img": "assets/images/flyanya.jpg",
    "overall": 5,
    "style": 5,
    "story": 5,
    "grammar": 5,
    "content": 5,
    "title": "amazing read!!",
    "review": "loved everything about it \ntruly the best book",
    "helpful": 12,
    "date": "January 01, 2022",
    "location": 6,
    "award": true
  },
  {
    "display": "Anya",
    "img": "assets/images/flyanya.jpg",
    "overall": 5,
    "style": 5,
    "story": 5,
    "grammar": 5,
    "content": 5,
    "title": "amazing read!!",
    "review": "loved everything about it \ntruly the best book",
    "helpful": 12,
    "date": "January 01, 2022",
    "location": 6,
    "award": false
  },
  {
    "display": "Anya",
    "img": "assets/images/flyanya.jpg",
    "overall": 2,
    "style": 3,
    "story": 1,
    "grammar": 4,
    "content": 1,
    "title": "okie",
    "review": "was an okie book",
    "helpful": 1,
    "date": "January 01, 2022",
    "location": 1,
    "award": false
  },
  {
    "display": "Anya",
    "img": "assets/images/flyanya.jpg",
    "overall": 5,
    "style": 5,
    "story": 5,
    "grammar": 5,
    "content": 5,
    "title": "amazing read!!",
    "review": "loved everything about it \ntruly the best book",
    "helpful": 12,
    "date": "January 01, 2022",
    "location": 6,
    "award": false
  },
];

const List reviewList = [
  {
    "display": "Anya",
    "img": "assets/images/flyanya.jpg",
    "overall": 5,
    "style": 5,
    "story": 5,
    "grammar": 5,
    "content": 5,
    "title": "amazing read!!",
    "review": "loved everything about it \ntruly the best book",
    "helpful": 12,
    "date": "January 01, 2022",
    "location": 6,
    "award": true
  },
  {
    "display": "Gintoki",
    "img": "assets/images/gintoki.webp",
    "overall": 2,
    "style": 4,
    "story": 1,
    "grammar": 1,
    "content": 3,
    "title": "was ok ",
    "review":
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, \nand more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    "helpful": 0,
    "date": "March 08, 2022",
    "location": 1,
    "award": false
  },
  {
    "display": "Loid",
    "img": "assets/images/loid.jpg",
    "overall": 4,
    "style": 5,
    "story": 1,
    "grammar": 4,
    "content": 4,
    "title": "needs sum fixin",
    "review":
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, \nand more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    "helpful": 0,
    "date": "March 08, 2022",
    "location": 4,
    "award": true
  },
  {
    "display": "Loid",
    "img": "assets/images/loid.jpg",
    "overall": 4,
    "style": 5,
    "story": 1,
    "grammar": 4,
    "content": 4,
    "title": "needs sum fixin",
    "review":
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, \nand more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    "helpful": 0,
    "date": "March 08, 2022",
    "location": 4,
    "award": true
  },
  {
    "display": "Loid",
    "img": "assets/images/loid.jpg",
    "overall": 4,
    "style": 5,
    "story": 1,
    "grammar": 4,
    "content": 4,
    "title": "needs sum fixin",
    "review":
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, \nand more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    "helpful": 0,
    "date": "March 08, 2022",
    "location": 4,
    "award": true
  },
  {
    "display": "Loid",
    "img": "assets/images/loid.jpg",
    "overall": 4,
    "style": 5,
    "story": 1,
    "grammar": 4,
    "content": 4,
    "title": "needs sum fixin",
    "review":
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, \nand more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    "helpful": 0,
    "date": "March 08, 2022",
    "location": 4,
    "award": true
  },
  {
    "display": "Loid",
    "img": "assets/images/loid.jpg",
    "overall": 4,
    "style": 5,
    "story": 1,
    "grammar": 4,
    "content": 4,
    "title": "needs sum fixin",
    "review":
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, \nand more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    "helpful": 0,
    "date": "March 08, 2022",
    "location": 4,
    "award": true
  },
  {
    "display": "Loid",
    "img": "assets/images/loid.jpg",
    "overall": 4,
    "style": 5,
    "story": 1,
    "grammar": 4,
    "content": 4,
    "title": "needs sum fixin",
    "review":
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, \nand more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    "helpful": 0,
    "date": "March 08, 2022",
    "location": 4,
    "award": true
  },
  {
    "display": "Loid",
    "img": "assets/images/loid.jpg",
    "overall": 4,
    "style": 5,
    "story": 1,
    "grammar": 4,
    "content": 4,
    "title": "needs sum fixin",
    "review":
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, \nand more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    "helpful": 0,
    "date": "March 08, 2022",
    "location": 4,
    "award": true
  },
  {
    "display": "Loid",
    "img": "assets/images/loid.jpg",
    "overall": 4,
    "style": 5,
    "story": 1,
    "grammar": 4,
    "content": 4,
    "title": "needs sum fixin",
    "review":
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, \nand more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    "helpful": 0,
    "date": "March 08, 2022",
    "location": 4,
    "award": true
  },
  {
    "display": "Loid",
    "img": "assets/images/loid.jpg",
    "overall": 4,
    "style": 5,
    "story": 1,
    "grammar": 4,
    "content": 4,
    "title": "needs sum fixin",
    "review":
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, \nand more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    "helpful": 0,
    "date": "March 08, 2022",
    "location": 4,
    "award": true
  },
  {
    "display": "Loid",
    "img": "assets/images/loid.jpg",
    "overall": 4,
    "style": 5,
    "story": 1,
    "grammar": 4,
    "content": 4,
    "title": "needs sum fixin",
    "review":
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, \nand more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
    "helpful": 0,
    "date": "March 08, 2022",
    "location": 4,
    "award": true
  },
];
