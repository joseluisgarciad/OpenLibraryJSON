//
//  VistaJSON.swift
//  OpenlibraryJSON
//
//  Created by Jose Luis Garcia Dueñas on 26/1/16.
//  Copyright © 2016 Jose Luis Garcia Dueñas. All rights reserved.
//

import UIKit

class VistaJSON: UIViewController {
    var volver:Bool = false
    var CodigoISBN: String = ""
    var DireccionPortadas: String = "https://covers.openlibrary.org/b/id/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if recuperarJSON() == false {
           print("falso")
           navigationController?.popToRootViewControllerAnimated(true)
           mensaje("No existe el ISBN indicado") 
        } else {
            print("verdadero")
        }
        //if volver == true {
        //   navigationController?.popViewControllerAnimated(true)
        //}
        
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var Titulo: UILabel!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var Autores: UILabel!
    @IBOutlet weak var ImagenPortada: UIImageView!
    
    override func viewWillAppear(animated: Bool) {
        //if recuperarJSON() == false {
         //   print("paso")
         // navigationController?.popToRootViewControllerAnimated(true)
         // navigationController?.popViewControllerAnimated(true)
        //}
    }

    func recuperarJSON() -> Bool {
        var listaAutores = [String]()
        let urls = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:"
        let url = NSURL(string: urls + CodigoISBN)
        let datos = NSData(contentsOfURL: url!)
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
            
            let dico1 = json as! NSDictionary
            if let _ = dico1["ISBN:" + CodigoISBN] as? NSDictionary { //existe isbn??
             let dico2 = dico1["ISBN:" + CodigoISBN] as! NSDictionary
             print(dico2)
             if let aut = dico2["authors"] as? [[String: AnyObject]] {
                 for a in aut {
                     if let name = a["name"] as? String {
                         listaAutores.append(name)
                     }
                 }
             }
            
             Autores.text = ""
             for b in listaAutores {
                 Autores.text = Autores.text! + " " + b + "\n"
             }
             self.Titulo.text = dico2["title"] as! NSString as String
            
             if let _ = dico2["cover"] as? NSDictionary {
                // dispatch_async(dispatch_get_main_queue(), {
                 let cover = dico2["cover"]
                     if cover != nil && cover is NSDictionary {
                        let covers = dico2["cover"] as!NSDictionary
                     ImagenPortada.imageFromUrl(covers["medium"] as! NSString as String)
                     }
                // },,
             }
            } else {
                //mensaje("No existe el ISBN indicado")
                volver = true
                return false
            }
            
          return true
        }
        catch _ {
            //mensaje("Error al Recuperar ISBN")
            volver = true
            return false
        }
    }
    
    func mensaje (Texto: String) {
        let alertController = UIAlertController(title: "OpenLibrary JSON", message:
            Texto, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
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
