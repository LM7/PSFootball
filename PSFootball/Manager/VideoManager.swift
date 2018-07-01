//
//  VideoManager.swift
//  PSFootball
//
//  Created by Lorenzo on 25/06/18.
//  Copyright © 2018 Lorenzo. All rights reserved.
//

import Foundation
import UIKit
import SwiftVideoBackground

class VideoManager {
    
    class func resume() {
        VideoBackground.shared.resume()
    }
    
    class func restart() {
        VideoBackground.shared.restart()
    }
    
    class func pause() {
        VideoBackground.shared.pause()
    }
    
    class func getVideoWithAudio(view: UIView, nameVideo: String) {
        try? VideoBackground.shared.play(view: view, videoName: nameVideo, videoType: "mp4", isMuted: false, darkness: 0.0, willLoopVideo: true, setAudioSessionAmbient: true)
    }
}
