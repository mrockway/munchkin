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

    // segue to continue to due date setup
    @IBAction func buttonPressed()  {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyleAttribues()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // Styling for the background containers
    func setStyleAttribues() {
        
        // set shadow attributes
        let rgb: CGColorSpaceRef = CGColorSpaceCreateDeviceRGB()!
        let black: [CGFloat]   = [0, 0, 0, 1]
        
        // set border color
        let borderColor = UIColor(red:154/255.0, green:154/255.0, blue:147/255.0, alpha: 1.0).CGColor
        
        // continue container styling
        continueButton.layer.cornerRadius = 5
        continueBackgroundContainer.layer.borderWidth = 5
        continueBackgroundContainer.layer.borderColor = borderColor
        continueBackgroundContainer.layer.cornerRadius = 10
        continueBackgroundContainer.layer.shadowRadius = 5
        continueBackgroundContainer.layer.shadowColor = CGColorCreate(rgb, black)
        continueBackgroundContainer.layer.shadowOpacity = 1
        continueBackgroundContainer.layer.shadowOffset = CGSizeMake(-2,2)
        
        // lower portion of the welcome view
        descriptionBackgroundContainer.layer.borderWidth = 5
        descriptionBackgroundContainer.layer.borderColor = borderColor
        descriptionBackgroundContainer.layer.cornerRadius = 10
        descriptionBackgroundContainer.layer.shadowRadius = 5
        descriptionBackgroundContainer.layer.shadowColor = CGColorCreate(rgb, black)
        descriptionBackgroundContainer.layer.shadowOpacity = 1
        descriptionBackgroundContainer.layer.shadowOffset = CGSizeMake(-2,2)
        
        // continue button styling
        continueButton.layer.borderWidth = 5
        continueButton.layer.borderColor = borderColor
        continueButton.layer.cornerRadius = 10
        continueButton.layer.shadowRadius = 5
        continueButton.layer.shadowColor = CGColorCreate(rgb, black)
        continueButton.layer.shadowOpacity = 1
        continueButton.layer.shadowOffset = CGSizeMake(-2,2)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // setup app to handle motion events
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    // On shake event the phone displays a helpful message
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            let ac = UIAlertController(title: "Careful", message: "Dont't shake the baby!", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "You have been warned", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
            return
        }
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

