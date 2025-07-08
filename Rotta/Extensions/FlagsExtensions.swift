//
//  FlagsExtensions.swift
//  Rotta
//
//  Created by Marcos on 05/07/25.
//

extension String {
    func getCountryFlag() -> String {
        let country = self.lowercased()
        
        let flagMapping: [String: String] = [
            "brazil": "🇧🇷",
            "ireland": "🇮🇪",
            "united kingdom": "🇬🇧",
            "england": "🏴󠁧󠁢󠁥󠁮󠁧󠁿",
            "france": "🇫🇷",
            "spain": "🇪🇸",
            "italy": "🇮🇹",
            "germany": "🇩🇪",
            "netherlands": "🇳🇱",
            "monaco": "🇲🇨",
            "australia": "🇦🇺",
            "argentina": "🇦🇷",
            "colombia": "🇨🇴",
            "sweden": "🇸🇪",
            "india": "🇮🇳",
            "czech republic": "🇨🇿",
            "paraguay": "🇵🇾",
            "mexico": "🇲🇽",
            "japan": "🇯🇵",
            "belgium": "🇧🇪",
            "estonia": "🇪🇪",
            "bulgaria": "🇧🇬",
            "austria": "🇦🇹",
            "finland": "🇫🇮",
            "poland": "🇵🇱",
            "singapore": "🇸🇬",
            "norway": "🇳🇴",
            "denmark": "🇩🇰",
            "thailand": "🇹🇭",
            "united states": "🇺🇸",
            "peru": "🇵🇪",
            "united arab emirates": "🇦🇪",
            "bahrain": "🇧🇭",
            "brasil": "🇧🇷",
            "irlanda":  "🇮🇪",
            "reino unido": "🇬🇧",
            "frança": "🇫🇷",
            "espanha": "🇪🇸",
            "itália": "🇮🇹",
            "alemanha": "🇩🇪",
            "holanda": "🇳🇱",
            "mônaco": "🇲🇨",
            "austrália": "🇦🇺",
            "estados unidos": "🇺🇸",
            "colômbia": "🇨🇴",
            "suécia": "🇸🇪",
            "índia": "🇮🇳",
            "república tcheca": "🇨🇿",
            "paraguai": "🇵🇾",
            "méxico": "🇲🇽",
            "japão": "🇯🇵",
            "bélgica": "🇧🇪",
            "estônia": "🇪🇪",
            "bulgária": "🇧🇬",
            "áustria": "🇦🇹",
            "finlândia": "🇫🇮",
            "polônia": "🇵🇱",
            "singapura": "🇸🇬",
            "noruega": "🇳🇴",
            "dinamarca": "🇩🇰",
            "tailândia": "🇹🇭",
            "emirados árabes unidos": "🇦🇪",
            "uae": "🇦🇪",
            "arábia Saudita": "🇸🇦",
            "azerbaijão": "🇦🇿",
            "hungria": "🇭🇺",
            "uk": "🇬🇧",
            "emirados Árabes Unidos / alemanha": "🇦🇪🇩🇪"
        ]
        
        return flagMapping[country] ?? "🏁"
    }
}
