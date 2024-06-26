//
//  Dependencies.swift
//  Config
//
//  Created by jiyeon on 12/26/23.
//

import ProjectDescription

let spm = SwiftPackageManagerDependencies([
    .remote(url: "https://github.com/SnapKit/SnapKit.git", requirement: .upToNextMinor(from: "5.0.1")),
    .remote(url: "https://github.com/scinfu/SwiftSoup.git", requirement: .upToNextMajor(from: "2.7.1")),
    .remote(url: "https://github.com/Juanpe/SkeletonView.git", requirement: .upToNextMajor(from: "1.0.0"))
], productTypes: ["SnapKit": .framework, "SwiftSoup": .framework, "SkeletonView": .framework]
)

let dependencies = Dependencies(
    swiftPackageManager: spm,
    platforms: [.iOS]
)
