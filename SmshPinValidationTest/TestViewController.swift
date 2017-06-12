//
//  ViewController.swift
//  SmshPinValidationTest
//
//  Created by Sviluppo 3 on 26/05/17.
//  Copyright © 2017 i-contact. All rights reserved.
//

import UIKit

class TestViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    
    var infoLabel:UILabel!
    var countryCodeTextField:UITextField!
    var phoneTextField:UITextField!
    var pinTextField:UITextField!
    var verifyButton:UIButton!
    var verifyId:String!
    var countryCodesList:[[String:Any]]!
    var countryPicker: UIPickerView!
    
    var loadingView:LoadingView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.view.backgroundColor = UIColor(red: 235.0/255, green: 235.0/255, blue: 236.0/255, alpha: 1.0)
        
        printView()
        countryCodesList = []
        getCountryCodes()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: UITextField Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
    //MARK: UIPickerView Methods
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return countryCodesList.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(format:"%@ (%d)",(countryCodesList[row]["countyName"] as! String),(countryCodesList[row]["prefix"] as! Int))
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        countryCodeTextField.text = String(format: "%d",countryCodesList[row]["prefix"] as! Int)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //MARK: ***** Verify Methods *****
    func sendPin(){
        self.view.endEditing(true)
        verifyId = nil
        
        showLoadingView()
        
        let completeNumber:String = countryCodeTextField.text! + phoneTextField.text!
        
        SmshostingVerify.sendPinWithPhoneNumberAndText(phoneNumber: completeNumber, text:"SMSHosting code ${verify_code}", sandbox:false, completion: {
            (result: [String:Any]) in
            
            DispatchQueue.main.async {
                
                if(result["errorCode"] == nil){
                    //Request Done
                    
                    let alert = UIAlertController(title: "Pin Sent!", message: "You'll receive an sms soon...", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                    self.verifyId = result["verify_id"] as! String
                    
                    self.infoLabel.text = "STEP 2\nEnter pin received via sms"
                    
                    
                    self.pinTextField.isUserInteractionEnabled = true
                    self.pinTextField.alpha = 1.0
                    
                    self.phoneTextField.isUserInteractionEnabled = false
                    self.phoneTextField.alpha = 0.4
                    
                    self.countryCodeTextField.isUserInteractionEnabled = false
                    self.countryCodeTextField.alpha = 0.4
                    
                    self.verifyButton.setTitle("Verify", for: .normal)
                    self.verifyButton.removeTarget(self, action: #selector(self.sendPin), for: .touchUpInside)
                    self.verifyButton.addTarget(self, action: #selector(self.verifyPin), for: .touchUpInside)
                    
                }
                else{
                    //Request Error
                    
                    let message:String = String(format: "Error Code: %d\nError Message: %@", (result["errorCode"] as! Int), (result["errorMsg"] as! String))
                    
                    let alert = UIAlertController(title: "Request Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }
                
                self.hideLoadingView()
            }
            
        })
        
    }
    
    func verifyPin(){
        self.view.endEditing(true)
        
        showLoadingView()
        
        SmshostingVerify.verifyWithIdAndCode(verifyId: verifyId, verifyCode: pinTextField.text!, completion: {
            (result: [String:Any]) in
            
            DispatchQueue.main.async {
                
                if(result["errorCode"] == nil){
                    //Request Done
                    
                    var title:String = ""
                    var message:String = ""
                    var isValid:Bool = false
                    
                    if(result["verify_status"] != nil){
                        
                        let statusString:String = result["verify_status"] as! String
                        
                        if(statusString == "VERIFIED"){
                            title = "Done!"
                            message = "Now your phone number is verified."
                            isValid = true
                        }
                        else{
                            title = "Failed"
                            message = "Pin entered is not valid."
                        }
                        
                    }
                    
                    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {
                        (alert: UIAlertAction!) in
                        
                        if(isValid){
                            self.verifyId = nil
                            self.printView()
                        }
                        
                    }))
                    self.present(alert, animated: true, completion: nil)
                    
                }
                else{
                    //Request Error
                    
                    let message:String = String(format: "Error Code: %d\nError Message: %@", (result["errorCode"] as! Int), (result["errorMsg"] as! String))
                    
                    let alert = UIAlertController(title: "Request Error", message: message, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                }
                
                self.hideLoadingView()
                
            }
            
        })
        
    }
    
    //MARK: Other Methods
    func printView(){
        
        //clean view
        for v:UIView in self.view.subviews{
            v.removeFromSuperview()
        }
        
        loadingView = LoadingView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height ))
        
        
        var y:CGFloat = 35
        
        infoLabel = UILabel(frame: CGRect(x: 25, y: y, width: self.view.frame.size.width-50, height: 65 ))
        infoLabel.numberOfLines = 2
        infoLabel.text = "STEP 1\nInsert your Mobile Phone"
        infoLabel.textColor = UIColor(red: 42.0/255, green: 112.0/255, blue: 240.0/255, alpha: 1.0)
        infoLabel.textAlignment = .center
        infoLabel.font = UIFont.systemFont(ofSize: 23)
        infoLabel.backgroundColor = UIColor.clear
        self.view.addSubview(infoLabel)
        y = y+infoLabel.frame.size.height
        y = y+35
        
        countryPicker = UIPickerView()
        countryPicker.delegate = self
        countryPicker.dataSource = self
        countryPicker.backgroundColor = UIColor.lightGray
        
        countryCodeTextField = UITextField(frame: CGRect(x: 25, y: y, width: 50, height: 38 ))
        countryCodeTextField.text = "39"
        countryCodeTextField.layer.borderWidth = 1
        countryCodeTextField.layer.borderColor = UIColor.lightGray.cgColor
        countryCodeTextField.layer.cornerRadius = 5
        countryCodeTextField.textAlignment = .center
        countryCodeTextField.backgroundColor = UIColor.white
        countryCodeTextField.inputView = countryPicker
        countryCodeTextField.autocorrectionType = .no
        countryCodeTextField.delegate = self
        self.view.addSubview(countryCodeTextField)
        
        phoneTextField = UITextField(frame: CGRect(x: 80, y: y, width: self.view.frame.size.width-105, height: 38 ))
        phoneTextField.placeholder = "Phone Number"
        phoneTextField.keyboardType = .phonePad
        phoneTextField.layer.borderWidth = 1
        phoneTextField.layer.borderColor = UIColor.lightGray.cgColor
        phoneTextField.layer.cornerRadius = 5
        phoneTextField.textAlignment = .center
        phoneTextField.backgroundColor = UIColor.white
        phoneTextField.autocorrectionType = .no
        phoneTextField.delegate = self
        self.view.addSubview(phoneTextField)
        y += phoneTextField.frame.size.height
        y += 7
        
        pinTextField = UITextField(frame: CGRect(x: 25, y: y, width: self.view.frame.size.width-50, height: 38 ))
        pinTextField.placeholder = "PIN"
        pinTextField.keyboardType = .numberPad
        pinTextField.layer.borderWidth = 1
        pinTextField.layer.borderColor = UIColor.lightGray.cgColor
        pinTextField.layer.cornerRadius = 5
        pinTextField.textAlignment = .center
        pinTextField.backgroundColor = UIColor.white
        pinTextField.isUserInteractionEnabled = false
        pinTextField.delegate = self
        pinTextField.autocorrectionType = .no
        pinTextField.alpha = 0.4
        self.view.addSubview(pinTextField)
        y += pinTextField.frame.size.height
        y += 7
        
        verifyButton = UIButton(frame: CGRect(x: 25, y: y, width: self.view.frame.size.width-50, height: 38 ))
        verifyButton.setTitleColor(UIColor.white, for: .normal)
        verifyButton.setTitle("Send Pin", for: .normal)
        verifyButton.backgroundColor = UIColor(red: 42.0/255, green: 112.0/255, blue: 240.0/255, alpha: 1.0)
        verifyButton.layer.cornerRadius = 5
        verifyButton.addTarget(self, action: #selector(sendPin), for: .touchUpInside)
        self.view.addSubview(verifyButton)
        
        
    }
    
    func getCountryCodes(){
        
        SmshostingVerify.getCountryCodes(completion: {
            (result: [[String:Any]]) in
            
            self.countryCodesList = result
            self.countryPicker.reloadAllComponents()
            
            var i:Int = 0
            for country:[String:Any] in self.countryCodesList {
                
                let code:Int = country["prefix"] as! Int
                if(code == 39){
                    self.countryPicker.selectRow(i, inComponent: 0, animated: false)
                }
                
                i += 1;
            }
            
        })
        
    }
    
    func showLoadingView(){
        self.view.addSubview(loadingView)
    }
    
    func hideLoadingView(){
        loadingView.removeFromSuperview()
    }
    

}

