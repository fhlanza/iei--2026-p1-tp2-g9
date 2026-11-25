def validar_notas(notas):
    """Verifica se a lista de notas e valida."""
    if not isinstance(notas, list):
        raise TypeError("As notas devem ser fornecidas numa lista.")

    if len(notas) == 0:
        raise ValueError("A lista de notas nao pode estar vazia.")

    for nota in notas:
        if not isinstance(nota, (int, float)) or isinstance(nota, bool):
            raise TypeError("Todas as notas devem ser numeros.")

        if nota < 0 or nota > 20:
            raise ValueError("As notas devem estar entre 0 e 20.")


def calcular_media(notas):
    validar_notas(notas)
    return sum(notas) / len(notas)


def obter_maior_nota(notas):
    validar_notas(notas)
    return max(notas)


def obter_menor_nota(notas):
    validar_notas(notas)
    return min(notas)


def classificar_media(media):
    if not isinstance(media, (int, float)) or isinstance(media, bool):
        raise TypeError("A media deve ser um nimero.")

    if media < 0 or media > 20:
        raise ValueError("A media deve estar entre 0 e 20.")

    if media >= 10:
        return "Aprovado"

    return "Reprovado"


def main():
    notas = [15, 17, 14]

    media = calcular_media(notas)

    print("=== Calculadora de Media ===")
    print(f"Notas: {notas}")
    print(f"Media: {media:.2f}")
    print(f"Maior nota: {obter_maior_nota(notas)}")
    print(f"Menor nota: {obter_menor_nota(notas)}")
    print(f"Resultado: {classificar_media(media)}")


if __name__ == "__main__":
    main()  # pragma: no cover