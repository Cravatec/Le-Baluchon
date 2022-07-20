//
//  MoneyViewController.swift
//  Le Baluchon
//
//  Created by Sam on 24/06/2022.
//

import UIKit

class MoneyViewController: UIViewController
{
    // MARK: - IBAction
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer)
    {
        dollarTextField.resignFirstResponder()
        euroTextField.resignFirstResponder()
    }
    
    
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var euroTextField: UITextField!
    @IBOutlet weak var dollarTextField: UITextField!
    @IBOutlet weak var moneyImage: UIImageView!
    @IBOutlet weak var cardViewBlack: UIView!
    @IBOutlet weak var cardViewWhite: UIView!
    @IBOutlet weak var updateDate: UILabel!
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let gifmoney = UIImage.gifImageWithName("euro")
        moneyImage.image = gifmoney
        cardViewBlack.makeCornerRounded(cornerRadius: 10, borderWidth: 1)
        cardViewWhite.makeCornerRounded(cornerRadius: 10, borderWidth: 1)
        euroTextField.delegate = self
        euroTextField.addTarget(self, action: #selector(moneyConvert), for: .editingChanged)
      //  moneyConvert()
    }
    
    // MARK: - Methods
    
    @objc private func moneyConvert()
    {
        
        let euroToConvert = Double(self.euroTextField.text!)
        
        MoneyApi().fetchMoney()
        { [weak self] result in DispatchQueue.main.async
            {
                switch result
                {
                case .success(let money):
                    if self?.euroTextField.text != ""
                    { let rates = money.currencyData
                        for (symbol, ratesUpdate) in rates
                        {
                            print("\(symbol) = \(ratesUpdate)")
                            let total = euroToConvert! * ratesUpdate
                            self?.dollarTextField.text = String(format: "%.2f", total)
                            self?.updateDate.text = "Update \(money.date)"
                        }
                    }
                case .failure(_):
                    if self?.euroTextField.text != ""
                    { self?.presentAlert(error: "Veuillez entrer un nombre !")
                        self?.dollarTextField.text = "0.0"
                    }
                    return
                }
            }
        }
    }
}
