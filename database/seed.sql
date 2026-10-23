INSERT OR IGNORE INTO marcas (nome) VALUES ('Fiat');
INSERT OR IGNORE INTO marcas (nome) VALUES ('Volkswagen');
INSERT OR IGNORE INTO marcas (nome) VALUES ('Chevrolet');
INSERT OR IGNORE INTO marcas (nome) VALUES ('Ford');
INSERT OR IGNORE INTO marcas (nome) VALUES ('Toyota');

-- 2. POPULANDO OS MODELOS (7 Modelos)
INSERT OR IGNORE INTO modelos (marca_id, nome) VALUES ((SELECT id FROM marcas WHERE nome = 'Fiat'), 'Uno');
INSERT OR IGNORE INTO modelos (marca_id, nome) VALUES ((SELECT id FROM marcas WHERE nome = 'Fiat'), 'Argo');
INSERT OR IGNORE INTO modelos (marca_id, nome) VALUES ((SELECT id FROM marcas WHERE nome = 'Volkswagen'), 'Gol');
INSERT OR IGNORE INTO modelos (marca_id, nome) VALUES ((SELECT id FROM marcas WHERE nome = 'Volkswagen'), 'Polo');
INSERT OR IGNORE INTO modelos (marca_id, nome) VALUES ((SELECT id FROM marcas WHERE nome = 'Chevrolet'), 'Onix');
INSERT OR IGNORE INTO modelos (marca_id, nome) VALUES ((SELECT id FROM marcas WHERE nome = 'Ford'), 'Ka');
INSERT OR IGNORE INTO modelos (marca_id, nome) VALUES ((SELECT id FROM marcas WHERE nome = 'Toyota'), 'Corolla');

-- 3. POPULANDO AS VERSÕES (1 ou 2 por modelo)
-- Uno
INSERT OR IGNORE INTO versoes (modelo_id, nome, ano_inicio, ano_fim) VALUES ((SELECT id FROM modelos WHERE nome = 'Uno'), 'Mille 1.0', 2010, 2013);
-- Argo
INSERT OR IGNORE INTO versoes (modelo_id, nome, ano_inicio, ano_fim) VALUES ((SELECT id FROM modelos WHERE nome = 'Argo'), 'Drive 1.0', 2020, NULL);
-- Gol
INSERT OR IGNORE INTO versoes (modelo_id, nome, ano_inicio, ano_fim) VALUES ((SELECT id FROM modelos WHERE nome = 'Gol'), 'Trendline 1.0', 2015, 2018);
INSERT OR IGNORE INTO versoes (modelo_id, nome, ano_inicio, ano_fim) VALUES ((SELECT id FROM modelos WHERE nome = 'Gol'), 'Power 1.6', 2012, 2014);
-- Polo
INSERT OR IGNORE INTO versoes (modelo_id, nome, ano_inicio, ano_fim) VALUES ((SELECT id FROM modelos WHERE nome = 'Polo'), 'Comfortline TSI', 2019, NULL);
-- Onix
INSERT OR IGNORE INTO versoes (modelo_id, nome, ano_inicio, ano_fim) VALUES ((SELECT id FROM modelos WHERE nome = 'Onix'), 'LT 1.0', 2018, 2022);
INSERT OR IGNORE INTO versoes (modelo_id, nome, ano_inicio, ano_fim) VALUES ((SELECT id FROM modelos WHERE nome = 'Onix'), 'LTZ 1.4', 2011, 2018);
-- Ka
INSERT OR IGNORE INTO versoes (modelo_id, nome, ano_inicio, ano_fim) VALUES ((SELECT id FROM modelos WHERE nome = 'Ka'), 'SE 1.0', 2017, 2021);
-- Corolla
INSERT OR IGNORE INTO versoes (modelo_id, nome, ano_inicio, ano_fim) VALUES ((SELECT id FROM modelos WHERE nome = 'Corolla'), 'XEI 2.0', 2021, NULL);


-- 4. POPULANDO MEDIDAS DE PNEU (Uma original por versão + uma alternativa em pelo menos uma)
-- Uno Mille (Original)
INSERT OR IGNORE INTO medidas_pneu (versao_id, medida, original) VALUES ((SELECT id FROM versoes WHERE nome = 'Mille 1.0'), '165/70 R13', 1);
-- Argo Drive (Original)
INSERT OR IGNORE INTO medidas_pneu (versao_id, medida, original) VALUES ((SELECT id FROM versoes WHERE nome = 'Drive 1.0'), '175/65 R14', 1);
-- Gol Trendline (Original)
INSERT OR IGNORE INTO medidas_pneu (versao_id, medida, original) VALUES ((SELECT id FROM versoes WHERE nome = 'Trendline 1.0'), '175/70 R14', 1);
-- Gol Power (Original)
INSERT OR IGNORE INTO medidas_pneu (versao_id, medida, original) VALUES ((SELECT id FROM versoes WHERE nome = 'Power 1.6'), '185/60 R15', 1);
-- Polo Comfortline (Original)
INSERT OR IGNORE INTO medidas_pneu (versao_id, medida, original) VALUES ((SELECT id FROM versoes WHERE nome = 'Comfortline TSI'), '195/55 R16', 1);
-- Onix LT (Original)
INSERT OR IGNORE INTO medidas_pneu (versao_id, medida, original) VALUES ((SELECT id FROM versoes WHERE nome = 'LT 1.0'), '185/65 R15', 1);
-- Onix LTZ (Original)
INSERT OR IGNORE INTO medidas_pneu (versao_id, medida, original) VALUES ((SELECT id FROM versoes WHERE nome = 'LTZ 1.4'), '185/65 R15', 1);
-- Ka SE (Original)
INSERT OR IGNORE INTO medidas_pneu (versao_id, medida, original) VALUES ((SELECT id FROM versoes WHERE nome = 'SE 1.0'), '175/65 R14', 1);
-- Corolla XEI (Original)
INSERT OR IGNORE INTO medidas_pneu (versao_id, medida, original) VALUES ((SELECT id FROM versoes WHERE nome = 'XEI 2.0'), '215/50 R17', 1);

-- MEDIDA ALTERNATIVA (Exemplo no Corolla XEI: usando aro 16 com +1 PSI comparado à original que faremos abaixo)
INSERT OR IGNORE INTO medidas_pneu (versao_id, medida, original) VALUES ((SELECT id FROM versoes WHERE nome = 'XEI 2.0'), '205/55 R16', 0);


-- 5. POPULANDO AS CALIBRAGENS (Leve e Completa para cada medida)
-- Regras aplicadas: verificado = 0, fonte = 'Dado de demonstração'

-- Uno Mille (165/70 R13)
INSERT OR IGNORE INTO calibragens (medida_pneu_id, carga, psi_dianteiro, psi_traseiro, fonte, verificado) 
VALUES ((SELECT id FROM medidas_pneu WHERE medida = '165/70 R13'), 'leve', 28, 28, 'Dado de demonstração', 0);
INSERT OR IGNORE INTO calibragens (medida_pneu_id, carga, psi_dianteiro, psi_traseiro, fonte, verificado) 
VALUES ((SELECT id FROM medidas_pneu WHERE medida = '165/70 R13'), 'completa', 30, 32, 'Dado de demonstração', 0);

-- Argo Drive (175/65 R14)
INSERT OR IGNORE INTO calibragens (medida_pneu_id, carga, psi_dianteiro, psi_traseiro, fonte, verificado) 
VALUES ((SELECT id FROM medidas_pneu WHERE medida = '175/65 R14' AND versao_id = (SELECT id FROM versoes WHERE nome = 'Drive 1.0')), 'leve', 29, 29, 'Dado de demonstração', 0);
INSERT OR IGNORE INTO calibragens (medida_pneu_id, carga, psi_dianteiro, psi_traseiro, fonte, verificado) 
VALUES ((SELECT id FROM medidas_pneu WHERE medida = '175/65 R14' AND versao_id = (SELECT id FROM versoes WHERE nome = 'Drive 1.0')), 'completa', 32, 32, 'Dado de demonstração', 0);

-- Gol Trendline (175/70 R14)
INSERT OR IGNORE INTO calibragens (medida_pneu_id, carga, psi_dianteiro, psi_traseiro, fonte, verificado) 
VALUES ((SELECT id FROM medidas_pneu WHERE medida = '175/70 R14'), 'leve', 29, 29, 'Dado de demonstração', 0);
INSERT OR IGNORE INTO calibragens (medida_pneu_id, carga, psi_dianteiro, psi_traseiro, fonte, verificado) 
VALUES ((SELECT id FROM medidas_pneu WHERE medida = '175/70 R14'), 'completa', 31, 34, 'Dado de demonstração', 0);

-- Gol Power (185/60 R15)
INSERT OR IGNORE INTO calibragens (medida_pneu_id, carga, psi_dianteiro, psi_traseiro, fonte, verificado) 
VALUES ((SELECT id FROM medidas_pneu WHERE medida = '185/60 R15'), 'leve', 29, 29, 'Dado de demonstração', 0);
INSERT OR IGNORE INTO calibragens (medida_pneu_id, carga, psi_dianteiro, psi_traseiro, fonte, verificado) 
VALUES ((SELECT id FROM medidas_pneu WHERE medida = '185/60 R15'), 'completa', 31, 34, 'Dado de demonstração', 0);

-- Polo Comfortline (195/55 R16)
INSERT OR IGNORE INTO calibragens (medida_pneu_id, carga, psi_dianteiro, psi_traseiro, fonte, verificado) 
VALUES ((SELECT id FROM medidas_pneu WHERE medida = '195/55 R16'), 'leve', 29, 29, 'Dado de demonstração', 0);
INSERT OR IGNORE INTO calibragens (medida_pneu_id, carga, psi_dianteiro, psi_traseiro, fonte, verificado) 
VALUES ((SELECT id FROM medidas_pneu WHERE medida = '195/55 R16'), 'completa', 32, 35, 'Dado de demonstração', 0);

-- Onix LT (185/65 R15)
INSERT OR IGNORE INTO calibragens (medida_pneu_id, carga, psi_dianteiro, psi_traseiro, fonte, verificado) 
VALUES ((SELECT id FROM medidas_pneu WHERE medida = '185/65 R15'), 'leve', 32, 32, 'Dado de demonstração', 0);
INSERT OR IGNORE INTO calibragens (medida_pneu_id, carga, psi_dianteiro, psi_traseiro, fonte, verificado) 
VALUES ((SELECT id FROM medidas_pneu WHERE medida = '185/65 R15'), 'completa', 35, 35, 'Dado de demonstração', 0);

-- Onix LTZ (185/65 R15)
INSERT OR IGNORE INTO calibragens (medida_pneu_id, carga, psi_dianteiro, psi_traseiro, fonte, verificado) 
VALUES ((SELECT id FROM medidas_pneu WHERE medida = '185/65 R15'), 'leve', 32, 32, 'Dado de demonstração', 0);
INSERT OR IGNORE INTO calibragens (medida_pneu_id, carga, psi_dianteiro, psi_traseiro, fonte, verificado) 
VALUES ((SELECT id FROM medidas_pneu WHERE medida = '185/65 R15'), 'completa', 32, 35, 'Dado de demonstração', 0);

-- Ka SE (175/65 R14)
INSERT OR IGNORE INTO calibragens (medida_pneu_id, carga, psi_dianteiro, psi_traseiro, fonte, verificado) 
VALUES ((SELECT id FROM medidas_pneu WHERE medida = '175/65 R14' AND versao_id = (SELECT id FROM versoes WHERE nome = 'SE 1.0')), 'leve', 30, 30, 'Dado de demonstração', 0);
INSERT OR IGNORE INTO calibragens (medida_pneu_id, carga, psi_dianteiro, psi_traseiro, fonte, verificado) 
VALUES ((SELECT id FROM medidas_pneu WHERE medida = '175/65 R14' AND versao_id = (SELECT id FROM versoes WHERE nome = 'SE 1.0')), 'completa', 33, 33, 'Dado de demonstração', 0);

-- Corolla XEI - ORIGINAL (215/50 R17) -> Exemplo: 32 Leve / 35 Completa
INSERT OR IGNORE INTO calibragens (medida_pneu_id, carga, psi_dianteiro, psi_traseiro, fonte, verificado) 
VALUES ((SELECT id FROM medidas_pneu WHERE medida = '215/50 R17'), 'leve', 32, 32, 'Dado de demonstração', 0);
INSERT OR IGNORE INTO calibragens (medida_pneu_id, carga, psi_dianteiro, psi_traseiro, fonte, verificado) 
VALUES ((SELECT id FROM medidas_pneu WHERE medida = '215/50 R17'), 'completa', 35, 35, 'Dado de demonstração', 0);

-- Corolla XEI - ALTERNATIVA (205/55 R16) -> Regra do guia: Valor da original +1 PSI (33 Leve / 36 Completa)
INSERT OR IGNORE INTO calibragens (medida_pneu_id, carga, psi_dianteiro, psi_traseiro, fonte, verificado) 
VALUES ((SELECT id FROM medidas_pneu WHERE medida = '205/55 R16'), 'leve', 33, 33, 'Dado de demonstração', 0);
INSERT OR IGNORE INTO calibragens (medida_pneu_id, carga, psi_dianteiro, psi_traseiro, fonte, verificado) 
VALUES ((SELECT id FROM medidas_pneu WHERE medida = '205/55 R16'), 'completa', 36, 36, 'Dado de demonstração', 0);


-- 6. POPULANDO O COMPRESSOR EXIGIDO
INSERT OR IGNORE INTO compressores (codigo, nome, url_base, ativo) 
VALUES ('COMP-001', 'Compressor Central', 'http://localhost:9000', 1);