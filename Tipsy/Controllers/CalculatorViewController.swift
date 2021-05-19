//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    var tips: Float = 1.0
    var total: Float = 0.0
    
    @IBOutlet weak var billText: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func tipChanged(_ sender: UIButton) {
        billText.endEditing(true)
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        sender.isSelected = true
        switch sender.currentTitle {
        case "10%":
            tips = 1.1
        case "20%":
            tips = 1.2
        default:
            tips = 1.0
        }
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel.text = String(format: "%.0f", sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        print(billText.text ?? "123.56")
        let bill = Float(billText.text!) ?? 123.56
        let split = Float(splitNumberLabel.text!) ?? 2.0
        total = bill * tips / split
        performSegue(withIdentifier: "goToResult", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.amount = String(total)
            switch tips {
                case 1.1:
                    destinationVC.tips = "10%"
            case 1.2:
                destinationVC.tips = "20%"
            default:
                destinationVC.tips = "0%"
            }
            destinationVC.numberOfSplit = splitNumberLabel.text
        }
    }
}

