import Routing
import Vapor

public func routes(_ router: Router) throws {
    router.get("hello") { req in
        return "Hello, world!"
    }

    router.get("talk", Int.parameter) { req -> Future<View> in
        let id = try req.parameter(Int.self)
        
        _ = Talk(id: 1, presenter: "Jon Friskics...").create(on: req)
        _ = Talk(id: 2, presenter: "David Haney...").create(on: req)
        _ = Talk(id: 3, presenter: "Devan Beitel...").create(on: req)

        struct TalkContext: Codable {
            var id: Int?
            var presenter: String
        }

        return Talk.find(id, on: req).flatMap(to: View.self) { talk in
            guard let talk = talk else {
                throw Abort(.notFound)
            }
            let context = TalkContext(id: talk.id, presenter: talk.presenter)
            return try req.view().render("talk", context)
        }
    }
}
