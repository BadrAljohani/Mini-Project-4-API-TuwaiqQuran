
import Foundation
import UIKit
import Alamofire
import AVFoundation

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
//        Cell.backgroundColor = UIColor(red: 0.42, green: 0.35, blue: 0.80, alpha: 1.00)
        
        return Cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "sender", sender: self)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let index = tableView.indexPathForSelectedRow?.row
        let info = segue.destination as! PlayerVC
        info.radio_Play = radios[index!].radio_url
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self ; tableView.dataSource = self
        getData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3){
            for item in self.radios {
                print(item.name )
                print(item.radio_url)
            }
        }
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
                            
                        }
                        self.tableView.reloadData()
                        
                    }
                }
            }catch{
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
}
