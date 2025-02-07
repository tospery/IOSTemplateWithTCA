//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import RswiftResources
import UIKit

private class BundleFinder {}
let R = _R(bundle: Bundle(for: BundleFinder.self))

struct _R {
  let bundle: Foundation.Bundle
  var string: string { .init(bundle: bundle, preferredLanguages: nil, locale: nil) }
  var color: color { .init(bundle: bundle) }
  var image: image { .init(bundle: bundle) }
  var file: file { .init(bundle: bundle) }
  var storyboard: storyboard { .init(bundle: bundle) }

  func string(bundle: Foundation.Bundle) -> string {
    .init(bundle: bundle, preferredLanguages: nil, locale: nil)
  }
  func string(locale: Foundation.Locale) -> string {
    .init(bundle: bundle, preferredLanguages: nil, locale: locale)
  }
  func string(preferredLanguages: [String], locale: Locale? = nil) -> string {
    .init(bundle: bundle, preferredLanguages: preferredLanguages, locale: locale)
  }
  func color(bundle: Foundation.Bundle) -> color {
    .init(bundle: bundle)
  }
  func image(bundle: Foundation.Bundle) -> image {
    .init(bundle: bundle)
  }
  func file(bundle: Foundation.Bundle) -> file {
    .init(bundle: bundle)
  }
  func storyboard(bundle: Foundation.Bundle) -> storyboard {
    .init(bundle: bundle)
  }
  func validate() throws {
    try self.storyboard.validate()
  }

  struct project {
    let developmentRegion = "en"
  }

  /// This `_R.string` struct is generated, and contains static references to 2 localization tables.
  struct string {
    let bundle: Foundation.Bundle
    let preferredLanguages: [String]?
    let locale: Locale?
    var constant: constant { .init(source: .init(bundle: bundle, tableName: "Constant", preferredLanguages: preferredLanguages, locale: locale)) }
    var localizable: localizable { .init(source: .init(bundle: bundle, tableName: "Localizable", preferredLanguages: preferredLanguages, locale: locale)) }

    func constant(preferredLanguages: [String]) -> constant {
      .init(source: .init(bundle: bundle, tableName: "Constant", preferredLanguages: preferredLanguages, locale: locale))
    }
    func localizable(preferredLanguages: [String]) -> localizable {
      .init(source: .init(bundle: bundle, tableName: "Localizable", preferredLanguages: preferredLanguages, locale: locale))
    }


    /// This `_R.string.constant` struct is generated, and contains static references to 2 localization keys.
    struct constant {
      let source: RswiftResources.StringResource.Source

      /// en translation: 中文
      ///
      /// Key: Chinese
      ///
      /// Locales: en
      var chinese: RswiftResources.StringResource { .init(key: "Chinese", tableName: "Constant", source: source, developmentValue: "中文", comment: nil) }

      /// en translation: English
      ///
      /// Key: English
      ///
      /// Locales: en
      var english: RswiftResources.StringResource { .init(key: "English", tableName: "Constant", source: source, developmentValue: "English", comment: nil) }
    }

    /// This `_R.string.localizable` struct is generated, and contains static references to 38 localization keys.
    struct localizable {
      let source: RswiftResources.StringResource.Source

      /// en translation: About
      ///
      /// Key: About
      ///
      /// Locales: en, zh-Hans
      var about: RswiftResources.StringResource { .init(key: "About", tableName: "Localizable", source: source, developmentValue: "About", comment: nil) }

      /// en translation: Blog
      ///
      /// Key: Blog
      ///
      /// Locales: en, zh-Hans
      var blog: RswiftResources.StringResource { .init(key: "Blog", tableName: "Localizable", source: source, developmentValue: "Blog", comment: nil) }

      /// en translation: Cancel
      ///
      /// Key: Cancel
      ///
      /// Locales: en, zh-Hans
      var cancel: RswiftResources.StringResource { .init(key: "Cancel", tableName: "Localizable", source: source, developmentValue: "Cancel", comment: nil) }

      /// en translation: Click to Login
      ///
      /// Key: ClickToLogin
      ///
      /// Locales: en, zh-Hans
      var clickToLogin: RswiftResources.StringResource { .init(key: "ClickToLogin", tableName: "Localizable", source: source, developmentValue: "Click to Login", comment: nil) }

      /// en translation: Home
      ///
      /// Key: Dashboard
      ///
      /// Locales: en, zh-Hans
      var dashboard: RswiftResources.StringResource { .init(key: "Dashboard", tableName: "Localizable", source: source, developmentValue: "Home", comment: nil) }

      /// en translation: User has canceled
      ///
      /// Key: Error.Cancel.Message
      ///
      /// Locales: en, zh-Hans
      var errorCancelMessage: RswiftResources.StringResource { .init(key: "Error.Cancel.Message", tableName: "Localizable", source: source, developmentValue: "User has canceled", comment: nil) }

      /// en translation: User has canceled
      ///
      /// Key: Error.Cancel.Title
      ///
      /// Locales: en, zh-Hans
      var errorCancelTitle: RswiftResources.StringResource { .init(key: "Error.Cancel.Title", tableName: "Localizable", source: source, developmentValue: "User has canceled", comment: nil) }

      /// en translation: Data exception
      ///
      /// Key: Error.DataInvalid.Message
      ///
      /// Locales: en, zh-Hans
      var errorDataInvalidMessage: RswiftResources.StringResource { .init(key: "Error.DataInvalid.Message", tableName: "Localizable", source: source, developmentValue: "Data exception", comment: nil) }

      /// en translation: Data exception
      ///
      /// Key: Error.DataInvalid.Title
      ///
      /// Locales: en, zh-Hans
      var errorDataInvalidTitle: RswiftResources.StringResource { .init(key: "Error.DataInvalid.Title", tableName: "Localizable", source: source, developmentValue: "Data exception", comment: nil) }

      /// en translation: The current list doesn't have any data yet
      ///
      /// Key: Error.ListIsEmpty.Message
      ///
      /// Locales: en, zh-Hans
      var errorListIsEmptyMessage: RswiftResources.StringResource { .init(key: "Error.ListIsEmpty.Message", tableName: "Localizable", source: source, developmentValue: "The current list doesn't have any data yet", comment: nil) }

      /// en translation: List is empty
      ///
      /// Key: Error.ListIsEmpty.Title
      ///
      /// Locales: en, zh-Hans
      var errorListIsEmptyTitle: RswiftResources.StringResource { .init(key: "Error.ListIsEmpty.Title", tableName: "Localizable", source: source, developmentValue: "List is empty", comment: nil) }

      /// en translation: Navigation error
      ///
      /// Key: Error.Navigation.Message
      ///
      /// Locales: en, zh-Hans
      var errorNavigationMessage: RswiftResources.StringResource { .init(key: "Error.Navigation.Message", tableName: "Localizable", source: source, developmentValue: "Navigation error", comment: nil) }

      /// en translation: Navigation error
      ///
      /// Key: Error.Navigation.Title
      ///
      /// Locales: en, zh-Hans
      var errorNavigationTitle: RswiftResources.StringResource { .init(key: "Error.Navigation.Title", tableName: "Localizable", source: source, developmentValue: "Navigation error", comment: nil) }

      /// en translation: Please check your network link
      ///
      /// Key: Error.Network.NotConnected.Message
      ///
      /// Locales: en, zh-Hans
      var errorNetworkNotConnectedMessage: RswiftResources.StringResource { .init(key: "Error.Network.NotConnected.Message", tableName: "Localizable", source: source, developmentValue: "Please check your network link", comment: nil) }

      /// en translation: Network is not connected
      ///
      /// Key: Error.Network.NotConnected.Title
      ///
      /// Locales: en, zh-Hans
      var errorNetworkNotConnectedTitle: RswiftResources.StringResource { .init(key: "Error.Network.NotConnected.Title", tableName: "Localizable", source: source, developmentValue: "Network is not connected", comment: nil) }

      /// en translation: The current network access is inaccessible
      ///
      /// Key: Error.Network.NotReachable.Message
      ///
      /// Locales: en, zh-Hans
      var errorNetworkNotReachableMessage: RswiftResources.StringResource { .init(key: "Error.Network.NotReachable.Message", tableName: "Localizable", source: source, developmentValue: "The current network access is inaccessible", comment: nil) }

      /// en translation: Network anomaly
      ///
      /// Key: Error.Network.NotReachable.Title
      ///
      /// Locales: en, zh-Hans
      var errorNetworkNotReachableTitle: RswiftResources.StringResource { .init(key: "Error.Network.NotReachable.Title", tableName: "Localizable", source: source, developmentValue: "Network anomaly", comment: nil) }

      /// en translation: Placeholder Error
      ///
      /// Key: Error.None.Message
      ///
      /// Locales: en, zh-Hans
      var errorNoneMessage: RswiftResources.StringResource { .init(key: "Error.None.Message", tableName: "Localizable", source: source, developmentValue: "Placeholder Error", comment: nil) }

      /// en translation: Placeholder Error
      ///
      /// Key: Error.None.Title
      ///
      /// Locales: en, zh-Hans
      var errorNoneTitle: RswiftResources.StringResource { .init(key: "Error.None.Title", tableName: "Localizable", source: source, developmentValue: "Placeholder Error", comment: nil) }

      /// en translation: Timeout error
      ///
      /// Key: Error.Timeout.Message
      ///
      /// Locales: en, zh-Hans
      var errorTimeoutMessage: RswiftResources.StringResource { .init(key: "Error.Timeout.Message", tableName: "Localizable", source: source, developmentValue: "Timeout error", comment: nil) }

      /// en translation: Timeout error
      ///
      /// Key: Error.Timeout.Title
      ///
      /// Locales: en, zh-Hans
      var errorTimeoutTitle: RswiftResources.StringResource { .init(key: "Error.Timeout.Title", tableName: "Localizable", source: source, developmentValue: "Timeout error", comment: nil) }

      /// en translation: Unknown error
      ///
      /// Key: Error.Unknown.Message
      ///
      /// Locales: en, zh-Hans
      var errorUnknownMessage: RswiftResources.StringResource { .init(key: "Error.Unknown.Message", tableName: "Localizable", source: source, developmentValue: "Unknown error", comment: nil) }

      /// en translation: Unknown error
      ///
      /// Key: Error.Unknown.Title
      ///
      /// Locales: en, zh-Hans
      var errorUnknownTitle: RswiftResources.StringResource { .init(key: "Error.Unknown.Title", tableName: "Localizable", source: source, developmentValue: "Unknown error", comment: nil) }

      /// en translation: Dear, the current login has expired
      ///
      /// Key: Error.User.LoginExpired.Message
      ///
      /// Locales: en, zh-Hans
      var errorUserLoginExpiredMessage: RswiftResources.StringResource { .init(key: "Error.User.LoginExpired.Message", tableName: "Localizable", source: source, developmentValue: "Dear, the current login has expired", comment: nil) }

      /// en translation: Login expired
      ///
      /// Key: Error.User.LoginExpired.Title
      ///
      /// Locales: en, zh-Hans
      var errorUserLoginExpiredTitle: RswiftResources.StringResource { .init(key: "Error.User.LoginExpired.Title", tableName: "Localizable", source: source, developmentValue: "Login expired", comment: nil) }

      /// en translation: Dear, you haven't logged in yet
      ///
      /// Key: Error.User.NotLoginedIn.Message
      ///
      /// Locales: en, zh-Hans
      var errorUserNotLoginedInMessage: RswiftResources.StringResource { .init(key: "Error.User.NotLoginedIn.Message", tableName: "Localizable", source: source, developmentValue: "Dear, you haven't logged in yet", comment: nil) }

      /// en translation: User not logged in
      ///
      /// Key: Error.User.NotLoginedIn.Title
      ///
      /// Locales: en, zh-Hans
      var errorUserNotLoginedInTitle: RswiftResources.StringResource { .init(key: "Error.User.NotLoginedIn.Title", tableName: "Localizable", source: source, developmentValue: "User not logged in", comment: nil) }

      /// en translation: Exit
      ///
      /// Key: Exit
      ///
      /// Locales: en, zh-Hans
      var exit: RswiftResources.StringResource { .init(key: "Exit", tableName: "Localizable", source: source, developmentValue: "Exit", comment: nil) }

      /// en translation: Favorite
      ///
      /// Key: Favorite
      ///
      /// Locales: en, zh-Hans
      var favorite: RswiftResources.StringResource { .init(key: "Favorite", tableName: "Localizable", source: source, developmentValue: "Favorite", comment: nil) }

      /// en translation: Loading
      ///
      /// Key: Loading
      ///
      /// Locales: en, zh-Hans
      var loading: RswiftResources.StringResource { .init(key: "Loading", tableName: "Localizable", source: source, developmentValue: "Loading", comment: nil) }

      /// en translation: Login
      ///
      /// Key: Login
      ///
      /// Locales: en, zh-Hans
      var login: RswiftResources.StringResource { .init(key: "Login", tableName: "Localizable", source: source, developmentValue: "Login", comment: nil) }

      /// en translation: No
      ///
      /// Key: No
      ///
      /// Locales: en, zh-Hans
      var no: RswiftResources.StringResource { .init(key: "No", tableName: "Localizable", source: source, developmentValue: "No", comment: nil) }

      /// en translation: OK
      ///
      /// Key: OK
      ///
      /// Locales: en, zh-Hans
      var oK: RswiftResources.StringResource { .init(key: "OK", tableName: "Localizable", source: source, developmentValue: "OK", comment: nil) }

      /// en translation: Personal
      ///
      /// Key: Personal
      ///
      /// Locales: en, zh-Hans
      var personal: RswiftResources.StringResource { .init(key: "Personal", tableName: "Localizable", source: source, developmentValue: "Personal", comment: nil) }

      /// en translation: Confirm logout？
      ///
      /// Key: Sheet.Logout.Message
      ///
      /// Locales: en, zh-Hans
      var sheetLogoutMessage: RswiftResources.StringResource { .init(key: "Sheet.Logout.Message", tableName: "Localizable", source: source, developmentValue: "Confirm logout？", comment: nil) }

      /// en translation: Sure
      ///
      /// Key: Sure
      ///
      /// Locales: en, zh-Hans
      var sure: RswiftResources.StringResource { .init(key: "Sure", tableName: "Localizable", source: source, developmentValue: "Sure", comment: nil) }

      /// en translation: Unknown
      ///
      /// Key: Unknown
      ///
      /// Locales: en, zh-Hans
      var unknown: RswiftResources.StringResource { .init(key: "Unknown", tableName: "Localizable", source: source, developmentValue: "Unknown", comment: nil) }

      /// en translation: Yes
      ///
      /// Key: Yes
      ///
      /// Locales: en, zh-Hans
      var yes: RswiftResources.StringResource { .init(key: "Yes", tableName: "Localizable", source: source, developmentValue: "Yes", comment: nil) }
    }
  }

  /// This `_R.color` struct is generated, and contains static references to 1 colors.
  struct color {
    let bundle: Foundation.Bundle

    /// Color `AccentColor`.
    var accentColor: RswiftResources.ColorResource { .init(name: "AccentColor", path: [], bundle: bundle) }
  }

  /// This `_R.image` struct is generated, and contains static references to 12 images.
  struct image {
    let bundle: Foundation.Bundle

    /// Image `AppLogo`.
    var appLogo: RswiftResources.ImageResource { .init(name: "AppLogo", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `about_icon`.
    var about_icon: RswiftResources.ImageResource { .init(name: "about_icon", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `blog_icon`.
    var blog_icon: RswiftResources.ImageResource { .init(name: "blog_icon", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `dashboard_normal_icon`.
    var dashboard_normal_icon: RswiftResources.ImageResource { .init(name: "dashboard_normal_icon", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `dashboard_selected_icon`.
    var dashboard_selected_icon: RswiftResources.ImageResource { .init(name: "dashboard_selected_icon", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `default_circle_icon`.
    var default_circle_icon: RswiftResources.ImageResource { .init(name: "default_circle_icon", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `default_square_icon`.
    var default_square_icon: RswiftResources.ImageResource { .init(name: "default_square_icon", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `favorite_normal_icon`.
    var favorite_normal_icon: RswiftResources.ImageResource { .init(name: "favorite_normal_icon", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `favorite_selected_icon`.
    var favorite_selected_icon: RswiftResources.ImageResource { .init(name: "favorite_selected_icon", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `personal_normal_icon`.
    var personal_normal_icon: RswiftResources.ImageResource { .init(name: "personal_normal_icon", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `personal_parallax_icon`.
    var personal_parallax_icon: RswiftResources.ImageResource { .init(name: "personal_parallax_icon", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }

    /// Image `personal_selected_icon`.
    var personal_selected_icon: RswiftResources.ImageResource { .init(name: "personal_selected_icon", path: [], bundle: bundle, locale: nil, onDemandResourceTags: nil) }
  }

  /// This `_R.file` struct is generated, and contains static references to 2 resource files.
  struct file {
    let bundle: Foundation.Bundle

    /// Resource file `LanguageList.json`.
    var languageListJson: RswiftResources.FileResource { .init(name: "LanguageList", pathExtension: "json", bundle: bundle, locale: LocaleReference.none) }

    /// Resource file `default-v0.realm`.
    var defaultV0Realm: RswiftResources.FileResource { .init(name: "default-v0", pathExtension: "realm", bundle: bundle, locale: LocaleReference.none) }
  }

  /// This `_R.storyboard` struct is generated, and contains static references to 1 storyboards.
  struct storyboard {
    let bundle: Foundation.Bundle
    var launchScreen: launchScreen { .init(bundle: bundle) }

    func launchScreen(bundle: Foundation.Bundle) -> launchScreen {
      .init(bundle: bundle)
    }
    func validate() throws {
      try self.launchScreen.validate()
    }


    /// Storyboard `Launch Screen`.
    struct launchScreen: RswiftResources.StoryboardReference, RswiftResources.InitialControllerContainer {
      typealias InitialController = UIKit.UIViewController

      let bundle: Foundation.Bundle

      let name = "Launch Screen"
      func validate() throws {

      }
    }
  }
}