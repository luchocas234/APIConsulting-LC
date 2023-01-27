//
//  ViewController.swift
//  APIConsulting-LC
//
//  Created by u633168 on 27/01/2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var buttonBorrarName: UIButton!
    @IBOutlet weak var buttonGetUser: UIButton!
    @IBOutlet weak var buttonAddNewUser: UIButton!
    @IBOutlet weak var buttonEditar: UIButton!
    @IBOutlet weak var buttonAceptar: UIButton!
    @IBOutlet weak var inputName: UITextField!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emailLabel: UILabel!
    
    var newName = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        nameLabel.text = ""
        nameLabel.numberOfLines = 0
        emailLabel.text = ""
        inputName.text = ""
        idLabel.text = ""
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
        buttonEditar.isHidden = true
    }
    
    
    @IBAction func getUserAction(_ sender: Any) {
        activityIndicator.startAnimating()
        buttonEditar.isHidden = false
        nameLabel.isHidden = false
        emailLabel.isHidden = false
        idLabel.isHidden = false
        NetworkingProvider.shared.getUser(id: 511) { user in
            self.activityIndicator.stopAnimating()
            print(user)
            self.nameLabel.text = user.name
            self.emailLabel.text = user.email
            self.idLabel.text = user.id?.description
            
        } failure: { error in
            self.activityIndicator.stopAnimating()
            self.nameLabel.text = (error.debugDescription)
        }
        
    }
    
    
    @IBAction func addNewUserAction(_ sender: Any) {
        var numberRandom = Int.random(in: 0..<126)
        let newUser = NewUser(name: "Lucho\(numberRandom)", email: "lucho\(numberRandom)@gmail.com", gender: "Male", status: "Active")
        
        activityIndicator.startAnimating()
        
        NetworkingProvider.shared.addUser(user: newUser) { user in
            self.activityIndicator.stopAnimating()
            self.nameLabel.text = user.name
            self.emailLabel.text = user.email
            self.idLabel.text = user.id?.description
        } failure: { error in
            self.activityIndicator.stopAnimating()
            self.nameLabel.text = error.debugDescription
        }
        
    }
    
    @IBAction func editUserAction(_ sender: Any) {
        nameLabel.isHidden = true
        inputName.isHidden = false
        buttonAceptar.isHidden = false
        buttonBorrarName.isHidden = false
        buttonGetUser.isHidden = true
        buttonEditar.isHidden = true
        buttonAddNewUser.isHidden = true
        
    }
    
    
    @IBAction func inputAction(_ sender: UITextField) {
        newName = inputName.text!
    }
    
    
    @IBAction func aceptarAction(_ sender: Any) {
        print(newName)
        
        activityIndicator.startAnimating()
        let newUser = NewUser(name: newName, email: emailLabel.text!, gender: "Male", status: "Active")
        
        NetworkingProvider.shared.updateUser(user: newUser,id: Int(idLabel.text!)!) { user in
            self.activityIndicator.stopAnimating()
            
            self.inputName.text = ""
            self.nameLabel.isHidden = false
            self.inputName.isHidden = true
            self.buttonAceptar.isHidden = true
            self.buttonBorrarName.isHidden = true
            self.buttonGetUser.isHidden = false
            self.buttonEditar.isHidden = false
            self.buttonAddNewUser.isHidden = false
            
            
            self.nameLabel.text = user.name
            self.emailLabel.text = user.email
            self.idLabel.text = user.id?.description
        } failure: { error in
            self.activityIndicator.stopAnimating()
            self.nameLabel.text = error.debugDescription
        }
        
    }
    
    
    @IBAction func cancelAction(_ sender: Any) {
        inputName.text = ""
        nameLabel.isHidden = false
        inputName.isHidden = true
        buttonAceptar.isHidden = true
        buttonBorrarName.isHidden = true
        buttonGetUser.isHidden = false
        buttonEditar.isHidden = false
        buttonAddNewUser.isHidden = false
    }
}

