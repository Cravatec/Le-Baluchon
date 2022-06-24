//
//  WeatherViewController.swift
//  Le Baluchon
//
//  Created by Sam on 22/06/2022.
//

import UIKit

class WeatherViewController: UIViewController {

    

    @IBOutlet weak var descriptionNYWeather: UILabel!
    @IBOutlet weak var imageViewNY: UIImageView!
    @IBOutlet weak var nyStackView: UIStackView!
    @IBOutlet weak var tempNYCelsius: UILabel!
    @IBOutlet weak var tempNYFahrenheit: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gifNY = UIImage.gifImageWithName("sun")
        imageViewNY.image = gifNY
        
        nyStackView.layer.cornerRadius = 10
        nyStackView.clipsToBounds = true
        nyStackView.layer.borderWidth = 2.5
        nyStackView.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
