//
//  extensions.swift
//  Le Baluchon
//
//  Created by Sam on 08/07/2022.
//

import Foundation
import UIKit

extension UIView
{
    
    func makeCornerRounded(cornerRadius: CGFloat, borderWidth: CGFloat)
    {
        clipsToBounds = true
        layer.cornerRadius = cornerRadius
        layer.borderWidth = borderWidth
        layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
    }
}

// MARK: - Extension UIViewController

extension UIViewController
{
    func presentAlert(error: String)
    {
        let alert = UIAlertController(title: "Erreur", message: error, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
extension MoneyViewController: UITextFieldDelegate
{

    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        euroTextField.resignFirstResponder()
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField)
    {
        if euroTextField.text == ""
        {
            dollarTextField.text = "0.0"
        }
    }
}
