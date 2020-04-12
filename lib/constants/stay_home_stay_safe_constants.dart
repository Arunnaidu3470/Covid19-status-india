const List<String> IMAGE_ASSET_PATHS = [
  'assets/images/c_symptoms.gif',
  'assets/images/c_prevention.gif',
  'assets/images/c_treatment.gif',
];

const List<String> TITLES = [
  'Symptoms',
  'Prevention',
  'Treatment',
];

const List<String> INFO = [
  SYMPTOMS_INFO_MARKDOWN,
  PreventionInfo.BODYTEXT,
  TreatmentInfo.BODYTEXT
];

const SYMPTOMS_INFO_MARKDOWN = '''
People may be sick with the virus for 1 to 14 days before developing symptoms. 
The most common symptoms of coronavirus disease (COVID-19) are fever, tiredness, and dry cough. 
Most people (about 80%) recover from the disease without needing special treatment.

More rarely, the disease can be serious and even fatal. 
Older people, and people with other medical conditions (such as asthma, diabetes, or heart disease), 
may be more vulnerable to becoming severely ill.

## People may experience:
  * cough
  * fever
  * tiredness
  * difficulty breathing (severe cases)
''';

class SymptomsInfo {
  static const String BODYTEXT = '''
  People may be sick with the virus for 1 to 14 days before developing symptoms. 
The most common symptoms of coronavirus disease (COVID-19) are fever, tiredness, and dry cough. 
Most people (about 80%) recover from the disease without needing special treatment.

More rarely, the disease can be serious and even fatal. 
Older people, and people with other medical conditions (such as asthma, diabetes, or heart disease), 
may be more vulnerable to becoming severely ill.
  ''';
  static const String PEOPLE_MAY_EXPERIENCE = 'People may experience:';
  static const List<String> PEOPLE_MAY_EXPERIENCE_OPTIONS = [
    'Cough',
    'Fever',
    'Tiredness',
    'Difficulty breathing (severe cases)',
  ];

  static const List<String> PEOPLE_MAY_EXPERIENCE_OPTIONS_ICONS_PATHS = [
    'assets/icons/breathing.png',
    'assets/icons/cough.png',
    'assets/icons/fever.png',
    'assets/icons/tiredness.png',
  ];
}

class PreventionInfo {
  static const String BODYTEXT = '''

  **There’s currently no vaccine to prevent coronavirus disease (COVID-19).
You can protect yourself and help prevent spreading the virus to others if you:**
## Do
  * Wash your hands regularly for 20 seconds, with soap and water or alcohol-based hand rub
  * Cover your nose and mouth with a disposable tissue or flexed elbow when you cough or sneeze
  * Avoid close contact (1 meter or 3 feet) with people who are unwell
  * Stay home and self-isolate from others in the household if you feel unwell
## Don't 
  * Touch your eyes, nose, or mouth if your hands are not clean
  ''';
}

class TreatmentInfo {
  static const String BODYTEXT = '''
  *There is no specific medicine to prevent or treat coronavirus disease (COVID-19). People may need supportive care to help them breathe.
Self-care*

*If you have mild symptoms, stay at home until you’ve recovered. You can relieve your symptoms*

## if you:

  * rest and sleep
  * keep warm
  * drink plenty of liquids
  * use a room humidifier or take a hot shower to help ease a sore throat and cough

## Medical treatments
  *If you develop a fever, cough, and have difficulty breathing, promptly seek medical care.
Call in advance and tell your health provider of any recent travel or recent contact with travelers.*
  ''';
}
