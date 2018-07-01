//
//  CoreDataManagerPSF.swift
//  PSFootball
//
//  Created by Lorenzo on 26/06/18.
//  Copyright © 2018 Lorenzo. All rights reserved.
//

import Foundation
import CoreData

let cdmPSF = CoreDataManagerPSF.shared

class CoreDataManagerPSF {
    
    static let shared = CoreDataManagerPSF()
    
    static let kCoreDataFolder = "Resources/CoreData"
    static let kCoreDataModelName = "PSFootball"
    static let kCoreDataDBName = "PSFootball.sqlite"
    
    // MARK: - Private Property
    
    private lazy var coreDataDirectoryURL: URL = {
        var url = URL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!, isDirectory: true).appendingPathComponent(CoreDataManagerPSF.kCoreDataFolder)
        var isDir: ObjCBool = false
        
        if FileManager.default.fileExists(atPath: url.path, isDirectory: &isDir) || !isDir.boolValue {
            do {
                try FileManager.default.createDirectory(atPath: url.path, withIntermediateDirectories: true, attributes: nil)
                
                var resourceValues: URLResourceValues {
                    var resource = URLResourceValues()
                    resource.isExcludedFromBackup = true
                    
                    return resource
                }
                
                try url.setResourceValues(resourceValues)
                
            } catch {
                abort()
            }
        }
        
        return url
    }()
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: CoreDataManagerPSF.kCoreDataModelName, withExtension: "momd")
        let model = NSManagedObjectModel(contentsOf: modelURL!)
        
        return model!
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let storeURL = self.coreDataDirectoryURL.appendingPathComponent(CoreDataManagerPSF.kCoreDataDBName)
        let coordinator: NSPersistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
            
        } catch {
            // Light weight migration
            do {
                try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: [NSMigratePersistentStoresAutomaticallyOption : true, NSInferMappingModelAutomaticallyOption : true])
                
            } catch {
                // Unresolved error during light weight migration
                do {
                    try FileManager.default.removeItem(at: self.coreDataDirectoryURL)
                    try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
                    
                } catch {
                    abort()
                }
            }
        }
        
        // Apply protection
        do {
            //            try FileManager.default.setAttributes([FileAttributeKey.protectionKey : kCFURLFileProtectionComplete], ofItemAtPath: storeURL.path)
            try FileManager.default.setAttributes([FileAttributeKey.protectionKey : FileProtectionType.complete], ofItemAtPath: storeURL.path)
            
        } catch {
            abort()
        }
        
        return coordinator
    }()
    
    private lazy var writerMOC: NSManagedObjectContext = {
        var moc = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        moc.persistentStoreCoordinator = self.persistentStoreCoordinator
        
        return moc
    }()
    
    // MARK: - Public Property
    
    public lazy var mainMOC: NSManagedObjectContext = {
        var moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        moc.parent = self.writerMOC
        moc.undoManager = UndoManager()
        moc.undoManager?.levelsOfUndo = 10
        
        return moc
    }()
    
    // MARK: -
    
    private init() {
        // NOP
    }
    
    deinit {
        //        NSObject.logDeinit(filename: #file)
    }
    
    func saveMainMOC() {
        let moc = mainMOC
        
        moc.performAndWait {
            if moc.hasChanges {
                do {
                    try moc.save()
                    
                } catch let error as NSError {
                    self.handleCoreDataSavingError(error: error)
                }
            }
        }
        
        saveWriterMOC()
    }
    
    func saveBackgroundMOC(moc: NSManagedObjectContext) {
        moc.performAndWait {
            if moc.hasChanges {
                do {
                    try moc.save()
                    
                } catch let error as NSError {
                    self.handleCoreDataSavingError(error: error)
                }
            }
        }
        
        saveMainMOC()
    }
    
    func createNewBackgroundMOC() -> NSManagedObjectContext {
        let moc = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        moc.parent = self.mainMOC
        
        return moc
    }
    
    // MARK: - Private Methods
    
    private func handleCoreDataSavingError(error: NSError) {
        guard let detailedErrors = error.userInfo[NSDetailedErrorsKey] as? [NSError] else {
            debugPrint("*** [Error] CoreData: ", error)
            abort()
        }
        
        debugPrint("*** [Error] CoreData: ", detailedErrors)
        abort()
    }
    
    private func saveWriterMOC() {
        let moc = writerMOC
        
        moc.perform {
            if moc.hasChanges {
                do {
                    try moc.save()
                    
                } catch let error as NSError {
                    self.handleCoreDataSavingError(error: error)
                }
            }
        }
    }
}


