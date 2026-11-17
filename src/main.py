def calcular_media(notas):
    return sum(notas) / len(notas)


def main():
    notas = [15, 17, 14]

    media = calcular_media(notas)

    print("=== Calculadora de Média ===")
    print(f"Notas: {notas}")
    print(f"Média: {media:.2f}")


if __name__ == "__main__":
    main()
