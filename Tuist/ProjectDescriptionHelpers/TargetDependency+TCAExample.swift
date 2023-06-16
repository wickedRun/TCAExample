//
//  TargetDependency+TCAExample.swift
//  ProjectDescriptionHelpers
//
//  Created by wickedRun on 2023/06/16.
//

import Foundation

import ProjectDescription

extension TargetDependency {
    static let swiftComposableArchitecture: TargetDependency = .external(name: "ComposableArchitecture")
}
