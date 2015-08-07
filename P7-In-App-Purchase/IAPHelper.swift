//
//  IAPHelper.swift
//  swift-helpers
//
//  Created by Andrew Brandt on 2/4/15.
//  Copyright (c) 2015 Make School. All rights reserved.
//

import StoreKit

//  You can use this protocol to notify some object that purchases completed
protocol IAPHelperDelegate {
    
    func purchaseSuccessful(productString: String)
    func purchaseFailed()

}

class IAPHelper: NSObject, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    
    var delegate: IAPHelperDelegate?
    
    //called by you, to start purchase process
    func attemptPurchase(productName: String) {
        if (SKPaymentQueue.canMakePayments()) {
            var productID:NSSet = NSSet(object: productName)
            var productRequest:SKProductsRequest = SKProductsRequest(productIdentifiers: productID)
            productRequest.delegate = self
            productRequest.start()
        } else {
            //notify user that purchase isn't possible
            if let delegate = delegate {
                delegate.purchaseFailed()
            }
        }
    }
    
    //called by you, to start restore purchase process
    func attemptRestorePurchase() {
        if (SKPaymentQueue.canMakePayments()) {
            SKPaymentQueue.defaultQueue().restoreCompletedTransactions()
        } else {
            //notify user that restore isn't possible
            if let delegate = delegate {
                delegate.purchaseFailed()
            }
        }
    }
    
    //called after delegate method productRequest(...)
    func buyProduct(product: SKProduct) {
        var payment = SKPayment(product: product)
        SKPaymentQueue.defaultQueue().addTransactionObserver(self)
        SKPaymentQueue.defaultQueue().addPayment(payment)
    }
    
    // MARK: - SKProductsRequestDelegate method
    
    func productsRequest(request: SKProductsRequest!, didReceiveResponse response: SKProductsResponse!) {
        var count: Int = response.products.count
        if (count > 0) {
            var validProducts = response.products
            var product = validProducts[0] as SKProduct
            buyProduct(product)
        } else {
            //something went wrong with lookup, try again?
        }
    }
    
    // MARK: - SKPaymentTransactionObserver method
    
    func paymentQueue(queue: SKPaymentQueue!, updatedTransactions transactions: [AnyObject]!) {
        println("recieved response")
        for transaction: AnyObject in transactions {
            if let tx: SKPaymentTransaction = transaction as? SKPaymentTransaction {
                switch tx.transactionState {
                case .Purchased, .Restored:
                    println("product purchased/restored")
                    //notify delegate if one exists
                    if let delegate = delegate {
                        delegate.purchaseSuccessful(tx.payment.productIdentifier)
                    }
                    queue.finishTransaction(tx)
                    break;
                case .Failed:
                    //delegate.purchaseFailed()
                    queue.finishTransaction(tx)
                    break;
                case .Deferred:
                    break;
                case .Purchasing:
                    break;
                }
            }
        }
    }
}
