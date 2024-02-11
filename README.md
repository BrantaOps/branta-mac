<picture>
  <source media="(prefers-color-scheme: dark)" srcset="branta/Assets.xcassets/goldwhitecropped.imageset/goldwhitecropped.png">
  <source media="(prefers-color-scheme: light)" srcset="branta/Assets.xcassets/goldblackcropped.imageset/goldblackcropped.jpeg">
  <img alt="Branta" src="Branta/Assets/goldblackcropped.jpg">
</picture>

## Features
 - ✅ Wallet Verification: Automatically verifies supported wallets against PGP verified SHA-256 checksums
 - ✅ Clipboard Guardian: Get notified of bitcoin-related activity on your clipboard
 - ✅ Focus Automation: Verify wallets upon launch
 - - [ ] Installer Automation
  
  <img width="873" alt="Screen Shot 2024-02-04 at 10 55 43 AM" src="https://github.com/BrantaOps/branta-mac/assets/74844722/75644c8e-591e-4871-a48c-161a4f9ae209">


#### Supported Wallets
- ✅ Sparrow
- ✅ Ledger
- ✅ Trezor
- ✅ Wasabi
- ✅ Blockstream Green
- ✅ Whirlpool

## Known Limitations

- Spoof Wallets likely install to custom paths. Branta needs to have more flexible path scanning to catch these.
- Ongoing wallet support - Branta doesn't know about new releases unless we manually input them.

## External dependencies

Zero network calls, zero dependencies. 

Branta uses no external dependencies; Branta-Mac is purely native Swift.

## Building
- XCode 14

## Feature Requests & Bug Reporting

Open a [new issue](https://github.com/BrantaOps/branta-mac/issues/new) on Github and we'll reply as soon as we can.

## Policy on Altcoins/Altchains

Branta is Bitcoin-only. Enduring Bitcoin products are difficult to build; adding support for the unstable, poorly designed altcoin ecosystem is a lose-lose proposition.

## Licensing

The code in this project is licensed under the [MIT license](LICENSE).
