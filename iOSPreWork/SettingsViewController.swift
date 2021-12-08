//
//  SettingsViewController.swift
//  iOSPreWork
//
//  Created by John Ajao on 12/7/21.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var tipDefaultTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tipDefaultTextField.becomeFirstResponder()
        //setting what is in textfield to user defing default value
        if let x = UserDefaults.standard.object(forKey: "tipDefault") as? String{
            tipDefaultTextField.text = String(x)
        }
        
    }
    
    @IBAction func tipDefaultChanged(_ sender: Any) {
        
        //code to force percentage to not go above 100
        let tipDef = Double(tipDefaultTextField.text!) ?? 0
        tipDefaultTextField.text = String( Int(tipDefaultTextField.text!) ?? 0)
        
        if tipDef>100{
            tipDefaultTextField.text = "100"
        }
        
        //permanent storage of set default value
        UserDefaults.standard.set(tipDefaultTextField.text, forKey: "tipDefault")
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
