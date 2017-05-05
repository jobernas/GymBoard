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
    @IBOutlet weak var edtWeight: UITextField!
    @IBOutlet weak var edtBMI: UITextField!
    @IBOutlet weak var edtFatMass: UITextField!
    @IBOutlet weak var edtWater: UITextField!
    @IBOutlet weak var edtPhyEval: UITextField!
    @IBOutlet weak var edtBoneMass: UITextField!
    @IBOutlet weak var edtBMR: UITextField!
    @IBOutlet weak var edtIddMet: UITextField!
    @IBOutlet weak var edtViscFat: UITextField!
    
    /***
     * Computed Vars
     */
    var date: String? {
        didSet {
            self.edtDate?.text = date
            // self.edtDate.setNeedsDisplay()
            for (_, value) in self.form {
                value.update(key: nil, date: self.date!, value: nil, unit: nil)
            }
        }
    }
    
    var weight: Double = 0.0 {
        didSet {
            self.updateEntry(key: Entry.TYPE_WEIGHT, newValue: self.weight, unit: "Kg", edtView: self.edtWeight)
        }
    }
    
    var bmi: Double = 0.0 {
        didSet {
            self.updateEntry(key: Entry.TYPE_BMI, newValue: self.bmi, unit: "", edtView: self.edtBMI)
        }
    }
    
    var fatMass: Double = 0.0 {
        didSet {
            self.updateEntry(key: Entry.TYPE_FAT_MASS, newValue: self.fatMass, unit: "%", edtView: self.edtFatMass)
        }
    }
    
    var water: Double = 0.0 {
        didSet {
            self.updateEntry(key: Entry.TYPE_WATER, newValue: self.water, unit: "%", edtView: self.edtWater)
        }
    }
    
    var phyEval: Double = 0.0 {
        didSet {
            self.updateEntry(key: Entry.TYPE_PHYSICAL_EVAL, newValue: self.phyEval, unit: "", edtView: self.edtPhyEval)
        }
    }
    
    var boneMass: Double = 0.0 {
        didSet {
            self.updateEntry(key: Entry.TYPE_BONE_MASS, newValue: self.boneMass, unit: "", edtView: self.edtBoneMass)
        }
    }
    
    var bmr: Double = 0.0 {
        didSet {
            self.updateEntry(key: Entry.TYPE_BMR, newValue: self.bmr, unit: "", edtView: self.edtBMR)
        }
    }
    
    var iddMet: Double = 0.0 {
        didSet {
            self.updateEntry(key: Entry.TYPE_IDDMET, newValue: self.iddMet, unit: "", edtView: self.edtIddMet)
        }
    }
    
    var viscFat: Double = 0.0 {
        didSet {
            self.updateEntry(key: Entry.TYPE_VIS_FAT, newValue: self.viscFat, unit: "", edtView: self.edtViscFat)
        }
    }
    
    // Var
    var form = [Int: Entry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if self.date == nil {
            let date = TimeManager.getTodaysDate()
            self.setData(date, array: Array(EntryCRUD.getDailyEntries(date)))
        }
        self.edtDate.inputView = self.getDatePickerConfig()
        self.edtDate.inputAccessoryView = self.getDateToolbar()
        
        // Touch Event to close keyboard
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(self.hideKeyboard(_:)))
        gesture.numberOfTapsRequired = 1
        gesture.cancelsTouchesInView = true
        gesture.delaysTouchesBegan = false
        gesture.delaysTouchesEnded = false
        self.view.addGestureRecognizer(gesture)
        
        //Init UI
        self.setUI()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /***
     * Private Methods
     ***/
    private func updateEntry(key: Int, newValue: Double, unit: String, edtView: UITextField?){
        var newEntry : Entry!
        if let index = self.form.index(forKey: key) {
            newEntry = self.form.values[index]
            print(newEntry)
        }else{
            newEntry = Entry()
        }
        newEntry.update(key: key, date: self.date!, value: newValue, unit: unit)
        edtView?.text = "\(newValue)"
        self.form[key] = newEntry
    }
    
    private func setUI() {
        self.edtDate?.text = date
        self.edtWeight?.text = "\(self.weight)"
        self.edtBMI?.text = "\(self.bmi)"
        self.edtFatMass?.text = "\(self.fatMass)"
        self.edtWater?.text = "\(self.water)"
        self.edtPhyEval?.text = "\(self.phyEval)"
        self.edtBoneMass?.text = "\(self.boneMass)"
        self.edtBMR?.text = "\(self.bmr)"
        self.edtIddMet?.text = "\(self.iddMet)"
        self.edtViscFat?.text = "\(self.viscFat)"
        
        //Init Delegates
        self.edtWeight?.delegate = self
        self.edtBMI?.delegate = self
        self.edtFatMass?.delegate = self
        self.edtWater?.delegate = self
        self.edtPhyEval?.delegate = self
        self.edtBoneMass?.delegate = self
        self.edtBMR?.delegate = self
        self.edtIddMet?.delegate = self
        self.edtViscFat?.delegate = self
    }

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
    
    private func setValues(_ id:Int, value:Double){
        switch id {
        case 0:
            self.weight = value
        case 1:
            self.bmi = value
        case 2:
            self.fatMass = value
        case 3:
            self.water = value
        case 4:
            self.phyEval = value
        case 5:
            self.boneMass = value
        case 6:
            self.bmr = value
        case 7:
            self.iddMet = value
        case 8:
            self.viscFat = value
        default:
            break
        }
    }
    
    public func setData(_ date:String, array data:Array<Entry>){
        self.date = date
        print("-----------------------------------------------")
        print(data)
        for entry in data {
            self.form[entry.type] = entry
            self.setValues(entry.type, value: entry.value)
        }
        print("-----------------------------------------------")
        print(self.form)
    }
    
    /****
     * Actions
     ****/
    @IBAction func enterDate(_ sender: UITextField) {
        
    }
    
    @IBAction func handleValue(_ sender: UIStepper) {
        self.setValues(sender.tag, value: sender.value)
    }
    
    @IBAction func saveNewEntry(_ sender: UIBarButtonItem) {
        print("Save and Close")
        print(self.form)
        if self.form.count == 9 {
            for (_, value) in self.form {
                value.save()
            }
            _ = navigationController?.popViewController(animated: true)
        }else{
            Toast.showMessage(message: "Missing fields, please check the form.", context: self)
        }
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
                    let date = TimeManager.convertDateToAppFormate(date: piker.date)
                    self.setData(date, array: Array(EntryCRUD.getDailyEntries(date)))
                }
            }
            fallthrough
        default:
            //Hide Picker
            self.edtDate.endEditing(true)
        }
    }
}

extension AddNewViewController: UITextFieldDelegate {
    
    func hideKeyboard(_ recognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        // Try to find next responder
//        if textField == edtUsername {
//            edtPassword.becomeFirstResponder()
//        } else {
//            // Not found, so remove keyboard.
//            textField.resignFirstResponder()
//            validator.validate(self)
//        }
        // Do not add a line break
        return false
    }
}

