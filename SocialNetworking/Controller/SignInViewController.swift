//
//  SignInViewController.swift
//  SocialNetworking
//
//  Created by Gabriel Catice on 11/4/17.
//  Copyright © 2017 Gabriel Catice. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase

class SignInViewController: UIViewController {
    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var passwordField: FancyField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func facebookButtonPressed(_ sender: Any) {
        let facebookLogin = FBSDKLoginManager()
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            if error != nil {
                print("Gabriel: Unable to authenticate with Facebook - \(String(describing: error))")
            } else if result?.isCancelled == true {
                print("Gabriel: user cancelled authentication with Facebook")
            } else {
                print("Gabriel: successfully authenticated with Facebook")
                let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuthenticate(credential)
            }
        }
    }
    
    func firebaseAuthenticate(_ credential: AuthCredential) {
        Auth.auth().signIn(with: credential, completion: {(user, error) in
            if error != nil {
                print("Gabriel: unable to authenticate with firebase - \(String(describing: error))")
            } else {
                print("Gabriel: Successfully authenticated with Firebase")
            }
        })
    }
    
    @IBAction func signInPressed(_ sender: Any) {
        if let email = emailField.text, let pwd = passwordField.text {
            Auth.auth().signIn(withEmail: email, password: pwd, completion: {(user, error) in
                if error == nil {
                    print("Gabriel: Email user authenticated with Firebase")
                } else {
                    Auth.auth().createUser(withEmail: email, password: pwd, completion: {(user, error) in
                        if error != nil {
                            print("Gabriel: unable to authenticate with Firebase using email")
                        } else {
                            print("Gabriel: Successfully authenticated with Firebase")
                        }
                    })
                }
            })
        }
    }
}
