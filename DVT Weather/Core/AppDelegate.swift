//
//  AppDelegate.swift
//  DVT Weather
//
//  Created by Bedan Kimani on 11/01/2025.
//
import Foundation
import GooglePlaces
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      _ = try? GMSPlacesClient.provideAPIKey(Configuration.value(for: "PLACES_API_KEY"))
      return true
  }
    
}
