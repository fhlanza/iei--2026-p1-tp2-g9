import pytest

from src.main import calcular_media


def test_media_tres_notas():
    assert calcular_media([15, 17, 14]) == pytest.approx(15.333333333333334)


def test_media_notas_iguais():
    assert calcular_media([10, 10, 10]) == 10


def test_media_com_zero():
    assert calcular_media([0, 10, 20]) == 10
