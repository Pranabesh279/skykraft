class UserLevel {
  final int postCount;

  UserLevel({required this.postCount});

  int get level => getUserLevel(postCount);

  int getUserLevel(int postCount) {
    if (postCount < 10) {
      return 1;
    } else if (postCount < 20) {
      return 2;
    } else if (postCount < 30) {
      return 3;
    } else if (postCount < 40) {
      return 4;
    } else if (postCount < 50) {
      return 5;
    } else if (postCount < 60) {
      return 6;
    } else if (postCount < 70) {
      return 7;
    } else if (postCount < 80) {
      return 8;
    } else if (postCount < 90) {
      return 9;
    } else if (postCount < 100) {
      return 10;
    } else {
      return 11;
    }
  }

  String getLevelName(int level) {
    switch (level) {
      case 1:
        return 'Beginner';
      case 2:
        return 'Intermediate';
      case 3:
        return 'Advanced';
      case 4:
        return 'Expert';
      case 5:
        return 'Master';
      case 6:
        return 'Grand Master';
      case 7:
        return 'Legend';
      case 8:
        return 'Myth';
      case 9:
        return 'God';
      case 10:
        return 'Titan';
      case 11:
        return 'Legend';
      default:
        return 'Beginner';
    }
  }

  int get priceByLevel => getPriceByLevel(level);

  int getPriceByLevel(int level) {
    switch (level) {
      case 1:
        return 1000;
      case 2:
        return 2000;
      case 3:
        return 3000;
      case 4:
        return 4000;
      case 5:
        return 5000;
      case 6:
        return 6000;
      case 7:
        return 7000;
      case 8:
        return 8000;
      case 9:
        return 9000;
      case 10:
        return 10000;
      case 11:
        return 11000;
      default:
        return 0;
    }
  }
}
