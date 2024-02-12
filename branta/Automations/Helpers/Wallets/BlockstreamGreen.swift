//
//  BlockstreamGreen.swift
//  Branta
//
//  Created by Keith Gardner on 1/10/24.
//

/*
 Note - Blockstream uses universal binary. These hashes are same across x86/arm
 
 $ lipo -archs Blockstream\ Green
 x86_64 arm64
 */

class BlockstreamGreen: Wallet {
    override class func runtimeName() -> String {
        return "Blockstream Green"
    }
    
    override class func name() -> String {
        return "Blockstream Green.app"
    }
    
    override class func x86() -> [String:String] {
        return [
            "1.2.9": "6026166039a2722182fb39ea16fafb83cbcf5c0947bc79afc9a2474665820e76",
            "1.2.8": "a501734a4e2b0258dbae931c18c8255a544bce2f4c5c4bf19e4222df00f839ee",
            "1.2.7": "043c911fc32fef36ad9468a4d20f77b1bad987d25c8d40142a98065ed4d0984c",
            "1.2.6": "e3ee45b128acf07303a81609bf67cec1a6b6f6643a8402bc98609741d05bf33f",
            "1.2.5": "38250937994bf4d173d1c18874258e18ce3802806afa172ab1838409ff137716",
            "1.2.4": "66d6c4d677d2295035fd2f0e5ea38d4f04d1f6b71a8930520d3417c88111947f"
        ]
    }
    
    override class func arm() -> [String:String] {
        return [
            "1.2.9": "6026166039a2722182fb39ea16fafb83cbcf5c0947bc79afc9a2474665820e76",
            "1.2.8": "a501734a4e2b0258dbae931c18c8255a544bce2f4c5c4bf19e4222df00f839ee",
            "1.2.7": "043c911fc32fef36ad9468a4d20f77b1bad987d25c8d40142a98065ed4d0984c",
            "1.2.6": "e3ee45b128acf07303a81609bf67cec1a6b6f6643a8402bc98609741d05bf33f",
            "1.2.5": "38250937994bf4d173d1c18874258e18ce3802806afa172ab1838409ff137716",
            "1.2.4": "66d6c4d677d2295035fd2f0e5ea38d4f04d1f6b71a8930520d3417c88111947f"
        ]
    }
    
    // Standard SHA 256 from manifest
    override class func installerHashes() -> [String:String] {
        return [
            // 1.2.9
            "6c28ed9f08c2bfdd1a9ccb5da26ab27549d3d95ac791e013c3316264a0b7a2eb":  "BlockstreamGreen_Windows_x86_64.zip",
            "1b8589bc997016087ba27ef28f2026626834c91af525ca88bd3841bafcbe4c06":  "BlockstreamGreen_MacOS_x86_64.zip",
            "f7bbc3333012ffd8a3512ede7415169329b4010cfe9f96ae6e1a92268236a52e":  "BlockstreamGreen-x86_64.AppImage",
            "19e24095367acf1eb94818c4d67ccabc9e86f5e128edbb05f586bd6bae844822":  "BlockstreamGreen_Linux_x86_64.tar.gz",
            
            // 1.2.8
            "47d394ef3beaf96b77f2210e796be0a41c70afb9109b3b069655abeacdc485d0": "BlockstreamGreen_Windows_x86_64.zip",
            "9bfee4300aefc6f518f181c83e4af21bbdab7ae8b3fd8e334ea3fbe2c4a3b5ee": "BlockstreamGreen_MacOS_x86_64.zip",
            "52589b48279960057db48e80cdcff9a26966cf76dcf75910cdd72e7e554b49f1": "BlockstreamGreen-x86_64.AppImage",
            "66c354b0d3bd26fc582815c4dfbe14e2232bb5e964277a2f1604a719c2593cc2": "BlockstreamGreen_Linux_x86_64.tar.gz",
            
            // 1.2.7
            "373b459952a8acecb4d13a6958df861df50b7ecec1876220025ecf5fb61adedb": "BlockstreamGreen_Windows_x86_64.zip",
            "692496addde67c052d1db051498c261dc4528ffc4c9e5de35629d645182d7171": "BlockstreamGreen_MacOS_x86_64.zip",
            "7221cb0211d5b31ca73440cada498020823718427296f16c599ea9660276be54": "BlockstreamGreen-x86_64.AppImage",
            "7cb7ce8659a778919327a702f3b4b37d17bec4d9d0dbf4f9c9cae4361e418758": "BlockstreamGreen_Linux_x86_64.tar.gz",
            
            // 1.2.6
            "5b1420b5215334be3ef37bd500deab7c5c00b8ab8007e16c3a344d1aa714cb00": "BlockstreamGreen_Windows_x86_64.zip",
            "9110ba0f1490a3baedbaaaec9c4a7bf8f511bb9c1f2f81655e6be6ee1c71b40b": "BlockstreamGreen_MacOS_x86_64.zip",
            "cf57b16498e8a9e1607b556a107973e39c4bca0222cc16fb1402fd78f16c418d": "BlockstreamGreen-x86_64.AppImage",
            "073ec6a37e26d63c693afdce7aa047d3d1c966519c490b8b4fb45190303faa70": "BlockstreamGreen_Linux_x86_64.tar.gz"
        ]
    }
}
