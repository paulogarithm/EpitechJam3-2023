import random

def generate_entities(num_sheep, num_enemies):
    entities = []

    for _ in range(num_sheep):
        x = random.randint(0, 1000)
        y = random.randint(0, 1000)
        color = "black" if random.random() < 0.5 else "white"
        entities.append(f"sheep x={x} y={y} {color}")

    for _ in range(num_enemies):
        x = random.randint(0, 1000)
        y = random.randint(0, 1000)
        color = "black" if random.random() < 0.5 else "white"
        entities.append(f"enemy x={x} y={y} {color}")

    x = random.randint(0, 1000)
    y = random.randint(0, 1000)
    color = "black" if random.random() < 0.5 else "white"
    entities.append(f"fence x={x} y={y} {color}")

    x = random.randint(0, 1000)
    y = random.randint(0, 1000)

    color = "black"
    entities.append(f"fence x={x} y={y} {color}")

    x = random.randint(0, 1000)
    y = random.randint(0, 1000)
    entities.append(f"button x={x} y={y} none")

    x = random.randint(0, 1000)
    y = random.randint(0, 1000)
    entities.append(f"player x={x} y={y} white")

    return entities

num_sheep = int(input("How many sheeps ? "))
num_enemies = int(input("How many enemies ? "))

entities = generate_entities(num_sheep, num_enemies)

with open("map.txt", "w") as file:
    for entity in entities:
        file.write(entity + "\n")

print("The map has been saved as map.txt.")