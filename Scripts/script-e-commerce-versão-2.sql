-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Clientes` (
  `idCliente` INT NOT NULL,
  `identificação` VARCHAR(45) NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Entregas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Entregas` (
  `idEntrega` INT NOT NULL,
  `códigoDeRastreio` VARCHAR(45) NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `Clientes_idCliente` INT NOT NULL,
  PRIMARY KEY (`idEntrega`),
  UNIQUE INDEX `códigoDeRastreio_UNIQUE` (`códigoDeRastreio` ASC) VISIBLE,
  INDEX `fk_Entregas_Clientes1_idx` (`Clientes_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Entrega_Cliente1`
    FOREIGN KEY (`Clientes_idCliente`)
    REFERENCES `mydb`.`Clientes` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pedidos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pedidos` (
  `idPedido` INT NOT NULL,
  `Clientes_idCliente` INT NOT NULL,
  `statusDoPedido` VARCHAR(45) NULL,
  `descrição` VARCHAR(45) NULL,
  `frete` FLOAT NULL,
  `Entregas_idEntrega` INT NOT NULL,
  PRIMARY KEY (`idPedido`, `Entregas_idEntrega`),
  INDEX `fk_Pedidos_Clientes1_idx` (`Clientes_idCliente` ASC) VISIBLE,
  INDEX `fk_Pedidos_Entregas1_idx` (`Entregas_idEntrega` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Cliente1`
    FOREIGN KEY (`Clientes_idCliente`)
    REFERENCES `mydb`.`Clientes` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_Entrega1`
    FOREIGN KEY (`Entregas_idEntrega`)
    REFERENCES `mydb`.`Entregas` (`idEntrega`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Produtos` (
  `idProduto` INT NOT NULL,
  `categoria` VARCHAR(45) NULL,
  `descrição` VARCHAR(45) NULL,
  `valor` VARCHAR(45) NULL,
  PRIMARY KEY (`idProduto`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Fornecedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Fornecedor` (
  `idFornecedor` INT NOT NULL,
  `razãoSocial` VARCHAR(45) NULL,
  `cnpj` CHAR(15) NULL,
  PRIMARY KEY (`idFornecedor`),
  UNIQUE INDEX `CNPJ_UNIQUE` (`cnpj` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Fornecimentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Fornecimentos` (
  `Fornecedores_idFornecedor` INT NOT NULL,
  `Produtos_idProduto` INT NOT NULL,
  PRIMARY KEY (`Fornecedores_idFornecedor`, `Produtos_idProduto`),
  INDEX `fk_Fornecedores_has_Produtos_Produtos1_idx` (`Produtos_idProduto` ASC) INVISIBLE,
  INDEX `fk_Fornecedores_has_Produtos_Fornecedores_idx` (`Fornecedores_idFornecedor` ASC) VISIBLE,
  CONSTRAINT `fk_Fornecedor_has_Produto_Fornecedor`
    FOREIGN KEY (`Fornecedores_idFornecedor`)
    REFERENCES `mydb`.`Fornecedor` (`idFornecedor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Fornecedor_has_Produto_Produto1`
    FOREIGN KEY (`Produtos_idProduto`)
    REFERENCES `mydb`.`Produtos` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Estoque` (
  `idEstoque` INT NOT NULL,
  `Local` VARCHAR(45) NULL,
  PRIMARY KEY (`idEstoque`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produtos em Estoque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Produtos em Estoque` (
  `Produtos_idProduto` INT NOT NULL,
  `Estoques_idEstoque` INT NOT NULL,
  `quantidade` INT NULL,
  PRIMARY KEY (`Produtos_idProduto`, `Estoques_idEstoque`),
  INDEX `fk_Produtos_has_Estoques_Estoques1_idx` (`Estoques_idEstoque` ASC) VISIBLE,
  INDEX `fk_Produtos_has_Estoques_Produtos1_idx` (`Produtos_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Estoque_Produto1`
    FOREIGN KEY (`Produtos_idProduto`)
    REFERENCES `mydb`.`Produtos` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Estoque_Estoque1`
    FOREIGN KEY (`Estoques_idEstoque`)
    REFERENCES `mydb`.`Estoque` (`idEstoque`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pedidos tem Produtos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pedidos tem Produtos` (
  `Produtos_idProduto` INT NOT NULL,
  `Pedidos_idPedido` INT NOT NULL,
  `quantidade` VARCHAR(45) NULL,
  PRIMARY KEY (`Produtos_idProduto`, `Pedidos_idPedido`),
  INDEX `fk_Produtos_has_Pedidos_Pedidos1_idx` (`Pedidos_idPedido` ASC) VISIBLE,
  INDEX `fk_Produtos_has_Pedidos_Produtos1_idx` (`Produtos_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Pedido_Produto1`
    FOREIGN KEY (`Produtos_idProduto`)
    REFERENCES `mydb`.`Produtos` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Pedido_Pedido1`
    FOREIGN KEY (`Pedidos_idPedido`)
    REFERENCES `mydb`.`Pedidos` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Terceirizados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Terceirizados` (
  `idVendedores Terceiros` INT NOT NULL,
  `razãoSocial` VARCHAR(45) NULL,
  `local` VARCHAR(45) NULL,
  PRIMARY KEY (`idVendedores Terceiros`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produtos por Vendedor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Produtos por Vendedor` (
  `Produtos_idProduto` INT NOT NULL,
  `Terceirizados_idTerceirizado` INT NOT NULL,
  `quantidade` INT NULL,
  PRIMARY KEY (`Produtos_idProduto`, `Terceirizados_idTerceirizado`),
  INDEX `fk_Produtos_has_Terceirizados_Terceirizados1_idx` (`Terceirizados_idTerceirizado` ASC) VISIBLE,
  INDEX `fk_Produtos_has_Terceirizados_Produtos1_idx` (`Produtos_idProduto` ASC) VISIBLE,
  CONSTRAINT `fk_Produto_has_Vendedores Terceiros_Produto1`
    FOREIGN KEY (`Produtos_idProduto`)
    REFERENCES `mydb`.`Produtos` (`idProduto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produto_has_Vendedores Terceiros_Vendedores Terceiros1`
    FOREIGN KEY (`Terceirizados_idTerceirizado`)
    REFERENCES `mydb`.`Terceirizados` (`idVendedores Terceiros`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pessoas Físicas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pessoas Físicas` (
  `idPessoa Física` INT NOT NULL,
  `Clientes_idCliente` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `cpf` VARCHAR(45) NOT NULL,
  `endereço` VARCHAR(45) NULL,
  `contato` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPessoa Física`, `Clientes_idCliente`),
  UNIQUE INDEX `CPF_UNIQUE` (`cpf` ASC) VISIBLE,
  INDEX `fk_Pessoa Física_Cliente1_idx` (`Clientes_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Pessoa Física_Cliente1`
    FOREIGN KEY (`Clientes_idCliente`)
    REFERENCES `mydb`.`Clientes` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pessoas Jurídicas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pessoas Jurídicas` (
  `idPessoa Jurídica` INT NOT NULL,
  `Clientes_idCliente` INT NOT NULL,
  `razãoSocial` VARCHAR(45) NOT NULL,
  `cnpj` VARCHAR(45) NOT NULL,
  `endereço` VARCHAR(45) NULL,
  `contato` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPessoa Jurídica`, `Clientes_idCliente`),
  UNIQUE INDEX `CNPJ_UNIQUE` (`cnpj` ASC) VISIBLE,
  INDEX `fk_Pessoas Jurídicas_Clientes1_idx` (`Clientes_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Pessoa Jurídica_Cliente1`
    FOREIGN KEY (`Clientes_idCliente`)
    REFERENCES `mydb`.`Clientes` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Formas de Pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Formas de Pagamento` (
  `idFormaDePagamento` INT NOT NULL,
  `nomeDoCartão` VARCHAR(45) NOT NULL,
  `númeroDoCartão` VARCHAR(45) NOT NULL,
  `vencimentoDoCartão` VARCHAR(45) NOT NULL,
  `cpfOuCnpjDoProprietárioDoCartão` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idFormaDePagamento`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Clientes tem Formas de Pagamento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Clientes tem Formas de Pagamento` (
  `Clientes_idCliente` INT NOT NULL,
  `Formas de Pagamento_idFormaDePagamento` INT NOT NULL,
  PRIMARY KEY (`Clientes_idCliente`, `Formas de Pagamento_idFormaDePagamento`),
  INDEX `fk_Cliente_has_Forma de pagamento_Forma de pagamento1_idx` (`Formas de Pagamento_idFormaDePagamento` ASC) VISIBLE,
  INDEX `fk_Cliente_has_Forma de pagamento_Cliente1_idx` (`Clientes_idCliente` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_has_Forma de pagamento_Cliente1`
    FOREIGN KEY (`Clientes_idCliente`)
    REFERENCES `mydb`.`Clientes` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_has_Forma de pagamento_Forma de pagamento1`
    FOREIGN KEY (`Formas de Pagamento_idFormaDePagamento`)
    REFERENCES `mydb`.`Formas de Pagamento` (`idFormaDePagamento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
