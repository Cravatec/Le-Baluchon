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
    }
    
    // MARK: - Methods
    
    @objc private func moneyConvert()
    {
        let euroToConvert = Double(self.euroTextField.text!)!
        // Check if the last api call exceeded 24h
        if !isStorageLessThan24()
        {
            // fetch the rates if the last call exceeded 24h
            MoneyApi().fetchMoney()
            { [weak self] result in DispatchQueue.main.async
                {
                    switch result
                    {
                    case .success(let money):
                        if self?.euroTextField.text != ""
                        { let rates = money.currencyData
                            self?.storeDataMoney(rates: rates)
                            self!.updateUI(amount: euroToConvert, basedOn: rates)
                            print("get stored Rates \(String(describing: self?.getStoredRates))")
//                            for (symbol, ratesUpdate) in rates
//                            {
//                                print("\(symbol) = \(ratesUpdate)")
//                                let total = euroToConvert! * ratesUpdate
//                                self?.dollarTextField.text = String(format: "%.2f", total)
//                                self?.updateDate.text = "Update \(money.date)"
//                            }
                        }
                    case .failure:
                        if self?.euroTextField.text != ""
                        { self?.presentAlert(error: "Error when trying to catch the rate update")
                            self?.dollarTextField.text = "0.0"
                        }
                        return
                    }
                }
            }
        }
    }
    
    private func updateUI(amount: Double, basedOn rates: [String: Double]) {
        
        for (symbol, ratesUpdate) in rates
        {
            print("\(symbol) = \(ratesUpdate)")

            let total = amount * ratesUpdate

            dollarTextField.text = String(format: "%.2f", total)
            updateDate.text = "Update \(String(describing: getLastFetchDate()))"
        }
    }
    
    
    private func storeDataMoney(rates: [String: Double])
    {
        UserDefaults.standard.set(rates, forKey: "rates")
        UserDefaults.standard.set(Date(), forKey: "lastFetchDate")
        UserDefaults.standard.synchronize()
    }
    
    private func getStoredRates() -> [String: Double]?
    {
        let storedRates = UserDefaults.standard.dictionary(forKey: "rates")
        return storedRates as? [String: Double]
    }
    
    private func getLastFetchDate() -> Date?
    {
        let lastFetchDate = UserDefaults.standard.object(forKey: "lastFetchDate") as? Date
        return lastFetchDate
    }
    
    private func isStorageLessThan24() -> Bool
    {
        guard let lastFetchDate = getLastFetchDate() else
        {
            return false
        }
        let calendar = Calendar.current
        let diff = calendar.dateComponents([.hour], from: lastFetchDate, to: Date()).hour
        let hoursInDay = 24

        print("Difference ==> \(String(describing: diff))")
        return diff != nil ? diff! < hoursInDay : false
    }
}
