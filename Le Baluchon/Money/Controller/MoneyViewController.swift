//
//  MoneyViewController.swift
//  Le Baluchon
//
//  Created by Sam on 24/06/2022.
//

import UIKit

class MoneyViewController: UIViewController {
    // MARK: - Properties

    // MARK: - IBAction
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        dollarTextField.resignFirstResponder()
        euroTextField.resignFirstResponder()
    }
    // MARK: - IBOutlets
    @IBOutlet weak var euroTextField: UITextField!
    @IBOutlet weak var dollarTextField: UITextField!
    @IBOutlet weak var moneyImage: UIImageView!
    @IBOutlet weak var cardViewBlack: UIView!
    @IBOutlet weak var cardViewWhite: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gifmoney = UIImage.gifImageWithName("euro")
        moneyImage.image = gifmoney
        cardViewBlack.makeCornerRounded(cornerRadius: 10, borderWidth: 1)
        cardViewWhite.makeCornerRounded(cornerRadius: 10, borderWidth: 1)
    }
    
    // MARK: - Methods
    }
