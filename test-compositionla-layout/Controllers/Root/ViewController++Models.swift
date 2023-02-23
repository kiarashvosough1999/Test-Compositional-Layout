//
//  ViewController++Models.swift
//  test-compositionla-layout
//
//  Created by Kiarash Vosough on 2/23/23.
//

import struct Foundation.UUID
import struct Foundation.URL

extension ViewController {
    enum Section: String, Hashable, Sendable, CaseIterable {
        case myAlbum
        case triplet
        case lowHeight
    }

    struct Item: Hashable, Sendable, Identifiable {
        var id: UUID
        let imageURL: URL
    }
}
