//
//  TCAExampleModule.swift
//  ProjectDescriptionHelpers
//
//  Created by wickedRun on 2023/06/16.
//

import Foundation

import ProjectDescription

public enum TCAExampleModule: Modulable, CaseIterable {
    case app
    
    public var name: String {
        switch self {
        case .app:
            return "TCAExample"
        }
    }
    
    public var bundleId: String {
        return "\(Project.organizationName).\(self.name)"
    }
    
    public var productType: Product {
        switch self {
        case .app:
            return .app
        }
    }
    
    public var infoPlist: InfoPlist {
        switch self {
        case .app:
            return .extendingDefault(with: [
                "CFBundleShortVersionString": "1.0",
                "CFBundleVersion": "1",
//                "UIMainStoryboardFile": "",
                "UILaunchStoryboardName": "LaunchScreen"
            ])
        default:
            return .default
        }
    }
    
    public var sources: SourceFilesList {
        let path: Path = .relativeToRoot("Targets/\(self.name)/Sources/**")
        return .paths([path])
    }
    
    public var resources: ResourceFileElements? {
        let resource: ResourceFileElement = .glob(pattern: .relativeToRoot("Targets/\(self.name)/Resources/**"))
        
        switch self {
        case .app:
            return [resource]
        default:
            return nil
        }
    }
    
    public var dependencies: [TargetDependency] {
        switch self {
        case .app:
            return [
                .swiftComposableArchitecture
            ]
        }
    }
    
    public var settings: Settings {
        let base: SettingsDictionary = [:]
        let debug: SettingsDictionary
        let release: SettingsDictionary
        
        switch self {
        case .app:
            debug = [:]
            release = [:]
        }
        
        return .settings(
            base: base,
            debug: debug,
            release: release,
            defaultSettings: .recommended
        )
    }
    
    public var target: Target {
        return Target(
            name: self.name,
            platform: .iOS,
            product: self.productType,
            bundleId: self.bundleId,
            deploymentTarget: Project.minimumDeploymentTarget,
            infoPlist: self.infoPlist,
            sources: self.sources,
            resources: self.resources,
            dependencies: self.dependencies
        )
    }
    
    public var testTarget: Target {
        let testSource: SourceFilesList = .paths([.relativeToRoot("Targets/\(self.name)/Tests/**")])
        return Target(
            name: "\(self.name)Tests",
            platform: .iOS,
            product: .unitTests,
            bundleId: "\(self.bundleId)Tests",
            infoPlist: .default,
            sources: testSource,
            dependencies: [.target(name: self.name)]
        )
    }
    
    public var path: Path {
        return .relativeToRoot("Targets/\(self.name)")
    }
    
    public var project: TargetDependency {
        return .project(target: self.name, path: self.path)
    }
}
