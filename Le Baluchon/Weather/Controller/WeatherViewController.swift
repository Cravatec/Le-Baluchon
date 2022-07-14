//
//  WeatherViewController.swift
//  Le Baluchon
//
//  Created by Sam on 22/06/2022.
//

import UIKit

class WeatherViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var reloadButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var cardViewWhite: UIView!
    @IBOutlet weak var cardViewBlack: UIView!
    //New York
    @IBOutlet weak var nyStackView: UIStackView!
    @IBOutlet weak var descriptionNYWeatherLabel: UILabel!
    @IBOutlet weak var imageViewNY: UIImageView!
    @IBOutlet weak var tempNYCelsiusLabel: UILabel!
    @IBOutlet weak var tempNYFahrenheitLabel: UILabel!
    //Paris
    @IBOutlet weak var parisStackView: UIStackView!
    @IBOutlet weak var imageViewParis: UIImageView!
    @IBOutlet weak var descriptionParisWeatherLabel: UILabel!
    @IBOutlet weak var tempParisCelsiusLabel: UILabel!
    @IBOutlet weak var tempParisFahrenheitLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gifNY = UIImage.gifImageWithName("sun")
        let gifParis = UIImage.gifImageWithName("sun")
        imageViewNY.image = gifNY
        imageViewParis.image = gifParis
        stackviewSetup()
        cardViewBlackSetup()
        cardViewWhiteSetup()
        weather(city: "New York")
        weather(city: "Paris")
    }
    
    // MARK: - IBAction
    
    @IBAction func tappedReloadButton(_ sender: Any) {
        weather(city: "New York")
        weather(city: "Paris")
    }
    
    // MARK: - Methods
    
    private func stackviewSetup() {
        nyStackView.layer.cornerRadius = 10
        nyStackView.clipsToBounds = true
    }
    
    private func cardViewBlackSetup() {
        cardViewBlack.layer.cornerRadius = 10
        cardViewBlack.clipsToBounds = true
    }
    
    private func cardViewWhiteSetup() {
        cardViewWhite.layer.cornerRadius = 10
        cardViewWhite.clipsToBounds = true
        cardViewWhite.layer.borderWidth = 1
        cardViewWhite.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    private func weather(city: String) {
        toggleActivityIndicator(shown: true)
        
        WeatherAPI().fetchWeather(city: city) { [weak self] result in
            DispatchQueue.main.async {
                self?.toggleActivityIndicator(shown: false)
                switch result {
                case .success(let weather):
                    self?.updateDataLabel(city: city, weather: weather)
                case .failure(let error):
                    self?.presentAlert(error: error.localizedDescription)
                }
            }
        }
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        self.reloadButton.isHidden = shown
        self.activityIndicator.isHidden = !shown
        self.activityIndicator.startAnimating()
    }
    
    private func updateDataLabel(city: String, weather: WeatherModel) {
        if city == "New York" {
            self.tempNYCelsiusLabel.text = "🌡\(weather.temperatureString)°C"
            self.imageViewNY.image = UIImage.gifImageWithName("\(weather.conditionName)")
            self.descriptionNYWeatherLabel.text = weather.main
            self.tempNYFahrenheitLabel.text = "🌡\(CelsiusToFahrenheit(temp: weather.temperature))°F"
        }    else if city == "Paris" {
            self.tempParisCelsiusLabel.text = "🌡\(weather.temperatureString)°C"
            self.imageViewParis.image = UIImage.gifImageWithName("\(weather.conditionName)")
            self.descriptionParisWeatherLabel.text = weather.main
            self.tempParisFahrenheitLabel.text = "🌡\(CelsiusToFahrenheit(temp: weather.temperature))°F"
        }
    }
    
    // MARK: - Convert Celsius to Fahrenheit and return the result in Int */
    
    private func CelsiusToFahrenheit(temp: Double) -> Int {
        return Int((temp * 9/5 + 32))
    }
}
