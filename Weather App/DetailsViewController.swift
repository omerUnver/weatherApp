//
//  DetailsViewController.swift
//  Weather App
//
//  Created by M.Ömer Ünver on 27.09.2022.
//

import UIKit

class DetailsViewController: UIViewController {
var city = String()
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var weather: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityName.text = city
        getRequest(cityName: city)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func getRequest(cityName : String){
        let urlRequest = URLRequest(url: URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=0cf0b8aec57f0673aa317cfae9353996")!)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                self.alert(title: "Error", message: "Error")
            }
            if let jsonData = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                    if let main = json["main"] as? NSDictionary{
                       if let temperature = main["temp"] as? Double {
                           let weather = Int(temperature - 273.15)
                           DispatchQueue.main.async {
                               self.weather.text = String(weather)
                           }
                        }
                    }
                } catch {
                    self.alert(title: "Error", message: "Error")
                }
            }
        }
        task.resume()
    }
    func alert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)
    }
}
