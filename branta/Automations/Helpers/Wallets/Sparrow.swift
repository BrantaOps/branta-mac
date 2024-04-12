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
            "1.8.4":"ecced5bd2cef9e861c2ec2f0c9c997edb67542bf980e8e8ba4f4eab6d941f393",
            "1.8.3":"0c3d33dcee976d7726d048d0fb8916429768c10740d3bdd4f113fa7eee7cf09b",
            "1.8.2":"c82536ca87e8e40184be6cec4f64bea60666573428c41f6d004342445733b41f",
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
        ]
    }
    
    override class func arm() -> [String:String] {
        return [
            "1.8.4":"c45b0ff26a69df91adc1368e6f24265a2a066973e0fa026e6416feda551aac54",
            "1.8.3":"f374a2e7064a39bebbc2702e746e186fdb3849f2ba224fbe8c5824806f8d745c",
            "1.8.2":"11a261ee06509071e181892c0d531b4aa94a35269bb56fc8ad2d8427c1ec2dc5",
            "1.8.1":"c40b1533969a467f9ee7ce86c09d75ae0218127dc74c0554059df22ce5b23f87",
            "1.8.0":"50197b7d0952c211997f7f7633fd9e7ee427da1dfb0c443585eb413bad607c29",
            "1.7.9":"4804d0dd0f72dfcf02b05a657aba649c442141dcb3b9c027390f4a60e994cf9f",
        ]
    }
}
