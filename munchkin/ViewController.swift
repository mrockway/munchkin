//
//  ViewController.swift
//  munchkin
//
//  Created by Michael Rockway on 1/27/16.
//  Copyright © 2016 rockway. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    func setDate() {
        let defaults = NSUserDefaults.standardUserDefaults()
        if let dueDate = defaults.stringForKey("DueDate") {
            print("date from str \(dueDate)")
        }
    }
    @IBAction func buttonPressed()  {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}

