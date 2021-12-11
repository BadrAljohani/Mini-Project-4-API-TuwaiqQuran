import UIKit
import AVFoundation

class PlayerVC: UIViewController {
    
    
    var radio_Play = ""
    var theNumber : Int = 0
    var soraAraay = ["adel"]
    var isPlaying = true
    var radios : [Radio] = []
    
    @IBOutlet weak var sliders: UISlider!
    
    
    @IBAction func sliderMov(_ seder: Any) {
        SoundPlayer.player.currentTime = TimeInterval(sliders.value)
        SoundPlayer.player.play()
    }
    
    
    var player : AVPlayer?
    @IBOutlet weak var soraName: UILabel!
    @IBOutlet weak var playnow: UIButton!
    
    func playOneAyah(linkURL:String) {
        let staionsURL = linkURL
        let url = URL.init(string: staionsURL)
        let playerItem = AVPlayerItem.init(url: url!)
        player = AVPlayer.init(playerItem: playerItem)
        player?.play()
    }
    
    func nextNprev(){
        
        SoundPlayer.play(number: theNumber + 1 )
        soraName.text = soraAraay[theNumber]
        //               playLable.setTitle("ايقاف", for: .normal)
        playnow.setImage(UIImage(named: "pause.png"), for: .normal)
        sliders.maximumValue = Float(SoundPlayer.player.duration)
        sliders.value = 0
        
    }
    @objc func timer() {
        
        sliders.value = Float(SoundPlayer.player.currentTime)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        playOneAyah(linkURL: radio_Play)
//        let soraName.text = Radio.name.self
        //SoundPlayer.play(number: theNumber + 1)
        //soraName.text =  soraAraay[theNumber]
        //soraName.textColor = UIColor.white
        //sliders.maximumValue = Float(SoundPlayer.player.duration)
        
        //        _ = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(PlayerVC.timer) , userInfo: nil, repeats: true)
        //
    }
    
    
    
    
    @IBAction func PlayPresed(_ sender: Any){
        
        isPlaying = !isPlaying
        
        if isPlaying {
            
            SoundPlayer.playAfterPause()
            playnow.setImage(UIImage(named: "pause.png"), for: .normal)
            
            
            
        } else {
            
            playnow.setImage(UIImage(named: "play.png"), for: .normal)
            
            SoundPlayer.player.stop()
            
        }
    }
    
    
    @IBAction func prevPresed(_ sender: Any){
        
        if theNumber < 1 { return}
        theNumber -= 1
        nextNprev()
    }
    
    @IBAction func nextPressed(_ sender: Any) {
        if theNumber > 112 {return }
        theNumber += 1
        nextNprev()
        
    }
    
    
    
    
    @IBAction func backPresed(_ sender: Any){
        
        navigationController?.popToRootViewController(animated: true)
        
        SoundPlayer.player.stop()
        
    }
    
    
}
