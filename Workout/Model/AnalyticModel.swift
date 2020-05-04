import UIKit
import Firebase
import FacebookCore
import YandexMobileMetrica

class AnalyticModel {
    
    func setEvent(event: String, key: String, value: Any) {
        let params : [String : Any] = [key : value]
        AppEvents.logEvent(.init(event), parameters: params)
        Analytics.logEvent(event, parameters: params)
        YMMYandexMetrica.reportEvent(event, parameters: params, onFailure: { (error) in print(error) })
    }
}
