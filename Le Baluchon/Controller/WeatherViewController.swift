//
//  WeatherViewController.swift
//  Le Baluchon
//
//  Created by Sam on 22/06/2022.
//

import UIKit

class WeatherViewController: UIViewController {

    

    @IBOutlet weak var imageViewNY: UIImageView!
//  @IBOutlet weak var imageViewParis: UIImageView!
    
    @IBOutlet weak var nyStackView: UIStackView!
 //   @IBOutlet weak var parisStackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gifNY = UIImage.gifImageWithName("sun")
        imageViewNY.image = gifNY
        
//        let gifParis = UIImage.gifImageWithName("rain")
//        imageViewParis.image = gifParis
        
        
        nyStackView.layer.cornerRadius = 10
        nyStackView.clipsToBounds = true
        nyStackView.layer.borderWidth = 2.5
        nyStackView.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
        
//        parisStackView.layer.cornerRadius = 10
//        parisStackView.clipsToBounds = true
//        parisStackView.layer.borderWidth = 5.5
//        parisStackView.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
