import pytest

from src.main import (
    calcular_media,
    classificar_media,
    obter_maior_nota,
    obter_menor_nota,
    validar_notas,
)

# TESTES DA FUNCAO validar_notas (3 testes)


def test_validar_notas_validas():
    assert validar_notas([10, 15, 20]) is None


def test_validar_notas_lista_vazia():
    with pytest.raises(ValueError):
        validar_notas([])


def test_validar_notas_entrada_invalida():
    with pytest.raises(TypeError):
        validar_notas("10, 15, 20")


# TESTES DA FUNCAO calcular_media (3 testes)


def test_calcular_media_normal():
    assert calcular_media([10, 15, 20]) == 15


def test_calcular_media_uma_nota():
    assert calcular_media([12]) == 12


def test_calcular_media_lista_vazia():
    with pytest.raises(ValueError):
        calcular_media([])


# TESTES DA FUNCAO obter_maior_nota (3 testes)


def test_obter_maior_nota():
    assert obter_maior_nota([10, 15, 18]) == 18


def test_obter_maior_nota_repetida():
    assert obter_maior_nota([18, 18, 10]) == 18


def test_obter_maior_nota_lista_vazia():
    with pytest.raises(ValueError):
        obter_maior_nota([])


# TESTES DA FUNCAO obter_menor_nota (3 testes)


def test_obter_menor_nota():
    assert obter_menor_nota([10, 15, 18]) == 10


def test_obter_menor_nota_repetida():
    assert obter_menor_nota([10, 10, 18]) == 10


def test_obter_menor_nota_lista_vazia():
    with pytest.raises(ValueError):
        obter_menor_nota([])


# TESTES DA FUNCAOO classificar_media (3 testes)


def test_classificar_media_aprovado():
    assert classificar_media(15) == "Aprovado"


def test_classificar_media_reprovado():
    assert classificar_media(8) == "Reprovado"


def test_classificar_media_invalida():
    with pytest.raises(ValueError):
        classificar_media(25)
