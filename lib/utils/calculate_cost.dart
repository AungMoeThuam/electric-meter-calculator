int calculateCost(String prev, String current) {
  int total = int.parse(current) - int.parse(prev);

  if (total <= 50) {
    total = total * 50;
  }

  else if (total <= 100) {
    total = 2500 + (total - 50) * 100;
  }

  else if (total <= 200) {
    total = 7500 + (total - 100) * 150;
  }

  else{
    total = 22500 + (total - 200) * 300;
  }

  return total;
}


