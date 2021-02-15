//
//  WeatherView.swift
//  Weather
//
//  Created by Данил Дубов on 28.11.2020.
//
    
import UIKit

class WeatherCard: UIView {
    var weatherCard: UIView?
    
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var fellsLike: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var pic: UIImageView! {
        didSet{
            self.pic.layer.cornerRadius = 12
        }
    }
    var response: Response?{
        didSet{
            guard let response = response else {
                fatalError("я хочу умереть блять сука чмо")
            }
            UIView.transition(with: self, duration: 0.6, options: .curveEaseIn, animations: {
                self.windSpeed.text = "Скорость ветра: \(Double(round(1000*response.wind.speed)/1000))"
                self.fellsLike.text = "Ощущается как: \(Double(round(1000*response.main.feelslike_!)/1000))"
                self.temperature.text = "Температура: \(Double(round(1000*response.main.temp_!)/1000))"
                self.layoutIfNeeded()
            }, completion: nil)
            
           
        }
    }
    required init(lat: String, lon: String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        getView()
        isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self,
                                                       action: #selector(self.didPress(_ :)))
        self.addGestureRecognizer(gestureRecognizer)
        loadData(lat: lat, lon: lon)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func loadData(lat: String, lon: String){
        WeatherApi.getInformationAboutWeatherInGeoPosition(lat: lat, lon: lon){  response in
            
            DispatchQueue.main.async {
                self.response = response
            }
        }
        DispatchQueue.global(qos: .background).async {
            while true{
                WeatherApi.getInformationAboutWeatherInGeoPosition(lat: lat, lon: lon){ [weak self] response in
                    guard let self = self else{
                        return
                    }
                    DispatchQueue.main.async {
                        self.response = response
                    }
                }
                sleep(10)
            }
        }
        
    }
    private func getView(){
            
        let viewFromNib = UINib(nibName: "WeatherCard", bundle: nil).instantiate(withOwner: self, options: nil)[0] as? UIView
        weatherCard = viewFromNib!.subviews[0]
        weatherCard?.layer.cornerRadius = 12
        guard let weatherCard = weatherCard else {
            return
        }
        
        weatherCard.translatesAutoresizingMaskIntoConstraints = false
        addSubview(weatherCard)
        NSLayoutConstraint.activate([
            weatherCard.topAnchor.constraint(equalTo: topAnchor),
            weatherCard.bottomAnchor.constraint(equalTo: bottomAnchor),
            weatherCard.leadingAnchor.constraint(equalTo: leadingAnchor),
            weatherCard.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        layoutSubviews()
        
    }
    
    @objc func didPress(_ sender: UITapGestureRecognizer){
        let rotation : CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.y")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 5
        self.layer.add(rotation, forKey: "rotationAnimation")
            
        
    }
}
