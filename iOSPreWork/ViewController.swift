//
//  ViewController.swift
//  iOSPreWork
//
//  Created by John Ajao on 11/30/21.
//

import UIKit

class ViewController: UIViewController {
    
    public var tipPercent: Double = 10
    var billAmount: Double = 200
   
    
    @IBOutlet weak var billAmountTextField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var tipStepper: UIStepper!
    @IBOutlet weak var tipPercentageTextField: UITextField!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    @IBOutlet weak var tipAmountLabel: UILabel!
    @IBOutlet weak var plusImage: UIImageView!
    @IBOutlet weak var minusImage: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        billAmountTextField.becomeFirstResponder()
        
        // Do any additional setup after loading the view.
        if let x = UserDefaults.standard.object(forKey: "tipDefault") as? String{
            tipPercent = Double(x) ?? 50
            tipPercentageTextField.text = String(tipPercent)
            tipStepper.value = tipPercent
        }
        
        if let y = UserDefaults.standard.object(forKey: "savedBill") as? Double{
            billAmount = y
        }
        //set nav bar title
        self.title = "Tippr"
        billAmountTextField.text = String(billAmount)
        calcAndUpdateTip()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        billAmountTextField.becomeFirstResponder()
    }

    
    //Actions
    
    @IBAction func stepperClicked(_ sender: Any) {
        //initalize billAmount to value in textbox
        billAmount = Double(billAmountTextField.text!) ?? 0
        
        //initalize tipPercent as value of stepper
        tipPercent = tipStepper.value
        tipPercentageTextField.text = String(format: "%.0f", tipPercent)
        
        //calculate and update tip and total
        calcAndUpdateTip()
    }
    
   
    @IBAction func tipPercentChanged(_ sender: Any) {
        //set tipPercent to be value in textfield
       tipPercent = Double(tipPercentageTextField.text!) ?? 0
        
        if tipPercent>100 {
            tipPercent = 100
        }
        tipPercentageTextField.text = String(format: "%.0f", tipPercent)
        tipStepper.value = tipPercent
        
        calcAndUpdateTip()
        print("Chnage")
    }
    
    
    @IBAction func billTextFieldEditingChanged(_ sender: Any) {
        billAmount = Double(billAmountTextField.text!) ?? 0
        UserDefaults.standard.set(billAmount, forKey: "savedBill")
        calcAndUpdateTip()
    }
    
    @IBAction func darkModeSwitchToggled(_ sender: Any) {
        if darkModeSwitch.isOn{
            view.backgroundColor = UIColor.black
            plusImage.tintColor = UIColor.orange
            minusImage.tintColor = UIColor.orange
            billAmountTextField.keyboardAppearance = UIKeyboardAppearance.dark
            tipPercentageTextField.keyboardAppearance = UIKeyboardAppearance.dark
        }
        else{
            view.backgroundColor = UIColor.white
            plusImage.tintColor = UIColor.white
            minusImage.tintColor = UIColor.white
            billAmountTextField.keyboardAppearance = UIKeyboardAppearance.light
            tipPercentageTextField.keyboardAppearance = UIKeyboardAppearance.light
        }
    }
    
    //Functions
    
    //calculate tip, total and update shown values
    func calcAndUpdateTip(){
        print(tipPercent)
        let tip = calculateTip(tipPercent: tipPercent, billAmount: billAmount)
        tipAmountLabel.text = "Tip: " + convertToCurrencyFormat(double: tip)
        totalLabel.text = convertToCurrencyFormat(double: tip+billAmount)
    }
    
    //convert tip percent to decimal
    func calculateTip(tipPercent: Double, billAmount: Double) -> Double{
        return billAmount*(tipPercent/100)
    }
    
    //currency formatting
    func convertToCurrencyFormat(double: Double) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale.current
        
        return numberFormatter.string(from: NSNumber(value: double))!
    }
    
}

