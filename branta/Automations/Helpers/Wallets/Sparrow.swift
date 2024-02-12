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
            "f81b259799d3dbf7ac75555b59ac719256fcfacb716c653ca445f21f327add5c": "*sparrow_1.8.2-1_arm64.deb",
            
            "b2203fc939ae61068dbd084e256e581b58813019aea8b2c71beb70cfe33ebbe1": "Sparrow-1.8.1-aarch64.dmg",
            "2789804db778f553f3b743fe87eb2affa171f3a427185aba2d902e07a02a1588": "Sparrow-1.8.1-x86_64.dmg",
            "97a0b598b2478d10f3a2da55909caac5ca34fdbe6a71f633374270a63959cd4b": "Sparrow-1.8.1.exe",
            "b9eafe9f49ce7359fb9608508360a575d0433bddf98cfe160e5ad97d7f3212ee": "Sparrow-1.8.1.zip",
            "221e78ee2e564e676662cfafd415d96ca073b2ce888b0b04279890f1f61f673f": "sparrow-1.8.1-1.aarch64.rpm",
            "e6de0ce0f9202ad530cab2a4eb5f4621f8046101292638f440030b0aac2b0194": "sparrow-1.8.1-1.x86_64.rpm",
            "d7f3ed2fd249d5cf003e4a4d0394513e13370d7ae7a97b9a3ff6f733798608c7": "sparrow-1.8.1-aarch64.tar.gz",
            "76960631c958323c6351b21c499ed5e782352d355f1f100a1fdfbb09aa6b0f85": "sparrow-1.8.1-x86_64.tar.gz",
            "3ca9398f99fcf4bcf0f44aec29fcbdeebbb0f916a1ecf4fbe6c6287138d56296": "sparrow-server-1.8.1-1.aarch64.rpm",
            "7d0ed373650bb2bd1f04da03b112394c1396f93e165f5754cda71759f08257c8": "sparrow-server-1.8.1-1.x86_64.rpm",
            "9afcdea9e1693458ff880aab0d5f9a7abdb342ed2cbe8feb2d38d87791fb20aa": "sparrow-server-1.8.1-aarch64.tar.gz",
            "73adfd45b8f8de7ca4b06e3cf91d41f11d69c212c73f52c7ec13afd576d9d393": "sparrow-server-1.8.1-x86_64.tar.gz",
            "d0eb0e51faea8a9dc5d93a5fa53a98f55befab76d52cf9a1892cf7938e33f16b": "sparrow-server_1.8.1-1_amd64.deb",
            "585028517cea29d243ba106c5ebf5e18ba5d5eacb73a94f3ef750025d01a5939": "sparrow-server_1.8.1-1_arm64.deb",
            "acdf80e8a27d619c51e57cc4ebd2c581046a757557c2484e8b3211f2f83e6fcf": "sparrow_1.8.1-1_amd64.deb",
            "9b764b3bb8954dddffe89d94b55310fa4fdcdcfcf46de1b38816919d174d841e": "sparrow_1.8.1-1_arm64.deb",
            
            "a144925d9b58462202dd87100f1e3bc7b135cedaa033f6dd28d2290e4a5c09c8": "Sparrow-1.8.0-aarch64.dmg",
            "72098d503b807268226832f2e883cf2ec862475d849265cad00dbbf3956777d9": "Sparrow-1.8.0-x86_64.dmg",
            "10811c6c7ac2aadab0ed1d1c0b5d8c75dab265d9b05c8bed1a6b8355f988618b": "Sparrow-1.8.0.exe",
            "256733c191a2e979b9573208ff50d1304ff412a4f96d98d6544b3fbf038af056": "Sparrow-1.8.0.zip",
            "f00392d76a93996afa3766751130b8a8b1932ab473f38b406a2ef62b1418c5a3": "sparrow-1.8.0-1.aarch64.rpm",
            "f0b1e1c78bc1994fb35009e6365deef21352f2970012fdcfbe71219985a47e26": "sparrow-1.8.0-1.x86_64.rpm",
            "e253fad2b2a4fc878c2b99d23e761888dcce2532b51bf708d6d7c4ba7895c2c7": "sparrow-1.8.0-aarch64.tar.gz",
            "92c3c26db53bad8b6c9faae90c1b5c05d7f6c819bb8f62a4b6bcea42a5629f39": "sparrow-1.8.0-x86_64.tar.gz",
            "870995972663da8dd1e246bb98558a81da1fb2fb4d776853e1c9f900413ee92d": "sparrow-server-1.8.0-1.aarch64.rpm",
            "5aa057ab4590e87432358978e1a5402f351087e822965511ff3a8257e1ab3ada": "sparrow-server-1.8.0-1.x86_64.rpm",
            "ec46ced8f4eee4212819be7ac40b59fc8219193486e35563ff533d2513fe6766": "sparrow-server-1.8.0-aarch64.tar.gz",
            "129df95b3408379a92f4f69493e2b51df10c3c5dd88c1d0672840048be505c98": "sparrow-server-1.8.0-x86_64.tar.gz",
            "eefbc0ef827361478bf9cbd51d0f00642118332b2191358b6b7e779f8b582a68": "sparrow-server_1.8.0-1_amd64.deb",
            "1a8aec25b5e5673c4864806474a4a96e616d8ceac57561e1023a945c80ad9cc6": "sparrow-server_1.8.0-1_arm64.deb",
            "36ccc6be352c777743132a633e41b6fd7019baa1c54dde5a4e3453cef82f6919": "sparrow_1.8.0-1_amd64.deb",
            "eef111ec28ed72ef6514f7875bd1e7344395684f2a1c98c315dc9dd48a0b8118": "sparrow_1.8.0-1_arm64.deb",
            
            "b6a6d7b99f35449ac8da0802ad5bcd987396ac494e6762f54c0aa4413f8e9dc2": "Sparrow-1.7.9-aarch64.dmg",
            "d04baf2de6ba22162b6cf874e8876c1a03370e9617d9cda4f3e6a63ff4795424": "Sparrow-1.7.9-x86_64.dmg",
            "22457f2c6882663194a39f8d705195dcc2599f8cca2273b2db95057db0fcfc51": "Sparrow-1.7.9.exe",
            "0f664c48ebb4fc22bb7c8a1188be56d4558085883a02abcb69682e2fe2ca646b": "Sparrow-1.7.9.zip",
            "9132535b10c0e5d10b375697eaa4b7ab39bc5c167b7204e307e7252e6d163e0a": "sparrow-1.7.9-1.aarch64.rpm",
            "fad0c35dbabf57e3059fd66e73b8756788213c665246d2008b548cb055619757": "sparrow-1.7.9-1.x86_64.rpm",
            "8803b8a881cfd3257bf00ecb720f8d43bbab2fb057d59e6e503ffe79701f1231": "sparrow-1.7.9-aarch64.tar.gz",
            "5eab87da652fbf4ed33438d7d7f23b258b5c48b4912c6a4f6f0a7f5d4dafe82f": "sparrow-1.7.9-x86_64.tar.gz",
            "a6f3c8f733db73e2644042c6d4544a95a1018822e87a2354d3b86655c7481a40": "sparrow-server-1.7.9-1.aarch64.rpm",
            "cc1d1a4975dd1bc760f252ec188674a3d2a58dfc035ad292eed78d6f1342fdea": "sparrow-server-1.7.9-1.x86_64.rpm",
            "d8b0be29bef67e4d998ab4dcdca95d46072d01036810019670fe6dca14453efb": "sparrow-server-1.7.9-aarch64.tar.gz",
            "95fe86fa7582fe6a064b30d1d889c2f41e9e7984529b2c9e62c9629e499cb723": "sparrow-server-1.7.9-x86_64.tar.gz",
            "d24ac4739ee6a7868ece72f6a65557bc950371e28a6869ca62abee63a13e72e3": "sparrow-server_1.7.9-1_amd64.deb",
            "3656e6f97386c29021ff62eabb1e058dcb8768deec4bd91c89bea0dce823975f": "sparrow-server_1.7.9-1_arm64.deb",
            "2fe964c29ed2dc9101d937a14d7d2749ba14f414dc7d4b3da1dd40454477a7ab": "sparrow_1.7.9-1_amd64.deb",
            "30a172ec9261a6eec4ef636afc58dc7cfad655c0bb6b81037786935f274c502d": "sparrow_1.7.9-1_arm64.deb",
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
