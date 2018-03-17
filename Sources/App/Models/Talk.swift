import Fluent
import FluentSQLite
import Foundation
import Vapor

final class Talk: SQLiteModel {
    var id: Int?
    var presenter: String

    init(id: Int?, presenter: String) {
        self.id = id
        self.presenter = presenter
    }
}

extension Talk: Content { }
extension Talk: Parameter { }
extension Talk: Migration { }