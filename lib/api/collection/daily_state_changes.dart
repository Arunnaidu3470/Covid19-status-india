part of covid19_api;

class DailyStateChanges {
  Covid19Api _api;
  String path = '/states_daily.json';
  DailyStateChanges(this._api);

  Future<Map<String, Map<String, List<Map<String, String>>>>>
      getAllStatesCount() async {
    Map result = await _api._query(path);
    return _parseData(result);
  }

  Map<String, Map<String, List<Map<String, String>>>> _parseData(Map result) {
    Map<String, Map<String, List<Map<String, String>>>> mappedData = {
      'AP': {
        'confirmed': [],
        'recovered': [],
        'deceased': [],
      },
      'AR': {
        'confirmed': [],
        'recovered': [],
        'deceased': [],
      },
      'AS': {
        'confirmed': [],
        'recovered': [],
        'deceased': [],
      },
      'BR': {
        'confirmed': [],
        'recovered': [],
        'deceased': [],
      },
      'CT': {
        'confirmed': [],
        'recovered': [],
        'deceased': [],
      },
      'GA': {
        'confirmed': [],
        'recovered': [],
        'deceased': [],
      },
      'GJ': {
        'confirmed': [],
        'recovered': [],
        'deceased': [],
      },
      'HR': {
        'confirmed': [],
        'recovered': [],
        'deceased': [],
      },
      'HP': {
        'confirmed': [],
        'recovered': [],
        'deceased': [],
      },
      'JH': {
        'confirmed': [],
        'recovered': [],
        'deceased': [],
      },
      'KA': {
        'confirmed': [],
        'recovered': [],
        'deceased': [],
      },
      'KL': {
        'confirmed': [],
        'recovered': [],
        'deceased': [],
      },
      'MP': {
        'confirmed': [],
        'recovered': [],
        'deceased': [],
      },
      'MH': {
        'confirmed': [],
        'recovered': [],
        'deceased': [],
      },
      'MN': {
        'confirmed': [],
        'recovered': [],
        'deceased': [],
      },
      'ML': {
        'confirmed': [],
        'recovered': [],
        'deceased': [],
      },
      'MZ': {
        'confirmed': [],
        'recovered': [],
        'deceased': [],
      },
      'NL': {
        'confirmed': [],
        'recovered': [],
        'deceased': [],
      },
      'OR': {
        'confirmed': [],
        'recovered': [],
        'deceased': [],
      },
      'PB': {
        'confirmed': [],
        'recovered': [],
        'deceased': [],
      },
      'RJ': {
        'confirmed': [],
        'recovered': [],
        'deceased': [],
      },
      'SK': {
        'confirmed': [],
        'recovered': [],
        'deceased': [],
      },
      'TN': {
        'confirmed': [],
        'recovered': [],
        'deceased': [],
      },
      'TG': {
        'confirmed': [],
        'recovered': [],
        'deceased': [],
      },
      'TR': {
        'confirmed': [],
        'recovered': [],
        'deceased': [],
      },
      'UT': {
        'confirmed': [],
        'recovered': [],
        'deceased': [],
      },
      'UP': {
        'confirmed': [],
        'recovered': [],
        'deceased': [],
      },
      'WB': {
        'confirmed': [],
        'recovered': [],
        'deceased': [],
      },
      'AN': {
        'confirmed': [],
        'recovered': [],
        'deceased': [],
      },
      'CH': {
        'confirmed': [],
        'recovered': [],
        'deceased': [],
      },
      'DN': {
        'confirmed': [],
        'recovered': [],
        'deceased': [],
      },
      'DL': {
        'confirmed': [],
        'recovered': [],
        'deceased': [],
      },
      'JK': {
        'confirmed': [],
        'recovered': [],
        'deceased': [],
      },
      'LA': {
        'confirmed': [],
        'recovered': [],
        'deceased': [],
      },
      'LD': {
        'confirmed': [],
        'recovered': [],
        'deceased': [],
      },
      'PY': {
        'confirmed': [],
        'recovered': [],
        'deceased': [],
      },
      'TT': {
        'confirmed': [],
        'recovered': [],
        'deceased': [],
      },
    };
    for (int index = 0; index < result['states_daily'].length; index++) {
      mappedData.forEach((key, value) {
        mappedData[key][result['states_daily'][index]['status'].toLowerCase()]
            .add({
          'date': result['states_daily'][index]['date'],
          'count': result['states_daily'][index][key.toLowerCase()],
        });
      });
    }
    return mappedData;
  }
}

const Map<String, String> _STATE_CODES = {
  'AP': 'Andhra Pradesh',
  'AR': 'Arunachal Pradesh',
  'AS': 'Assam',
  'BR': 'Bihar',
  'CT': 'Chhattisgarh',
  'GA': 'Goa',
  'GJ': 'Gujarat',
  'HR': 'Haryana',
  'HP': 'Himachal Pradesh',
  'JH': 'Jharkhand',
  'KA': 'Karnataka',
  'KL': 'Kerala',
  'MP': 'Madhya Pradesh',
  'MH': 'Maharashtra',
  'MN': 'Manipur',
  'ML': 'Meghalaya',
  'MZ': 'Mizoram',
  'NL': 'Nagaland',
  'OR': 'Odisha',
  'PB': 'Punjab',
  'RJ': 'Rajasthan',
  'SK': 'Sikkim',
  'TN': 'Tamil Nadu',
  'TG': 'Telangana',
  'TR': 'Tripura',
  'UT': 'Uttarakhand',
  'UP': 'Uttar Pradesh',
  'WB': 'West Bengal',
  'AN': 'Andaman and Nicobar Islands',
  'CH': 'Chandigarh',
  'DN': 'Dadra and Nagar Haveli and Daman and Diu',
  'DL': 'Delhi',
  'JK': 'Jammu and Kashmir',
  'LA': 'Ladakh',
  'LD': 'Lakshadweep',
  'PY': 'Puducherry',
  'TT': 'India'
};
