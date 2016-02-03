//
//  ViewController.swift
//  munchkin
//
//  Created by Michael Rockway on 1/27/16.
//  Copyright © 2016 rockway. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var continueBackgroundContainer: UIImageView!
    @IBOutlet weak var descriptionBackgroundContainer: UIImageView!
    @IBAction func buttonPressed()  {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        continueBackgroundContainer.layer.cornerRadius = 10
        continueButton.layer.cornerRadius = 5
        descriptionBackgroundContainer.layer.cornerRadius = 10
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

