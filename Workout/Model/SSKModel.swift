import UIKit
import SPAlert
import SwiftyStoreKit

class SSKModel {
    
    let spAlertModel = SPAlertModel()
    
    func validateAction(sharedSecret: String) {
        let appleValidator = AppleReceiptValidator(service: .production, sharedSecret: sharedSecret)
        SwiftyStoreKit.verifyReceipt(using: appleValidator) { result in
            if case .success(let receipt) = result {
                let productIds = Set([ "",
                                       "",
                                       ""])
                let purchaseResult = SwiftyStoreKit.verifySubscriptions(productIds: productIds, inReceipt: receipt)
                switch purchaseResult {
                case .purchased(let expiryDate, let receiptItems):
                    print("Покупка есть")
                case .expired(let expiryDate, let receiptItems):
                    print("Покупки нет")
                case .notPurchased:
                    print("Покупки нет")
                }
            } else {
                print("Покупки нет")
            }
        }
    }
    
    func restoreAction() {
        SwiftyStoreKit.restorePurchases(atomically: true) { results in
            if results.restoreFailedPurchases.count > 0 {
                self.spAlertModel.openTextSPAlert(message: "Не удалось восстановить покупку",
                                             duration: 3)
            } else if results.restoredPurchases.count > 0 {
                self.spAlertModel.openTextSPAlert(message: "Восстановлено",
                                                  duration: 3)
            } else {
                self.spAlertModel.openTextSPAlert(message: "Нет покупок для восстановления",
                                                  duration: 3)
            }
        }
    }
    
    func buyAction(productId: String) {
        SwiftyStoreKit.purchaseProduct(productId, quantity: 1, atomically: true) { result in
            switch result {
            case .success( _):
                self.spAlertModel.openIconSPAlert(title: "Поздравляем 🎉",
                                             message: "Вам доступен полный доступ",
                                             preset: .heart,
                                             duration: 3)
            case .error(let error):
                switch error.code {
                case .unknown: print("Unknown error. Please contact support")
                case .clientInvalid: print("Not allowed to make the payment")
                case .paymentCancelled: break
                case .paymentInvalid: print("The purchase identifier was invalid")
                case .paymentNotAllowed: print("The device is not allowed to make the payment")
                case .storeProductNotAvailable: print("The product is not available in the current storefront")
                case .cloudServicePermissionDenied: print("Access to cloud service information is not allowed")
                case .cloudServiceNetworkConnectionFailed: print("Could not connect to the network")
                case .cloudServiceRevoked: print("User has revoked permission to use this cloud service")
                default: break
                }
                self.spAlertModel.openIconSPAlert(title: "Ошибка",
                                                  message: "Что-то пошло не так",
                                                  preset: .heart,
                                                  duration: 3)
            }
        }
    }
}
