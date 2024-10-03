class WeatherModel {
  Coord? _coord;
  List<Weather>? _weather;
  String? _base;
  Main? _main;
  int? _visibility;
  Wind? _wind;
  Clouds? _clouds;
  int? _dt;
  Sys? _sys;
  int? _timezone;
  int? _id;
  String? _name;
  int? _cod;

  WeatherModel({
    Coord? coord,
    List<Weather>? weather,
    String? base,
    Main? main,
    int? visibility,
    Wind? wind,
    Clouds? clouds,
    int? dt,
    Sys? sys,
    int? timezone,
    int? id,
    String? name,
    int? cod,
  }) {
    if (coord != null) {
      this._coord = coord;
    }
    if (weather != null) {
      this._weather = weather;
    }
    if (base != null) {
      this._base = base;
    }
    if (main != null) {
      this._main = main;
    }
    if (visibility != null) {
      this._visibility = visibility;
    }
    if (wind != null) {
      this._wind = wind;
    }
    if (clouds != null) {
      this._clouds = clouds;
    }
    if (dt != null) {
      this._dt = dt;
    }
    if (sys != null) {
      this._sys = sys;
    }
    if (timezone != null) {
      this._timezone = timezone;
    }
    if (id != null) {
      this._id = id;
    }
    if (name != null) {
      this._name = name;
    }
    if (cod != null) {
      this._cod = cod;
    }
  }

  Coord? get coord => _coord;
  set coord(Coord? coord) => _coord = coord;
  List<Weather>? get weather => _weather;
  set weather(List<Weather>? weather) => _weather = weather;
  String? get base => _base;
  set base(String? base) => _base = base;
  Main? get main => _main;
  set main(Main? main) => _main = main;
  int? get visibility => _visibility;
  set visibility(int? visibility) => _visibility = visibility;
  Wind? get wind => _wind;
  set wind(Wind? wind) => _wind = wind;
  Clouds? get clouds => _clouds;
  set clouds(Clouds? clouds) => _clouds = clouds;
  int? get dt => _dt;
  set dt(int? dt) => _dt = dt;
  Sys? get sys => _sys;
  set sys(Sys? sys) => _sys = sys;
  int? get timezone => _timezone;
  set timezone(int? timezone) => _timezone = timezone;
  int? get id => _id;
  set id(int? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;
  int? get cod => _cod;
  set cod(int? cod) => _cod = cod;

  WeatherModel.fromJson(Map<String, dynamic> json) {
    _coord = json['coord'] != null ? Coord.fromJson(json['coord']) : null;
    if (json['weather'] != null) {
      _weather = <Weather>[];
      json['weather'].forEach((v) {
        _weather!.add(Weather.fromJson(v));
      });
    }
    _base = json['base'];
    _main = json['main'] != null ? Main.fromJson(json['main']) : null;
    _visibility = json['visibility'];
    _wind = json['wind'] != null ? Wind.fromJson(json['wind']) : null;
    _clouds = json['clouds'] != null ? Clouds.fromJson(json['clouds']) : null;
    _dt = json['dt'];
    _sys = json['sys'] != null ? Sys.fromJson(json['sys']) : null;
    _timezone = json['timezone'];
    _id = json['id'];
    _name = json['name'];
    _cod = json['cod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (_coord != null) {
      data['coord'] = _coord!.toJson();
    }
    if (_weather != null) {
      data['weather'] = _weather!.map((v) => v.toJson()).toList();
    }
    data['base'] = _base;
    if (_main != null) {
      data['main'] = _main!.toJson();
    }
    data['visibility'] = _visibility;
    if (_wind != null) {
      data['wind'] = _wind!.toJson();
    }
    if (_clouds != null) {
      data['clouds'] = _clouds!.toJson();
    }
    data['dt'] = _dt;
    if (_sys != null) {
      data['sys'] = _sys!.toJson();
    }
    data['timezone'] = _timezone;
    data['id'] = _id;
    data['name'] = _name;
    data['cod'] = _cod;
    return data;
  }
}

class Coord {
  double? _lon;
  double? _lat;

  Coord({double? lon, double? lat}) {
    if (lon != null) {
      this._lon = lon;
    }
    if (lat != null) {
      this._lat = lat;
    }
  }

  double? get lon => _lon;
  set lon(double? lon) => _lon = lon;
  double? get lat => _lat;
  set lat(double? lat) => _lat = lat;

  Coord.fromJson(Map<String, dynamic> json) {
    _lon = (json['lon'] as num).toDouble(); // Ensure lon is double
    _lat = (json['lat'] as num).toDouble(); // Ensure lat is double
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['lon'] = _lon;
    data['lat'] = _lat;
    return data;
  }
}

class Weather {
  int? _id;
  String? _main;
  String? _description;
  String? _icon;

  Weather({int? id, String? main, String? description, String? icon}) {
    if (id != null) {
      this._id = id;
    }
    if (main != null) {
      this._main = main;
    }
    if (description != null) {
      this._description = description;
    }
    if (icon != null) {
      this._icon = icon;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get main => _main;
  set main(String? main) => _main = main;
  String? get description => _description;
  set description(String? description) => _description = description;
  String? get icon => _icon;
  set icon(String? icon) => _icon = icon;

  Weather.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _main = json['main'];
    _description = json['description'];
    _icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = _id;
    data['main'] = _main;
    data['description'] = _description;
    data['icon'] = _icon;
    return data;
  }
}

class Main {
  double? _temp;
  double? _feelsLike;
  double? _tempMin;
  double? _tempMax;
  int? _pressure;
  int? _humidity;
  int? _seaLevel;
  int? _grndLevel;

  Main({
    double? temp,
    double? feelsLike,
    double? tempMin,
    double? tempMax,
    int? pressure,
    int? humidity,
    int? seaLevel,
    int? grndLevel,
  }) {
    if (temp != null) {
      this._temp = temp;
    }
    if (feelsLike != null) {
      this._feelsLike = feelsLike;
    }
    if (tempMin != null) {
      this._tempMin = tempMin;
    }
    if (tempMax != null) {
      this._tempMax = tempMax;
    }
    if (pressure != null) {
      this._pressure = pressure;
    }
    if (humidity != null) {
      this._humidity = humidity;
    }
    if (seaLevel != null) {
      this._seaLevel = seaLevel;
    }
    if (grndLevel != null) {
      this._grndLevel = grndLevel;
    }
  }

  double? get temp => _temp;
  set temp(double? temp) => _temp = temp;
  double? get feelsLike => _feelsLike;
  set feelsLike(double? feelsLike) => _feelsLike = feelsLike;
  double? get tempMin => _tempMin;
  set tempMin(double? tempMin) => _tempMin = tempMin;
  double? get tempMax => _tempMax;
  set tempMax(double? tempMax) => _tempMax = tempMax;
  int? get pressure => _pressure;
  set pressure(int? pressure) => _pressure = pressure;
  int? get humidity => _humidity;
  set humidity(int? humidity) => _humidity = humidity;
  int? get seaLevel => _seaLevel;
  set seaLevel(int? seaLevel) => _seaLevel = seaLevel;
  int? get grndLevel => _grndLevel;
  set grndLevel(int? grndLevel) => _grndLevel = grndLevel;

  Main.fromJson(Map<String, dynamic> json) {
    _temp = (json['temp'] as num).toDouble(); // Ensure temp is double
    _feelsLike = (json['feels_like'] as num).toDouble(); // Ensure feelsLike is double
    _tempMin = (json['temp_min'] as num).toDouble(); // Ensure tempMin is double
    _tempMax = (json['temp_max'] as num).toDouble(); // Ensure tempMax is double
    _pressure = json['pressure'];
    _humidity = json['humidity'];
    _seaLevel = json['sea_level'];
    _grndLevel = json['grnd_level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['temp'] = _temp;
    data['feels_like'] = _feelsLike;
    data['temp_min'] = _tempMin;
    data['temp_max'] = _tempMax;
    data['pressure'] = _pressure;
    data['humidity'] = _humidity;
    data['sea_level'] = _seaLevel;
    data['grnd_level'] = _grndLevel;
    return data;
  }
}

class Wind {
  double? _speed;
  int? _deg;
  double? _gust;

  Wind({double? speed, int? deg, double? gust}) {
    if (speed != null) {
      this._speed = speed;
    }
    if (deg != null) {
      this._deg = deg;
    }
    if (gust != null) {
      this._gust = gust;
    }
  }

  double? get speed => _speed;
  set speed(double? speed) => _speed = speed;
  int? get deg => _deg;
  set deg(int? deg) => _deg = deg;
  double? get gust => _gust;
  set gust(double? gust) => _gust = gust;

  Wind.fromJson(Map<String, dynamic> json) {
    _speed = (json['speed'] as num).toDouble(); // Ensure speed is double
    _deg = json['deg'];
    _gust = (json['gust'] as num).toDouble(); // Ensure gust is double
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['speed'] = _speed;
    data['deg'] = _deg;
    data['gust'] = _gust;
    return data;
  }
}

class Clouds {
  int? _all;

  Clouds({int? all}) {
    if (all != null) {
      this._all = all;
    }
  }

  int? get all => _all;
  set all(int? all) => _all = all;

  Clouds.fromJson(Map<String, dynamic> json) {
    _all = json['all'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['all'] = _all;
    return data;
  }
}

class Sys {
  int? _type;
  int? _id;
  String? _country;
  int? _sunrise;
  int? _sunset;

  Sys({int? type, int? id, String? country, int? sunrise, int? sunset}) {
    if (type != null) {
      this._type = type;
    }
    if (id != null) {
      this._id = id;
    }
    if (country != null) {
      this._country = country;
    }
    if (sunrise != null) {
      this._sunrise = sunrise;
    }
    if (sunset != null) {
      this._sunset = sunset;
    }
  }

  int? get type => _type;
  set type(int? type) => _type = type;
  int? get id => _id;
  set id(int? id) => _id = id;
  String? get country => _country;
  set country(String? country) => _country = country;
  int? get sunrise => _sunrise;
  set sunrise(int? sunrise) => _sunrise = sunrise;
  int? get sunset => _sunset;
  set sunset(int? sunset) => _sunset = sunset;

  Sys.fromJson(Map<String, dynamic> json) {
    _type = json['type'];
    _id = json['id'];
    _country = json['country'];
    _sunrise = json['sunrise'];
    _sunset = json['sunset'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['type'] = _type;
    data['id'] = _id;
    data['country'] = _country;
    data['sunrise'] = _sunrise;
    data['sunset'] = _sunset;
    return data;
  }
}
