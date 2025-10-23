// The Swift Programming Language
// https://docs.swift.org/swift-book

// the below is from ShhShell/ShhShell/Misc/Haptics.swift
// https://github.com/neon443/ShhShell/blob/cbe1fbad11899043adf3f21835d8142c46ba1107/ShhShell/Misc/Haptics.swift

//
//  Haptics.swift
//  ShhShell
//
//  Created by neon443 on 26/07/2025.
//

import Foundation
#if canImport(UIKit)
import UIKit

public enum Haptic {
	case success
	case warning
	case error
	case light
	case medium
	case heavy
	case soft
	case rigid
	
	var isUIImpact: Bool {
		switch self {
		case .light, .medium, .heavy, .soft, .rigid:
			return true
		case .success, .warning, .error:
			return false
		}
	}
	
	@MainActor
	var uiImpact: UIImpactFeedbackGenerator? {
		guard self.isUIImpact else { return nil }
		switch self {
		case .light, .medium, .heavy, .soft, .rigid:
			switch self {
			case .light:
				return UIImpactFeedbackGenerator(style: .light)
			case .medium:
				return UIImpactFeedbackGenerator(style: .medium)
			case .heavy:
				return UIImpactFeedbackGenerator(style: .heavy)
			case .soft:
				if #available(iOS 13.0, *) {
					return UIImpactFeedbackGenerator(style: .soft)
				} else {
					return UIImpactFeedbackGenerator(style: .light)
				}
			case .rigid:
				if #available(iOS 13.0, *) {
					return UIImpactFeedbackGenerator(style: .rigid)
				} else {
					return UIImpactFeedbackGenerator(style: .heavy)
				}
			default: return nil
			}
		default: return nil
		}
	}
	
	@MainActor
	public func trigger() {
		if self.isUIImpact {
			self.uiImpact?.impactOccurred()
		} else {
			switch self {
			case .success:
				UINotificationFeedbackGenerator().notificationOccurred(.success)
			case .warning:
				UINotificationFeedbackGenerator().notificationOccurred(.warning)
			case .error:
				UINotificationFeedbackGenerator().notificationOccurred(.error)
			default: print("idk atp")
			}
		}
	}
}
#endif
