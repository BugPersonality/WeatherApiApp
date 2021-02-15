//
//  ViewController.swift
//  Weather
//
//  Created by Данил Дубов on 28.11.2020.
//

import UIKit
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.view.frame)
        let pizda = WeatherCard(lat: "60.083529", lon: "30.005144")
        
        self.view.addSubview(pizda)
        NSLayoutConstraint.activate([
            pizda.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            pizda.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            pizda.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
           //r pizda.heightAnchor.constraint(equalToConstant: self.view.frame.size.height / 4),
        ])
        
    }
}

