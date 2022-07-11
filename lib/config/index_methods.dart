int getLengthByIndex(int index, int max, int dataLength) {
  int placeLength = 0;

  if (dataLength > index * max) {
    placeLength = index * max;
  } else {
    placeLength = dataLength;
  }

  return placeLength;
}

bool isIndexIn(int index, int max, int dataLength) {
  bool isIn = false;

  if (dataLength >= index * max) {
    isIn = true;
  } else {
    if (dataLength > (index - 1) * max) {
      isIn = true;
    }
  }

  return isIn;
}

bool isLastIndex(int index, int max, int dataLength) {
  bool isIn = false;

  if (index == ((dataLength / max).ceil() - 1)) {
    isIn = true;
  }

  return isIn;
}

bool isLastRow(int rowIndex, int max, int dataLength) {
  bool isLast = false;

  if (rowIndex * max + max > dataLength) {
    isLast = true;
  }

  return isLast;
}
