-- Grau educacional
INSERT INTO grau_educacional (grau_educacional) VALUES 
('Ensino Médio'), 
('Graduação'), 
('Pós-graduação');

-- Grau hierárquico
INSERT INTO grau_hierarquico (grau_hierarquico) VALUES 
('Estagiário'), 
('Analista'), 
('Gerente'), 
('Diretor');

-- Departamentos
INSERT INTO departamento (nome_departamento) VALUES 
('RH'), 
('Financeiro'), 
('TI');

-- Benefícios
INSERT INTO beneficio (nome_beneficio) VALUES 
('Vale Alimentação'), 
('Plano de Saúde'), 
('Vale Transporte');

-- Médico
INSERT INTO medico (nome_medico, crm) VALUES 
('Dr. João Silva', '12345-RJ'),
('Dra. Maria Souza', '67890-SP');

-- Exames obrigatórios
INSERT INTO exames_obrigatorios (nome_exame) VALUES 
('Exame Admissional'),
('Exame Periódico'),
('Exame Demissional');

-- Datas de admissão e demissão
INSERT INTO data_admissao (data_admissao) VALUES ('2020-01-15'), ('2021-03-01');
INSERT INTO data_demissao (data_demissao, motivo_demissao) VALUES (NULL, NULL), (NULL, NULL);

-- Colaboradores
INSERT INTO colaborador 
(cpf_colaborador, rg_colaborador, nome_colaborador, data_nascimento_colaborador, 
 naturalidade_colaborador, nacionalidade_colaborador, sexo_colaborador, estado_civil, id_grau_educacional) 
VALUES
('12345678901', 'MG1234567', 'Carlos Andrade', '1990-05-12', 'Belo Horizonte', 'Brasileiro', 'Masculino', 'Casado', 2),
('98765432100', 'SP9876543', 'Ana Pereira', '1995-10-20', 'São Paulo', 'Brasileira', 'Feminino', 'Solteiro', 3);

-- Dados trabalhistas
INSERT INTO dados_trabalhistas (pis, ctps, reservista, id_colaborador) VALUES
('1234567', 'CTPS1234', 'Sim', 1),
('7654321', 'CTPS5678', 'Não', 2);

-- Dados bancários
INSERT INTO dados_bancarios (banco, agencia, conta, id_colaborador) VALUES
('Banco do Brasil', '1234', '56789-0', 1),
('Caixa Econômica', '5678', '12345-6', 2);

-- Contratos
INSERT INTO contrato (nome_contrato, tipo_contrato, turno, data_inicio, salario, status, 
                      id_colaborador, id_grau_hierarquico, id_data_admissao, id_data_demissao) 
VALUES
('Contrato CLT', 'CLT', 'Manhã', '2020-01-15', 3500.00, 'Ativo', 1, 2, 1, 1),
('Contrato PJ', 'PJ', 'Tarde', '2021-03-01', 6000.00, 'Ativo', 2, 3, 2, 2);

-- Departamento x Colaborador
INSERT INTO departamento_colaborador (id_colaborador, id_departamento) VALUES 
(1, 1), -- Carlos no RH
(2, 3); -- Ana na TI

-- Benefício x Colaborador
INSERT INTO beneficio_colaborador (id_beneficio, id_colaborador, tipo_beneficio, valor_total, valor_descontado, descricao, status) 
VALUES
(1, 1, 'Vale Alimentação', 500.00, 50.00, 'Cartão Sodexo', 'Ativo'),
(2, 2, 'Plano de Saúde', 800.00, 100.00, 'Plano Bradesco Saúde', 'Ativo');

-- Dependentes
INSERT INTO dependentes (nome_dependente, cpf_dependente, rg_dependente, data_nascimento_dependente, tipo_relacionamento, id_colaborador) 
VALUES
('Joãozinho Andrade', '22233344455', 'RJ112233', '2015-07-10', 'Filho', 1),
('Mariana Souza', '55544433322', 'SP998877', '1998-09-25', 'Cônjuge', 2);

-- Férias
INSERT INTO ferias (inicio, fim, vencimento, numero_de_dias, abono, descricao, status, id_colaborador) 
VALUES
('2023-12-01', '2023-12-30', '2023-11-30', 30, FALSE, 'Férias anuais', 'Ativo', 1);

-- Histórico de Cargo
INSERT INTO historico_cargo (cargo_antigo, cargo_novo, data, motivo, salario_antigo, salario_novo, id_colaborador, id_departamento_antigo, id_departamento_novo) 
VALUES
('Analista', 'Gerente', '2022-06-01', 'Promoção por mérito', 3500.00, 6000.00, 1, 1, 1);

-- Exames de colaborador
INSERT INTO exame_colaborador (data_exame, cid, descricao, status, aptidao, data_proximo_exame, dias_folga, id_colaborador, id_exame, id_medico) 
VALUES
('2022-01-10', 'Z00.0', 'Exame admissional', 'Realizado', 'Apto', '2023-01-10', 0, 1, 1, 1),
('2022-06-15', 'Z02.0', 'Exame periódico', 'Realizado', 'Apto', '2023-06-15', 0, 2, 2, 2);

-- Contatos (colocados por último)
INSERT INTO contato (tipo, valor, id_colaborador) VALUES
('Email', 'carlos.andrade@email.com', 1),
('Telefone', '(31)99999-0000', 1),
('Email', 'ana.pereira@email.com', 2),
('Telefone', '(11)98888-1111', 2);

