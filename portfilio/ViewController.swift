//
//  ViewController.swift
//  portfilio
//
//  Created by Mac Mini on 14/1/2024.
//

import UIKit
import CoreData
class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    var projects = [String]()
    var techno = [String]()

    
    @IBOutlet weak var tab: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tab.reloadData()
        fetchProject()
        tab.reloadData()

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "mCell")
        let cv=cell?.contentView
        
        let imagepr=cv?.viewWithTag(1) as! UIImageView
        let namepr=cv?.viewWithTag(2) as! UILabel
        let tech=cv?.viewWithTag(3) as! UILabel

        
        imagepr.image=UIImage(named: techno[indexPath.row])
        namepr.text=projects[indexPath.row]
        tech.text=techno[indexPath.row]

        
        return cell!
    }
    
    
    
    
 
    func fetchProject()  {
        
        let appDelegate=UIApplication.shared.delegate as! AppDelegate
        let persistentContainer=appDelegate.persistentContainer
        let managedContext=persistentContainer.viewContext
        
        let request=NSFetchRequest<NSManagedObject>(entityName: "Project")
        
        do{
           let result = try managedContext.fetch(request)
            for item in result{
            
              
                projects.append(item.value(forKey: "name") as! String)
                techno.append(item.value(forKey: "tech") as! String)

                   print(projects)
                print(techno)

               
            }

        }catch{
            print("topproject fetching error")
        }
    }
    
 
    // this method handles row deletion
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        let selectedProduct=projects[indexPath.row]
        if editingStyle == .delete {

          
               

            let confirmationAlert = UIAlertController(title: "PROJECT DELETED", message: "Voulez vous suprimer cet projet?", preferredStyle: .alert)

            confirmationAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

            confirmationAlert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { [weak self] _ in
                // Delete the suspect from Core Data
                self?.deleteSuspectFromCoreData(at: indexPath.row)

                // Remove the suspect from the arrays
                self?.projects.remove(at: indexPath.row)
                self?.techno.remove(at: indexPath.row)


                // Delete the table view row
                tableView.deleteRows(at: [indexPath], with: .fade)
          
              
            }))

            present(confirmationAlert, animated: true, completion: nil)
         }
     }
    func deleteSuspectFromCoreData(at index: Int) {
         let appDelegate = UIApplication.shared.delegate as! AppDelegate
         let persistentContainer = appDelegate.persistentContainer
         let managedContext = persistentContainer.viewContext

         let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Project")
         request.predicate = NSPredicate(format: "name == %@", projects[index])

         do {
             let result = try managedContext.fetch(request)
             if let objectToDelete = result.first as? NSManagedObject {
                 managedContext.delete(objectToDelete)

                 // Save the changes
                 try managedContext.save()
             }
         } catch {
             print("Error deleting suspect from Core Data: \(error)")
         }
     }


    
 
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "firstSegue", sender: indexPath)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "firstSegue"{
            let indexPath = sender as! IndexPath
            let destination = segue.destination as! DetailViewController
            destination.nameprojet = projects[indexPath.row]
            destination.technoprojet = techno[indexPath.row]

        }
    }
   

    


    @IBAction func addProject(_ sender: Any) {
        
        performSegue(withIdentifier: "secondSegue", sender: sender)

    }
}

