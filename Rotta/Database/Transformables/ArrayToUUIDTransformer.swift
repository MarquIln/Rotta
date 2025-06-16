//
//  ArrayToUUIDTransformer.swift
//  Rotta
//
//  Created by Marcos on 12/06/25.
//

import UIKit

@objc(ArrayToUUIDTransformer)
class ArrayToUUIDTransformer: ValueTransformer {

    override class func transformedValueClass() -> AnyClass {
        return NSData.self
    }

    override class func allowsReverseTransformation() -> Bool {
        return true
    }

    override func transformedValue(_ value: Any?) -> Any? {
        guard let array = value as? [UUID] else { return nil }
        return try? JSONSerialization.data(withJSONObject: array, options: [])
    }

    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }
        return try? JSONSerialization.jsonObject(with: data, options: [])
            as? [UUID]
    }
}
