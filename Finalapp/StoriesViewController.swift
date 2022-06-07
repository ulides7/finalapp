//
//  StoriesViewController.swift
//  Finalapp
//
//  Created by Ulises on 2022-06-03.
//

import UIKit

class StoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, Managerprotocol {
 
    
    var datitos: Datos?
    var Managerc = Manager()
    
    var arreglodat: [Datos] = []
    
    func Error(Error: String) {
        print(Error)
    }
    
    
    
func cargarDatos(datitos: [Datos]) {
        arreglodat = datitos
        
        DispatchQueue.main.async {
            self.tablastorie.reloadData()
            
        }
    }
    
  
    
   
    
   
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arreglodat.count
    }

   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = tablastorie.dequeueReusableCell(withIdentifier: "celda", for:indexPath) as! StoriesTableViewCell
        
        celda.nombre.text = arreglodat[indexPath.row].owner?.firstName
//        celda.fecha.text   = String(arreglodat[indexPath.row].publishDate)
        celda.descrip.text = arreglodat[indexPath.row].text
        
       
        if let value = arreglodat[indexPath.row].likes {
             celda.likes.text = String(value)
        } else {
             celda.likes.text = "NANAIS"
        }
       
        print("este si \(arreglodat[indexPath.row].text)")
        
        
      
        if let urlString = arreglodat[indexPath.row].owner?.picture{
            if let imagenURL = URL(string: urlString){

                DispatchQueue.global().async {

                    guard let imagen = try? Data(contentsOf: imagenURL) else {return}
                    let image = UIImage(data:imagen)
                    DispatchQueue.main.async {
                        celda.perfil.image = image
                    }
                }
            }

        }
        
        if let urlString = arreglodat[indexPath.row].image{
            if let imagenURL = URL(string: urlString){

                DispatchQueue.global().async {

                    guard let imagen = try? Data(contentsOf: imagenURL) else {return}
                    let image = UIImage(data:imagen)
                    DispatchQueue.main.async {
                        celda.imapost.image = image
                    }
                }
            }

        }
        
        return celda
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }

    @IBOutlet weak var tablastorie: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        tablastorie.register(UINib(nibName: "StoriesTableViewCell", bundle: nil), forCellReuseIdentifier: "celda")
      
        
        tablastorie.delegate = self
        tablastorie.dataSource = self
        
        Managerc.delegado = self
        Managerc.buscar()
        
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
