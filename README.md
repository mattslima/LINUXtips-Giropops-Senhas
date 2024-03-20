## **Desafio do dia 2 do PICK ( Programa Intensivo de Containers e Kubernetes)**


O desafio é criar uma imagem com o aplicativo GiropopsSenha fazendo tudo a partir de um unico dockerfile

  

## **Step 1**

Baixe o aplicativo giropops-senha diretamente do repo do Jefferson
https://github.com/badtuxx/giropops-senhas.git

  

![image](https://github.com/mattslima/LINUXtips-Giropops-Senhas/assets/55968562/24829808-a332-4d51-8ab9-3b9b880d6e98)

## **Step 2**

Vamos entrar na pasta do giropops-senhas com o comando cd giropops-senhas
Ao listar tudo com o comando ls vamos ver o arquivo requirements.txt onde vamos fazer uma pequena correção
Vamos adicionar ao final do arquivo a seguinte linha Werkzeug==2.3.7 com o seguinte comando

*`echo Werkzeug==2.3.7 >> requirements.txt`*

Antes

![image](https://github.com/mattslima/LINUXtips-Giropops-Senhas/assets/55968562/7f416c1b-daba-4f14-8d15-83fc5bd96c7d)

  
Depois

![image](https://github.com/mattslima/LINUXtips-Giropops-Senhas/assets/55968562/0e035fc4-4b9e-4209-8371-e18177f2f76d)

## **Step 3**

Bom com o arquivo da aplicação configurado vamos criar nosso Dockerfile.
tenha o Docker instalado no seu computador, caso não tenho só seguir o passo a passo do link abaixo

    https://docs.docker.com/get-docker/

 
Inicie com `vim Dockerfile`, na tela inicial do vim, clique com a tecla `i` para entrar no modo de edição

![image](https://github.com/mattslima/LINUXtips-Giropops-Senhas/assets/55968562/27f39b47-f54f-4590-8259-db807932f022)

 
Vamos adicionar o corpo do nosso Dockerfile, para salvar aperte ESC, :wq (ESC para sair do modo de edição e :wq para sair salvando write and quit)

![image](https://github.com/mattslima/LINUXtips-Giropops-Senhas/assets/55968562/72a39639-e882-4b5e-9ff0-226d331af829)

  

Aqui é o corpo de nosso Docker file, vou explicar linha por linha

  

    FROM ubuntu:22.04
    #FROM indica de qual vai ser nossa imagem base, nesse caso vamos utilizar um Ubuntu versão 22.04, caso não especifique a versão ele puxara a ultima(latest)
    WORKDIR /app
    #WORKDIR Indica qual pasta será a padrão para iniciar nossa aplicação nesse caso será na pasta app dentro do diretorio raíz /
    COPY . .
    #COPY copiará os arquivos da nossa aplicação giropops-senhas para dentro de app, dentro do container
    RUN apt-get update -y
    RUN apt-get install pip -y
    RUN pip install --no-cache-dir -r requeriments.txt
    RUN pip install flask redis prometheus_client
    RUN pip install --upgrade flask
    RUN apt-get install redis -y
    #RUN Toda essa camada de comandos será iniciada no build de nossa imagem e fará parte das configs de nosso container, nesse caso vamos instalar oque é necessário para nossa aplicação ficar no ar
    ENV REDIS_HOST=127.0.0.1
    #ENV Variavel de ambiente, nesse caso está especificando que o REDIS_HOST é o localhost, as ENV tbm ficam amarradas ao container em criação
    EXPOSE 5000
    #EXPOSE expõe uma porta do container ao mundo para acessarmos a aplicação
    CMD redis-server --daemonize yes && flask run --host=0.0.0.0
    #CMD passa um comando para o container já em execução após o build, aqui está iniciando o Redis Server e o Flask da aplicação.

 
***Tudo que está com # é comentário nos dockerfile use sem moderação.***

## **Step 4**

Agora com a aplicação configurada e com o nosso Dockerfile criado, vamos iniciar o build
Para iniciarmos o build vamos usar o seguinte comando

    docker build -t giropops-senha:1.0 .

  
**docker build:** é o comando em si
**-t:** signfica que vamos criar uma tag pra essa imagem
**giropops-senha:** é a tag criada
**.:** o ponto indica que o arquivo Dockerfile está no mesmo nivel do diretorio que estamos

![image](https://github.com/mattslima/LINUXtips-Giropops-Senhas/assets/55968562/c6efc318-cd0d-4866-847e-e2de98511027)

  
  

No terminal da pra acompanhar cada passo a passo

![image](https://github.com/mattslima/LINUXtips-Giropops-Senhas/assets/55968562/18207926-e85f-4fc0-bf69-fb37802d287d)

  

Ao finalizar

![image](https://github.com/mattslima/LINUXtips-Giropops-Senhas/assets/55968562/1662c093-3ad6-453c-8bbf-4f93bf916043)

  

Vamos verficiar nossa imagem com comando docker image ls

![image](https://github.com/mattslima/LINUXtips-Giropops-Senhas/assets/55968562/42659901-ba23-47b6-b250-56007bf9d74e)

## **Step 5**

Vamos finalmente iniciar nosso container com o comando

    docker container run -d -p 5000:5000 --name giropops giropops-senha:1.0

E em seguida digitamos o seguinte comando para ver se ele está em excução

    docker container ls

  

![image](https://github.com/mattslima/LINUXtips-Giropops-Senhas/assets/55968562/454aebda-5c1b-4072-9afb-4be4bf1c9c9b)

  

Explicando os comandos

**docker container run:** Para iniciar o container

**-d:** modo detached ele deixa o nosso terminal solto, a aplicação fica em background

**-p:** Redirecionamento de porta, indicando que a porta 5000 do container vai jogar os dados na porta 5000 do localhost

**--name:** o nome do container, neste caso giropops

**giropops-senha:1.0:** é o nome da imagem que buildamos no passo anterior e o numeral é a versão do build

  
  
  

Ao acessar localhost:5000 esse será nosso resultado

  

![image](https://github.com/mattslima/LINUXtips-Giropops-Senhas/assets/55968562/8736c586-65bb-4b63-b4ef-46a0014e6350)

