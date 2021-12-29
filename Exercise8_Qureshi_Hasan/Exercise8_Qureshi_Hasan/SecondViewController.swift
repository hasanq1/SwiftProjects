//
//  SecondViewController.swift
//  Exercise8_Qureshi_Hasan
//
//  Created by Hasan Qureshi on 11/11/21.
//  Copyright © 2021 Hasan Qureshi. All rights reserved.
//


import UIKit
import NaturalLanguage

class SecondViewController: UIViewController {

    @IBOutlet weak var inputTxt: UITextField!
    @IBOutlet weak var resultTxt: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func textAnalysis(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            tokenizeText()
        } else if sender.selectedSegmentIndex == 1 {
            lemmatizeText()
        }
        else if sender.selectedSegmentIndex == 2 {
            analyzeSentiment()
        }
    }
    func analyzeSentiment(){
        let text = inputTxt.text!
        let tagger = NLTagger(tagSchemes: [.sentimentScore])
        tagger.string = text
        
        let sentiment = tagger.tag(at: text.startIndex, unit: .paragraph, scheme: .sentimentScore).0
        
        let score = sentiment?.rawValue
        var value: Double
        if score == nil {
            value = 0
        }
        else {value = Double(score!)!}
        var status = ""
        if value == 0 {
            status = "neutral"
        } else if value > 0 {
            status = "positive"
        }
        else { status = "negative" }
        
        resultTxt.text = "The input is a \(status) text. Sentiment Score: \(value)"
    }
    func lemmatizeText(){
        let text = inputTxt.text!
        let tagger = NLTagger(tagSchemes: [.lemma])
        tagger.string = text
        
        var outputTxt = ""
        
        tagger.enumerateTags(in: text.startIndex..<text.endIndex, unit: .word, scheme: .lemma) {
            tag, tokenId in
            if let convertedTag = tag {
                outputTxt += "\(text[tokenId]): \(convertedTag.rawValue.capitalized)\n"
            }
            return true
        }
        // print(outputTxt)
        resultTxt.text = outputTxt
    }
    
    func tokenizeText(){
        let text = inputTxt.text!
        
        let tokenizer = NLTokenizer(unit: .word)
        
        tokenizer.string = text
        
        var outputTxt = ""
        tokenizer.enumerateTokens(in: text.startIndex..<text.endIndex) {
            tokenIdx, _ in
            
            if outputTxt == "" {
                outputTxt += text[tokenIdx]
            } else {
                outputTxt += ", \(text[tokenIdx])"
            }
            return true
        }
        resultTxt.text = outputTxt
    }

    
}

