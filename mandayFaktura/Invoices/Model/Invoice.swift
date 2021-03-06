//
//  Invoice.swift
//  mandayFaktura
//
//  Created by Wojciech Kicior on 27.01.2018.
//  Copyright © 2018 Wojciech Kicior. All rights reserved.
//

import Foundation

struct Invoice {
    let issueDate: Date
    let number: String
    let sellingDate: Date
    let seller: Counterparty
    let buyer: Counterparty
    let items: [InvoiceItem]
    let paymentForm: PaymentForm
    let paymentDueDate: Date
    
    var totalNetValue: Decimal {
        get {
            return items.map{i in i.netValue}.reduce(0, +)
        }
    }
    
    var totalVatValue: Decimal {
        get {
            return items.map{i in i.vatValue}.reduce(0, +)
        }
    }
    
    var totalGrossValue: Decimal {
        get {
            return items.map{i in i.grossValue}.reduce(0, +)
        }
    }
    
    var vatBreakdown: VatBreakdown {
        get {
            return VatBreakdown(invoiceItems: self.items)
        }
    }
}

func anInvoice() -> InvoiceBuilder {
    return InvoiceBuilder()
}

class InvoiceBuilder {
    private var issueDate = Date()
    private var number = ""
    private var sellingDate = Date()
    private var seller: Counterparty?
    private var buyer: Counterparty?
    private var items: [InvoiceItem] = []
    private var paymentForm: PaymentForm = .transfer
    private var paymentDueDate = Date()
    
    func withIssueDate(_ issueDate: Date) -> InvoiceBuilder {
        self.issueDate = issueDate
        return self
    }
    
    func withNumber(_ number: String) -> InvoiceBuilder {
        self.number = number
        return self
    }
    
    func withSellingDate(_ sellingDate: Date) -> InvoiceBuilder {
        self.sellingDate = sellingDate
        return self
    }
    
    func withSeller(_ seller: Counterparty) -> InvoiceBuilder {
        self.seller = seller
        return self
    }
    
    func withBuyer(_ buyer: Counterparty) -> InvoiceBuilder {
        self.buyer = buyer
        return self
    }
    
    func withItems(_ items: [InvoiceItem]) -> InvoiceBuilder {
        self.items = items
        return self
    }
    
    func withPaymentForm(_ paymentForm: PaymentForm) -> InvoiceBuilder {
        self.paymentForm = paymentForm
        return self
    }
    
    func withPaymentDueDate(_ paymentDueDate: Date) -> InvoiceBuilder {
        self.paymentDueDate = paymentDueDate
        return self
    }
    
    func build() -> Invoice {
        return Invoice(issueDate: issueDate, number: number, sellingDate: sellingDate, seller: seller!, buyer: buyer!, items: items, paymentForm: paymentForm, paymentDueDate: paymentDueDate)
    }
}
