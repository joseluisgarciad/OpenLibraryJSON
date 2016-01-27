//
//  ViewController.swift
//  OpenlibraryJSON
//
//  Created by Jose Luis Garcia Dueñas on 26/1/16.
//  Copyright © 2016 Jose Luis Garcia Dueñas. All rights reserved.
//

import UIKit
extension UIImageView {
    public func imageFromUrl(urlString: String) {
        NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: urlString)!) { (data, response, error) in
            dispatch_async(dispatch_get_main_queue()) {
                self.contentMode = UIViewContentMode.ScaleAspectFill
                self.image = UIImage(data: data!)
            }
            }.resume()
    }
}
class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var TextoISBN: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        TextoISBN.delegate = self
        TextoISBN.returnKeyType = UIReturnKeyType.Search
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func textFieldDoneEditing(sender:UITextField)
    {
        sender.resignFirstResponder() // desaparece el teclado
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if TextoISBN.text == "" {
        } else {
            let sigVista=segue.destinationViewController as!VistaJSON
            sigVista.CodigoISBN = TextoISBN.text!
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

