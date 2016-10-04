//
//  You_View.swift
//  tappy
//
//  Created by Jack Crawford on 9/25/16.
//  Copyright © 2016 jtc. All rights reserved.
//

import UIKit

class You_View: UIViewController {
    @IBOutlet weak var fname: UILabel!
    @IBOutlet weak var tap_number: UILabel!
    @IBOutlet weak var pal_number: UILabel!
    @IBOutlet weak var code: UILabel!
    func loadweb2() {
        let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
        let fileURL = DocumentDirURL.appendingPathComponent("cookie").appendingPathExtension("txt")
        
        
        do {
            let cookie_contents = try String(contentsOf: fileURL)
            print(cookie_contents)
            let url = URL(string: "http://ec2-54-201-48-199.us-west-2.compute.amazonaws.com/tappy/profile.php?user=" + cookie_contents)
            print(url)
        print("loadweb2 started")
        
        print("This was hit 28")
        let session = URLSession.shared
        print("This was hit line 30")
        let task1 = session.dataTask(with: url!, completionHandler: {
            (data, response, error) -> Void in
            do {
                if data == nil {
                    print("data is nil")
                    return
                } else {
                    
                    let jsonObject = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
                    if let dict = jsonObject as? NSDictionary {
                        print(dict)
                        let fname_content = dict["fname"] as! String
                        let code_content = dict["code"] as! String
                        let taps_content = dict["taps"] as! String
                        let connections_content = dict["connections"] as! String
                        print(fname_content)
                        self.fname.text = fname_content
                        self.tap_number.text = taps_content
                        self.pal_number.text = connections_content
                        self.code.text = code_content
                    } else {
                        self.fname.text = ""
                        self.tap_number.text = ""
                        self.pal_number.text = ""
                        self.code.text = ""
                    }
                }
                
            } catch let error as NSError {
                print("Failed to load: \(error.localizedDescription)")
                self.fname.text = ""
                self.tap_number.text = ""
                self.pal_number.text = ""
                self.code.text = ""
                
            }
            
        })
        print("This was hit")
        task1.resume()
        } catch {
            self.fname.text = ""
            self.tap_number.text = ""
            self.pal_number.text = ""
            self.code.text = ""
        }
    }

    @IBAction func logout(_ sender: AnyObject) {
        URLCache.shared.removeAllCachedResponses()
        URLCache.shared.diskCapacity = 0
        URLCache.shared.memoryCapacity = 0

        let vc = UIViewController(nibName: "main", bundle: nil)
        self.navigationController?.pushViewController(vc, animated:true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadweb2()
    }
    
    func viewWillAppear() {
        loadweb2()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
