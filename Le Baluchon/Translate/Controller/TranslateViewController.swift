//
//  TranslateViewController.swift
//  Le Baluchon
//
//  Created by Sam on 24/06/2022.
//

import UIKit

class TranslateViewController: UIViewController {
    // MARK: - IBActions
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        frenchTextView.resignFirstResponder()
        englishTextView.resignFirstResponder()
    }
    // MARK: - IBOutlets
    @IBOutlet weak var translateImage: UIImageView!
    @IBOutlet weak var frenchTextView: UITextView!
    @IBOutlet weak var englishTextView: UITextView!
    @IBOutlet weak var frenchPlaceHolder: UITextField!
    @IBOutlet weak var englishPlaceHolder: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let giftranslate = UIImage.gifImageWithName("worldwide")
        translateImage.image = giftranslate
        frenchTextView.delegate = self
        border()
    }
    
    // MARK: - Methods
    func translateText() {
        let textToTranslate = frenchTextView.text!
        let session = URLSession(configuration: .default)
        TranslateApi(session: session).fetchJSON(text: textToTranslate) {(error, translation) in
            if let translation = translation {
                self.englishTextView.text = translation.translatedText
            } else {
                self.presentAlert(error: error?.localizedDescription ?? "Erreur de chargement")
            }
        }
    }
    private func border() {
        frenchTextView.layer.cornerRadius = 10
        frenchTextView.clipsToBounds = true
        frenchTextView.layer.borderWidth = 1.5
        frenchTextView.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
        englishTextView.layer.cornerRadius = 10
        englishTextView.clipsToBounds = true
        englishTextView.layer.borderWidth = 1.5
        englishTextView.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
extension TranslateViewController: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        englishPlaceHolder.placeholder = ""
        translateText()
        
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        frenchPlaceHolder.placeholder = ""
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return true
        }
        return true
    }
}
