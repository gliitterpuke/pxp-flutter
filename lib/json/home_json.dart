import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';

class tierColor {
  static const Color bronze = Color(0xFFCD7F32);
  static const Color silver = Color(0xFFC0C0C0);
  static const Color gold = Color(0xFFFFD700);
  static const Color paid = Color(0xFF818181);
}

const List authorList = [
  {
    "img": "assets/images/loid.jpg",
    "author": "Loid Forger",
    "series": "2",
    "followers": "11,231",
    "notification": "yes"
  },
  {
    "img": "assets/images/gintoki.webp",
    "author": "Gin-chan",
    "series": "1",
    "followers": "512",
    "notification": "no"
  },
  {
    "img": "assets/images/flyanya.jpg",
    "author": "Anya Forger",
    "series": "1",
    "followers": "52",
    "notification": "no"
  },
  {
    "img": "assets/images/san.jpg",
    "author": "San",
    "series": "321",
    "followers": "1,342",
    "notification": "yes"
  },
  {
    "img": "assets/images/drunkyor.jpg",
    "author": "Yor Forger",
    "series": "1",
    "followers": "2,468",
    "notification": "no"
  },
];

const List pxppicks = [
  {
    "img": "assets/images/midnightsun.jpg",
    "title": "Under the Midnight Sun",
    "genre": "Mystery",
    "author": "Keigo Higashino",
    "description":
        "When a man is found murdered in an abandoned building in Osaka in 1973, unflappable detective Sasagaki is assigned to the case. He begins to piece together the connection of two young people who are inextricably linked to the crime; the dark, taciturn son of the victim and the unexpectedly captivating daughter of the main suspect. Over the next twenty years we follow their lives as Sasagaki pursues the case - which remains unsolved - to the point of obsession.",
    "epub": "assets/epub/pachinko.epub",
    "tierIcon": FontAwesome.hourglass_o,
    "status": "Completed",
    "views": "100,000",
    "tier": 0,
    "tags": ["Cultural", "Thriller", "Japan", "Detective", "Crime"]
  },
  {
    "img": "assets/images/pachinko.jpg",
    "title": "Pachinko",
    "genre": "Historical Fiction",
    "author": "Lee Min-jin",
    "description":
        "In the early 1900s, teenaged Sunja, the adored daughter of a crippled fisherman, falls for a wealthy stranger at the seashore near her home in Korea. He promises her the world, but when she discovers she is pregnant — and that her lover is married — she refuses to be bought. Instead, she accepts an offer of marriage from a gentle, sickly minister passing through on his way to Japan. But her decision to abandon her home, and to reject her son's powerful father, sets off a dramatic saga that will echo down through the generations.",
    "epub": "assets/epub/pachinko.epub",
    "tierIcon": AntDesign.star,
    "status": "Completed",
    "views": "100,000",
    "tier": 2,
    "tags": ["Japan", "Historical Fiction", "Adult", "Literature"]
  },
  {
    "img": "assets/images/endswithus.jpg",
    "title": "It Ends with Us",
    "genre": "Romance",
    "author": "Colleen Hoover",
    "description":
        "Lily hasn’t always had it easy, but that’s never stopped her from working hard for the life she wants. She’s come a long way from the small town in Maine where she grew up — she graduated from college, moved to Boston, and started her own business. So when she feels a spark with a gorgeous neurosurgeon named Ryle Kincaid, everything in Lily’s life suddenly seems almost too good to be true.",
    "epub": "assets/epub/pachinko.epub",
    "tierIcon": FontAwesome.dollar,
    "status": "Completed",
    "views": "100,000",
    "tier": 4,
    "tags": [
      "Romance",
      "Contemporary",
      "Sociology",
      "Women's Lit",
      "Young Adult"
    ],
  },
  {
    "img": "assets/images/braidingsweetgrass.jpg",
    "title":
        "Braiding Sweetgrass: Indigenous Wisdom, Scientific Knowledge, and the Teachings of Plantsbrain",
    "genre": "Non-fiction",
    "author": "Robin Wall Kimmerer",
    "description":
        "As a botanist, Robin Wall Kimmerer has been trained to ask questions of nature with the tools of science. As a member of the Citizen Potawatomi Nation, she embraces the notion that plants and animals are our oldest teachers. In Braiding Sweetgrass, Kimmerer brings these lenses of knowledge together to show that the awakening of a wider ecological consciousness requires the acknowledgment and celebration of our reciprocal relationship with the rest of the living world. For only when we can hear the languages of other beings are we capable of understanding the generosity of the earth, and learning to give our own gifts in return.",
    "epub": "assets/epub/pachinko.epub",
    "tierIcon": AntDesign.star,
    "status": "Completed",
    "views": "100,000",
    "tier": 3,
    "tags": [
      "Science",
      "Environment",
      "Nature",
      "Memoir",
      "Essays",
      "Spirituality",
      "Biology",
      "Ecology"
    ],
  },
];

const List mylist = [
  {
    "img": "assets/images/endswithus.jpg",
    "title": "It Ends with Us",
    "genre": "Romance",
    "author": "Colleen Hoover",
    "description":
        "Lily hasn’t always had it easy, but that’s never stopped her from working hard for the life she wants. She’s come a long way from the small town in Maine where she grew up — she graduated from college, moved to Boston, and started her own business. So when she feels a spark with a gorgeous neurosurgeon named Ryle Kincaid, everything in Lily’s life suddenly seems almost too good to be true.",
    "epub": "assets/epub/pachinko.epub",
    "tierIcon": FontAwesome.dollar,
    "status": "Completed",
    "views": "100,000",
    "tier": 4,
    "tags": [
      "Romance",
      "Contemporary",
      "Sociology",
      "Women's Lit",
      "Young Adult"
    ],
  },
  {
    "img": "assets/images/narnia.jpg",
    "title": "The Lion, the Witch, and the Wardrobe",
    "genre": "Fantasy",
    "author": "C.S. Lewis",
    "description":
        "Narnia… the land beyond the wardrobe door, a secret place frozen in eternal winter, a magical country waiting to be set free.\n\nLucy is the first to find the secret of the wardrobe in the professor's mysterious old house. At first her brothers and sister don't believe her when she tells of her visit to the land of Narnia. But soon Edmund, then Peter and Susan step through the wardrobe themselves. In Narnia they find a country buried under the evil enchantment of the White Witch. When they meet the Lion Aslan, they realize they've been called to a great adventure and bravely join the battle to free Narnia from the Witch's sinister spell.",
    "epub": "assets/epub/pachinko.epub",
    "tierIcon": FontAwesome.hourglass_o,
    "status": "Completed",
    "views": "80,000",
    "tier": 0,
    "tags": ["Fantasy", "Classics", "Childrens", "Christian", "Magic"],
  },
  {
    "img": "assets/images/none.jpg",
    "title": "And Then There Were None",
    "genre": "Mystery",
    "author": "Agatha Christie",
    "description":
        "First, there were ten—a curious assortment of strangers summoned as weekend guests to a little private island off the coast of Devon. Their host, an eccentric millionaire unknown to all of them, is nowhere to be found. All that the guests have in common is a wicked past they're unwilling to reveal—and a secret that will seal their fate. For each has been marked for murder. A famous nursery rhyme is framed and hung in every room of the mansion:\n\nTen little boys went out to dine; One choked his little self and then there were nine. Nine little boys sat up very late; One overslept himself and then there were eight. Eight little boys traveling in Devon; One said he'd stay there then there were seven. Seven little boys chopping up sticks; One chopped himself in half and then there were six. Six little boys playing with a hive; A bumblebee stung one and then there were five. Five little boys going in for law; One got in Chancery and then there were four. Four little boys going out to sea; A red herring swallowed one and then there were three. Three little boys walking in the zoo; A big bear hugged one and then there were two. Two little boys sitting in the sun; One got frizzled up and then there was one. One little boy left all alone; He went out and hanged himself and then there were none.\n\nWhen they realize that murders are occurring as described in the rhyme, terror mounts. One by one they fall prey. Before the weekend is out, there will be none. Who has choreographed this dastardly scheme? And who will be left to tell the tale? Only the dead are above suspicion.",
    "epub": "assets/epub/pachinko.epub",
    "tierIcon": FontAwesome.hourglass_o,
    "status": "Completed",
    "views": "80,000",
    "tier": 0,
    "tags": ["Mystery", "Classics", "Crime", "Suspense", "Adult"],
  },
  {
    "img": "assets/images/primarythreat.jpg",
    "title": "Primary Threat",
    "genre": "Action",
    "author": "Jack Mars",
    "description":
        "In PRIMARY THREAT (The Forging of Luke Stone—Book #3), a ground-breaking action thriller by #1 bestseller Jack Mars, elite Delta Force veteran Luke Stone, 29, leads the FBI’s Special Response Team as they respond to a hostage situation on an oil rig in the remote Arctic.Yet what at first seems like a simple terrorist event may, it turns out, be much more.\n\nWith a Russian master plan unfolding rapidly in the Arctic, Luke may have arrived at the precipice of the next world war.\n\nAnd Luke Stone may just be the only man standing in its way.\n\nPRIMARY THREAT is a standalone, un-putdownable military thriller, a wild action ride that will leave you turning pages late into the night. The precursor to the #1 bestselling LUKE STONE THRILLER SERIES, this series takes us back to how it all began, a riveting series by bestseller Jack Mars, dubbed one of the best thriller authors out there.",
    "epub": "assets/epub/pachinko.epub",
    "tierIcon": FontAwesome.hourglass_o,
    "status": "Completed",
    "views": "80,000",
    "tier": 0,
    "tags": ["Thriller", "Fiction"],
  },
];

const List trendingList = [
  {
    "img": "assets/images/morethanwords.jpg",
    "title": "more than words",
    "genre": "Romance",
    "author": "Jill Santopolo",
    "epub": "assets/epub/pachinko.epub",
    "status": "Completed",
    "views": "100,000",
    "tags": [
      "Women's Fiction",
      "New York",
      "Romance",
    ],
  },
  {
    "img": "assets/images/loveunscripted.jpg",
    "title": "Love, Unscripted",
    "genre": "Romance",
    "author": "Owen Nicholls",
    "epub": "assets/epub/pachinko.epub",
    "status": "Completed",
    "views": "100,000",
    "tags": [
      "Romance",
      "Contemporary",
      "Sociology",
      "Women's Lit",
      "Young Adult"
    ],
  },
  {
    "img": "assets/images/dune.jpg",
    "title": "Dune",
    "genre": "Sci-fi",
    "author": "Frank Herbert",
    "epub": "assets/epub/pachinko.epub",
    "status": "Completed",
    "views": "100,000",
    "tags": ["Science Fiction Fantasy", "Space Opera", "Classics", "Adult"],
  },
];

const List newList = [
  {
    "img": "assets/images/hitchhiker.jpg",
    "title": "The Hitchhiker's Guide to the Galaxy",
    "genre": "Sci-fi",
    "author": "Douglas Adams",
    "epub": "assets/epub/pachinko.epub",
    "status": "Completed",
    "views": "100,000",
    "tags": ["Humor", "Classics", "Fantasy", "Science Fiction"],
  },
  {
    "img": "assets/images/housel.jpg",
    "title": "Think Outside the Box",
    "genre": "Non-fiction",
    "author": "Author",
    "epub": "assets/epub/pachinko.epub",
    "status": "Completed",
    "views": "100,000",
    "tags": [""],
  },
  {
    "img": "assets/images/motivate.jpg",
    "title": "Think Outside the Box",
    "genre": "Non-fiction",
    "author": "Author",
    "epub": "assets/epub/pachinko.epub",
    "status": "Completed",
    "views": "100,000",
    "tags": [""],
  },
];

const List completedList = [
  {
    "img": "assets/images/scifi.png",
    "title": "Think Outside the Box",
    "genre": "Non-fiction",
    "author": "Author",
    "epub": "assets/epub/pachinko.epub",
    "status": "Completed",
    "views": "100,000",
    "tags": [""],
  },
  {
    "img": "assets/images/sky.jpg",
    "title": "Think Outside the Box",
    "genre": "Non-fiction",
    "author": "Author",
    "epub": "assets/epub/pachinko.epub",
    "status": "Completed",
    "views": "100,000",
    "tags": [""],
  },
  {
    "img": "assets/images/storytelling.jpg",
    "title": "Think Outside the Box",
    "genre": "Non-fiction",
    "author": "Author",
    "epub": "assets/epub/pachinko.epub",
    "status": "Completed",
    "views": "100,000",
    "tags": [""],
  },
];

const List genreList = [
  {
    "id": 14,
    "icon": MaterialCommunityIcons.space_invaders,
    "genre": "Sci-fi",
  },
  {
    "id": 13,
    "icon": MaterialCommunityIcons.heart_multiple_outline,
    "genre": "Romance",
  },
  {
    "id": 6,
    "icon": FontAwesome.magic,
    "genre": "Fantasy",
  },
  {
    "id": 2,
    "icon": MaterialCommunityIcons.sword,
    "genre": "Adventure",
  },
  {
    "id": 9,
    "icon": FontAwesome.search,
    "genre": "Mystery",
  },
  {
    "id": 3,
    "icon": MaterialCommunityIcons.drama_masks,
    "genre": "Comedy",
  },
  {
    "id": 1,
    "icon": MaterialCommunityIcons.target,
    "genre": "Action",
  },
  {
    "id": 11,
    "icon": Entypo.open_book,
    "genre": "Non-fiction",
  },
];

const List badgeList = [
  {
    "icon": Foundation.power,
    "badge": "Power user",
  },
  {
    "icon": AntDesign.book,
    "badge": "Master reader",
  },
  {
    "icon": AntDesign.team,
    "badge": "Team player",
  },
  {
    "icon": MaterialCommunityIcons.podium_gold,
    "badge": "Gold contributor",
  },
  {
    "icon": Foundation.social_skillshare,
    "badge": "Social chameleon",
  },
];
