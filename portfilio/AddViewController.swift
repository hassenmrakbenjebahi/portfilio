//
//  AddViewController.swift
//  portfilio
//
//  Created by Mac Mini on 14/1/2024.
//

import UIKit
import CoreData
class AddViewController: UIViewController {
    
    
    var nameP = "project"
    var tech = "iOS"
    
    @IBOutlet weak var imgproject: UIImageView!
    
    
    @IBOutlet weak var textnameproject: UITextField!
    
    @IBOutlet weak var textdescproject: UITextField!
    
    
    @IBOutlet weak var textlienproject: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func isAdded() -> Bool {
        
        var mBoolean=false
        guard let n = textnameproject?.text else{
            return mBoolean
        }
        
        nameP = n
        let appDelegate=UIApplication.shared.delegate as! AppDelegate
        let persistentContainer=appDelegate.persistentContainer
        let managedContext=persistentContainer.viewContext
        
        let request=NSFetchRequest<NSManagedObject>(entityName: "Project")
        let predicate=NSPredicate(format: "name = %@", nameP)
        request.predicate=predicate
        
        do{
           let result = try managedContext.fetch(request)
            if result.count>0{
                mBoolean=true
            }

        }catch{
            print("Animal fetching error")
        }
        
        return mBoolean
    }
    
    
    
    func addProject() {
        
        guard let n = textnameproject?.text else{
            return
        }
        
        nameP = n

        let appDelegate=UIApplication.shared.delegate as! AppDelegate
        let persistentContainer=appDelegate.persistentContainer
        let managedContext=persistentContainer.viewContext
        
        let entityDescription=NSEntityDescription.entity(forEntityName: "Project", in: managedContext)
        let object=NSManagedObject(entity: entityDescription!, insertInto: managedContext)
        object.setValue(nameP, forKey: "name")
        object.setValue(tech, forKey: "tech")

       
        
        do{
            try managedContext.save()
            self.showAlert(title: "INSERT SUCCESSFULLY", message: "PROJECT ADDED")
        }catch{
            print("Product adding error")
        }
    }
    
    
    
    func showAlert(title:String,message:String) {
        let alert=UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
   
    
    
    
    
    
    
    
    

    @IBAction func iosbtn(_ sender: Any) {
        tech = "iOS"
        imgproject.image = UIImage(named: "iOS")

    }
    
    @IBAction func fluttterbtn(_ sender: Any) {
        tech = "Flutter"

        imgproject.image = UIImage(named: "Flutter")

    }
    
    
    @IBAction func androidbtn(_ sender: Any) {
        tech = "Android"

        imgproject.image = UIImage(named: "Android")

    }
    
    
    @IBAction func nodebtn(_ sender: Any) {
        tech = "NodeJS"

        imgproject.image = UIImage(named: "NodeJS")

    }
    
    
    @IBAction func savebtn(_ sender: Any) {
        
        if !isAdded(){
            addProject()
            
        }else{
            
            self.showAlert(title: "WARNNG", message: "PROJECT EXISTED")
            
        }
    }
    
    
}
