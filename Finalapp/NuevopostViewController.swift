//
//  NuevopostViewController.swift
//  Finalapp
//
//  Created by Ulises on 2022-06-03.
//

import UIKit

class NuevopostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var nombre: UITextField!
    @IBOutlet weak var descr: UITextField!
    @IBOutlet weak var camara: UIImageView!
    
    var nombrerec: String!
    var desc: String!
    
    var imagePicker: UIImagePickerController!
        
        
    var isEditVC: Bool = false
    var postnew: Post?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nombre.text = nombrerec
        descr.text = desc
        
        if isEditVC {
            title = "Update Contact"
            if let post = postnew {
                
                camara.image = UIImage(data: post.ima!)
                nombre.text = post.nombre
                descr.text = post.desc
                
               
                }
            }
         else {
            title = "Add New Contact"
        }

        imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(browseImage))
        camara.addGestureRecognizer(tapGesture)
        camara.isUserInteractionEnabled = true
        
    }
    
    @objc func browseImage() {
        present(imagePicker, animated: true, completion: nil)
    }
    


    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            camara.image = image
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
    

        // Do any additional setup after loading the view.
    
    
    @IBAction func subir(_ sender: Any) {

        if isEditVC {
            postnew?.nombre = nombre.text
            postnew?.desc = descr.text!
            postnew?.ima = UIImage.pngData(camara.image!)()
            
          
            
            try? postnew?.managedObjectContext?.save()
//            try? context.save()
            
        } else {
            let postnewnew = Post(context: context)
            postnewnew.nombre = nombre.text
            postnewnew.desc = descr.text!
            postnewnew.ima = UIImage.pngData(camara.image!)()
            
        
            
            try? postnewnew.managedObjectContext?.save()
            
            print("guardado")
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    
  
    
    @IBAction func cancelar(_ sender: Any) {
        
        
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
