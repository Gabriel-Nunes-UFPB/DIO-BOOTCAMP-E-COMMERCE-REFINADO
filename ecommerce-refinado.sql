create database ecommerce;
use ecommerce;

create table clients(
	idClient int primary key auto_increment,
    Fname varchar(10),
    Mnit char(3),
    Lname varchar(20),
    Document varchar(14) not null,
    Address varchar(30),
    TypeClient enum ("PJ", "PF"),
    constraint unique_document_client unique (Document),
    constraint chk_document check(
			(TypeClient = 'PF' AND length(Document) = 11) OR 
			(TypeClient = 'PJ' AND length(Document) = 14))
);

create table product(
	idProduct int auto_increment primary key,
    Pname varchar(10) not null,
    Classification_kids bool default false,
    Category enum("Eletronico","Móveis", "Vestimenta", "Brinquedos", "Leitura", "Alimentos"),
    Review float default 0,
    Size varchar(10), 
    Price decimal(10,2) not null,
    ProductDescription varchar(255),
    constraint unique_product_product unique (idProduct)
);

create table payments(
	idClient int,
	idPayment int auto_increment,
    TypePayment enum ("Dinheiro", "Boleto", "Pix", "Crédito", "Débito"),
    LimitAvailable float,
    primary key(idPayment),
    constraint fk_payment_idclient foreign key(idClient) references clients(idClient)
);

create table delivery(
	idDelivery int primary key auto_increment,
    OrderStatus enum("Cancelado", "Confirmado", "Em processamento"),
    TrackingCode varchar(10) not null,
    DeliveryTime time,
    constraint unique_trackingcode unique (TrackingCode)
);

create table orders(
	idOrder int auto_increment primary key,
    idOrderClient int,
    idPayment int,
    idDeliveryOrder int,
    OderDescription varchar(255),
    SendValue decimal(2) default 10,
    PaymentCash bool default false,
    constraint fk_payments_order foreign key (idPayment) references payments(idPayment),
	constraint fk_orders_client foreign key(idOrderClient) references clients(idClient),
    constraint fk_orders_delivery foreign key(idDeliveryOrder) references delivery(idDelivery) 
);

create table productsStorage(
	idProdStorage int auto_increment primary key,
	StorageLocation varchar(255),
    Quantity int default 0
);

create table supplier(
	idSupplier int auto_increment primary key,
	SocialName varchar(255) not null,
    CNPJ char(15) not null,
    Contact char(11) not null,
    constraint unique_supplier unique (CNPJ)
);

create table seller(
	idSeller int auto_increment primary key,
    SocialName varchar(255) not null,
    AbstName varchar(255),
    CNPJ char(15) not null,
    CPF char(11),
    Location varchar(255),
	Contact char(11) not null,
    constraint unique_cnpj_seller unique (CNPJ),
    constraint unique_cpf_seller unique (CPF)
);

create table productSeller(
	idPseller int,
    idProduct int,
    ProdQuantity int default 1,
    primary key (idPseller, idProduct),
    constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
	constraint fk_product_product foreign key (idProduct) references product(idProduct)
);

create table productSupplier(
	idPsSupplier int,
    idPsProduct int,
    quantity int not null,
    primary key (idPsSupplier, idPsProduct),
    constraint fk_procut_supplier_supplier foreign key (idPsSupplier) references supplier (idSupplier),
	constraint fk_procut_supplier_product foreign key (idPsProduct) references product (idProduct)
);

create table productOrder(
	idPOproduct int,
    idPOorder int,
    poQuantity int default 1,
    poSatatus enum ("Disponível", "Sem estoque") default "Disponível",
    primary key (idPOproduct, idPOorder),
    constraint fk_productorder_seller foreign key (idPOproduct) references product(idProduct),
    constraint fk_productorder_product foreign key (idPOorder) references orders(idOrder)
);

create table storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    poSatatus enum ("Disponível", "Sem estoque") default "Disponível",
    primary key (idLproduct, idLstorage),
    constraint fk_storage_location_product foreign key (idLproduct) references product(idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references productsStorage(idProdStorage)
);

-- inserindo clientes 
INSERT INTO clients (Fname, Mnit, Lname, Document, Address, TypeClient) VALUES
('Carlos', 'M.', 'Silva', '12345678901', 'Rua A, 123', 'PF'),
('Mariana', 'F.', 'Oliveira', '98765432100', 'Av. B, 456', 'PF'),
('Empresa X', NULL, NULL, '11222333000144', 'Rua C, 789', 'PJ'),
('Empresa Y', NULL, NULL, '55667788000199', 'Av. D, 101', 'PJ');

-- inserindo produtos
INSERT INTO product (Pname, Classification_kids, Category, Review, Size, Price) VALUES
('Notebook', false, 'Eletronico', 4.8, '15 pol', 3500.00),
('Sofá', false, 'Móveis', 4.2, '2m', 1500.00),
('Camiseta', false, 'Vestimenta', 4.5, 'M', 50.00),
('Lego', true, 'Brinquedos', 4.9, 'Grande', 120.00),
('Notebook6', false, 'Eletronico', 4.8, '15 pol', 3500.00),
('Notebook2', false, 'Eletronico', 4.8, '15 pol', 3500.00),
('Notebook3', false, 'Eletronico', 4.8, '15 pol', 3500.00),
('Notebook4', false, 'Eletronico', 4.8, '15 pol', 3500.00),
('Notebook5', false, 'Eletronico', 4.8, '15 pol', 3500.00),
('Livro Java', false, 'Leitura', 4.7, 'Único', 90.00);

-- inserindo formas de pagamento 
INSERT INTO payments (idClient, TypePayment, LimitAvailable) VALUES
(1, 'Crédito', 5000.00),
(2, 'Débito', 2000.00),
(3, 'Pix', 10000.00),
(4, 'Boleto', 7000.00);

-- inserindo entregas
INSERT INTO delivery (OrderStatus, TrackingCode) VALUES
('Confirmado', 'ABC123'),
('Em processamento', 'XYZ987'),
('Cancelado', 'DEF456');


-- inserindo pedidos
INSERT INTO orders (idOrderClient, idPayment, idDeliveryOrder, OderDescription, SendValue, PaymentCash) VALUES
(1, 1, 1, 'Compra de notebook', 15.00, false),
(2, 2, 2, 'Compra de camiseta', 5.00, true),
(3, 3, 3, 'Compra de livros', 10.00, false);

-- inserindo estoques 
INSERT INTO productsStorage (StorageLocation, Quantity) VALUES
('Depósito Central', 100),
('Filial Norte', 50),
('Filial Sul', 30);

-- inserindo fornecedores
INSERT INTO supplier (SocialName, CNPJ, Contact) VALUES
('Tech Supplier Ltda', '12345678000199', '11987654321'),
('Moda Fina SA', '98765432000177', '11923456789');

-- inserindo vendedores
INSERT INTO seller (SocialName, AbstName, CNPJ, CPF, Location, Contact) VALUES
('Loja Eletrônicos', 'EletroShop', '12345678000199', NULL, 'Shopping X', '11911112222'),
('Vestuário Fashion', 'ModaXPTO', '98765432000177', NULL, 'Centro Comercial', '11922223333');


--  relacionando produtos e vendedores
INSERT INTO productSeller (idPseller, idProduct, ProdQuantity) VALUES
(1, 1, 10),
(2, 3, 50);

-- relacionando podutos e fornecedores 
INSERT INTO productSupplier (idPsSupplier, idPsProduct, quantity) VALUES
(1, 1, 20),
(2, 3, 40);

-- relacionando produtos e pedidos 
INSERT INTO productOrder (idPOproduct, idPOorder, poQuantity, poSatatus) VALUES
(1, 1, 1, 'Disponível'),
(3, 2, 2, 'Disponível');

--  relacionando produtos ao estoque
INSERT INTO storageLocation (idLproduct, idLstorage, location, poSatatus) VALUES
(1, 1, 'Depósito Central', 'Disponível'),
(3, 2, 'Filial Norte', 'Disponível');

-- Filtrando Dados (WHERE Statement)
SELECT * FROM clients WHERE TypeClient = 'PJ';
-- Quais produtos são da categoria Eletrônicos?
SELECT * FROM product WHERE Category = 'Eletronico';

-- Criando Atributos Derivados
SELECT Pname, Price, Price * 1.10 AS PrecoComImposto FROM product;

-- Ordenação de Dados (ORDER BY Statement)
-- Liste os produtos ordenados pelo preço (do mais caro ao mais barato).
SELECT * FROM product ORDER BY Price DESC;
-- Liste os clientes ordenados por nome.
SELECT * FROM clients ORDER BY Fname ASC;

-- Agrupamento e Filtros (HAVING Statement)
-- Quantos produtos existem em cada categoria?
SELECT Category, COUNT(*) AS Quantidade 
FROM product 
GROUP BY Category;

-- Quais categorias possuem mais de 5 produtos cadastrados?
SELECT Category, COUNT(*) AS Quantidade 
FROM product 
GROUP BY Category 
HAVING COUNT(*) > 5;

--  Junções entre tabelas (JOIN Statement)
-- Quais pedidos foram feitos por cada cliente?
SELECT c.Fname, c.Lname, o.idOrder 
FROM clients c
JOIN orders o ON c.idClient = o.idOrderClient;

-- Algum vendedor também é fornecedor?
SELECT s.SocialName 
FROM seller s
JOIN supplier sup ON s.CNPJ = sup.CNPJ;

-- Relação entre produtos, fornecedores e estoques
SELECT p.Pname, sup.SocialName, ps.Quantity 
FROM product p
JOIN productSupplier ps ON p.idProduct = ps.idPsProduct
JOIN supplier sup ON ps.idPsSupplier = sup.idSupplier;

-- Relação de nomes dos fornecedores e nomes dos produtos fornecidos.
SELECT sup.SocialName, p.Pname 
FROM supplier sup
JOIN productSupplier ps ON sup.idSupplier = ps.idPsSupplier
JOIN product p ON ps.idPsProduct = p.idProduct;



