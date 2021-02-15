import Foundation

/*
 var req = unirest("GET", "https://community-open-weather-map.p.rapidapi.com/weather");

 req.query({
     "q": " Saint Petersburg, ru",
     "lat": "60.08352939",
     "lon": "30.005144",
     "callback": "test",
     "id": "2172797",
     "lang": "null",
     "units": "\"metric\" or \"imperial\"",
     "mode": "xml, html"
 });

 req.headers({
     "x-rapidapi-key": "ec982ef309mshe4b8af97327c71fp191ecejsn0b5260d4e117",
     "x-rapidapi-host": "community-open-weather-map.p.rapidapi.com",
     "useQueryString": true
 });
 */
class WeatherApi{
    static func getInformationAboutWeatherInGeoPosition(lat: String, lon: String, complection: @escaping (Response) ->Void){
        let headers = [
            "x-rapidapi-key": "ec982ef309mshe4b8af97327c71fp191ecejsn0b5260d4e117",
            "x-rapidapi-host": "community-open-weather-map.p.rapidapi.com"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://community-open-weather-map.p.rapidapi.com/weather?q=%20Saint%20Petersburg%2C%20ru&lat=\(lat)lon=\(lon)&callback=test&id=2172797&lang=null&units=%22metric%22%20or%20%22imperial%22&mode=xml%2C%20html")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            if let data = data{
                var dataAsstr = String(data: data, encoding: .utf8)
                dataAsstr!.removeLast()
                for _ in 0..<5{
                    dataAsstr!.removeFirst()
                }
                let jsonDecoder = JSONDecoder()
                print(dataAsstr)
                let response = try! jsonDecoder.decode(Response.self, from: (dataAsstr?.data(using: .utf8))!)
                complection(response)
            }
        })

        dataTask.resume()
        
    }
    
}

struct Response: Codable{
    var weather: [Weather]
    var main: MainInfo
    var wind: Wind
}

struct Weather: Codable {
    var main: String
}

struct MainInfo: Codable {
    var feels_like: Double
    var temp: Double
    var temp_: Double?{
        get{
            return temp - 273
        }
        set {
        
        }
    }
    var feelslike_: Double? {
        get{
            return feels_like - 273
        }
        set {
            
        }
    }
    
}

struct Wind: Codable {
    var speed: Double
}
