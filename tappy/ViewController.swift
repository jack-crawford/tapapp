//
//  ViewController.swift
//  tappy
//
//  Created by Jack Crawford on 9/25/16.
//  Copyright © 2016 jtc. All rights reserved.
//

import UIKit
import Contacts
extension UIView {
    func fadeIn() {
        // Move our fade out code from earlier
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0 // Instead of a specific instance of, say, birdTypeLabel, we simply set [thisInstance] (ie, self)'s alpha
            }, completion: nil)
    }
    
    func fadeOut() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.alpha = 0.0
            }, completion: nil)
    }
}



class ViewController: UIViewController {
    @IBOutlet weak var web_viiew: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = URL(string: "http://ec2-54-201-48-199.us-west-2.compute.amazonaws.com/tappy/home.php")
        let request = URLRequest(url: url!)
        web_viiew.loadRequest(request)
        
        if let cookies = HTTPCookieStorage.shared.cookies {
            for cookie in cookies {
                print("\(cookie)")
                if cookie.name == "tap_email" {
                    print(cookie.value)
                    
                    let fileName = "cookie"
                    let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                    
                    let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
                    print("FilePath: \(fileURL.path)")
                    
                    let writeString = cookie.value
                    do {
                        // Write to the file
                        try writeString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
                        print("wrote write string")
                    } catch let error as NSError {
                        print("Failed writing to URL: \(fileURL), Error: " + error.localizedDescription)
                    }
                    
                    

                }
            }
        }
        
        
    }
    
    @IBAction func add_friend(_ sender: UIButton) {
        print("how bout this")
        let alertController = UIAlertController(title: "Add a pal", message: "Get your friend's code and put it in to start tapping with them", preferredStyle: .alert)
        print("button was pushed here")

        func add(code: String) {
            //get contents of a url with user's id and new person's code
            //if invalid, another alert with an error, go back to original
            //if valid, give a confirm w the person's name and then refresh webview to add them
            //yipeee
            print(code)
        }
        let loginAction = UIAlertAction(title: "Add", style: .default) { (_) in
            let palCodeField = alertController.textFields![0] as UITextField

            add(code: palCodeField.text!)
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Pal Code"
            
        }
        let cancelAction = UIAlertAction(title: "Nevermind", style: .cancel) { (_) in }
        
        alertController.addAction(loginAction)
        alertController.addAction(cancelAction)
        print("button was pushed there")
        present(alertController, animated: true, completion: nil)

        web_viiew.reload()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

