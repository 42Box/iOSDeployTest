How are we using it
----

# Installation by Github Action

```sh
jobs:
  build:
    name: Deploy on macOS latest - Release for iOS
    runs-on: macos-latest
    env:
      RUBY_VERSION: "2.6.10"
      TUIST_VERSION: "3.36.2"

    steps:
      - name: Set up Ruby 2.6
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: ${{ env.RUBY_VERSION }}
          bundler-cache: true

      - name: Install Fastlane
        run: brew install fastlane

      - name: Set Keychain
        run: fastlane set_keychain
        env:
            KEYCHAIN_NAME: ${{ secrets.KEYCHAIN_NAME }}
            KEYCHAIN_PASSWORD: ${{ secrets.KEYCHAIN_PASSWORD }}

      - name: Fastlane run
        run: fastlane tf
```

# Used

```ruby
# Constants
APP_NAME = "iBox"
SCHEME = "iBox"
BUNDLE_ID = "com.box42.iBox"

KEYCHAIN_NAME = ENV["KEYCHAIN_NAME"]
KEYCHAIN_PASSWORD = ENV["KEYCHAIN_PASSWORD"]

default_platform(:ios)
```

# Available Actions

## iOS

### ios set_keychain

```ruby
# Keychain
  desc "Save To Keychain"
  lane :set_keychain do |options|
    create_keychain(
      name: "#{KEYCHAIN_NAME}",
      password: "#{KEYCHAIN_PASSWORD}",
      default_keychain: true,
      unlock: true,
      timeout: 3600,
      lock_when_sleeps: true
    )

    import_certificate(
      certificate_path: "Tuist/Signing/release.cer",
      keychain_name: "#{KEYCHAIN_NAME}",
      keychain_password: "#{KEYCHAIN_PASSWORD}"
    )

    import_certificate(
      certificate_path: "Tuist/Signing/release.p12",
      keychain_name: "#{KEYCHAIN_NAME}",
      keychain_password: "#{KEYCHAIN_PASSWORD}"
    )

    install_provisioning_profile(path: "Tuist/Signing/#{APP_NAME}.Release.mobileprovision")
  end
```

Save To Keychain

### ios tf

```ruby
# Upload TestFlight
  desc "Push to TestFlight"
  lane :tf do |options|
    # AppStore Connect API key
    app_store_connect_api_key(is_key_content_base64: true, in_house: false)

    # BuildNumber Up
    increment_build_number({ build_number: latest_testflight_build_number() + 1 })

    # Build App
    build_app(
      workspace: "#{APP_NAME}.xcworkspace",
      scheme: "#{SCHEME}",
      export_method: "app-store"
    )

    # Upload to TestFlight
    upload_to_testflight(skip_waiting_for_build_processing: true)
  end
```

Push to TestFlight

----
