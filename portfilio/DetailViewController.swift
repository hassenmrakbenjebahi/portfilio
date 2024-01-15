//
//  DetailViewController.swift
//  portfilio
//
//  Created by Mac Mini on 14/1/2024.
//

import UIKit

class DetailViewController: UIViewController {

    var nameprojet:String?
    var technoprojet:String?


    
    @IBOutlet weak var img1: UIImageView!
    
    @IBOutlet weak var label1: UILabel!
    
    
    @IBOutlet weak var des: UITextView!
    
    
    @IBOutlet weak var lien: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        img1.image = UIImage(named: technoprojet!)
        label1.text = nameprojet!

        // Do any additional setup after loading the view.
    }
    

   

}
