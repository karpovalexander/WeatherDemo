// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Error
  internal static let error = L10n.tr("Localizable", "error")
  /// OK
  internal static let ok = L10n.tr("Localizable", "ok")

  internal enum Cities {
    /// Cities
    internal static let title = L10n.tr("Localizable", "cities.title")
  }

  internal enum Error {
    /// Something went wrong.
    /// Data can't be reading
    internal static let parsing = L10n.tr("Localizable", "error.parsing")
  }

  internal enum WeatherInfo {
    /// Current temperature
    internal static let currentTemperature = L10n.tr("Localizable", "weather-info.current-temperature")
    /// Description
    internal static let description = L10n.tr("Localizable", "weather-info.description")
    /// Humidity
    internal static let humidity = L10n.tr("Localizable", "weather-info.humidity")
    /// Maximum temperature
    internal static let maxTemperature = L10n.tr("Localizable", "weather-info.max-temperature")
    /// Minimum temperature
    internal static let minTemperature = L10n.tr("Localizable", "weather-info.min-temperature")
    /// Wind speed
    internal static let windSpeed = L10n.tr("Localizable", "weather-info.wind-speed")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
