<picture>
  <source media="(prefers-color-scheme: dark)" srcset="branta/Assets.xcassets/goldwhitecropped.imageset/goldwhitecropped.png">
  <source media="(prefers-color-scheme: light)" srcset="branta/Assets.xcassets/goldblackcropped.imageset/goldblackcropped.jpeg">
  <img alt="Branta" src="Branta/Assets/goldblackcropped.jpg">
</picture>

## Features
 - ✅ Wallet Verification
   - Automatically verifies supported wallets against PGP verified SHA-256 checksums
 - ✅ Clipboard Guardian
   - Get notified of bitcoin-related activity on your clipboard
 - ✅ Focus Automation
   - Verify Wallets upon launch & Notify User
 - ✅ Drag & Drop PGP Verification for Installers
   - Skip importing authors PGP keys & running SHA256 manually before install (Sparrow, Blockstream)
  
  <img width="873" alt="Screen Shot 2024-02-04 at 10 55 43 AM" src="https://github.com/BrantaOps/branta-mac/assets/74844722/75644c8e-591e-4871-a48c-161a4f9ae209">


#### Supported Wallets
- ✅ Sparrow
- ✅ Ledger
- ✅ Trezor
- ✅ Wasabi
- ✅ Blockstream Green
- ✅ Whirlpool

## Installing

- Visit https://www.branta.pro/download to download the Branta.dmg.zip
- Double click the .dmg
- In the window that opens, drag the Branta Icon to Applications
- Double click Branta (Allow to open under Security & Privacy)
- Allow Notifcations
<img width="400" alt="Screen Shot 2024-02-10 at 10 01 44 PM" src="https://github.com/BrantaOps/branta-mac/assets/74844722/2d678f46-ffd5-4362-8f59-302b740c5b20">

<img width="400" alt="Screen Shot 2024-02-10 at 10 02 31 PM" src="https://github.com/BrantaOps/branta-mac/assets/74844722/c15f30cb-cbc7-4814-a095-07d122fbb7f7">


## Known Limitations

- Spoof Wallets likely install to custom paths. Branta needs to have more flexible path scanning to catch these.
- Ongoing wallet support - Branta doesn't know about new releases unless we manually input them.


## Building
- XCode 14

## Feature Requests & Bug Reporting

Open a [new issue](https://github.com/BrantaOps/branta-mac/issues/new) on Github and we'll reply as soon as we can.

## Policy on Altcoins/Altchains

Branta is Bitcoin-only. Enduring Bitcoin products are difficult to build; adding support for the unstable, poorly designed altcoin ecosystem is a lose-lose proposition.

## Licensing

The code in this project is licensed under the [MIT license](LICENSE).
