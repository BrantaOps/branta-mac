//
//  Sparrow.swift
//  branta
//
//  Created by Keith Gardner on 11/17/23.
//
//

class Sparrow: Wallet {
    
    override class func runtimeName() -> String {
        return "Sparrow"
    }
    
    override class func name() -> String {
        return "Sparrow.app"
    }
    
    override class func x86() -> [String:String] {
        return [
            "1.8.1":"a35554c23d8e324f8e4226e15ad0b6d4a71da4f47c5a219b6b1b395472f57422",
            "1.8.0":"cd4ed0b38d94d6a9fb32effa0ee1700eed4cfc6306fd3c29cd87637b7a40519e",
            "1.7.9":"ba0c91af54e327a3acb9f3afc61aed19f2321c73e5a6a7733292727201d3a9c6",
            "1.7.8":"9ad69a2f0bc9d7089627398d8159532f9c27a13216c43610ec7a63097f5aeb1a",
            "1.7.7":"b9f6551a6ac55745bbb2989fae8f06d8b1e4938a06e5142d4927da51a6a87505",
            "1.7.6":"9a3df1b18e58ac6ba95eb50cfcb819672a69d68725f0e305df41d085d0adf56c",
            "1.7.5":"17ff3d80d5d0616a03a3beaa5417433d4b7d1a1b712807686bdd9bc8875a5348",
            "1.7.4":"efc69dfd54f2435b55c1f7195896085de58579bdc2acec4b11907835a4539fcd",
            "1.7.3":"ede392db8b50a58713e612fb8b0238320bbbd2053454fcc1a4a5bda5c88c592b",
            "1.7.2":"42bc031e1eb6e4a21b918014a9fe8505a48e2dbce5d54630c07df8d436ee78b2",
            "1.7.1":"c30fcb83b56f9f44dd040dd092efad942d089866418269d2411a48465ef7410c",
            "1.7.0":"4d772e2c42ae9b3a2fa32c81c86c0ab693a7b622463e98ed6e44b3b9171ab83f",
            "1.6.6":"b74fbea448d0d1b5d6cdaf827c49354974ca8c65e9809c96632b35bd3074a2db",
            "1.6.5":"e51308a58e0c079f2c76d4fa1ee775d253cdbcb5c8c938abc093b56229bda57f",
            "1.6.4":"e0e70d1160dcf2e8a0f4c9479f5160818337cac295da37fd53739e47031f1870",
            "1.6.3":"c9ebc422fed51111a211f645ab1496dc639fc80c75e18af70bdac91d9072594c",
            "1.6.2":"bdb27bedcf6396e4a007f64122155a2ea92804f88da16ee726b211a4c3d71d7e",
            "1.6.1":"766a8c08b6610b9d80a6538a3ec78d56c3a19cd59eb01efc5df94daf4c863dcb",
            "1.6.0":"44c4b5700a44ad20db7bd330262d8f945db05fdacd52f27a7020ea90fa106e92",
            "1.5.6":"cca2553f37f94df3f349696e73e4f67b06bcdf95f3a9f0ffd441b37b1d035579",
            "1.5.5":"d1d3caaf73368ca31ff1d15fd40e5439fd9dc2c7c95ab69d46f6e49e92d4e151"
        ]
    }
    
    override class func arm() -> [String:String] {
        return [
            "1.8.1":"c40b1533969a467f9ee7ce86c09d75ae0218127dc74c0554059df22ce5b23f87",
            "1.8.0":"50197b7d0952c211997f7f7633fd9e7ee427da1dfb0c443585eb413bad607c29",
            "1.7.9":"4804d0dd0f72dfcf02b05a657aba649c442141dcb3b9c027390f4a60e994cf9f",
        ]
    }
    
    override class func installerHashes() -> [String:String] {
        return [
            "541b82e83ec928e7b54490211fa5e9d3b315394d895aebeab9a9696ce24c378d": "*Sparrow-1.8.2-aarch64.dmg",
            "508a5ba212c2393a9d4cd122c2a8aa8b16e593c640bc3e4ac111ee574b2fd82d": "*Sparrow-1.8.2-x86_64.dmg",
            "1035fc5663e53ce3a7d87a63a1dadc33bb180ceb3154549b251407b09db202b7": "*Sparrow-1.8.2.exe",
            "8ff8e70886af91c8758509097a1047a05341b29a2407934c49b6885ff71c60c2": "*Sparrow-1.8.2.zip",
            "afee92405d3013d24add5e3099cea86f5201829b8f5f485f26b753af109619b9": "*sparrow-1.8.2-1.aarch64.rpm",
            "22b72b62865d8e9d0dcf71dc0907a3945f7a5c859257db4f05ee5b815c4bc56d": "*sparrow-1.8.2-1.x86_64.rpm",
            "97d43340c6938dbd513c62e3528ae61f57cefe308cd950b0d0cf3f7a3a36993f": "*sparrow-1.8.2-aarch64.tar.gz",
            "ffb7f86e978ab312dcc169d7c70b33048256dcf3280aecb1cb9392124eac31b9": "*sparrow-1.8.2-x86_64.tar.gz",
            "e69873062837f90745b384d53afeb590cb0058061da3148cbad35604b3e4b1bd": "*sparrow-server-1.8.2-1.aarch64.rpm",
            "3fb4900e078427c230dd1372e1b56abdaa71653c5247d6ca4605e9fdda90bffe": "*sparrow-server-1.8.2-1.x86_64.rpm",
            "6278fe3b8261576bb9e597ac0e1a5305781917a6716dfc8c5ebb8b244c1a8805": "*sparrow-server-1.8.2-aarch64.tar.gz",
            "0f2025a3fee1057fef763ff1ead471b4468766c0db99e07d8cd1de26e359852d": "*sparrow-server-1.8.2-x86_64.tar.gz",
            "c538a93d22698a46218859fbf936731484683e188da33a2e35dac053388a5e14": "*sparrow-server_1.8.2-1_amd64.deb",
            "817469b84741832d4b58b0f6305139cf740ba6b91ca9ff5e65dac75f1fa0221e": "*sparrow-server_1.8.2-1_arm64.deb",
            "ef461e5b75681e39fde235ee75d0bb23d4cfbeb30c312383f17596115d0a9188": "*sparrow_1.8.2-1_amd64.deb",
            "f81b259799d3dbf7ac75555b59ac719256fcfacb716c653ca445f21f327add5c": "*sparrow_1.8.2-1_arm64.deb"


        ]
    }
}



/*
 Sparrow links out to many libs. We could hash all of these as well.
 $ ls -lh *.dylib
 -rw-r--r--@ 1 keithgardner  admin   632K Nov 22 03:53 libawt.dylib
 -rw-r--r--@ 1 keithgardner  admin   1.1M Nov 22 03:53 libawt_lwawt.dylib
 -rw-r--r--@ 1 keithgardner  admin   1.6M Nov 22 03:53 libfontmanager.dylib
 -rw-r--r--@ 1 keithgardner  admin   664K Nov 22 03:53 libfreetype.dylib
 -rw-r--r--@ 1 keithgardner  admin    37K Nov 22 03:53 libj2pcsc.dylib
 -rw-r--r--@ 1 keithgardner  admin    95K Nov 22 03:53 libj2pkcs11.dylib
 -rw-r--r--@ 1 keithgardner  admin   171K Nov 22 03:53 libjava.dylib
 -rw-r--r--@ 1 keithgardner  admin   247K Nov 22 03:53 libjavajpeg.dylib
 -rw-r--r--@ 1 keithgardner  admin    27K Nov 22 03:53 libjawt.dylib
 -rw-r--r--@ 1 keithgardner  admin    47K Nov 22 03:53 libjimage.dylib
 -rw-r--r--@ 1 keithgardner  admin    83K Nov 22 03:53 libjli.dylib
 -rw-r--r--@ 1 keithgardner  admin    28K Nov 22 03:53 libjsig.dylib
 -rw-r--r--@ 1 keithgardner  admin   104K Nov 22 03:53 libjsound.dylib
 -rw-r--r--@ 1 keithgardner  admin   426K Nov 22 03:53 liblcms.dylib
 -rw-r--r--@ 1 keithgardner  admin    38K Nov 22 03:53 libmanagement.dylib
 -rw-r--r--@ 1 keithgardner  admin   620K Nov 22 03:53 libmlib_image.dylib
 -rw-r--r--@ 1 keithgardner  admin    77K Nov 22 03:53 libnet.dylib
 -rw-r--r--@ 1 keithgardner  admin    83K Nov 22 03:53 libnio.dylib
 -rw-r--r--@ 1 keithgardner  admin    39K Nov 22 03:53 libosx.dylib
 -rw-r--r--@ 1 keithgardner  admin   148K Nov 22 03:53 libosxapp.dylib
 -rw-r--r--@ 1 keithgardner  admin    40K Nov 22 03:53 libosxsecurity.dylib
 -rw-r--r--@ 1 keithgardner  admin    58K Nov 22 03:53 libosxui.dylib
 -rw-r--r--@ 1 keithgardner  admin    44K Nov 22 03:53 libprefs.dylib
 -rw-r--r--@ 1 keithgardner  admin   376K Nov 22 03:53 libsplashscreen.dylib
 -rw-r--r--@ 1 keithgardner  admin    71K Nov 22 03:53 libverify.dylib
 -rw-r--r--@ 1 keithgardner  admin    53K Nov 22 03:53 libzip.dylib
 */
