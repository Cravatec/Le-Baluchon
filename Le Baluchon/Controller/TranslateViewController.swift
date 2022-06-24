//
//  TranslateViewController.swift
//  Le Baluchon
//
//  Created by Sam on 24/06/2022.
//

import UIKit

class TranslateViewController: UIViewController {
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        text1.resignFirstResponder()
        text2.resignFirstResponder()

    }
    
    @IBOutlet weak var translateImage: UIImageView!
    @IBOutlet weak var text1: UITextField!
    @IBOutlet weak var text2: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let giftranslate = UIImage.gifImageWithName("worldwide")
        translateImage.image = giftranslate
}
}
