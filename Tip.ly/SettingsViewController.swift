//
//  SettingsViewController.swift
//  Tip.ly
//
//  Created by Michael Huh on 8/9/16.
//  Copyright © 2016 Michael Huh. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    /** VARIABLES _______________________________________________________________ **/

    let defaults = NSUserDefaults.standardUserDefaults() // References the user defaults object.
    let KEY_DEFAULT_TIP_VALUE = "key_default_tip_value" // Constant that references the key name for the default tip value.
    let KEY_BILL_OPTION = "key_bill_option" // Constant that references the key name for the default bill option.
    let KEY_PERCENT_OPTION = "key_percent_option" // Constant that references the key name for the default percent option.
    
    @IBOutlet weak var defaultTipValueField: UITextField! // References the tip value field.
    @IBOutlet weak var retainBillValueSwitch: UISwitch! // References the retain bill value switch.
    @IBOutlet weak var retainPercentageValueSwitch: UISwitch! // References the retain tip percentage switch.
    
    /** VIEW CONTROLLER METHODS _________________________________________________ **/
    
    // viewDidLoad(): Runs after the view has loaded. Do any additional setup after
    // loading the view, typically from a nib.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaultTipValue = defaults.floatForKey(KEY_DEFAULT_TIP_VALUE) // Retrieves the default tip value.
        let retainBillOption = defaults.boolForKey(KEY_BILL_OPTION) // Retrieves the retain bill value from user defaults.
        let retainPercentOption = defaults.boolForKey(KEY_PERCENT_OPTION) // Retrieves the percent tip value from user defaults.
        
        defaultTipValueField.text = String(defaultTipValue) // Sets the default tip value.
        retainBillValueSwitch.setOn(retainBillOption, animated: false) // Sets the switch value for retain bill value.
        retainPercentageValueSwitch.setOn(retainPercentOption, animated: false) // Sets the switch value for percentage value.
    }

    // didReceiveMemoryWarning(): Dispose of any resources that can be recreated.
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /** SETTINGS METHODS ________________________________________________________ **/
    
    // setTipDefaultValue(): Runs when the default tip value field has changed. Sets the default tip value.
    @IBAction func setTipDefaultValue(sender: AnyObject) {
        
        // Retrieves the default tip value from the default tip field.
        let defaultTipValue = Float(defaultTipValueField.text!) ?? 0
        
        // If default tip value exceeds range, defaultTipValueField value is updated to be within range.
        if (defaultTipValue > 50) {
            defaultTipValueField.text = "50"
            return
        } else if (defaultTipValue < 0) {
            defaultTipValueField.text = "0"
            return
        }
        
        defaults.setFloat(defaultTipValue, forKey: KEY_DEFAULT_TIP_VALUE)
        defaults.synchronize() // Saves the changed value to user defaults.
    }
    
    // setBillValueDefaultValue(): Runs when the retain bill value switch is toggled.
    // Saves the switch value to user defaults.
    @IBAction func setBillValueDefaultValue(sender: AnyObject) {
        defaults.setBool(retainBillValueSwitch.on, forKey: KEY_BILL_OPTION)
        defaults.synchronize() // Saves the changed value to user defaults.
    }
    
    // setTipPercentDefaultValue(): Runs when the retain percentage value switch is 
    // toggled. Saves the switch value to user defaults. Note that when enabled,
    // this overrides the tipDefaultValue setting.
    @IBAction func setTipPercentDefaultValue(sender: AnyObject) {
        defaults.setBool(retainPercentageValueSwitch.on, forKey: KEY_PERCENT_OPTION)
        defaults.synchronize() // Save the changed value to user defaults.
    }
}