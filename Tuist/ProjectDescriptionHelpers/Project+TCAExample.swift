//
//  Project+TCAExample.swift
//  ProjectDescriptionHelpers
//
//  Created by wickedRun on 2023/06/16.
//

import Foundation

import ProjectDescription

public extension Project {
    
    static var organizationName: String {
        return "org.wickedrun"
    }
    
    static var minimumDeploymentTarget: DeploymentTarget {
        return .iOS(targetVersion: "16.0", devices: [.iphone])
    }
    
    static func create(with module: Modulable) -> Project {
        return Project(
            name: module.name,
            organizationName: Self.organizationName,
            settings: module.settings,
            targets: [module.target, module.testTarget]
        )
    }
}
