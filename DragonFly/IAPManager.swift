//
//  IAPManager.swift
//  DragonFly
//
//  Created by Александр Уткин on 10.08.2020.
//  Copyright © 2020 Ivan Akulov. All rights reserved.
//

import Foundation
import StoreKit

class IAPManager: NSObject {
    
    static let productNotificationIdentifier = "IAPManagerProductIdentifier"
    static let shared = IAPManager()
    
    private override init() { }
    
    var products: [SKProduct] = []
    let paymentQueue = SKPaymentQueue.default()
    
    public func setupPurchases(callback: @escaping(Bool) -> ()) {
        if SKPaymentQueue.canMakePayments() {
            paymentQueue.add(self)
            callback(true)
            return
        }
        callback(false)
    }
    
    public func getProducts() {
        
        let identifiersProduct: Set = [
            IAPPoducts.nonConsumable.rawValue
        ]
        
        let request = SKProductsRequest(productIdentifiers: identifiersProduct)
        request.delegate = self
        request.start()
    }
    
    public func purchase(productWith identifier: String) {
        
        guard let product = products.filter({ $0.productIdentifier == identifier }).first else { return }
        let payment = SKPayment(product: product)
        paymentQueue.add(payment)
        
    }
    
    public func restoreCompletedTransactions() {
        print("restore purshased")
        paymentQueue.restoreCompletedTransactions()
    }
}

extension IAPManager:SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .deferred: break
            case .purchasing: break
            case .failed: failed(transaction: transaction)
            case .purchased: completed(transaction: transaction)
            case .restored: restored(transaction: transaction)
            @unknown default:
                print("error")
            }
        }
    }
    
    private  func failed(transaction: SKPaymentTransaction) {
        if let transactionError = transaction.error as NSError? {
            if transactionError.code != SKError.paymentCancelled.rawValue {
                print("Ошибка транзакции \(transaction.error!.localizedDescription)")
            }
        }
        paymentQueue.finishTransaction(transaction)
    }
    
    private func completed(transaction: SKPaymentTransaction) {
        //можно добавить нотификейшн центр с идентификатором покупки, чтобы разделять покупки, которые сделал пользователь. курс IAP, видео 11
        paymentQueue.finishTransaction(transaction)
        Persistance.shared.isPay = true
        NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
    }
    
    private func restored(transaction: SKPaymentTransaction) {
        
        guard (transaction.original?.payment.productIdentifier) != nil else { return }
        
        Persistance.shared.isPay = true
        NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
        paymentQueue.finishTransaction(transaction)
    }
}

extension IAPManager: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        self.products = response.products
        products.forEach { print($0.localizedTitle) }
        
        if products.count > 0 {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: IAPManager.productNotificationIdentifier), object: nil)
        }
    }
}
