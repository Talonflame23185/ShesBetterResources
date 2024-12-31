//
//  DeviceSpace.swift
//  ShesBetterResources
//
//  Created by Connor Ott on 12/30/24.
//
import SwiftUI

enum DeviceSpacing {
    static var standardPadding: CGFloat {
        UIDevice.current.userInterfaceIdiom == .pad ? 24 : 16
    }
    
    static var largeSpacing: CGFloat {
        UIDevice.current.userInterfaceIdiom == .pad ? 40 : 24
    }
    
    static var contentWidth: CGFloat {
        UIDevice.current.userInterfaceIdiom == .pad ? 600 : UIScreen.main.bounds.width - 32
    }
} 
