import UIKit
import Foundation

class AnimationModel {
    
    func scaleAnimationButton(sender: UIButton, scaleX: CGFloat, scaleY: CGFloat, duration: TimeInterval) {
        UIView.animate(withDuration: duration, animations: {
            sender.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        }, completion: { _ in
            UIView.animate(withDuration: duration) {
                sender.transform = CGAffineTransform.identity
            }
        })
    }
    
    func scaleAnimationView(sender: UIView, scaleX: CGFloat, scaleY: CGFloat, duration: TimeInterval) {
        UIView.animate(withDuration: duration, animations: {
            sender.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        }, completion: { _ in
            UIView.animate(withDuration: duration) {
                sender.transform = CGAffineTransform.identity
            }
        })
    }
    
    func moveAnimationView(sender: UIImageView, tx: CGFloat, ty: CGFloat, duration: TimeInterval) {
        UIView.animate(withDuration: 0, animations: {
            sender.transform = CGAffineTransform(translationX: tx, y: ty)
        }, completion: { _ in
            UIView.animate(withDuration: duration) {
                sender.transform = CGAffineTransform.identity
            }
        })
    }
    
    func shakeAnimation(sender: UIView) {
        sender.transform = CGAffineTransform(translationX: 12, y: 0)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            sender.transform = CGAffineTransform.identity
        }, completion: nil)
    }
    
    func blinkAnimation(duration: TimeInterval, delay: TimeInterval, alpha: CGFloat, sender: UIButton) {
        UIView.animate(withDuration: duration, delay: delay, options: [.curveEaseInOut, .repeat, .autoreverse], animations: {
            sender.alpha = alpha
        })
    }
    
    func scaleRepeatAnimationButton(sender: UIButton, scaleX: CGFloat, scaleY: CGFloat, duration: TimeInterval) {
        UIView.animate(withDuration: duration, delay: 0, options: [.curveEaseIn, .repeat], animations: {
            sender.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
        }, completion: { _ in
            UIView.animate(withDuration: duration) {
                sender.transform = CGAffineTransform.identity
            }
        })
    }
}

