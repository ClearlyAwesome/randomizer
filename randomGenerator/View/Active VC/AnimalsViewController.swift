//
//  AnimalsViewController.swift
//  randomGenerator
//
//  Created by R C on 11/29/20.
//

import UIKit

class AnimalsViewController: UIViewController {
    
    //    @IBOutlet weak var randomAnimal: UIImageView!
    @IBOutlet weak var randomAnimalLabel: UILabel!
    @IBOutlet weak var generateRandomAnimalLabel: UIButton!
    //    @IBOutlet weak var randomAnimalImage: UIImageView!
    
    let choices = ["giraffe", "donkey","cat", "dog", "horse", "snake", "hamster", "Aardvark", "Aardwolf", "African buffalo", "African elephant", "African leopard", "Albatross", "Alligator", "Alpaca", "American buffalo (bison)", "American robin", "Anaconda", "Anglerfish", "Ant", "Anteater", "Antelope", "Antlion", "Ape", "Arabian leopard", "Arctic Fox", "Arctic Wolf", "Armadillo", "Arrow crab", "Baboon", "Badger", "Bald eagle", "Barnacle", "Barracuda", "Basilisk", "Bass", "Bat", "Beaked whale", "Bear", "Beaver", "Bedbug", "Bee", "Beetle", "Bird", "Black panther", "Black widow spider", "Blackbird", "Blue bird", "Blue jay", "Blue whale", "Boa", "Boar", "Bobcat", "Box jellyfish", "Buffalo, African", "Buffalo, American (bison)", "Butterfly", "Buzzard", "Camel", "Cape buffalo", "Capybara", "Cardinal", "Caribou", "Carp", "Caterpillar", "Catfish", "Catshark", "Cattle", "Centipede", "Cephalopod", "Chameleon", "Cheetah", "Chickadee", "Chicken", "Chimpanzee", "Chinchilla", "Chipmunk", "Cicada", "Clam", "Clownfish", "Cobra", "Cockroach", "Cod", "Condor", "Constrictor", "Cougar", "Cow", "Coyote", "Crab", "Crane", "Crane fly", "Crayfish", "Cricket", "Crocodile", "Crow", "Damselfly", "Deer", "Dingo", "Dinosaur", "Dolphin", "Dove", "Dragon", "Dragonfly", "Duck", "Dung beetle", "Eagle", "Earthworm", "Earwig", "Echidna", "Eel", "Egret", "Elephant", "Elephant seal", "Elk", "Emu", "English pointer", "Ermine", "Falcon", "Fancy mouse", "Fancy rat", "Finch", "Firefly", "Flamingo", "Flea", "Fly", "Flyingfish", "Fowl", "Fox", "Frog", "Fruit bat", "Galliform", "Gayal", "Gazelle", "Gecko", "Gerbil", "Giant panda", "Giant squid", "Gibbon", "Goat", "Goldfish", "Goose", "Gopher", "Gorilla", "Grasshopper", "Great blue heron", "Great white shark", "Grizzly bear", "Guinea pig", "Guineafowl", "Gull", "Guppy", "Haddock", "Halibut", "Hammerhead shark", "Hare", "Hawk", "Hedgehog", "Hermit crab", "Heron", "Herring", "Hippopotamus", "Hookworm", "Hornet", "Hoverfly", "Hummingbird", "Humpback whale", "Hyena", "Iguana", "Impala", "Irukandji jellyfish", "Jackal", "Jaguar", "Jellyfish", "Kangaroo", "Kangaroo mouse", "Kangaroo rat", "Kingfisher", "Kiwi", "Koala", "Koi", "Komodo dragon", "Krill", "Ladybug", "Lamprey", "Lark", "Leech", "Lemming", "Lemur", "Leopard", "Leopon", "Limpet", "Lion", "Lizard", "Llama", "Lobster", "Locust", "Lungfish", "Lynx", "Macaw", "Mackerel", "Magpie", "Mammal", "Manatee", "Mandrill", "Manta ray", "Marlin", "Marsupial", "Marten", "Mastodon", "Meadowlark", "Meerkat", "Mink", "Minnow", "Mite", "Mockingbird", "Mole", "Mollusk", "Mongoose", "Monitor lizard", "Monkey", "Moose", "Mosquito", "Moth", "Mountain goat", "Mouse", "Mule", "Muskox", "New World quail", "Newt", "Nightingale", "Ocelot", "Octopus", "Opossum", "Orangutan", "Orca", "Ostrich", "Otter", "Owl", "Ox", "Panda", "Panther", "Panthera hybrid", "Parakeet", "Parrot", "Parrotfish", "Peacock", "Peafowl", "Pelican", "Penguin", "Perch", "Peregrine falcon", "Pheasant", "Pig", "Pigeon", "Pike", "Pilot whale", "Piranha", "Platypus", "Polar bear", "Pony", "Porcupine", "Porpoise", "Possum", "Prairie dog", "Prawn", "Praying mantis", "Puma", "Python", "Quail", "Rabbit", "Raccoon", "Rainbow trout", "Rat", "Rattlesnake", "Raven", "Reindeer", "Reptile", "Rhinoceros", "Rooster", "Roundworm", "Saber-toothed tiger", "Sailfish", "Salamander", "Salmon", "Sawfish", "Scallop", "Scorpion", "Sea lion", "Sea slug", "Sea snail", "Seahorse", "Shark", "Sheep", "Shrew", "Shrimp", "Siamese fighting fish", "Silkworm", "Silverfish", "Skink", "Skunk", "Sloth", "Slug", "Smelt", "Snail", "Snipe", "Snow leopard", "Sockeye salmon", "Sparrow", "Sperm whale", "Spider", "Spider monkey", "Spoonbill", "Squid", "Squirrel", "Star-nosed mole", "Starfish", "Steelhead trout", "Stingray", "Stork", "Swallow", "Swan", "Swordfish", "Swordtail", "Tarantula", "Tarsier", "Tasmanian devil", "Termite", "Tick", "Tiger", "Tiger shark", "Toad", "Tortoise", "Toucan", "Trapdoor spider", "Tree frog", "Trout", "Tuna", "Turkey", "Turtle", "Tyrannosaurus Rex", "Urial", "Vampire bat", "Viper", "Vulture", "Wallaby", "Walrus", "Warbler", "Wasp", "Water Boa", "Water buffalo", "Weasel", "Whale", "Wildcat", "Wildebeest", "Wolf", "Wolverine", "Wombat", "Woodpecker", "Worm", "Yak", "Yellow perch", "Zebra", "Zebra finch"]
    
    
    var randomImage: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        generateRandomAnimalLabel.layer.cornerRadius = 25
        
    }
    
    @IBAction func generateNewAnimal(_ sender: UIButton) {
        
        randomImage = choices.randomElement()
        randomAnimalLabel.text = randomImage?.capitalized
    }
}

////MARK: - UIImage Extension
//extension UIImage {
//    enum AssetIdentifier: String {
//        case giraffe = "giraffe"
//        case donkey = "donkey"
//        case cat = "cat"
//        case dog = "dog"
//        case horse = "horse"
//        case snake = "snake"
//        case dinosaur = "dinosaur"
//        case ferret = "ferret"
//        case hamster = "hamster"
//
//        static let choices = ["giraffe", "donkey","cat", "dog", "horse", "snake", "dinosaur", "ferret", "hamster"]
//
//    }
//    convenience init!(assetIdentifier: AssetIdentifier) {
//        self.init(named: assetIdentifier.rawValue)
//    }
//}
//
//        randomAnimalImage.image = UIImage.init(assetIdentifier: ((UIImage.AssetIdentifier(rawValue: (randomImage ?? randomImage)!) ?? UIImage.AssetIdentifier(rawValue: randomImage!))!))
