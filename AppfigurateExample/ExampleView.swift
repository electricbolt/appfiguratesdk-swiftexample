// ExampleView.swift
// SwiftExample Copyright© 2026; Electric Bolt Limited.

import SwiftUI
import AppfigurateLibrary

struct ExampleView: View {
    @State private var refreshID = UUID()

    var body: some View {
        NavigationView {
            List {
                boolSection
                stringSection
                integerSection
                floatSection
                doubleSection
                remoteConfigSection
            }
#if os(iOS)
            .navigationTitle("Swift Example " + APLVersion())
#endif
            .id(refreshID)
            .onReceive(NotificationCenter.default.publisher(for: APLConfigurationUpdatedNotificationName)) { _ in
                refreshID = UUID()
            }
        }
        .navigationViewStyle(.stack)
        .configurationView()
    }

    // MARK: - Bool

    private var boolSection: some View {
        Section("Bool") {
            row("boolean", value: CONFIGURATION().boolean ? "true" : "false")
        }
    }

    // MARK: - String

    private var stringSection: some View {
        Section("String") {
            row("string_Textfield", value: CONFIGURATION().string_Textfield)
            row("string_RegexTextfield", value: CONFIGURATION().string_RegexTextfield)
            row("string_List", value: CONFIGURATION().string_List)
            row("string_Textfield_List", value: CONFIGURATION().string_Textfield_List)
            row("string_RegexTextfield_List", value: CONFIGURATION().string_RegexTextfield_List)
            row("encrypted_string_Textfield_List", value: CONFIGURATION().encrypted_string_Textfield_List)
            row("encrypted_string_RegexTextfield_List", value: CONFIGURATION().encrypted_string_RegexTextfield_List)
        }
    }

    // MARK: - Integer

    private var integerSection: some View {
        Section("Integer") {
            row("integer_Slider", value: "\(CONFIGURATION().integer_Slider)")
            row("integer_Textfield", value: "\(CONFIGURATION().integer_Textfield)")
            row("integer_RegexTextfield", value: "\(CONFIGURATION().integer_RegexTextfield)")
            row("integer_List", value: "\(CONFIGURATION().integer_List)")
            row("integer_Textfield_List", value: "\(CONFIGURATION().integer_Textfield_List)")
            row("integer_RegexTextfield_List", value: "\(CONFIGURATION().integer_RegexTextfield_List)")
        }
    }

    // MARK: - Float

    private var floatSection: some View {
        Section("Float") {
            row("float_Slider", value: "\(CONFIGURATION().float_Slider)")
            row("float_Textfield", value: "\(CONFIGURATION().float_Textfield)")
            row("float_RegexTextfield", value: "\(CONFIGURATION().float_RegexTextfield)")
            row("float_List", value: "\(CONFIGURATION().float_List)")
            row("float_Textfield_List", value: "\(CONFIGURATION().float_Textfield_List)")
            row("float_RegexTextfield_List", value: "\(CONFIGURATION().float_RegexTextfield_List)")
        }
    }

    // MARK: - Double

    private var doubleSection: some View {
        Section("Double") {
            row("double_Slider", value: "\(CONFIGURATION().double_Slider)")
            row("double_Textfield", value: "\(CONFIGURATION().double_Textfield)")
            row("double_RegexTextfield", value: "\(CONFIGURATION().double_RegexTextfield)")
            row("double_List", value: "\(CONFIGURATION().double_List)")
            row("double_Textfield_List", value: "\(CONFIGURATION().double_Textfield_List)")
            row("double_RegexTextfield_List", value: "\(CONFIGURATION().double_RegexTextfield_List)")
        }
    }

    // MARK: - Remote Config

    private var remoteConfigSection: some View {
        Section("Remote Config") {
            row("alwaysDarkMode", value: CONFIGURATION().alwaysDarkMode ? "true" : "false")
            row("appTitle", value: CONFIGURATION().appTitle)
            row("fontSize", value: "\(CONFIGURATION().fontSize)")
            row("bookingDuration", value: "\(CONFIGURATION().bookingDuration)")
        }
    }

    // MARK: - Row

    private func row(_ title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
            Text(value)
                .font(.caption)
                .foregroundStyle(.secondary)
                .accessibilityIdentifier("\(title)_value")
        }
    }
}
