CREATE DATABASE IF NOT EXISTS tdv COLLATE 'utf8_general_ci';

CREATE TABLE IF NOT EXISTS clientes (
	id INT NOT NULL AUTO_INCREMENT,
	nome VARCHAR(120) NOT NULL DEFAULT '',
	cidade VARCHAR(120) NOT NULL DEFAULT '',
	uf CHAR(2) NOT NULL DEFAULT '',
	PRIMARY KEY (id),
	INDEX index_nome (nome)
);

INSERT INTO clientes (nome, cidade, uf) VALUES ('Ângelo Câmara Castro', 'Rio Branco', 'AC');
INSERT INTO clientes (nome, cidade, uf) VALUES ('Gonçalo Saldanha Bonifacio', 'Arapiraca', 'AL');
INSERT INTO clientes (nome, cidade, uf) VALUES ('Fernando Barradas Hernandes', 'Macapá', 'AP');
INSERT INTO clientes (nome, cidade, uf) VALUES ('Joaquim Torres Pires', 'Manaus', 'AM');
INSERT INTO clientes (nome, cidade, uf) VALUES ('Ângelo Pereira Machado', 'Salvador', 'BA');
INSERT INTO clientes (nome, cidade, uf) VALUES ('Luna Guerra Varela', 'Fortaleza', 'CE');
INSERT INTO clientes (nome, cidade, uf) VALUES ('Lorena Abrantes Coelho', 'Vitória', 'ES');
INSERT INTO clientes (nome, cidade, uf) VALUES ('Mia Siqueira Costa', 'Goiás', 'GO');
INSERT INTO clientes (nome, cidade, uf) VALUES ('Joaquim Aurora Leite Rodrigues', 'São Luiz', 'MA');
INSERT INTO clientes (nome, cidade, uf) VALUES ('Matias Isaac Aranha de Mascarenhas', 'Sinop', 'MT');
INSERT INTO clientes (nome, cidade, uf) VALUES ('Tomé Agra Leite', 'Campo Grande', 'MS');
INSERT INTO clientes (nome, cidade, uf) VALUES ('Clara de Saraiva Amaral', 'São Thomé das Letras', 'MG');
INSERT INTO clientes (nome, cidade, uf) VALUES ('Pilar Chão de Magalhães', 'Belém', 'PA');
INSERT INTO clientes (nome, cidade, uf) VALUES ('Áurea Nunes Venancio', 'João Pessoa', 'PB');
INSERT INTO clientes (nome, cidade, uf) VALUES ('João Mascarenhas Portela', 'Curitiba', 'PR');
INSERT INTO clientes (nome, cidade, uf) VALUES ('Adrien Ávila França', 'Recife', 'PE');
INSERT INTO clientes (nome, cidade, uf) VALUES ('Vitória Feijóo Guardado', 'Teresina', 'PI');
INSERT INTO clientes (nome, cidade, uf) VALUES ('Noa Ivo Santiago Portela', 'Niterói', 'RJ');
INSERT INTO clientes (nome, cidade, uf) VALUES ('Vera de Albuquerque Botelho', 'Natal', 'RN');
INSERT INTO clientes (nome, cidade, uf) VALUES ('Mia Clezar Morais', 'Porto Alegre', 'RS');
INSERT INTO clientes (nome, cidade, uf) VALUES ('Dylan Topete de Freitas', 'Porto Velho', 'RO');
INSERT INTO clientes (nome, cidade, uf) VALUES ('Matilde de Brito Luz', 'Boa Vista', 'RR');
INSERT INTO clientes (nome, cidade, uf) VALUES ('Érica Veiga de Magalhães Mota ', 'Chapecó', 'SC');
INSERT INTO clientes (nome, cidade, uf) VALUES ('Adriana Lisboa Borges', 'São José do Rio Preto', 'SP');
INSERT INTO clientes (nome, cidade, uf) VALUES ('Santiago Vieira Vieira', 'Aracaju', 'SE');
INSERT INTO clientes (nome, cidade, uf) VALUES ('Bernardo d`Ávila Abrantes', 'Palmas', 'TO');
INSERT INTO clientes (nome, cidade, uf) VALUES ('Nicole de Medeiros Gadelha', 'Gama', 'DF');
INSERT INTO clientes (nome, cidade, uf) VALUES ('Giovanna Sarmento Brandão', 'Mirassol', 'SP');
INSERT INTO clientes (nome, cidade, uf) VALUES ('Manuel Florencio Seixas', 'Contagem', 'MG');
INSERT INTO clientes (nome, cidade, uf) VALUES ('Sérgio Nicolau Abreu', 'Anápolis', 'GO');

CREATE TABLE IF NOT EXISTS produtos (
	id INT NOT NULL AUTO_INCREMENT,
	descricao VARCHAR(120) NOT NULL DEFAULT '',
	preco DECIMAL(18,2) NOT NULL DEFAULT '0.00',
	PRIMARY KEY (id),
	INDEX index_descricao (descricao)
);

INSERT INTO produtos (descricao, preco) VALUES ('Arroz', 139.06);
INSERT INTO produtos (descricao, preco) VALUES ('Feijão', 214.80);
INSERT INTO produtos (descricao, preco) VALUES ('Óleo', 42.87);
INSERT INTO produtos (descricao, preco) VALUES ('Sal', 31.53);
INSERT INTO produtos (descricao, preco) VALUES ('Açúcar', 99.46);
INSERT INTO produtos (descricao, preco) VALUES ('Café', 8.63);
INSERT INTO produtos (descricao, preco) VALUES ('Molho de tomate', 151.24);
INSERT INTO produtos (descricao, preco) VALUES ('Macarrão espaguete', 285.50);
INSERT INTO produtos (descricao, preco) VALUES ('Sardinha', 35.81);
INSERT INTO produtos (descricao, preco) VALUES ('Salsicha', 168.76);
INSERT INTO produtos (descricao, preco) VALUES ('Milho', 180.57);
INSERT INTO produtos (descricao, preco) VALUES ('Farinha de trigo', 223.54);
INSERT INTO produtos (descricao, preco) VALUES ('Biscoito doce', 7.06);
INSERT INTO produtos (descricao, preco) VALUES ('Pão de forma', 203.22);
INSERT INTO produtos (descricao, preco) VALUES ('Manteiga', 221.55);
INSERT INTO produtos (descricao, preco) VALUES ('Banana', 100.06);
INSERT INTO produtos (descricao, preco) VALUES ('Leite em pó', 215.10);
INSERT INTO produtos (descricao, preco) VALUES ('Temperos', 106.20);
INSERT INTO produtos (descricao, preco) VALUES ('Achocolatado', 15.04);
INSERT INTO produtos (descricao, preco) VALUES ('Doces', 228.92);
INSERT INTO produtos (descricao, preco) VALUES ('Leite condensado', 247.63);
INSERT INTO produtos (descricao, preco) VALUES ('Mel', 87.38);
INSERT INTO produtos (descricao, preco) VALUES ('Iogurte', 85.49);
INSERT INTO produtos (descricao, preco) VALUES ('Papel higiênico', 6.95);
INSERT INTO produtos (descricao, preco) VALUES ('Molho de tomate', 34.68);
INSERT INTO produtos (descricao, preco) VALUES ('Fermento de pó', 252.14);
INSERT INTO produtos (descricao, preco) VALUES ('Farinha de tapioca', 148.99);
INSERT INTO produtos (descricao, preco) VALUES ('Aveia', 97.46);
INSERT INTO produtos (descricao, preco) VALUES ('Massa pronta de bolos', 181.55);
INSERT INTO produtos (descricao, preco) VALUES ('Dúzia de ovos', 119.91);

CREATE TABLE IF NOT EXISTS pedidos (
	id INT NOT NULL AUTO_INCREMENT,
	dataemissao datetime NOT NULL,
	cliente_id INTEGER NOT NULL,
	valortotal DECIMAL(18,2) NOT NULL DEFAULT '0.00',
	PRIMARY KEY (id),
	INDEX index_cliente_id (cliente_id),
	CONSTRAINT fk_cliente FOREIGN KEY (cliente_id) REFERENCES clientes (id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS pedidos_produtos (
	id INT NOT NULL AUTO_INCREMENT,
	pedido_id INTEGER NOT NULL,
	produto_id INTEGER NOT NULL,
	quantidade INTEGER NOT NULL DEFAULT 0,
	valorunitario DECIMAL(18,2) NOT NULL DEFAULT '0.00',
	valortotal DECIMAL(18,2) NOT NULL DEFAULT '0.00', 
	PRIMARY KEY (id),
	INDEX index_pedido_id (pedido_id),
	INDEX index_produto_id (produto_id),
	CONSTRAINT fk_pedido FOREIGN KEY (pedido_id) REFERENCES pedidos (id) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT fk_produto FOREIGN KEY (produto_id) REFERENCES produtos (id) ON UPDATE CASCADE ON DELETE CASCADE
);
