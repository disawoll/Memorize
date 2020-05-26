//
//  Array+Only.swift
//  Memorize
//
//  Created by Doğan Mert Güven on 26.05.2020.
//  Copyright © 2020 Doğan Mert Güven. All rights reserved.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
