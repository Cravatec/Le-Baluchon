//
//  WeatherViewController.swift
//  Le Baluchon
//
//  Created by Sam on 22/06/2022.
//

import UIKit

class WeatherViewController: UIViewController {

    
    @IBOutlet weak var imageViewNY: UIImageView!
    @IBOutlet weak var imageViewParis: UIImageView!
    
    @IBOutlet weak var nyStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gifNY = UIImage.gifImageWithName("sun")
        imageViewNY.image = gifNY
        
        let gifParis = UIImage.gifImageWithName("rain")
        imageViewParis.image = gifParis
        
        
        nyStackView.layer.cornerRadius = 10
        nyStackView.clipsToBounds = true
        
//        // The following is "supposed" to create rounded corners for the stackview
//            let subView = UIView()
//            subView.backgroundColor = .yellow // this ends up showing through instead of the systemPink
//            subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            subView.layer.cornerRadius = 10
//            subView.layer.masksToBounds = true
//            subView.clipsToBounds = true
//            view.addSubview(subView)
//            subView.translatesAutoresizingMaskIntoConstraints = false
//
//            let nyStackView = UIStackView()
//        nyStackView.axis = .vertical
//        nyStackView.distribution = .fillEqually
//        nyStackView.alignment = .fill
//        nyStackView.spacing = 6
//        nyStackView.backgroundColor = .systemPink // this actually works
//
//            subView.addSubview(nyStackView)
//        nyStackView.translatesAutoresizingMaskIntoConstraints = false
            
            // Fill the stackview with buttons
//            for index in 0..< buttonList.count {
//                let button = UIButton()
//                button.setTitle(buttonList[index], for: .normal)
//                button.backgroundColor = .cyan
//                button.setTitleColor(.black, for: .normal)
//                button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
//                stackView.addArrangedSubview(button)
//            }
//
//            NSLayoutConstraint.activate([
//                nyStackView.trailingAnchor.constraint(equalTo: subView.trailingAnchor),
//                nyStackView.leadingAnchor.constraint(equalTo: subView.leadingAnchor),
//                nyStackView.topAnchor.constraint(equalTo: subView.topAnchor),
//                nyStackView.bottomAnchor.constraint(equalTo: subView.bottomAnchor),
//
//                subView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//                subView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//                subView.widthAnchor.constraint(equalToConstant: 140)
//            ])
        
        
        // Do any additional setup after loading the view.
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
