//
//  FeedViewController.swift
//  SocialNetworking
//
//  Created by Gabriel Catice on 11/7/17.
//  Copyright © 2017 Gabriel Catice. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func signOutPressed(_ sender: Any) {
        if (self.presentingViewController != nil) {
            self.dismiss(animated: true, completion: nil)
        }
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        try! Auth.auth().signOut()
        //performSegue(withIdentifier: "goToSignIn", sender: nil)
    }
    
}
