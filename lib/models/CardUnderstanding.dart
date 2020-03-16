enum CardUnderstanding{
  none,
  clear,
  unsure,
  problematic
}

CardUnderstanding enumFromString(String str){
  CardUnderstanding cardUnderstanding = CardUnderstanding.values.firstWhere((e) => e.toString() == str);
  return cardUnderstanding;
}
