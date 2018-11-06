//
//  ViewController.swift
//  CalculatorApp
//
//  Created by nira on 2018/11/01.
//  Copyright © 2018年 nira. All rights reserved.
//

import UIKit
import Expression

class ViewController: UIViewController {
    @IBAction func clearCalculation(_ sender: UIButton) {
        //Cボタンが押されたら式と答えをクリアする
        formulaLabel.text = ""
        answerLabel.text = ""
    }
    @IBAction func answerCalculation(_ sender: UIButton) {
        //=ボタンが押されたら答えを計算して表示する
        guard let formulaText = formulaLabel.text else {
            return
        }
        let formula: String = formatFormula(formulaText)
        answerLabel.text = evalFormula(formula)
    }
    
    private func formatFormula(_ formula: String) -> String{
        let formattedFormula: String = formula.replacingOccurrences(
            of: "(?<=^|[÷×\\+\\-\\(])([0-9]+)(?=[÷×\\+\\-\\)]|$)",
            with: "$1.0",
            options: NSString.CompareOptions.regularExpression,
            range: nil
        ).replacingOccurrences(of: "÷", with: "/").replacingOccurrences(of: "×", with: "*")
        return formattedFormula
    }
    
    private func evalFormula(_ formula: String) -> String{
        do{
            //Expressionで文字列の計算式を評価して答えを求める
            let expression = Expression(formula)
            let answer = try expression.evaluate()
            return formatAnswer(String(answer))
        } catch{
            //計算式が不当だった場合
            return "式を正しく入力してください"
        }
    }
    
    private func formatAnswer(_ answer: String) -> String{
        //答えの小数点以下が.0だった場合はそれを削除して整数で表示する
        let formattedAnswer: String = answer.replacingOccurrences(of: "\\.0$",
        with: "",
        options: NSString.CompareOptions.regularExpression,
        range: nil)
        return formattedAnswer
    }
    @IBAction func inputFormula(_ sender: UIButton) {
        //ボタンが押されたら式を表示する
        guard let formulaText = formulaLabel.text else {
            return
        }
        guard let senderedText = sender.titleLabel?.text else {
            return
        }
        formulaLabel.text = formulaText + senderedText
    }
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var formulaLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ビューがロードされた時点で式と答えのラベルは空にする
        formulaLabel.text = ""
        answerLabel.text = ""
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning(){
        super.didReceiveMemoryWarning()
    }
}

