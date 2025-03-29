# DIO-BOOTCAMP-E-COMMERCE-REFINADO
Feito para o bootcamp da Heinekein da DIO, este projeto implementa um banco de dados relacional para e-commerce, atendendo aos requisitos definidos e permitindo análises detalhadas das informações. Com uma estrutura bem definida, possibilita expansões futuras e melhorias conforme necessário.

# Banco de Dados E-commerce

## 📌 Descrição do Projeto ##

Este projeto consiste na modelagem e implementação do banco de dados para um sistema de e-commerce. O banco foi estruturado considerando os requisitos especificados no desafio, utilizando conceitos como chaves primárias, chaves estrangeiras, constraints e modelagem EER (Enhanced Entity-Relationship Model).

A estrutura foi projetada para armazenar informações de clientes, produtos, pedidos, pagamentos, estoque, vendedores e fornecedores, permitindo consultas complexas para gestão do sistema.

## 🎯 Objetivo do Projeto ##

O banco de dados foi modelado para atender aos seguintes requisitos:

-> Diferenciar clientes Pessoa Física (PF) e Pessoa Jurídica (PJ),

-> Permitir mais de uma forma de pagamento por cliente,

-> Controlar status e código de rastreio das entregas,

-> Registrar pedidos, produtos, fornecedores, vendedores e estoque,

-> Criar consultas SQL para extrair informações relevantes.

## 📂 Modelagem do Banco de Dados ##

O esquema lógico do banco de dados é composto pelas seguintes tabelas:

### 🛒 Clients (Clientes) ###
Armazena informações sobre os clientes, diferenciando entre PF e PJ.
idClient (PK) - Identificador único do cliente
Fname, Mnit, Lname - Nome do cliente
Document - CPF ou CNPJ (com constraint para validação)
Address - Endereço
TypeClient - Define se é "PF" ou "PJ"

### 📦 Product (Produtos) ###
Registra os produtos disponíveis para venda.
idProduct (PK) - Identificador único do produto
Pname - Nome do produto
Classification_kids - Indica se é para crianças
Category - Categoria do produto
Review - Avaliação média
Size - Dimensões do produto
Price - Preço do produto

### 💳 Payments (Pagamentos) ###
Registra formas de pagamento associadas aos clientes.
idPayment (PK) - Identificador do pagamento
idClient (FK) - Relacionamento com Clients
TypePayment - Tipo de pagamento (dinheiro, crédito, débito, etc.)
LimitAvailable - Limite de crédito disponível

### 🚚 Delivery (Entregas) ###
Gerencia os status e rastreamento de entregas.
idDelivery (PK) - Identificador da entrega
OrderStatus - Status do pedido (Confirmado, Em Processamento, Cancelado)
TrackingCode - Código de rastreio

### 📑 Orders (Pedidos) ###
Registra os pedidos feitos pelos clientes.
idOrder (PK) - Identificador do pedido
idOrderClient (FK) - Cliente que fez o pedido
idPayment (FK) - Forma de pagamento usada
idDeliveryOrder (FK) - Informações da entrega
OrderDescription - Descrição do pedido
SendValue - Valor do frete
PaymentCash - Indica se foi pago à vista

### 🏪 Supplier (Fornecedores) ###
Registra os fornecedores dos produtos.
idSupplier (PK) - Identificador do fornecedor
SocialName - Razão social
CNPJ - Identificação da empresa
Contact - Contato

### 🏬 Seller (Vendedores) ###
Registra os vendedores cadastrados na plataforma.
idSeller (PK) - Identificador do vendedor
SocialName - Razão social
AbstName - Nome fantasia
CNPJ ou CPF - Identificação
Location - Localização
Contact - Contato

### 🏭 Storage (Estoque) ###
Gerencia os locais onde os produtos estão armazenados.
idProdStorage (PK) - Identificador do estoque
StorageLocation - Localização do estoque
Quantity - Quantidade de produtos

## 🔗 Relações entre Tabelas ##
productOrder associa produtos aos pedidos
productSeller relaciona produtos com vendedores

productSupplier vincula produtos aos fornecedores

storageLocation liga produtos ao estoque
