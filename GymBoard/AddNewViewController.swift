//
//  AddNewViewController.swift
//  GymBoard
//
//  Created by João Luís on 10/04/17.
//  Copyright © 2017 JoBernas. All rights reserved.
//

import UIKit

class AddNewViewController: SuperViewController {

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
    @IBOutlet weak var edtLeanMass: UITextField!
    @IBOutlet weak var edtPhyEval: UITextField!
    @IBOutlet weak var edtBoneMass: UITextField!
    @IBOutlet weak var edtBMR: UITextField!
    @IBOutlet weak var edtIddMet: UITextField!
    @IBOutlet weak var edtViscFat: UITextField!
    @IBOutlet weak var svContainer: UIScrollView!
    @IBOutlet weak var cBottomScrollContainer: NSLayoutConstraint!
//    @IBOutlet var steppers: [UIStepper]!

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
    
    var leanMass: Double = 0.0 {
        didSet {
            self.updateEntry(key: Entry.TYPE_LEAN_MASS, newValue: self.leanMass, unit: "Kg", edtView: self.edtLeanMass)
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
        //Add Observers
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(sender:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(sender:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
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
        self.title = "Add New Entry"
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
//        if let edt = edtView, let stepper = self.getStepperByTag(edt.tag) {
//            stepper.value = newValue
//        }
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
        self.edtLeanMass?.text = "\(self.leanMass)"
        
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
        self.edtLeanMass?.delegate = self
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
    
    fileprivate func setValues(_ id:Int, value:Double){
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
        case 9:
            self.leanMass = value
        default:
            break
        }
    }
    
    fileprivate func getValue(_ id:Int) ->Double {
        switch id {
        case 0:
            return self.weight
        case 1:
            return self.bmi
        case 2:
            return self.fatMass
        case 3:
            return self.water
        case 4:
            return self.phyEval
        case 5:
            return self.boneMass
        case 6:
            return self.bmr
        case 7:
            return self.iddMet
        case 8:
            return self.viscFat
        case 9:
            return self.leanMass
        default:
            return 0.0
        }
    }
    
    /// Get Stepper for Tag X
    ///
    /// - Parameter tag: 0 to 9
    /// - Returns: UIStepper Instance
//    fileprivate func getStepperByTag(_ tag: Int) -> UIStepper? {
//        var stepper: UIStepper?
//        
//        //Search for First Stepper witht the Tag == tag
//        for stepp in steppers {
//            if stepp.tag == tag {
//                stepper = stepp
//                break
//            }
//        }
//        return stepper
//    }
    
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
        if self.form.count == 10 {
            for (_, value) in self.form {
                value.save()
            }
            _ = navigationController?.popViewController(animated: true)
        }else{
            Toast.showMessage(message: "Missing fields, please check the form.", context: self)
        }
    }
    
    @IBAction func cancelNewEntry(_ sender: UIBarButtonItem) {
        print("Cancel and Close")
        if let date = self.date {
            EntryCRUD.deleteEntriesForDate(date)
        }
        _ = navigationController?.popViewController(animated: true)
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
    
    func keyboardWillShow(sender: NSNotification) {
        let info = sender.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.cBottomScrollContainer.constant = (keyboardFrame.size.height) //Move view 180 points upward
        })
        
    }
    
    func keyboardWillHide(sender: NSNotification) {
        UIView.animate(withDuration: 0.1, animations: { () -> Void in
            self.cBottomScrollContainer.constant = 0
        })
    }

}

extension AddNewViewController: UITextFieldDelegate {
    
    func hideKeyboard(_ recognizer: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        var tmpString = textField.text
        tmpString = tmpString?.replacingOccurrences(of: ",", with: ".")
        
        var result = 0.0
        if let value = tmpString, value.isInt || value.isDouble {
            result = Double(value)!
            self.setValues(textField.tag, value: result)
        }else{ //the Value is not valid reset to the previous value
            result = self.getValue(textField.tag)
            let value = String(result)
            textField.text = value
        }
    }
    
    // MARK: - UITextFieldDelegate Methods
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if(string == "," || string == "."){
//            //Add decimal
//            if let value = textField.text {
//                textField.text = "\(value)."
//            }
//        }
//        return true
//    }
}

