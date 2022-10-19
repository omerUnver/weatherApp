//
//  ViewController.swift
//  Weather App
//
//  Created by M.Ömer Ünver on 27.09.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnOutlet: UIButton!
    @IBOutlet weak var sehirText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let tapGesture = UIGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        self.sehirText.text = ""
    }
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    @IBAction func showButton(_ sender: Any) {
        let city = sehirText.text ?? ""
        if city.isEmpty{
            let alert = UIAlertController(title: "Error!!!", message: "Lütfen şehir adı giriniz", preferredStyle: UIAlertController.Style.alert)
            let okButton = UIAlertAction(title: "OK", style: .default)
            alert.addAction(okButton)
            self.present(alert, animated: true)
        } else {
            performSegue(withIdentifier: "toDetailsVC", sender: nil)
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as? DetailsViewController
            destinationVC?.city = sehirText.text!
        }
    }
    
    
    


}

