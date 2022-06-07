//
//  AuthViewController.swift
//  Finalapp
//
//  Created by Ulises on 2022-06-06.
//

import UIKit
import FirebaseAuth

class AuthViewController: UIViewController {
    @IBOutlet weak var ima: UIImageView!
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func registrar(_ sender: Any) {
        if let email = email.text, let password = password.text {
            
            Auth.auth().createUser(withEmail: email, password: password) { (result,error) in
                
                if let result = result, error == nil {
                    
                    let alertController = UIAlertController(title: "Exito", message: "Usuario Creado", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "aceptar", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                    
                
                    
                } else {
                    let alertController = UIAlertController(title: "Error", message: "Se ha producido un error", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "aceptar", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                    
                }
            }
            
        }
        
        
    }
    
    @IBAction func entrar(_ sender: Any) {
        
        if let email = email.text, let password = password.text {
            
            Auth.auth().signIn(withEmail: email, password: password) { (result,error) in
                
                if let result = result, error == nil {
                    

                    self.performSegue(withIdentifier: "inicio", sender: nil)
                } else {
                    let alertController = UIAlertController(title: "Error", message: "Se ha producido un error al iniciar sesion", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "aceptar", style: .default))
                    self.present(alertController, animated: true, completion: nil)
                    
                }
            }
            
        }
        
        
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
