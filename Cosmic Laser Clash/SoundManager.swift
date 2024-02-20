//
//  SoundManager.swift
//  Cosmic Laser Clash
//
//  Created by Ilia Ilia on 19.02.2024.
//

import AVFoundation

enum SoundName: String {
    case shoot = "laser-shoot"
    case empty = "laser-empty"
    case reload = "laser-reload"
}

class SoundManager {
    
    static let shared = SoundManager()
    private var player: AVAudioPlayer?
    private init() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.ambient)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Error setting up audio session: \(error.localizedDescription)")
        }
    }
    
    func playSound(soundName: SoundName) {
        guard let url = Bundle.main.url(forResource: soundName.rawValue, withExtension: "mp3") else {
            print("Sound file not found")
            return
        }
        
        do {
            if player == nil {
                player = try AVAudioPlayer(contentsOf: url)
            } else {
                player?.stop()
                player = try AVAudioPlayer(contentsOf: url)
            }
            player?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }

    }
    
    func stopSound() {
        player?.stop()
    }
}
