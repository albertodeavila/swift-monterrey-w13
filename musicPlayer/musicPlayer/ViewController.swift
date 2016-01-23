
import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    let songs : Array<[String : Any]> = [
        ["song": NSBundle.mainBundle().URLForResource("Rainbow_Street", withExtension: "mp3")! as NSURL, "image":"Rainbow_Street", "title": "Rainbow Street"],
        ["song": NSBundle.mainBundle().URLForResource("Siesta", withExtension: "mp3")! as NSURL, "image":"Siesta", "title": "Siesta"],
        ["song": NSBundle.mainBundle().URLForResource("Night_Owl", withExtension: "mp3")! as NSURL, "image":"Night_Owl", "title": "Night Owl"],
        ["song": NSBundle.mainBundle().URLForResource("Its_Your_Birthday", withExtension: "mp3")! as NSURL, "image":"Its_Your_Birthday", "title": "Its Your Birthday"],
        ["song": NSBundle.mainBundle().URLForResource("Enthusiast", withExtension: "mp3")! as NSURL, "image":"Enthusiast", "title": "Enthusiast"]
    ]
    var currentSong: Int = 0
    
    private var player: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        random()
    }

    /**
     * Method to load the song send as parameter
     */
    func loadSong(songData : [String : Any] ){
        do{
            try player = AVAudioPlayer(contentsOfURL: songData["song"]! as! NSURL)
            titleLabel.text = songData["title"] as? String
            cover.image = UIImage(named: (songData["image"] as? String)!)
            play()
        }catch{
            print("Error loading the song")
        }
    }

    /**
      * Method to play the current song
      */
    @IBAction func play() {
        if !player.playing{
            player.play()
        }
    }
    
    /**
     * Method to pause the current song
     */
    @IBAction func pause() {
        if player.playing{
            player.pause()
        }
    }
    
    /**
     * Method to stop the current song
     */
    @IBAction func stop() {
        if player.playing{
            player.pause()
            player.currentTime = 0.0
        }
    }
    
    /**
     * Method to change to the next song
     */
    @IBAction func next() {
        currentSong++
        if currentSong >= 5{
            currentSong = 0
        }
        loadSong(songs[currentSong])
    }
    
    /**
     * Method to change to a random song
     */
    @IBAction func random() {
        var randomIndex = Int(arc4random_uniform(UInt32(songs.count)))
        while (randomIndex == currentSong){
            randomIndex = Int(arc4random_uniform(UInt32(songs.count)))
        }
        currentSong = randomIndex
        loadSong(songs[currentSong])
    }
    
    /**
     * Method to increase the volume
     */
    @IBAction func volumePlus() {
        player.volume = player.volume * 1.1
    }
    
    /**
     * Method to decrease the volume
     */
    @IBAction func volumeMinus() {
        player.volume = player.volume * 0.9
    }
    
}

