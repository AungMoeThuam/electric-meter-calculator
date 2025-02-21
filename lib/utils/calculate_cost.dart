List<int> calculateCost(String prev, String current) {
  int total = int.parse(current) - int.parse(prev);
  int cost = 0;
  if (total <= 50) {
    cost = total * 50;
  }

  else if (total <= 100) {
    cost = 2500 + (total - 50) * 100;
  }

  else if (total <= 200) {
    cost = 7500 + (total - 100) * 150;
  }

  else{
    cost = 22500 + (total - 200) * 300;
  }

  return [cost,total];
}


