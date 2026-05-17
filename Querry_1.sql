CREATE DATABASE hotel_nebula;
USE hotel_nebula;

CREATE TABLE hospedes (
id INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(100),
email VARCHAR(100),
cpf VARCHAR(14),
telefone VARCHAR(20)
);

CREATE TABLE quartos (
id INT PRIMARY KEY AUTO_INCREMENT,
numero VARCHAR(10),
tipo VARCHAR(50),
capacidade INT,
preco_diaria DECIMAL(10,2),
status_atual VARCHAR(20)
);

CREATE TABLE reservas (
id INT PRIMARY KEY AUTO_INCREMENT,
id_hospede INT,
id_quarto INT,
data_checkin DATE,
data_checkout DATE,
status_atual VARCHAR(20)
);

CREATE TABLE hospedagens (
id INT PRIMARY KEY AUTO_INCREMENT,
id_reserva INT,
checkin_real DATETIME,
checkout_real DATETIME
);

CREATE TABLE pagamentos (
id INT PRIMARY KEY AUTO_INCREMENT,
id_hospedagem INT,
valor DECIMAL(10,2),
metodo VARCHAR(30)
);

CREATE TABLE funcionarios (
id INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(100),
cargo VARCHAR(50)
);

CREATE TABLE servicos (
id INT PRIMARY KEY AUTO_INCREMENT,
nome_servico VARCHAR(100),
id_funcionario INT,
preco DECIMAL(10,2)
);

CREATE TABLE feedbacks (
id INT PRIMARY KEY AUTO_INCREMENT,
id_hospede INT,
nota INT,
comentario VARCHAR(200)
);


INSERT INTO hospedes (nome, email) VALUES
('João Silva', 'joao@email.com'),
('Maria Souza', 'maria@email.com');

INSERT INTO quartos (numero, tipo, capacidade, preco_diaria, status_atual) VALUES
('101', 'Simples', 2, 150.00, 'disponivel'),
('102', 'Luxo', 2, 300.00, 'ocupado');

INSERT INTO reservas (id_hospede, id_quarto, data_checkin, data_checkout, status_atual) VALUES
(1, 1, '2025-06-01', '2025-06-05', 'confirmada'),
(2, 2, '2025-06-02', '2025-06-06', 'cancelada');

INSERT INTO hospedagens (id_reserva, checkin_real, checkout_real) VALUES
(1, '2025-06-01 14:00:00', '2025-06-05 12:00:00');

INSERT INTO pagamentos (id_hospedagem, valor, metodo) VALUES
(1, 600.00, 'cartao');

INSERT INTO funcionarios (nome, cargo) VALUES
('Ana', 'Recepcionista'),
('Bruno', 'Limpeza');

INSERT INTO servicos (nome_servico, id_funcionario, preco) VALUES
('Café da manhã', 1, 50.00),
('Limpeza', 2, 80.00);

INSERT INTO feedbacks (id_hospede, nota, comentario) VALUES
(1, 5, 'Excelente'),
(2, 3, 'Ok');

-- CONSULTAS

-- Quartos disponíveis
SELECT *
FROM quartos
WHERE id NOT IN (
    SELECT id_quarto
    FROM reservas
    WHERE status_atual != 'cancelada'
);

-- Hóspedes com mais reservas
SELECT id_hospede, COUNT(*)
FROM reservas
GROUP BY id_hospede
ORDER BY COUNT(*) DESC;

-- Faturamento total (não há data para mês)
SELECT SUM(valor)
FROM pagamentos;

-- Serviços mais consumidos
SELECT nome_servico, COUNT(*)
FROM servicos
GROUP BY nome_servico
ORDER BY COUNT(*) DESC;

-- Quartos / hóspedes com melhores avaliações
SELECT id_hospede, AVG(nota)
FROM feedbacks
GROUP BY id_hospede
ORDER BY AVG(nota) DESC;

-- Reservas canceladas
SELECT *
FROM reservas
WHERE status_atual = 'cancelada';

-- Serviços por profissional
SELECT id_funcionario, COUNT(*)
FROM servicos
GROUP BY id_funcionario;