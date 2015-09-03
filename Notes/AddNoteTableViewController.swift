//
//  AddNoteTableViewController.swift
//  Notes
//
//  Created by Moon-Seok Kang on 6/18/15.
//  Copyright (c) 2015 Moon Kang. All rights reserved.
//

import UIKit
import Parse
import ParseUI
import Bolts

class AddNoteTableViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    // This constraint ties an element at zero points from the bottom layout guide
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var textView: UITextView!

    @IBOutlet var animatedView: UIView!
    
    var object: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.delegate = self;

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if (self.object != nil) {
                        
            self.titleField?.text = self.object["title"] as? String
            self.textView?.text = self.object["text"] as? String
            
            
        } else {
            
            self.object = PFObject(className: "Note")
        }
        
//        
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameDidChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
//
       NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardShow:", name: UIKeyboardWillShowNotification, object: nil)
       NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardHide:", name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    func keyboardShow(notification: NSNotification)
    {
        var info = notification.userInfo!
        var keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        if(self.textView.contentSize.height >= (self.textView.frame.height - keyboardFrame.height)){
            
            UIView.animateWithDuration(0.2, delay: 0.0, options: nil, animations: { () -> Void in
                self.textView.contentInset.bottom = keyboardFrame.height
                self.textView.scrollIndicatorInsets.bottom = keyboardFrame.height
            }, completion: nil)
        }
        
    }
    
    func keyboardHide(notification: NSNotification) {
        self.textView.contentInset = UIEdgeInsetsZero
        self.textView.scrollIndicatorInsets = UIEdgeInsetsZero
    }
    
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        //self.textView.setContentOffset(CGPointMake(0,250), animated: true)
        
        //self.activeField = textField

    }
    
    func textViewDidBeginEditing(textView: UITextView) {
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
    }
    
    func textViewDidEndEditing(textView: UITextView) {
    }
    
    

    override func didReceiveMemoryWarning() {
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func saveAction(sender: UIBarButtonItem) {
        
        self.object["username"] = PFUser.currentUser()?.username
        self.object["title"] = self.titleField?.text
        self.object["text"] = self.textView?.text
        
        if(self.titleField?.text == ""){
            let actionSheetController: UIAlertController = UIAlertController(title: "Error", message: "Title cannot be empty", preferredStyle: .Alert)
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
                //We need to provide a popover sourceView when using it on iPad
                
                //Present the AlertController
               
            }
            actionSheetController.addAction(cancelAction)
             self.presentViewController(actionSheetController, animated: true, completion: nil)
        } else {
            self.object.saveEventually { (success, error) -> Void in
                
                if(error == nil) {
                    
                } else {
                    println(error?.userInfo)
                    
                }
                
            }
            
            self.textView.resignFirstResponder()
            self.titleField.resignFirstResponder()
        }
        
        
        //self.navigationController?.popToRootViewControllerAnimated(true)
    }
    

    


    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
