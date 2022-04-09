//
//  FontExtension.swift
//  WeatherDemo
//
//  Created by Jérôme Figueiredo on 08/04/2022.
//

import UIKit
import SwiftUI

// MARK: Font extension
extension Font {
    // Heading
    static let headingXL = Font.custom(HelveticaNeue.Regular, size: 32)
    static let headingL = Font.custom(HelveticaNeue.Regular, size: 24)
    static let headingM = Font.custom(HelveticaNeue.Regular, size: 18)
    static let headingS = Font.custom(HelveticaNeue.Regular, size: 14)

    // Subtitle
    static let subtitleL = Font.custom(HelveticaNeue.Regular, size: 22)
    static let subtitleM = Font.custom(HelveticaNeue.Regular, size: 18)
    static let subtitleS = Font.custom(HelveticaNeue.Regular, size: 16)
    static let subtitleXS = Font.custom(HelveticaNeue.Regular, size: 14)

    // Label
    static let labelXS = Font.custom(HelveticaNeue.Bold, size: 12)

    // NavBar
    static let navbarL = Font.custom(HelveticaNeue.Bold, size: 27)
    static let navbarS = Font.custom(HelveticaNeue.Bold, size: 18)

    // Sub NavBar
    static let subnavActive = Font.custom(HelveticaNeue.Medium, size: 16)
    static let subnavInactive = Font.custom(HelveticaNeue.Regular, size: 16)

    // TabBar
    static let tabbarActive = Font.custom(HelveticaNeue.Bold, size: 11)
    static let tabbarInactive = Font.custom(HelveticaNeue.Regular, size: 11)

    // Body
    static let bodyM = Font.custom(HelveticaNeue.Regular, size: 16)
    static let bodyS = Font.custom(HelveticaNeue.Regular, size: 14)
    static let bodyXS = Font.custom(HelveticaNeue.Regular, size: 12)
    
    // Temperature
    static let mainTemp = Font.custom(SFCompact.regular, size: 100)
    static let forectas = Font.custom(HelveticaNeue.Regular, size: 18)
    
}

//// MARK: UIFont extension
//extension UIFont {
//    // Tab bar
//    static let tabbarActive = UIFont(name: EuclidCircularB.Semibold, size: 11)
//    static let tabbarInactive = UIFont(name: EuclidCircularB.Regular, size: 11)
//}

// MARK: - Font struct
// MARK: - Euclide Circular B
struct HelveticaNeue {
    static let Bold            = "HelveticaNeue-Bold"
    static let BoldItalic      = "HelveticaNeue-BoldItalic"
    static let Light           = "HeveticaNeue-Light"
    static let LightItalic     = "HeveticaNeue-LightItalic"
    static let Medium          = "HeveticaNeue-Medium"
    static let MediumItalic    = "HeveticaNeue-MediumItalic"
    static let Regular         = "HeveticaNeue-Regular"
    static let RegularItalic   = "HeveticaNeue-RegularItalic"
//    static let Semibold        = "HeveticaNeue-Semibold"
//    static let SemiboldItalic  = "HeveticaNeue-SemiboldItalic"
}

//// MARK: - Open Sans
struct SFCompact {
    static let regular = "SF-Compact-Regular"
}
