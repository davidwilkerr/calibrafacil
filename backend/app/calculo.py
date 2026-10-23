import os

PSI_MIN = 20
PSI_MAX = 50
ACRESCIMO_PADRAO = 4
ACRESCIMO_LIMITE = 10

def acrescimo_pneu_quente() -> int:
    """Lê a variável de ambiente, converte para inteiro e limita entre 0 e ACRESCIMO_LIMITE.
    Se houver erro de conversão, retorna o ACRESCIMO_PADRAO.
    """
    valor_env = os.getenv("PSI_ACRESCIMO_PNEU_QUENTE")
    
    if valor_env is None:
        return ACRESCIMO_PADRAO
        
    try:
        valor_int = int(valor_env)
        # Limita o número entre 0 e 10 usando a dica do roteiro
        return max(0, min(valor_int, ACRESCIMO_LIMITE))
    except ValueError:
        return ACRESCIMO_PADRAO

def psi_final(psi_base: int, pneu_quente: int) -> tuple[int, int]:
    """Calcula a pressão final respeitando o teto de 50 PSI e retorna
    uma tupla com (psi_final, acrescimo_aplicado).
    """
    if not pneu_quente:
        return psi_base, 0
        
    acrescimo_configurado = acrescimo_pneu_quente()
    
    # Calcula o quanto seria ideal, mas barra no limite máximo (PSI_MAX = 50)
    psi_calculado = psi_base + acrescimo_configurado
    psi_final_resultado = min(psi_calculado, PSI_MAX)
    
    # O acréscimo aplicado é a diferença real (se o teto cortar, ele muda)
    acrescimo_aplicado = psi_final_resultado - psi_base
    return psi_final_resultado, acrescimo_aplicado


def aviso_pneu_quente(acrescimo: int) -> str:
    """Devolve a mensagem de aviso baseada no acréscimo real aplicado."""
    if acrescimo == 0:
        return "Pneu quente detectado, mas não houve acréscimo pois a calibragem máxima já foi atingida."
    return f"Pneu quente detectado. Foi aplicado um acréscimo de segurança de +{acrescimo} PSI."
