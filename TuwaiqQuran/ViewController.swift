
import Foundation
import UIKit
import Alamofire
import AVFoundation


var soraArray = [String]()
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var player : AVPlayer?
    var radios : [Radio] = []
    let session = URLSession.shared

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        radios.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        Cell.textLabel?.textAlignment = .left
        Cell.textLabel?.text = radios[indexPath.row].name
        Cell.detailTextLabel?.text = radios[indexPath.row].radio_url

        return Cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        radio_Play
        performSegue(withIdentifier: "sender", sender: self)
        

//        let alert = UIAlertController(title: "Edit", message: nil, preferredStyle: .alert)
               
//                       // add textField in alert
//               alert.addTextField()
//
//               var textBox = alert.textFields?.first
////        textBox? = self.radios[indexPath.row]
//
//               alert.addAction(UIAlertAction(title: "Save", style: .default, handler: {action in
//
////                   self.radios[indexPath.row] = textBox?
//               }))
//               
//               alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
//
//
//               DispatchQueue.main.async {
//                   self.present(alert, animated: true, completion: nil)
//           }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = tableView.indexPathForSelectedRow?.row
        let info = segue.destination as! PlayerVC
        info.radio_Play = radios[index!].radio_url
    }

    @IBOutlet weak var tableView: UITableView! //{
//        didSet {
//            tableView.delegate = self ; tableView.dataSource = self
//        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self ; tableView.dataSource = self
        getData()
//        playOneAyah()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            for item in self.radios {
                print(item.name )
                print(item.radio_url)
            }
        }
        // Do any additional setup after loading the view.
//        "http://live.mp3quran.net:9702/;"
    }

    

    func getData(){
        var ulrcomponent = URLComponents()
        ulrcomponent.scheme = "https"
        ulrcomponent.host = "api.mp3quran.net"
        ulrcomponent.path="/radios/radio_arabic.json"

        let requset = URLRequest(url: ulrcomponent.url!)
        print(requset)

        let task = session.dataTask(with: requset) { (data ,respon,err) in
            do {
                let jsonDecoder = JSONDecoder()
                if let data = data {
                let decodedRes = try jsonDecoder.decode(DataResponse.self, from: data)
                    DispatchQueue.main.async {
                        for item in decodedRes.radios {
                            self.radios.append(item)
//                            self.playOneAyah(linkURL: item.radio_url)
                        }
                        self.tableView.reloadData()
                // self.quran = decoder
               // print(self.quran.radios)
//                print(" Data recieved: \(decodedRes)")
//                for item in self.quran.radios{
//                    print(item.)
                }
                }
            }catch{
                print(error.localizedDescription)
//                print("unable to fetch \(err?.localizedDescription)")
            }
        }
        task.resume()
    }
}

//class Quran : Codable{
//    var radios : [Information]
//
//}
//struct DataResponse : Codable{
//    let radios: [Radio]
//}
//struct Radio:Codable {
//    var name : String
//    let radio_url:String
//}

class MyCell : UITableViewCell{
    @IBOutlet var nameLbl : UILabel!
}

