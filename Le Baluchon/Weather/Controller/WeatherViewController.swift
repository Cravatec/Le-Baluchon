//
//  WeatherViewController.swift
//  Le Baluchon
//
//  Created by Sam on 22/06/2022.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var reloadButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var cardViewWhite: UIView!
    @IBOutlet weak var cardViewBlack: UIView!
    @IBOutlet weak var descriptionNYWeatherLabel: UILabel!
    @IBOutlet weak var imageViewNY: UIImageView!
    @IBOutlet weak var nyStackView: UIStackView!
    @IBOutlet weak var tempNYCelsiusLabel: UILabel!
    @IBOutlet weak var tempNYFahrenheitLabel: UILabel!
    
    
    @IBAction func tappedReloadButton(_ sender: Any) {
        downloadWeather()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gifNY = UIImage.gifImageWithName("sun")
        imageViewNY.image = gifNY
        stackviewSetup()
        cardViewBlackSetup()
        cardViewWhiteSetup()
    }
    
    private func stackviewSetup() {
        nyStackView.layer.cornerRadius = 10
        nyStackView.clipsToBounds = true
        // nyStackView.layer.borderWidth = 1.5
        // nyStackView.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
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
   
    private func downloadWeather() {
        toggleActivityIndicator(shown: true)
        
        WeatherAPI.shared.fetchWeather { (success, weather) in
            DispatchQueue.main.async {
                self.toggleActivityIndicator(shown: false)
                if success, let weather = weather {
                    self.update(weather: weather)
                } else {
                    self.presentAlert()
                }
            }
        }
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        self.reloadButton.isHidden = shown
        self.activityIndicator.isHidden = !shown
        self.activityIndicator.startAnimating()
    }
    private func update(weather: Weather) {
        descriptionNYWeatherLabel.text = weather.description
    }
    
    private func presentAlert() {
        let alert = UIAlertController(title: "Error", message: "The weather download failed", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
