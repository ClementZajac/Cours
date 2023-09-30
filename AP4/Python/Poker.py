from collections import Counter

def best_hand(cards):
    # Compter les occurences de chaque hauteur et couleur
    count = Counter([card[0] for card in cards])
    suits = Counter([card[1] for card in cards])

    # Identifier la combinaison la plus forte
    straight, flush = False, False
    if len(suits) == 1:
        flush = True
    if (max(count, key=count.get) - min(count, key=count.get) == 4) and len(count) == 5:
        straight = True
    if flush and straight:
        return "Suite à la couleur", max(count, key=count.get)
    elif flush:
        return "Couleur", sorted(count, key=count.get, reverse=True)
    elif straight:
        return "Suite", max(count, key=count.get)
    elif 4 in count.values():
        return "Carré", [card[0] for card in cards if count[card[0]] == 4], [card[0] for card in cards if count[card[0]] != 4][0]
    elif 3 in count.values() and 2 in count.values():
        return "Full", [card[0] for card in cards if count[card[0]] == 3][0], [card[0] for card in cards if count[card[0]] == 2][0]
    elif 3 in count.values():
        return "Brelan", [card[0] for card in cards if count[card[0]] == 3][0], sorted([card[0] for card in cards if count[card[0]] != 3], key=count.get, reverse=True)
    elif len([card[0] for card in cards if count[card[0]] == 2]) == 2:
        return "Double paire", sorted([card[0] for card in cards if count[card[0]] == 2], key=count.get, reverse=True), [card[0] for card in cards if count[card[0]] != 2][0]
    elif 2 in count.values():
        return "Paire", [card[0] for card in cards if count[card[0]] == 2][0], sorted([card[0] for card in cards if count[card[0]] != 2], key=count.get, reverse=True)
    else:
        return "Rien", sorted(count, key=count.get, reverse=True)

cards = [("A", "C"), ("K", "C"), ("Q", "C"), ("J", "C"), ("10", "C"), ("2", "C"), ("3", "C")]
print(best_hand(cards))