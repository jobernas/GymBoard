//
//  AddNewViewController.swift
//  GymBoard
//
//  Created by João Luís on 10/04/17.
//  Copyright © 2017 JoBernas. All rights reserved.
//

import UIKit

class AddNewViewController: UIViewController {

    //Lets
    let DONE = 0;
    let CANCEL = 1;
    
    /***
     * Widgets
     ***/
    @IBOutlet weak var edtDate: UITextField!
    
    /***
     * Computed Vars
     */
    var date: String? {
        didSet {
            self.edtDate.text = date
            self.edtDate.setNeedsDisplay()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.date = TimeManager.getTodaysDate()
        self.edtDate.inputView = self.getDatePickerConfig()
        self.edtDate.inputAccessoryView = self.getDateToolbar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /***
     * Private Methods
     ***/
    

    //Set Date Picker
    private func getDatePickerConfig() -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.setDate(Date(), animated: false)
        datePicker.datePickerMode = UIDatePickerMode.date
        return datePicker
    }
    
    //Set Date Picker Controls Done and Cancel
    private func getDateToolbar() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(donePicker))
        doneButton.tag = DONE
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(donePicker))
        cancelButton.tag = CANCEL
        
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    
    /****
     * Actions
     ****/
    @IBAction func enterDate(_ sender: UITextField) {
        
    }
    
    func donePicker (sender:UIBarButtonItem)
    {
        // Put something here
        switch sender.tag {
        case DONE:
            //Set date
            if let piker = self.edtDate.inputView as? UIDatePicker {
                if(piker.date > Date()){
                    Toast.showMessage(message: "Date Can't be bigger than Today", context: self)
                }else{
                    self.date = TimeManager.convertDateToAppFormate(date: piker.date)
                }
            }
            fallthrough
        default:
            //Hide Picker
            self.edtDate.endEditing(true)
        }
    }
}

