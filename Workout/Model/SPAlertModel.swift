import UIKit
import SPAlert
import Foundation

class SPAlertModel {
    
    func openTextSPAlert(message: String, duration: TimeInterval) {
        let spAlertView = SPAlertView(message: message)
        spAlertView.duration = duration
        spAlertView.present()
    }
    
    func openIconSPAlert(title: String, message: String, preset: SPAlertPreset, duration: TimeInterval) {
        let spAlertView = SPAlertView(title: title, message: message, preset: preset)
        spAlertView.duration = duration
        spAlertView.present()
    }
}
