//
//  ViewController.swift
//  Login App
//
//  Created by
//  Pravesh Giri (200423765)
//  Arjun Neupane ()
//  on 2019-06-13.
//  Copyright © 2019. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    var username: String? = nil
    var password: String? = nil
    var securityQuestion: String? = nil
    
    //defining initial id and password
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    @IBAction func btnLogin(_ sender: Any) {
        //username should be taken only after the button is pressed
        username = tfUsername.text!
        password = tfPassword.text!
        securityQuestion = tfSecurityQuestion.text!
        
        //if no tf is left empty, we start to check for login
        if(!checkForNull(username!, password!, securityQuestion!)){
            //for loop used to iterate over the data of the models struct
            for model in models{
                //if everything is matched, show wc message
                if model.name == username && model.password == password
                    && model.sQuestion == securityQuestion{
                    tfMessage.text = "Welcome back, \(username!) :)"
                    //calling IBAction func to clear out tfs
                    btnClearFileds(sender)
                }else{
                    //login error
                    tfMessage.text = "Credentials do not match."
                }
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
        
        if !checkForNull(username!, password!, securityQuestion!){
            //checkfornull is false so we can proceed to sign up
            //check if user already exists
            for model in models{
                if model.name == tfUsername.text!{
                    tfMessage.text = "User already exists. Login to continue."
                }else{
                    //it adds the new data values to models object struct
                    models.append(Model(name: tfUsername.text!, password: tfPassword.text!, sQuestion: tfSecurityQuestion.text!))
                    
                    tfMessage.text = "User registered successfully. Login to continue..."
                    btnClearFileds(sender)
                }
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
        if !username!.isEmpty && !securityQuestion!.isEmpty{
            
            for model in models{
                //if username and sec question are correct, then password is set automatically, user just need to login
                if model.name == username
                    && model.sQuestion == securityQuestion{
                    tfPassword.text = model.password
                    tfMessage.text = "Password has been set. Login to continue."
                }else{
                    //username and security question do not match at all
                    tfMessage.text = "Credentials do not match. Check again."
                }
            }
        }else{
            //either username or sec ques is left empty
            tfMessage.text = "Entry Fields are empty."
        }
    }
    
    //checking if the supplied name, password and security is left empty, return false if not empty
    func checkForNull(_ name: String, _ password: String,
                      _ sQuestion: String) -> Bool {
        if !name.isEmpty && !password.isEmpty && !sQuestion.isEmpty{
            return false
        }else{
            return true
        }
        
    }
}

//using struct data structure to store custom data
struct Model{
    var name: String?
    var password: String?
    var sQuestion: String?
}
