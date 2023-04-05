enum SecurityQuestion {
  Question1,
  Question2,
  Question3,
  Question4,
  Question5,
}

extension SecurityQuestionExtension on SecurityQuestion {
  String get value {
    switch (this) {
      case SecurityQuestion.Question1:
        return 'In welcher Stadt bzw. an welchem Ort wurdest du geboren?';
      case SecurityQuestion.Question2:
        return 'Wie lautet der zweite Vorname deiner ältesten Schwester bzw. deines ältesten Bruders?';
      case SecurityQuestion.Question3:
        return 'Welches war dein erstes Konzert, das du besucht hast?';
      case SecurityQuestion.Question4:
        return 'Gebe Marke und Model deines Autos an.';
      case SecurityQuestion.Question5:
        return 'In welcher Stadt bzw. welchem Ort haben sich deine Eltern kennengelernt?';
      default:
        return '';
    }
  }
}
