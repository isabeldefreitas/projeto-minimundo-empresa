CREATE DATABASE minimundo_empresa_projeto;

-- Tipos ENUM
CREATE TYPE sexo_enum AS ENUM ('Masculino', 'Feminino');
CREATE TYPE estado_civil_enum AS ENUM ('Solteiro', 'Casado', 'Divorciado');
CREATE TYPE grau_hierarquico_enum AS ENUM ('Estagiário', 'Analista', 'Gerente', 'Diretor');
CREATE TYPE grau_educacional_enum AS ENUM ('Ensino Médio', 'Graduação', 'Pós-graduação');
CREATE TYPE tipo_contrato_enum AS ENUM ('CLT', 'Estágio', 'PJ');
CREATE TYPE turno_enum AS ENUM ('Manhã', 'Tarde', 'Noite');
CREATE TYPE contrato_status_enum AS ENUM ('Ativo', 'Suspenso', 'Encerrado');
CREATE TYPE beneficio_status_enum AS ENUM ('Ativo', 'Inativo');
CREATE TYPE ferias_status_enum AS ENUM ('Ativo', 'Inativo');
CREATE TYPE exame_status_enum AS ENUM ('Agendado', 'Realizado', 'Cancelado');
CREATE TYPE aptidao_enum AS ENUM ('Apto', 'Inapto', 'Em espera');
CREATE TYPE reservista_enum AS ENUM ('Sim', 'Não');

-- Tabelas 
CREATE TABLE colaborador (
    id_colaborador SERIAL PRIMARY KEY,
    cpf_colaborador VARCHAR(11) UNIQUE NOT NULL,
    rg_colaborador VARCHAR(15),
    nome_colaborador VARCHAR(100) NOT NULL,
    data_nascimento_colaborador DATE NOT NULL,
    naturalidade_colaborador VARCHAR(50),
    nacionalidade_colaborador VARCHAR(50),
    sexo_colaborador sexo_enum NOT NULL,
    estado_civil estado_civil_enum NOT NULL
);

CREATE TABLE dados_trabalhistas (
    id_dados_trabalhistas SERIAL PRIMARY KEY,
    pis VARCHAR(15),
    ctps VARCHAR(20),
    reservista reservista_enum
);

CREATE TABLE dados_bancarios (
    id_dados_bancarios SERIAL PRIMARY KEY,
    banco VARCHAR(50),
    agencia VARCHAR(20),
    conta VARCHAR(20)
);

CREATE TABLE contrato (
    id_contrato SERIAL PRIMARY KEY,
    nome_contrato VARCHAR(50),
    tipo_contrato tipo_contrato_enum NOT NULL,
    turno turno_enum NOT NULL,
    data_inicio DATE,
    data_expiracao DATE,
    salario NUMERIC(10,2),
    status contrato_status_enum NOT NULL
);

CREATE TABLE data_admissao (
    id_data_admissao SERIAL PRIMARY KEY,
    data_admissao DATE NOT NULL
);

CREATE TABLE data_demissao (
    id_data_demissao SERIAL PRIMARY KEY,
    data_demissao DATE,
    motivo_demissao VARCHAR(255)
);

CREATE TABLE departamento (
    id_departamento SERIAL PRIMARY KEY,
    nome_departamento VARCHAR(50) NOT NULL
);

CREATE TABLE departamento_colaborador (
    id_departamento_colaborador SERIAL PRIMARY KEY
);

CREATE TABLE beneficio (
    id_beneficio SERIAL PRIMARY KEY,
    nome_beneficio VARCHAR(50) NOT NULL
);

CREATE TABLE beneficio_colaborador (
    id_beneficio_colaborador SERIAL PRIMARY KEY,
    tipo_beneficio VARCHAR(50) NOT NULL,
    valor_total NUMERIC(10,2),
    valor_descontado NUMERIC(10,2),
    descricao TEXT,
    status beneficio_status_enum NOT NULL
);

CREATE TABLE dependentes (
    id_dependente SERIAL PRIMARY KEY,
    nome_dependente VARCHAR(100),
    cpf_dependente VARCHAR(11),
    rg_dependente VARCHAR(15),
    data_nascimento_dependente DATE,
    tipo_relacionamento VARCHAR(50)
);

CREATE TABLE ferias (
    id_ferias SERIAL PRIMARY KEY,
    inicio DATE,
    fim DATE,
    vencimento DATE,
    numero_de_dias INT,
    abono BOOLEAN,
    descricao TEXT,
    status ferias_status_enum NOT NULL
);

CREATE TABLE grau_hierarquico (
    id_grau_hierarquico SERIAL PRIMARY KEY,
    grau_hierarquico grau_hierarquico_enum NOT NULL
);

CREATE TABLE grau_educacional (
    id_grau_educacional SERIAL PRIMARY KEY,
    grau_educacional grau_educacional_enum NOT NULL
);

CREATE TABLE medico (
    id_medico SERIAL PRIMARY KEY,
    nome_medico VARCHAR(100),
    crm VARCHAR(20) UNIQUE
);

CREATE TABLE exames_obrigatorios (
    id_exame SERIAL PRIMARY KEY,
    nome_exame VARCHAR(100) NOT NULL
);

CREATE TABLE exame_colaborador (
    id_exame_colaborador SERIAL PRIMARY KEY,
    data_exame DATE,
    cid VARCHAR(20),
    descricao TEXT,
    status exame_status_enum NOT NULL,
    aptidao aptidao_enum NOT NULL,
    data_proximo_exame DATE,
    dias_folga INT
);

CREATE TABLE contato (
    id_contato SERIAL PRIMARY KEY,
    tipo VARCHAR(20),
    valor VARCHAR(100)
);

CREATE TABLE historico_cargo (
    id_historico_cargo SERIAL PRIMARY KEY,
    cargo_antigo VARCHAR(50),
    cargo_novo VARCHAR(50),
    data DATE,
    motivo TEXT,
    salario_antigo NUMERIC(10,2),
    salario_novo NUMERIC(10,2)
);

-- Chaves Estrangeiras
ALTER TABLE colaborador
ADD COLUMN id_grau_educacional INT REFERENCES grau_educacional(id_grau_educacional);

ALTER TABLE dados_trabalhistas
ADD COLUMN id_colaborador INT UNIQUE REFERENCES colaborador(id_colaborador);

ALTER TABLE dados_bancarios
ADD COLUMN id_colaborador INT UNIQUE REFERENCES colaborador(id_colaborador);

ALTER TABLE contrato
ADD COLUMN id_colaborador INT REFERENCES colaborador(id_colaborador),
ADD COLUMN id_grau_hierarquico INT REFERENCES grau_hierarquico(id_grau_hierarquico),
ADD COLUMN id_data_admissao INT REFERENCES data_admissao(id_data_admissao),
ADD COLUMN id_data_demissao INT REFERENCES data_demissao(id_data_demissao);

ALTER TABLE departamento_colaborador
ADD COLUMN id_colaborador INT REFERENCES colaborador(id_colaborador),
ADD COLUMN id_departamento INT REFERENCES departamento(id_departamento);

ALTER TABLE beneficio_colaborador
ADD COLUMN id_beneficio INT REFERENCES beneficio(id_beneficio),
ADD COLUMN id_colaborador INT REFERENCES colaborador(id_colaborador);

ALTER TABLE dependentes
ADD COLUMN id_colaborador INT REFERENCES colaborador(id_colaborador);

ALTER TABLE ferias
ADD COLUMN id_colaborador INT REFERENCES colaborador(id_colaborador);

ALTER TABLE exame_colaborador
ADD COLUMN id_colaborador INT REFERENCES colaborador(id_colaborador),
ADD COLUMN id_exame INT REFERENCES exames_obrigatorios(id_exame),
ADD COLUMN id_medico INT REFERENCES medico(id_medico);

ALTER TABLE contato
ADD COLUMN id_colaborador INT REFERENCES colaborador(id_colaborador);

ALTER TABLE historico_cargo
ADD COLUMN id_colaborador INT REFERENCES colaborador(id_colaborador),
ADD COLUMN id_departamento_antigo INT REFERENCES departamento(id_departamento),
ADD COLUMN id_departamento_novo INT REFERENCES departamento(id_departamento);

