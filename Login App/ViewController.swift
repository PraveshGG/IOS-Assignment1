//
//  ViewController.swift
//  Login App
//
//  Created by
//*********************************************************
//  Pravesh Giri (200423765)
//  Arjun Neupane ()
//*********************************************************
//  on 2019-06-13.
//  Copyright © 2019. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var username: String? = nil
    var password: String? = nil
    var securityQuestion: String? = nil
    
    //defining initial id, password and security question
    //STRUCT IS DEFINED AT AFTER THE END OF THIS CLASS
    var models = [
        Model(name: "georgian", password: "college", sQuestion: "marc")
    ]
    
    //
    @IBOutlet weak var tfUsername: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfSecurityQuestion: UITextField!
    @IBOutlet weak var tfMessage: UILabel!
    @IBOutlet weak var btnClearFields: UIButton!
    @IBOutlet weak var btnClearMessage: UIButton!

    //overriding default func from UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnLogin(_ sender: Any) {
        //username should be taken only after the button is pressed
        username = tfUsername.text!
        password = tfPassword.text!
        securityQuestion = tfSecurityQuestion.text!
        
        //if user and password textFields (tf) are not left empty, we start to check for login
        if(!checkForNull(username!, password!, "", 1))
        {
            //this expression returns a boolean value by checking the struct data to match for username and password, if true=login success, else credentials do not match
            let loginCheck = models.filter{$0.name == username && $0.password==password}.count > 0

            if loginCheck{
                tfMessage.text = "Welcome back, \(username!) :)"
                //calling IBAction func to clear out tfs
                btnClearFileds(sender)
            }else{
                //login error
                tfMessage.text = "Credentials do not match."
            }
        }else{
            // tfs are left empty
            tfMessage.text = "Entry Fields are empty."        }
    }
    
    //clears all the tfs
    @IBAction func btnClearFileds(_ sender: Any) {
        tfUsername.text = ""
        tfPassword.text = ""
        tfSecurityQuestion.text = ""
        
    }
    
    @IBAction func tfSignup(_ sender: Any) {
        username = tfUsername.text!
        password = tfPassword.text!
        securityQuestion = tfSecurityQuestion.text!
        
        if !checkForNull(username!, password!, securityQuestion!, 0){
            //checkfornull is false so we can proceed to sign up
            
            //check if user already exists
            let signupCheck = models.filter{$0.name == username}.count > 0
            
            
            if signupCheck{
                tfMessage.text = "User already exists. Login to continue."
                tfSecurityQuestion.text = ""
            }else{
                //it adds the new data values to models object struct
                models.append(Model(name: tfUsername.text!, password: tfPassword.text!, sQuestion: tfSecurityQuestion.text!))
                
                tfMessage.text = "User registered successfully. Login to continue..."
                btnClearFileds(sender)
            }
            
        }else{
            //checkForNull returns true, so some tfs are empty
            tfMessage.text = "Entry Fields are empty."
        }
    }
    
    // reseting the lbl to Message
    @IBAction func btnClearMessage(_ sender: Any) {
        tfMessage.text = "Message"
    }
    
    @IBAction func forgotPassword(_ sender: Any) {
        username = tfUsername.text!
        securityQuestion = tfSecurityQuestion.text!
        password = tfPassword.text!
        
        
        //check if username and security are not left empty,password can be left empty
        if !checkForNull( username!, "", securityQuestion!, 2)
        {
            //check if username and sec question are correct,
            let forgotPasswordCheck = models.filter{$0.name == username && $0.sQuestion == securityQuestion}.count > 0
            
            if forgotPasswordCheck{
                  //then password is set automatically, user just need to press login button
                for model in models{
                    if(username == model.name){
                        password = model.password
                    }
                }
                tfPassword.text = password
                tfMessage.text = "Password has been set. Login to continue."
                tfSecurityQuestion.text = ""
            }else{
                //username and security question do not match at all
                tfMessage.text = "Credentials do not match. Check again."
            }
        }else{
            //either username or sec ques is left empty
            tfMessage.text = "Entry Fields are empty."
        }
    }
    
    //checking if the supplied name, password and security is left empty, return false if not empty
    func checkForNull(_ name: String, _ password: String,
                      _ sQuestion: String,_ code: Int) -> Bool {
        switch code{
            //used for login
            case 1:
                if !name.isEmpty && !password.isEmpty {
                    return false
                }else{
                    return true
            }
            //this is used for forget password
            case 2:
                if !name.isEmpty  && !sQuestion.isEmpty{
                    return false
                }else{
                    return true
            }
            // default for all fields check i.e for signup
            default:
                if !name.isEmpty && !password.isEmpty && !sQuestion.isEmpty{
                    return false
                }else{
                    return true
            }
        }
    }
}

//using struct data structure to store custom data
struct Model{
    var name: String?
    var password: String?
    var sQuestion: String?
}
