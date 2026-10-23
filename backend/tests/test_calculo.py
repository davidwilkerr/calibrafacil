import pytest
import os
# Tentativa de importação do módulo que ainda vamos criar (vai causar o erro esperado)
from app.calculo import psi_final

# --- Bloco 1: Testes básicos com acréscimo padrão de +4 ---
@pytest.mark.parametrize(
    "psi_base, pneu_quente, esperado_psi, esperado_acrescimo",
    [
        (30, 0, 30, 0),   # Pneu Frio (0): Não muda nada, acréscimo 0
        (30, 1, 34, 4),   # Pneu Quente (1): Soma 4, acréscimo 4
        (48, 1, 50, 2),   # Teto de 50 PSI: Tinha 48, somaria 4 (52), mas barra no 50. Acréscimo real foi 2.
        (50, 1, 50, 0),   # Já está no limite máximo de 50: Acréscimo real aplicado é 0.
    ]
)
def test_psi_final_com_acrescimo_padrao(psi_base, pneu_quente, esperado_psi, esperado_acrescimo):
    # Garante que a variável não exista no teste padrão para usar o fallback de 4
    if "PSI_ACRESCIMO_PNEU_QUENTE" in os.environ:
        del os.environ["PSI_ACRESCIMO_PNEU_QUENTE"]
        
    resultado_psi, acrescimo_real = psi_final(psi_base, pneu_quente)
    assert resultado_psi == esperado_psi
    assert acrescimo_real == esperado_acrescimo


# --- Bloco 2: Testes dinâmicos alterando a Variável de Ambiente ---
@pytest.mark.parametrize(
    "valor_env, psi_base, pneu_quente, esperado_psi, esperado_acrescimo",
    [
        ("2", 30, 1, 32, 2),       # Valor válido configurado como 2
        ("0", 30, 1, 30, 0),       # Valor válido configurado como 0
        ("12", 30, 1, 40, 10),     # Acima de 10: Deve virar 10 (30 + 10 = 40)
        ("-3", 30, 1, 30, 0),      # Valor negativo: Deve virar 0
        ("texto_invalido", 30, 1, 34, 4), # Texto inválido: Volta ao padrão (+4)
    ]
)
def test_psi_final_com_variavel_ambiente(monkeypatch, valor_env, psi_base, pneu_quente, esperado_psi, esperado_acrescimo):
    # Modifica temporariamente a variável de ambiente para este cenário do teste
    monkeypatch.setenv("PSI_ACRESCIMO_PNEU_QUENTE", valor_env)
    
    resultado_psi, acrescimo_real = psi_final(psi_base, pneu_quente)
    assert resultado_psi == esperado_psi
    assert acrescimo_real == esperado_acrescimo
