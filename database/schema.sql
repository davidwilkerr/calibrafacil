PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS marcas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS modelos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    marca_id INTEGER NOT NULL,
    nome TEXT NOT NULL,
    FOREIGN KEY (marca_id) REFERENCES marcas(id),
    UNIQUE (marca_id, nome)
);

CREATE TABLE IF NOT EXISTS versoes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    modelo_id INTEGER NOT NULL,
    nome TEXT NOT NULL,
    ano_inicio INTEGER NOT NULL,
    ano_fim INTEGER,
    FOREIGN KEY (modelo_id) REFERENCES modelos(id)
);

CREATE TABLE IF NOT EXISTS medidas_pneu (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    versao_id INTEGER NOT NULL,
    medida TEXT NOT NULL,
    original INTEGER NOT NULL CHECK (original IN (0, 1)),
    FOREIGN KEY (versao_id) REFERENCES versoes(id)
);

CREATE TABLE IF NOT EXISTS calibragens (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    medida_pneu_id INTEGER NOT NULL,
    carga TEXT NOT NULL CHECK (carga IN ('leve', 'completa')),
    psi_dianteiro INTEGER NOT NULL CHECK (psi_dianteiro BETWEEN 20 AND 50),
    psi_traseiro INTEGER NOT NULL CHECK (psi_traseiro BETWEEN 20 AND 50),
    fonte TEXT,
    verificado INTEGER NOT NULL DEFAULT 0 CHECK (verificado IN (0, 1)),
    verificado_em TEXT,
    FOREIGN KEY (medida_pneu_id) REFERENCES medidas_pneu(id),
    UNIQUE (medida_pneu_id, carga)
);

CREATE TABLE IF NOT EXISTS compressores (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    codigo TEXT NOT NULL UNIQUE,
    nome TEXT NOT NULL,
    url_base TEXT NOT NULL,
    ativo INTEGER NOT NULL DEFAULT 1 CHECK (ativo IN (0, 1))
);

CREATE TABLE IF NOT EXISTS comandos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    compressor_id INTEGER NOT NULL,
    calibragem_id INTEGER NOT NULL,
    eixo TEXT NOT NULL CHECK (eixo IN ('dianteiro', 'traseiro')),
    psi INTEGER NOT NULL,
    pneu_quente INTEGER NOT NULL CHECK (pneu_quente IN (0, 1)),
    status TEXT NOT NULL CHECK (status IN ('confirmado', 'falhou')),
    detalhe TEXT,
    criado_em TEXT DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (compressor_id) REFERENCES compressores(id),
    FOREIGN KEY (calibragem_id) REFERENCES calibragens(id)
);

CREATE UNIQUE INDEX IF NOT EXISTS idx_medida_original_por_versao 
ON medidas_pneu (versao_id) 
WHERE original = 1;
