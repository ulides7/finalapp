//
//  PostViewController.swift
//  Finalapp
//
//  Created by Ulises on 2022-06-02.
//

import UIKit
import CoreData


class PostViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
   var postarr = [Post]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    
    var  postseleccionadon: String!
    var  postseleccionadod: String!
    
    var emailrrecivido: String!
    
    let contexto = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewWillAppear(_ animated: Bool) {
        read()
    }
    
    func read() {
        postarr = try! contexto.fetch(Post.fetchRequest())
        tablapost.reloadData()

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postarr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let celda = tablapost.dequeueReusableCell(withIdentifier: "celda", for: indexPath) as! PostTableViewCell
        celda.nombre?.text = postarr[indexPath.row].nombre
        celda.descripcion?.text = postarr[indexPath.row].desc
        celda.imagenpost?.image = UIImage(data: postarr[indexPath.row].ima!)
        
        

//        celda.fechapub = postarr[indexPath.row].fecha
//        celda.imagen.image = postarr[indexPath.row].ima
//        celda.descripcion.text = postarr[indexPath.row].desc

        
        return celda
    }
    
  
    
    @IBAction func subir(_ sender: Any) {
        performSegue(withIdentifier: "editar" , sender: nil)
        
    }
    
    
    @IBAction func reload(_ sender: Any) {
        
        self.tablapost.reloadData()
        print()
    }
    
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        
    }
    
    
    
    func getdecripcion(texfield: UITextField! ){
        descripcion = texfield
        descripcion?.placeholder = "Escribe..."
        
    }
    
    func guardar(){
        
        do {
            try contexto.save()
            print("La base de datos de virus ha sido actualizada")
            
        } catch let error as NSError {
            print("Hijoles mano no se pudo: \(error.localizedDescription)")
        }
        
        recargar()
    }
    
    func recargar() {
        
        let fetchRequest : NSFetchRequest <Post> = Post.fetchRequest()
        
        do {
            postarr = try contexto.fetch(fetchRequest)
            
        } catch let error as NSError {
            print("Error al cargar: \(error.localizedDescription)")
        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       
        if editingStyle == .delete {
            contexto.delete(postarr[indexPath.row])
            postarr.remove(at: indexPath.row)
            guardar()
        }
        tablapost.reloadData()

    }
    
    
    
    
    @IBOutlet weak var tablapost: UITableView!
    
    @IBOutlet weak var descripcion: UITextField!
    
    @IBOutlet weak var imagen: UIButton!
    
    
    
    override func viewDidLoad() {
        read()
        
        tablapost.register(UINib(nibName: "PostTableViewCell", bundle: nil), forCellReuseIdentifier: "celda")
        
        super.viewDidLoad()
        
        tablapost.delegate = self
        tablapost.delegate = self
      
        // Do any additional setup after loading the view.
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
