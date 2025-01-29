# Blood Bank App

Este repositório contém um sistema completo para gerenciamento de um banco de sangue, incluindo uma **API** desenvolvida com **Spring Boot** e um **aplicativo** desenvolvido em **Flutter**.

## Estrutura do Projeto

- **`blood_bank_app`**: Diretório do aplicativo Flutter.
- **`blood_bank_api`**: Diretório da API Spring Boot.

---

## 1. Instalação dos Requisitos

Antes de rodar o projeto, é necessário instalar algumas dependências.

### 1.1 Instalar o Java 17 (Spring Boot requer Java 17+)

#### **Windows**
1. Baixe e instale o Java 17: [Oracle JDK](https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html) ou [OpenJDK](https://adoptium.net/temurin/releases/?version=17)
2. Adicione o Java ao **Path**:
   - No terminal, digite `java -version` para verificar a instalação.

#### **macOS (via Homebrew)**
```sh
brew install openjdk@17
```

#### **Linux (via APT ou Yum)**
```sh
sudo apt update && sudo apt install openjdk-17-jdk -y
```

### 1.2 Instalar o Maven

#### **Windows**
1. Baixe o Maven em: [Apache Maven](https://maven.apache.org/download.cgi)
2. Adicione ao Path e verifique com `mvn -version`

#### **macOS/Linux (via Homebrew ou APT)**
```sh
brew install maven
# ou
sudo apt install maven -y
```

### 1.3 Instalar o MySQL

#### **Windows**
1. Baixe o MySQL Server: [MySQL Download](https://dev.mysql.com/downloads/installer/)
2. Durante a instalação, defina o **usuário:** `root` e **senha:** `admin`

#### **macOS/Linux**
```sh
brew install mysql
sudo apt install mysql-server -y
```

- Iniciar o MySQL:
```sh
mysql -u root -p
```

- Criar o banco de dados:
```sql
CREATE DATABASE blood_bank;
```

### 1.4 Instalar o Flutter 3.24.0

#### **Windows/macOS/Linux**
Baixe e instale o Flutter:
- [Windows](https://docs.flutter.dev/get-started/install/windows)
- [macOS](https://docs.flutter.dev/get-started/install/macos)
- [Linux](https://docs.flutter.dev/get-started/install/linux)

- Verifique a instalação:
```sh
flutter --version
```

---

## 2. Clonar o Repositório

```sh
git clone https://github.com/seu-repositorio/blood-bank.git
cd blood-bank
```

---

## 3. Configurar a API (`blood_bank_api`)

### 3.1 Configuração do MySQL no `application.properties`

Edite o arquivo com as informações de login do seu Mysql **`blood_bank_api/src/main/resources/application.properties`**:

```properties
spring.application.name=blood-bank
spring.datasource.url=jdbc:mysql://localhost:3306/blood_bank?createDatabaseIfNotExist=true
spring.datasource.username=root
spring.datasource.password=admin
spring.jpa.hibernate.ddl-auto=update
spring.jpa.show-sql=true
```

### 3.2 Rodar a API

Dentro do diretório **`blood_bank_api`**, execute:
```sh
./mvnw spring-boot:run
```

Caso esteja no **Windows**, use:
```sh
mvnw.cmd spring-boot:run
```

---

## 4. Configurar a URL da API no Aplicativo

Para rodar o aplicativo corretamente, é necessário configurar a URL correta da API no arquivo **`blood_bank_app/lib/repository/api_repository_impl.dart`**.

Verifique o endereço IP da sua máquina para acessar a API localmente:

- **Windows**: Execute `ipconfig` no CMD e verifique o campo **Endereço IPv4**.
- **macOS/Linux**: Execute `ifconfig` ou `ip a` no terminal e busque pelo endereço IP local.

Após obter o IP, edite o arquivo e ajuste a linha:

```dart
URL= 'SEU_IP_AQUI';
```

Substitua `SEU_IP_AQUI` pelo endereço IP correto da sua máquina na rede local.

## 5. Rodar o Aplicativo Flutter (`blood_bank_app`)

Entre no diretório **`blood_bank_app`**:
```sh
cd blood_bank_app
```

Instale as dependências do Flutter:
```sh
flutter pub get
```

Conecte um emulador ou um dispositivo físico e execute:
```sh
flutter run
```

Para gerar um **build** do aplicativo, execute:
```sh
flutter build apk --debug
```

Para rodar no Android Studio, abra o projeto e clique em **Run**.

---



