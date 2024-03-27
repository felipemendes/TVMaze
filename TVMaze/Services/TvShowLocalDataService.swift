//
//  TvShowLocalDataService.swift
//  TVMaze
//
//  Created by Felipe Mendes on 27/03/24.
//

import Foundation
import CoreData

protocol TvShowLocalDataServiceProtocol {
    var container: NSPersistentContainer { get }
    var containerName: String { get }
    var entityName: String { get }
    var savedEntities: [TvShowEntity] { get }

    func updateTvShow(_ tvShow: TvShow)
}

class TvShowLocalDataService: TvShowLocalDataServiceProtocol {

    // MARK: - Initializer

    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { _, error in
            if let error {
                print("Error loading Core Data: \(error.localizedDescription)")
            }
        }

        self.fetchTvShow()
    }

    // MARK: - Public API

    let container: NSPersistentContainer
    let containerName: String = "TvShowContainer"
    let entityName: String = "TvShowEntity"

    @Published var savedEntities: [TvShowEntity] = []

    func updateTvShow(_ tvShow: TvShow) {
        // check if TV Show is already saved
        guard let entity = savedEntities.first(where: { $0.tvShowID == "\(tvShow.id)" }) else {
            add(tvShow: tvShow)
            return
        }

        delete(entity: entity)
    }

    // MARK: - Private

    private func fetchTvShow() {
        let request = NSFetchRequest<TvShowEntity>(entityName: entityName)

        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch {
            print("Error fetching TV Show Entities: \(error.localizedDescription)")
        }
    }

    private func add(tvShow: TvShow) {
        let entity = TvShowEntity(context: container.viewContext)
        entity.tvShowID = "\(tvShow.id)"
        applyChanges()
    }

    private func delete(entity: TvShowEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }

    private func save() {
        do {
            try container.viewContext.save()
        } catch {
            print("Error saving to Core Data: \(error.localizedDescription)")
        }
    }

    private func applyChanges() {
        save()
        fetchTvShow()
    }
}
