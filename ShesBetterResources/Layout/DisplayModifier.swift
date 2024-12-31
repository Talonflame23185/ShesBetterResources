//
//  DisplayModifier.swift
//  ShesBetterResources
//
//  Created by Connor Ott on 12/30/24.
//
import SwiftUI

struct AdaptiveLayoutModifier: ViewModifier {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: idealWidth)
            .padding(.horizontal, horizontalPadding)
    }
    
    private var idealWidth: CGFloat? {
        // For iPad
        if horizontalSizeClass == .regular {
            return UIDevice.current.userInterfaceIdiom == .pad ? 600 : nil
        }
        // For iPhone
        return nil
    }
    
    private var horizontalPadding: CGFloat {
        UIDevice.current.userInterfaceIdiom == .pad ? 40 : 20
    }
}

// Extension to make it easier to use
extension View {
    func adaptiveLayout() -> some View {
        modifier(AdaptiveLayoutModifier())
    }
}
