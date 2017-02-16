//
//  ViewController.swift
//  Start with Touch ID
//
//  Created by Robert Cuyegkeng on 2017-02-16.
//  Copyright © 2017 Robert Cuyegkeng. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    @IBOutlet weak var secureContent: UIImageView!
    
    @IBAction func btnAuthentication(_ sender: Any) {
        let localAuthority = LAContext()
        var error: NSError?
        if localAuthority.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // Can check fingerprint, now to see if it's correct
            localAuthority.evaluatePolicy(LAPolicy(rawValue: Int(kLAPolicyDeviceOwnerAuthenticationWithBiometrics))!,
                                          localizedReason: "Touch to Authenticate You",
                                          reply: { [unowned self] (success, error) -> Void in
                                            if (success) {
                                                OperationQueue.main.addOperation({ () -> Void in
                                                    self.initApp()
                                                })
                                            } else {
                                                // Not valid
                                                let alert: UIAlertController = UIAlertController(title: "Touch ID Error", message: "Not a valid fingerprint", preferredStyle: UIAlertControllerStyle.alert)
                                                alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
                                                    self.present(alert,animated: true, completion: nil)
                                            }
            })
        } else {
            let alert: UIAlertController = UIAlertController(title: "Touch ID Error", message: "Can't Access Touch ID", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert,animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initApp() {
        secureContent.isHidden = false;
    }

}
