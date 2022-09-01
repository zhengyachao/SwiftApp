//
//  LockConfig.swift
//  swiftTest2
//
//  Created by trustmobi on 2022/9/1.
//

import UIKit

struct LockViewConfig: PatternLockViewConfig {
    var matrix: Matrix = Matrix(row: 3, column: 3)
    var gridSize: CGSize = CGSize(width: 70, height: 70)
    var connectLine: ConnectLine?
    var autoMediumGridsConnect: Bool = false
    var connectLineHierarchy: ConnectLineHierarchy = .bottom
    var errorDisplayDuration: TimeInterval = 1
    var initGridClosure: (Matrix) -> (PatternLockGrid)

    init() {
        let tintColor = UIColor.theme
        initGridClosure = {(matrix) -> PatternLockGrid in
            let gridView = GridView()
            let outerStrokeLineWidthStatus = GridPropertyStatus<CGFloat>.init(normal: 1, connect: 2, error: 2)
            let outerStrokeColorStatus = GridPropertyStatus<UIColor>(normal: tintColor, connect: tintColor, error: .red)
            gridView.outerRoundConfig = RoundConfig(radius: 20, lineWidthStatus: outerStrokeLineWidthStatus, lineColorStatus: outerStrokeColorStatus)
            let innerFillColorStatus = GridPropertyStatus<UIColor>(connect: tintColor, error: .red)
            gridView.innerRoundConfig = RoundConfig(radius: 10, fillColorStatus: innerFillColorStatus)
            return gridView
        }
        let lineView = ConnectLineView()
        lineView.lineColorStatus = .init(normal: tintColor, error: .red)
        lineView.triangleColorStatus = .init(normal: tintColor, error: .red)
        lineView.isTriangleHidden = true
        lineView.lineWidth = 3
        connectLine = lineView
    }
}
