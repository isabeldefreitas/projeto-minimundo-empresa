-- CONSULTAS SQL - MINIMUNDO EMPRESA

--Listar colaboradores ativos em determinado departamento
SELECT c.id_colaborador, c.nome_colaborador, d.nome_departamento
FROM colaborador c
JOIN contrato ct ON c.id_colaborador = ct.id_colaborador
JOIN departamento_colaborador dc ON c.id_colaborador = dc.id_colaborador
JOIN departamento d ON dc.id_departamento = d.id_departamento
WHERE ct.status = 'Ativo'
  AND d.nome_departamento = 'TI';


-- Consultar dependentes de um colaborador
SELECT c.nome_colaborador, d.nome_dependente, d.tipo_relacionamento, d.data_nascimento_dependente
FROM colaborador c
JOIN dependentes d ON c.id_colaborador = d.id_colaborador
WHERE c.nome_colaborador = 'Carlos Andrade';


-- Verificar exames vencidos
-- Exames cujo "data_proximo_exame" já passou
SELECT c.nome_colaborador, e.nome_exame, ec.data_exame, ec.data_proximo_exame
FROM exame_colaborador ec
JOIN colaborador c ON ec.id_colaborador = c.id_colaborador
JOIN exames_obrigatorios e ON ec.id_exame = e.id_exame
WHERE ec.data_proximo_exame < CURRENT_DATE;


-- Calcular custo de benefícios por departamento
SELECT d.nome_departamento,
       SUM(bc.valor_total) AS custo_total,
       SUM(bc.valor_descontado) AS total_descontado,
       SUM(bc.valor_total - bc.valor_descontado) AS custo_liquido_empresa
FROM beneficio_colaborador bc
JOIN colaborador c ON bc.id_colaborador = c.id_colaborador
JOIN departamento_colaborador dc ON c.id_colaborador = dc.id_colaborador
JOIN departamento d ON dc.id_departamento = d.id_departamento
WHERE bc.status = 'Ativo'
GROUP BY d.nome_departamento;


-- CONSULTAS DE MELHORIA - HISTÓRICO DE CARGO

-- Ver promoções de um colaborador

SELECT c.nome_colaborador,
       h.cargo_antigo,
       h.cargo_novo,
       h.salario_antigo,
       h.salario_novo,
       h.data,
       h.motivo
FROM historico_cargo h
JOIN colaborador c ON h.id_colaborador = c.id_colaborador
WHERE c.nome_colaborador = 'Carlos Andrade'
ORDER BY h.data DESC;


-- Listar colaboradores que já receberam promoção (aumento salarial)
SELECT DISTINCT c.nome_colaborador
FROM historico_cargo h
JOIN colaborador c ON h.id_colaborador = c.id_colaborador
WHERE h.salario_novo > h.salario_antigo;



-- Diferença salarial média por departamento (histórico)
SELECT d.nome_departamento,
       ROUND(AVG(h.salario_novo - h.salario_antigo), 2) AS aumento_medio
FROM historico_cargo h
JOIN colaborador c ON h.id_colaborador = c.id_colaborador
JOIN departamento_colaborador dc ON c.id_colaborador = dc.id_colaborador
JOIN departamento d ON dc.id_departamento = d.id_departamento
WHERE h.salario_novo > h.salario_antigo
GROUP BY d.nome_departamento;



-- Último cargo de cada colaborador
SELECT c.nome_colaborador,
       h.cargo_novo,
       h.salario_novo,
       h.data
FROM historico_cargo h
JOIN colaborador c ON h.id_colaborador = c.id_colaborador
WHERE h.data = (
    SELECT MAX(h2.data)
    FROM historico_cargo h2
    WHERE h2.id_colaborador = h.id_colaborador
);
