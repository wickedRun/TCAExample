//
//  Dependencies.swift
//  Dependencies
//
//  Created by wickedRun on 2023/06/16.
//

import ProjectDescription

let spm = SwiftPackageManagerDependencies([
    .remote(url: "https://github.com/pointfreeco/swift-composable-architecture", requirement: .upToNextMajor(from: "0.54.1")),
])

let dependencies = Dependencies(swiftPackageManager: spm, platforms: [.iOS])
