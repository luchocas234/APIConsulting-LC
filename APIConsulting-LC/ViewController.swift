//
//  ViewController.swift
//  APIConsulting-LC
//
//  Created by u633168 on 27/01/2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var emailLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        nameLabel.text = ""
        nameLabel.numberOfLines = 0
        emailLabel.text = ""
        idLabel.text = ""
        activityIndicator.hidesWhenStopped = true
        activityIndicator.stopAnimating()
    }


    @IBAction func getUserAction(_ sender: Any) {
        activityIndicator.startAnimating()
        
        NetworkingProvider.shared.getUser(id: 509) { user in
            self.activityIndicator.stopAnimating()
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
}

