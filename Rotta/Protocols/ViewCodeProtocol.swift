//
//  ViewCodeProtocol.swift
//  Rotta
//
//  Created by Marcos on 10/06/25.
//

protocol ViewCodeProtocol {
    func addSubviews()
    func setupConstraints()
    func setup()
}

extension ViewCodeProtocol {
    func setup() {
        addSubviews()
        setupConstraints()
    }
}
