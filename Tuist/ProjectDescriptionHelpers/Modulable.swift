//
//  Modulable.swift
//  ProjectDescriptionHelpers
//
//  Created by wickedRun on 2023/06/16.
//

import Foundation

import ProjectDescription

public protocol Modulable {
    var name: String { get }
    var bundleId: String { get }
    var productType: Product { get }
    var infoPlist: InfoPlist { get }
    var sources: SourceFilesList { get }
    var resources: ResourceFileElements? { get }
    var dependencies: [TargetDependency] { get }
    var settings: Settings { get }
    var path: Path { get }
    var target: Target { get }
    var testTarget: Target { get }
}
