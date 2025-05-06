# Etapa 1: Build do projeto com Maven
FROM maven:3.9.4-eclipse-temurin-21 AS builder

# Diretório de trabalho dentro do container
WORKDIR /app

# Copia os arquivos de configuração do Maven
COPY pom.xml .

# Copia o restante dos arquivos do projeto
COPY . .

# Executa o build do projeto
RUN mvn clean install -DskipTests

# Etapa 2: Imagem de execução com Java 21 (mais leve)
FROM eclipse-temurin:21-jdk

# Diretório de trabalho
WORKDIR /app

# Copia o artefato gerado na etapa de build
COPY --from=builder /app/target/*.jar app.jar

# Expõe a porta da aplicação
EXPOSE 8080

# Comando para rodar a aplicação
CMD ["java", "-jar", "app.jar"]
