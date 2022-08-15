//
//  TranslateViewController.swift
//  Le Baluchon
//
//  Created by Sam on 24/06/2022.
//

import UIKit

class TranslateViewController: UIViewController
{
    
    // MARK: - IBActions
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer)
    {
        frenchTextView.resignFirstResponder()
        englishTextView.resignFirstResponder()
    }
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var translateImage: UIImageView!
    @IBOutlet weak var frenchTextView: UITextView!
    @IBOutlet weak var englishTextView: UITextView!
    @IBOutlet weak var frenchPlaceHolder: UITextField!
    @IBOutlet weak var englishPlaceHolder: UITextField!
    @IBOutlet weak var cardViewBlack: UIView!
    @IBOutlet weak var cardViewWhite: UIView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let giftranslate = UIImage.gifImageWithName("worldwide")
        translateImage.image = giftranslate
        frenchTextView.delegate = self
        cardViewWhite.makeCornerRounded(cornerRadius: 10, borderWidth: 1)
        cardViewBlack.makeCornerRounded(cornerRadius: 10, borderWidth: 1)
        frenchTextView.makeCornerRounded(cornerRadius: 10, borderWidth: 1.5)
        englishTextView.makeCornerRounded(cornerRadius: 10, borderWidth: 1.5)
    }
    
    // MARK: - Methods
    
    func translateText()
    {
        let textToTranslate = frenchTextView.text!
        
        TranslateApi().fetchTranslation(text: textToTranslate)
        { [weak self] result in
            DispatchQueue.main.async
            {
                switch result
                {
                case .success(let translation):
                    self?.englishTextView.text = translation.translatedText
                    print("Source: \(translation.detectedSourceLanguage)")
                case .failure(let error):
                    self?.presentAlert(error: error.localizedDescription)
                }
            }
        }
    }
}

extension TranslateViewController: UITextViewDelegate
{
    
    func textViewDidEndEditing(_ textView: UITextView)
    {
        englishPlaceHolder.placeholder = ""
        translateText()
        
    }
    func textViewDidBeginEditing(_ textView: UITextView)
    {
        frenchPlaceHolder.placeholder = ""
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        if text == "\n"
        {
            textView.resignFirstResponder()
            return true
        }
        return true
    }
}
