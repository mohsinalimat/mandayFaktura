//
//  InvoiceItemCoding.swift
//  mandayFaktura
//
//  Created by Wojciech Kicior on 17.02.2018.
//  Copyright © 2018 Wojciech Kicior. All rights reserved.
//

import Foundation

@objc(InvoiceItemCoding) class InvoiceItemCoding: NSObject, NSCoding {
    let invoiceItem: InvoiceItem
    
    func encode(with coder: NSCoder) {
        coder.encode(self.invoiceItem.name, forKey: "name")
        coder.encode(self.invoiceItem.amount, forKey: "amount")
        coder.encode(self.invoiceItem.unitNetPrice, forKey: "unitNetPrice")
        coder.encode(self.invoiceItem.unitOfMeasure.rawValue, forKey: "unitOfMeasure")
        coder.encode(VatRateCoding(self.invoiceItem.vatRate), forKey: "vatRate")
    }
    
    required convenience init?(coder decoder: NSCoder) {
        guard let name = decoder.decodeObject(forKey: "name") as? String,
            let amount = decoder.decodeObject(forKey: "amount") as? Decimal,
            let unitNetPrice = decoder.decodeObject(forKey: "unitNetPrice") as? Decimal
        
            else { return nil }
        let unitOfMeasure = UnitOfMeasure(rawValue: (decoder.decodeInteger(forKey: "unitOfMeasure")))!
        //vatRateInPercent - is deprecated
        let vatRateInPercent: Decimal? = decoder.decodeObject(forKey: "vatRateInPercent") as? Decimal
        let vatRateCoding = decoder.decodeObject(forKey: "vatRate") as? VatRateCoding
        let vatRate = vatRateCoding?.vatRate
        
        self.init(anInvoiceItem()
            .withName(name)
            .withAmount(amount)
            .withUnitNetPrice(unitNetPrice)
            .withUnitOfMeasure(unitOfMeasure)
            //vatRateInPercent - is deprecated
            .withVatRate(vatRate ?? VatRate(value: vatRateInPercent! / 100))
            .build())
    }
    
    init(_ invoiceItem: InvoiceItem) {
        self.invoiceItem = invoiceItem
    }
}
