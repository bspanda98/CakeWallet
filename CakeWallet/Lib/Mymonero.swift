import Foundation

func swapEndianBytes(for string: String) -> String {
    guard string.count == 8 else {
        return ""
    }
    
    return "\(string[6..<8])\(string[4..<6])\(string[2..<4])\(string[0..<2])"
}


func mndecode(seed: String, wordset: Wordset = englishWordset) -> String {
    let n = wordset.words.count
    var out = ""
    var wlist = seed.components(separatedBy: " ")
    //    print("wordset.tructWords")
    //    print(wordset.tructWords)
    var checksumWord = wlist.popLast()! // hardcoded value for english
    
    
    for i in stride(from: 0, to: wlist.count, by: 3) {
        let w1 = Int(wordset.tructWords.index(of: String(wlist[i][0..<wordset.prefixLength]))!)
        let w2 = Int(wordset.tructWords.index(of: String(wlist[i + 1][0..<wordset.prefixLength]))!)
        let w3 = Int(wordset.tructWords.index(of: String(wlist[i + 2][0..<wordset.prefixLength]))!)
        
        guard (w1 != -1 || w2 != -1 || w3 != -1) else {
            print("invalid word in mnemonic")
            return ""
        }
        
        let x = w1 + n * (((n - w1) + w2) % n) + n * n * (((n - w2) + w3) % n)
        
        guard x % n == w1 else {
            print("Something went wrong when decoding your private key, please try again")
            return ""
        }
        
        let res: String = {
            let _res = "0000000" +  String(x, radix: 16)
            let start = _res.count - 8
            let end = _res.count
            return String(_res[start..<end])
        }()
        
        out += swapEndianBytes(for: res)
    }
    
    return out
}

class Wordset {
    let prefixLength: Int
    let words: [String]
    
    private(set) lazy var tructWords: [String] = {
        let start = 0
        let end = prefixLength
        
        return words.map {
            return String($0[start..<end])
        }
    }()
    
    init(words: [String], prefixLength: Int) {
        self.words = words
        self.prefixLength = prefixLength
    }
}

let englishWordset = Wordset(words: englistWords, prefixLength: 3)

let englistWords = ["abbey", "abducts", "ability", "ablaze", "abnormal", "abort", "abrasive", "absorb",
                    "abyss", "academy", "aces", "aching", "acidic", "acoustic", "acquire", "across",
                    "actress", "acumen", "adapt", "addicted", "adept", "adhesive", "adjust", "adopt",
                    "adrenalin", "adult", "adventure", "aerial", "afar", "affair", "afield", "afloat",
                    "afoot", "afraid", "after", "against", "agenda", "aggravate", "agile", "aglow",
                    "agnostic", "agony", "agreed", "ahead", "aided", "ailments", "aimless", "airport",
                    "aisle", "ajar", "akin", "alarms", "album", "alchemy", "alerts", "algebra",
                    "alkaline", "alley", "almost", "aloof", "alpine", "already", "also", "altitude",
                    "alumni", "always", "amaze", "ambush", "amended", "amidst", "ammo", "amnesty",
                    "among", "amply", "amused", "anchor", "android", "anecdote", "angled", "ankle",
                    "annoyed", "answers", "antics", "anvil", "anxiety", "anybody", "apart", "apex",
                    "aphid", "aplomb", "apology", "apply", "apricot", "aptitude", "aquarium", "arbitrary",
                    "archer", "ardent", "arena", "argue", "arises", "army", "around", "arrow",
                    "arsenic", "artistic", "ascend", "ashtray", "aside", "asked", "asleep", "aspire",
                    "assorted", "asylum", "athlete", "atlas", "atom", "atrium", "attire", "auburn",
                    "auctions", "audio", "august", "aunt", "austere", "autumn", "avatar", "avidly",
                    "avoid", "awakened", "awesome", "awful", "awkward", "awning", "awoken", "axes",
                    "axis", "axle", "aztec", "azure", "baby", "bacon", "badge", "baffles",
                    "bagpipe", "bailed", "bakery", "balding", "bamboo", "banjo", "baptism", "basin",
                    "batch", "bawled", "bays", "because", "beer", "befit", "begun", "behind",
                    "being", "below", "bemused", "benches", "berries", "bested", "betting", "bevel",
                    "beware", "beyond", "bias", "bicycle", "bids", "bifocals", "biggest", "bikini",
                    "bimonthly", "binocular", "biology", "biplane", "birth", "biscuit", "bite", "biweekly",
                    "blender", "blip", "bluntly", "boat", "bobsled", "bodies", "bogeys", "boil",
                    "boldly", "bomb", "border", "boss", "both", "bounced", "bovine", "bowling",
                    "boxes", "boyfriend", "broken", "brunt", "bubble", "buckets", "budget", "buffet",
                    "bugs", "building", "bulb", "bumper", "bunch", "business", "butter", "buying",
                    "buzzer", "bygones", "byline", "bypass", "cabin", "cactus", "cadets", "cafe",
                    "cage", "cajun", "cake", "calamity", "camp", "candy", "casket", "catch",
                    "cause", "cavernous", "cease", "cedar", "ceiling", "cell", "cement", "cent",
                    "certain", "chlorine", "chrome", "cider", "cigar", "cinema", "circle", "cistern",
                    "citadel", "civilian", "claim", "click", "clue", "coal", "cobra", "cocoa",
                    "code", "coexist", "coffee", "cogs", "cohesive", "coils", "colony", "comb",
                    "cool", "copy", "corrode", "costume", "cottage", "cousin", "cowl", "criminal",
                    "cube", "cucumber", "cuddled", "cuffs", "cuisine", "cunning", "cupcake", "custom",
                    "cycling", "cylinder", "cynical", "dabbing", "dads", "daft", "dagger", "daily",
                    "damp", "dangerous", "dapper", "darted", "dash", "dating", "dauntless", "dawn",
                    "daytime", "dazed", "debut", "decay", "dedicated", "deepest", "deftly", "degrees",
                    "dehydrate", "deity", "dejected", "delayed", "demonstrate", "dented", "deodorant", "depth",
                    "desk", "devoid", "dewdrop", "dexterity", "dialect", "dice", "diet", "different",
                    "digit", "dilute", "dime", "dinner", "diode", "diplomat", "directed", "distance",
                    "ditch", "divers", "dizzy", "doctor", "dodge", "does", "dogs", "doing",
                    "dolphin", "domestic", "donuts", "doorway", "dormant", "dosage", "dotted", "double",
                    "dove", "down", "dozen", "dreams", "drinks", "drowning", "drunk", "drying",
                    "dual", "dubbed", "duckling", "dude", "duets", "duke", "dullness", "dummy",
                    "dunes", "duplex", "duration", "dusted", "duties", "dwarf", "dwelt", "dwindling",
                    "dying", "dynamite", "dyslexic", "each", "eagle", "earth", "easy", "eating",
                    "eavesdrop", "eccentric", "echo", "eclipse", "economics", "ecstatic", "eden", "edgy",
                    "edited", "educated", "eels", "efficient", "eggs", "egotistic", "eight", "either",
                    "eject", "elapse", "elbow", "eldest", "eleven", "elite", "elope", "else",
                    "eluded", "emails", "ember", "emerge", "emit", "emotion", "empty", "emulate",
                    "energy", "enforce", "enhanced", "enigma", "enjoy", "enlist", "enmity", "enough",
                    "enraged", "ensign", "entrance", "envy", "epoxy", "equip", "erase", "erected",
                    "erosion", "error", "eskimos", "espionage", "essential", "estate", "etched", "eternal",
                    "ethics", "etiquette", "evaluate", "evenings", "evicted", "evolved", "examine", "excess",
                    "exhale", "exit", "exotic", "exquisite", "extra", "exult", "fabrics", "factual",
                    "fading", "fainted", "faked", "fall", "family", "fancy", "farming", "fatal",
                    "faulty", "fawns", "faxed", "fazed", "feast", "february", "federal", "feel",
                    "feline", "females", "fences", "ferry", "festival", "fetches", "fever", "fewest",
                    "fiat", "fibula", "fictional", "fidget", "fierce", "fifteen", "fight", "films",
                    "firm", "fishing", "fitting", "five", "fixate", "fizzle", "fleet", "flippant",
                    "flying", "foamy", "focus", "foes", "foggy", "foiled", "folding", "fonts",
                    "foolish", "fossil", "fountain", "fowls", "foxes", "foyer", "framed", "friendly",
                    "frown", "fruit", "frying", "fudge", "fuel", "fugitive", "fully", "fuming",
                    "fungal", "furnished", "fuselage", "future", "fuzzy", "gables", "gadget", "gags",
                    "gained", "galaxy", "gambit", "gang", "gasp", "gather", "gauze", "gave",
                    "gawk", "gaze", "gearbox", "gecko", "geek", "gels", "gemstone", "general",
                    "geometry", "germs", "gesture", "getting", "geyser", "ghetto", "ghost", "giant",
                    "giddy", "gifts", "gigantic", "gills", "gimmick", "ginger", "girth", "giving",
                    "glass", "gleeful", "glide", "gnaw", "gnome", "goat", "goblet", "godfather",
                    "goes", "goggles", "going", "goldfish", "gone", "goodbye", "gopher", "gorilla",
                    "gossip", "gotten", "gourmet", "governing", "gown", "greater", "grunt", "guarded",
                    "guest", "guide", "gulp", "gumball", "guru", "gusts", "gutter", "guys",
                    "gymnast", "gypsy", "gyrate", "habitat", "hacksaw", "haggled", "hairy", "hamburger",
                    "happens", "hashing", "hatchet", "haunted", "having", "hawk", "haystack", "hazard",
                    "hectare", "hedgehog", "heels", "hefty", "height", "hemlock", "hence", "heron",
                    "hesitate", "hexagon", "hickory", "hiding", "highway", "hijack", "hiker", "hills",
                    "himself", "hinder", "hippo", "hire", "history", "hitched", "hive", "hoax",
                    "hobby", "hockey", "hoisting", "hold", "honked", "hookup", "hope", "hornet",
                    "hospital", "hotel", "hounded", "hover", "howls", "hubcaps", "huddle", "huge",
                    "hull", "humid", "hunter", "hurried", "husband", "huts", "hybrid", "hydrogen",
                    "hyper", "iceberg", "icing", "icon", "identity", "idiom", "idled", "idols",
                    "igloo", "ignore", "iguana", "illness", "imagine", "imbalance", "imitate", "impel",
                    "inactive", "inbound", "incur", "industrial", "inexact", "inflamed", "ingested", "initiate",
                    "injury", "inkling", "inline", "inmate", "innocent", "inorganic", "input", "inquest",
                    "inroads", "insult", "intended", "inundate", "invoke", "inwardly", "ionic", "irate",
                    "iris", "irony", "irritate", "island", "isolated", "issued", "italics", "itches",
                    "items", "itinerary", "itself", "ivory", "jabbed", "jackets", "jaded", "jagged",
                    "jailed", "jamming", "january", "jargon", "jaunt", "javelin", "jaws", "jazz",
                    "jeans", "jeers", "jellyfish", "jeopardy", "jerseys", "jester", "jetting", "jewels",
                    "jigsaw", "jingle", "jittery", "jive", "jobs", "jockey", "jogger", "joining",
                    "joking", "jolted", "jostle", "journal", "joyous", "jubilee", "judge", "juggled",
                    "juicy", "jukebox", "july", "jump", "junk", "jury", "justice", "juvenile",
                    "kangaroo", "karate", "keep", "kennel", "kept", "kernels", "kettle", "keyboard",
                    "kickoff", "kidneys", "king", "kiosk", "kisses", "kitchens", "kiwi", "knapsack",
                    "knee", "knife", "knowledge", "knuckle", "koala", "laboratory", "ladder", "lagoon",
                    "lair", "lakes", "lamb", "language", "laptop", "large", "last", "later",
                    "launching", "lava", "lawsuit", "layout", "lazy", "lectures", "ledge", "leech",
                    "left", "legion", "leisure", "lemon", "lending", "leopard", "lesson", "lettuce",
                    "lexicon", "liar", "library", "licks", "lids", "lied", "lifestyle", "light",
                    "likewise", "lilac", "limits", "linen", "lion", "lipstick", "liquid", "listen",
                    "lively", "loaded", "lobster", "locker", "lodge", "lofty", "logic", "loincloth",
                    "long", "looking", "lopped", "lordship", "losing", "lottery", "loudly", "love",
                    "lower", "loyal", "lucky", "luggage", "lukewarm", "lullaby", "lumber", "lunar",
                    "lurk", "lush", "luxury", "lymph", "lynx", "lyrics", "macro", "madness",
                    "magically", "mailed", "major", "makeup", "malady", "mammal", "maps", "masterful",
                    "match", "maul", "maverick", "maximum", "mayor", "maze", "meant", "mechanic",
                    "medicate", "meeting", "megabyte", "melting", "memoir", "menu", "merger", "mesh",
                    "metro", "mews", "mice", "midst", "mighty", "mime", "mirror", "misery",
                    "mittens", "mixture", "moat", "mobile", "mocked", "mohawk", "moisture", "molten",
                    "moment", "money", "moon", "mops", "morsel", "mostly", "motherly", "mouth",
                    "movement", "mowing", "much", "muddy", "muffin", "mugged", "mullet", "mumble",
                    "mundane", "muppet", "mural", "musical", "muzzle", "myriad", "mystery", "myth",
                    "nabbing", "nagged", "nail", "names", "nanny", "napkin", "narrate", "nasty",
                    "natural", "nautical", "navy", "nearby", "necklace", "needed", "negative", "neither",
                    "neon", "nephew", "nerves", "nestle", "network", "neutral", "never", "newt",
                    "nexus", "nibs", "niche", "niece", "nifty", "nightly", "nimbly", "nineteen",
                    "nirvana", "nitrogen", "nobody", "nocturnal", "nodes", "noises", "nomad", "noodles",
                    "northern", "nostril", "noted", "nouns", "novelty", "nowhere", "nozzle", "nuance",
                    "nucleus", "nudged", "nugget", "nuisance", "null", "number", "nuns", "nurse",
                    "nutshell", "nylon", "oaks", "oars", "oasis", "oatmeal", "obedient", "object",
                    "obliged", "obnoxious", "observant", "obtains", "obvious", "occur", "ocean", "october",
                    "odds", "odometer", "offend", "often", "oilfield", "ointment", "okay", "older",
                    "olive", "olympics", "omega", "omission", "omnibus", "onboard", "oncoming", "oneself",
                    "ongoing", "onion", "online", "onslaught", "onto", "onward", "oozed", "opacity",
                    "opened", "opposite", "optical", "opus", "orange", "orbit", "orchid", "orders",
                    "organs", "origin", "ornament", "orphans", "oscar", "ostrich", "otherwise", "otter",
                    "ouch", "ought", "ounce", "ourselves", "oust", "outbreak", "oval", "oven",
                    "owed", "owls", "owner", "oxidant", "oxygen", "oyster", "ozone", "pact",
                    "paddles", "pager", "pairing", "palace", "pamphlet", "pancakes", "paper", "paradise",
                    "pastry", "patio", "pause", "pavements", "pawnshop", "payment", "peaches", "pebbles",
                    "peculiar", "pedantic", "peeled", "pegs", "pelican", "pencil", "people", "pepper",
                    "perfect", "pests", "petals", "phase", "pheasants", "phone", "phrases", "physics",
                    "piano", "picked", "pierce", "pigment", "piloted", "pimple", "pinched", "pioneer",
                    "pipeline", "pirate", "pistons", "pitched", "pivot", "pixels", "pizza", "playful",
                    "pledge", "pliers", "plotting", "plus", "plywood", "poaching", "pockets", "podcast",
                    "poetry", "point", "poker", "polar", "ponies", "pool", "popular", "portents",
                    "possible", "potato", "pouch", "poverty", "powder", "pram", "present", "pride",
                    "problems", "pruned", "prying", "psychic", "public", "puck", "puddle", "puffin",
                    "pulp", "pumpkins", "punch", "puppy", "purged", "push", "putty", "puzzled",
                    "pylons", "pyramid", "python", "queen", "quick", "quote", "rabbits", "racetrack",
                    "radar", "rafts", "rage", "railway", "raking", "rally", "ramped", "randomly",
                    "rapid", "rarest", "rash", "rated", "ravine", "rays", "razor", "react",
                    "rebel", "recipe", "reduce", "reef", "refer", "regular", "reheat", "reinvest",
                    "rejoices", "rekindle", "relic", "remedy", "renting", "reorder", "repent", "request",
                    "reruns", "rest", "return", "reunion", "revamp", "rewind", "rhino", "rhythm",
                    "ribbon", "richly", "ridges", "rift", "rigid", "rims", "ringing", "riots",
                    "ripped", "rising", "ritual", "river", "roared", "robot", "rockets", "rodent",
                    "rogue", "roles", "romance", "roomy", "roped", "roster", "rotate", "rounded",
                    "rover", "rowboat", "royal", "ruby", "rudely", "ruffled", "rugged", "ruined",
                    "ruling", "rumble", "runway", "rural", "rustled", "ruthless", "sabotage", "sack",
                    "sadness", "safety", "saga", "sailor", "sake", "salads", "sample", "sanity",
                    "sapling", "sarcasm", "sash", "satin", "saucepan", "saved", "sawmill", "saxophone",
                    "sayings", "scamper", "scenic", "school", "science", "scoop", "scrub", "scuba",
                    "seasons", "second", "sedan", "seeded", "segments", "seismic", "selfish", "semifinal",
                    "sensible", "september", "sequence", "serving", "session", "setup", "seventh", "sewage",
                    "shackles", "shelter", "shipped", "shocking", "shrugged", "shuffled", "shyness", "siblings",
                    "sickness", "sidekick", "sieve", "sifting", "sighting", "silk", "simplest", "sincerely",
                    "sipped", "siren", "situated", "sixteen", "sizes", "skater", "skew", "skirting",
                    "skulls", "skydive", "slackens", "sleepless", "slid", "slower", "slug", "smash",
                    "smelting", "smidgen", "smog", "smuggled", "snake", "sneeze", "sniff", "snout",
                    "snug", "soapy", "sober", "soccer", "soda", "software", "soggy", "soil",
                    "solved", "somewhere", "sonic", "soothe", "soprano", "sorry", "southern", "sovereign",
                    "sowed", "soya", "space", "speedy", "sphere", "spiders", "splendid", "spout",
                    "sprig", "spud", "spying", "square", "stacking", "stellar", "stick", "stockpile",
                    "strained", "stunning", "stylishly", "subtly", "succeed", "suddenly", "suede", "suffice",
                    "sugar", "suitcase", "sulking", "summon", "sunken", "superior", "surfer", "sushi",
                    "suture", "swagger", "swept", "swiftly", "sword", "swung", "syllabus", "symptoms",
                    "syndrome", "syringe", "system", "taboo", "tacit", "tadpoles", "tagged", "tail",
                    "taken", "talent", "tamper", "tanks", "tapestry", "tarnished", "tasked", "tattoo",
                    "taunts", "tavern", "tawny", "taxi", "teardrop", "technical", "tedious", "teeming",
                    "tell", "template", "tender", "tepid", "tequila", "terminal", "testing", "tether",
                    "textbook", "thaw", "theatrics", "thirsty", "thorn", "threaten", "thumbs", "thwart",
                    "ticket", "tidy", "tiers", "tiger", "tilt", "timber", "tinted", "tipsy",
                    "tirade", "tissue", "titans", "toaster", "tobacco", "today", "toenail", "toffee",
                    "together", "toilet", "token", "tolerant", "tomorrow", "tonic", "toolbox", "topic",
                    "torch", "tossed", "total", "touchy", "towel", "toxic", "toyed", "trash",
                    "trendy", "tribal", "trolling", "truth", "trying", "tsunami", "tubes", "tucks",
                    "tudor", "tuesday", "tufts", "tugs", "tuition", "tulips", "tumbling", "tunnel",
                    "turnip", "tusks", "tutor", "tuxedo", "twang", "tweezers", "twice", "twofold",
                    "tycoon", "typist", "tyrant", "ugly", "ulcers", "ultimate", "umbrella", "umpire",
                    "unafraid", "unbending", "uncle", "under", "uneven", "unfit", "ungainly", "unhappy",
                    "union", "unjustly", "unknown", "unlikely", "unmask", "unnoticed", "unopened", "unplugs",
                    "unquoted", "unrest", "unsafe", "until", "unusual", "unveil", "unwind", "unzip",
                    "upbeat", "upcoming", "update", "upgrade", "uphill", "upkeep", "upload", "upon",
                    "upper", "upright", "upstairs", "uptight", "upwards", "urban", "urchins", "urgent",
                    "usage", "useful", "usher", "using", "usual", "utensils", "utility", "utmost",
                    "utopia", "uttered", "vacation", "vague", "vain", "value", "vampire", "vane",
                    "vapidly", "vary", "vastness", "vats", "vaults", "vector", "veered", "vegan",
                    "vehicle", "vein", "velvet", "venomous", "verification", "vessel", "veteran", "vexed",
                    "vials", "vibrate", "victim", "video", "viewpoint", "vigilant", "viking", "village",
                    "vinegar", "violin", "vipers", "virtual", "visited", "vitals", "vivid", "vixen",
                    "vocal", "vogue", "voice", "volcano", "vortex", "voted", "voucher", "vowels",
                    "voyage", "vulture", "wade", "waffle", "wagtail", "waist", "waking", "wallets",
                    "wanted", "warped", "washing", "water", "waveform", "waxing", "wayside", "weavers",
                    "website", "wedge", "weekday", "weird", "welders", "went", "wept", "were",
                    "western", "wetsuit", "whale", "when", "whipped", "whole", "wickets", "width",
                    "wield", "wife", "wiggle", "wildly", "winter", "wipeout", "wiring", "wise",
                    "withdrawn", "wives", "wizard", "wobbly", "woes", "woken", "wolf", "womanly",
                    "wonders", "woozy", "worry", "wounded", "woven", "wrap", "wrist", "wrong",
                    "yacht", "yahoo", "yanks", "yard", "yawning", "yearbook", "yellow", "yesterday",
                    "yeti", "yields", "yodel", "yoga", "younger", "yoyo", "zapped", "zeal",
                    "zebra", "zero", "zesty", "zigzags", "zinger", "zippers", "zodiac", "zombie",
                    "zones", "zoom"]

extension String {
    subscript(value: CountableClosedRange<Int>) -> Substring {
        get {
            return self[index(at: value.lowerBound)...index(at: value.upperBound)]
        }
    }
    
    subscript(value: CountableRange<Int>) -> Substring {
        get {
            return self[index(at: value.lowerBound)..<index(at: value.upperBound)]
        }
    }
    
    subscript(value: PartialRangeUpTo<Int>) -> Substring {
        get {
            return self[..<index(at: value.upperBound)]
        }
    }
    
    subscript(value: PartialRangeThrough<Int>) -> Substring {
        get {
            return self[...index(at: value.upperBound)]
        }
    }
    
    subscript(value: PartialRangeFrom<Int>) -> Substring {
        get {
            return self[index(at: value.lowerBound)...]
        }
    }
    
    func index(at offset: Int) -> String.Index {
        return index(startIndex, offsetBy: offset)
    }
}
