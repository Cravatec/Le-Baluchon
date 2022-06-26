//
//  WeatherViewController.swift
//  Le Baluchon
//
//  Created by Sam on 22/06/2022.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var descriptionNYWeatherLabel: UILabel!
    @IBOutlet weak var imageViewNY: UIImageView!
    @IBOutlet weak var nyStackView: UIStackView!
    @IBOutlet weak var tempNYCelsiusLabel: UILabel!
    @IBOutlet weak var tempNYFahrenheitLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gifNY = UIImage.gifImageWithName("sun")
        imageViewNY.image = gifNY
        stackviewSetup()
        cardViewSetup()
    }
    
    private func stackviewSetup() {
        nyStackView.layer.cornerRadius = 10
        nyStackView.clipsToBounds = true
        nyStackView.layer.borderWidth = 2.5
        nyStackView.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
    }
    
    private func cardViewSetup() {
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
    }
    
}
