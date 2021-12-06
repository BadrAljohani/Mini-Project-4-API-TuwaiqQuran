import Foundation
import AVFoundation



class SoundPlayer {
    
    
    static var player : AVAudioPlayer!
    static func play(number : Int) {
        
        let session = AVAudioSession.sharedInstance()
        let path = Bundle.main.path(forResource: String(number) + ".mp3", ofType: nil)
       

        let url = URL(fileURLWithPath: path ?? "http://live.mp3quran.net:9776/")
        do {
            let sound = try AVAudioPlayer(contentsOf: url)
            player = sound
            player.play()
        } catch  {
          func stop() {
               player.pause()
           }
        }
        
          do{
            try session.setCategory(AVAudioSession.Category.playback)
          }
          catch{
          }

          player.play()
    }
    
    
    static func playAfterPause() {
        
        player.play()
    }
    
    

    
}
