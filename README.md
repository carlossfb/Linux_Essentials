# Linux - Fundamentals

Este repositório tem como objetivo trazer um compilado dos conhecimentos essenciais relacionados a utilização do Linux, assim como scripts úteis.

## Tópicos abordados

- Ubuntu Desktop: https://ubuntu.com/download/desktop
- Ubuntu Server: https://ubuntu.com/download/server 
- VirtualBox: https://www.virtualbox.org/wiki/Downloads
- Putty: https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html

- AWS (EC2): https://portal.aws.amazon.com/billing/signup?nc2=h_ct&src=header_signup&redirect_url=https%3A%2F%2Faws.amazon.com%2Fregistration-confirmation&language=pt_br#/start/email



### Servidores Linux
- Instâncias remotas com AWS (EC2) e Putty
- Servidores de Arquivo (SAMPA)
- Servidores Web (APACHE2)
- Servidor de Banco de Dados (MySql)

## Configurando o ambiente de estudos na VM

Após a instalação do Virtual Box teremos algumas configurações que permitirão o funcionamento da nossa VM.
Execute o CMD como administrador e coloque:

```bash
  bcdedit
  bcdedit /set hypervisorlaunchtype off
```
#### Caso o hypervisorlaunchtype não apareça você precisa ir no painel de controle, na parte de programas e adicionar recursos, você irá marcar uma opção chamada "Plataforma do HyperVisor do Windows".
Feito isso, só reiniciar.
#### Crie a Máquina Virtual no Modo expert, na opção "Novo", use um disco dinâmico de no max 20GB e no mínimo 1024mb de ram.
Ao iniciar a VM criada, verá que tem a opção de selecionar o arquivo do Ubuntu baixado anteriormente, só selecionar e aguardar.

# Primeiros passos no Linux

## Navegação
O diretório de todo usuário linux é identificado como home, a navegação se dá através do comando CD assim como no windows:

```bash
    cd .. (voltar um nível na árvore de pastas)
    cd /home/user (acessar um user a partir da raiz "/")
    cd / (ir para raiz)
    cd ~ (atalho para ir para o diretório do user)
    pwd (nos mostra em detalhes o diretório atual, caminho da raiz até ele e afins)
```
diretórios que devem ser conhecidos:
- /etc/passwd (Aprofundaremos no tópico Usuários)
- /etc/group (Aprofundaremos no tópico Usuários)
- /etc/fstab (Aprofundaremos no tópico Servidores)

## Arquivos e Pastas
#### Buscar arquivos
```bash
    find nomeArquivo.txt
    find nomeArquivo*(pesquisar por nome, independente da extensão)
    find ??c(pesquisar por um nome onde o terceiro caractere é C)
    find *.txt(pesquisar todos arquivos de X extensão)
```
#### Abrir arquivo de texto
```bash
   cat arquivo.txt (abrir o arquivo de texto - ver)
```
#### Listar arquivos e pastas
Considere um diretório qualquer com pastas e arquivos numerados do 1 ao 6 (arquivo1, arquivo2...)
```bash
    ls (lista tudo no diretório atual)
    ls arquivo[1-3](listar arquivos identificados com sequência no fim do nome em um intervalo específico)
    ls arquivo[^1-3](negação de intervalo - faz o oposto do anterior)
    ls l (lista permissões, grupo, dono e afins - no caso dos diretorios)
    ls a(lista tudo, até coisas ocultas)
```
#### Criar arquivos
```bash
    touch arquivo.txt
```
#### Editor de textos
Tem vários editores, o nano é um deles:

```bash
    nano arquivo.txt
```
Salvamos alterações com CTRL+O e saímos com CTRL+X

#### Criar diretórios
```bash
    mkdir nomeDiretório
```
#### Copiar objetos
```bash
    cp /home/user/teste.txt /disk2/ (copiando da origem para o destino)
    cp /home/user/teste.txt /disk2/ -i (o -i indica que se precisar deve sobrescrever o arquivo existente no destino)
    cp * /disk2/ -r -v (copia o diretório atual para o destino, o -r indica que deve levar tbm subpastas e conteúdo)
        (-v é uma forma de pedir que o linux nos diga o que está fazendo, assim podemos acompanhar o processo em andamento)
```
#### Renomear objetos
```bash
    cp nomeAntigo.txt nomeNovo.txt (repare que também pode copiar um arquivo para outro lugar alterando seu nome ao mesmo tempo)
```
#### Mover objetos
```bash
    mv /home/user/teste.txt /disk2/
```
#### Exclusão de objetos
 ```bash
    rm nomeArquivo.txt
    rmdir nomeDiretorio
```

## Usuários e grupos
#### Super usuário - ROOT
```bash
    sudo passwd root (aqui com passwd vamos atribuir uma senha ao root)
```
Usuários onde o terminal identifica no final com $ são usuários comuns, o root é identificado com #.
#### Criando usuários
```bash
    useradd nomeUser -c "Usuário Teste" -s /bin/bash -m -p $(openssl passwd Senha123) -e 
    (-c serve para adicionar comentário, estamos colocando nome completo | -m cria o diretório do usuário na raiz | -s atribui um shell ao usuário, ajuda a identificar diretórios e arquivos através das cores do terminal no texto | -p é para definir senha | -e é para expirar a senha e pedir alteração, você pode colocar uma data também após um espaço em branco -e 30/01/2023 por exemplo)
```
#### Modificando usuários
```bash
  usermod -G adm,sudo nomeUser (o -G maiúsculo indica que iremos adicionar o usuário a mais grupos de usuário, se for só um tem o -g, se eu quiser alterar o bash uso -s, -c o comentário com o nome por ex e por aí vai, se for a senha é só usar o passwd mesmo)
```
#### Deletando usuários
```bash
  userdel -r (apaga o usuário e a pasta dele, pode adicionar -f pra forçar)  
```
#### Grupos
```bash
  groupadd GRP_NOME (adicionar um grupo com nome GRP_NOME)
  groupdel GRP_NOME (deleta o grupo)
  gpasswd -d nomeUser (remove o usuário do grupo)
```
#### Processos
  Similar ao gerenciador de tarefas do Windows, podemos matar processos em execução.
```bash
  ps aux (A todos os usuários U nome do user e hora de início X inclui processos fora do console)
  kill idProcesso (mata o processo pelo ID mostrado no comando anterior)
  Killall nomeProcesso (mata os processos com X nome, observe o nome no comando PS)
  w (permite que veja os usuários iniciados no sistema, acessos que não deveriam estar lá podem ser matados com KILL retirando o user de atividade)
  kill PID (PID é a numeração que identifica a sessão do usuário e é verificado com o comando anterior)
```
#### Permissões
  DRWX RWX RWX - nos diretórios usando um ls -l para verificar, podemos observar as permissões do diretório para o DONO, GRUPO, e DEMAIS usuários.
Repare que a primeira parte se dirige ao DONO e ele tem R(Leitura), W(Gravação), X(Execução), em resumo, pode fazer tudo.
- R=4
- W=2 
- X=1 
#### (essas numerações me permitem alterar os níveis de permissão dos diretórios.
```bash
  chmod 750 /adm/ (aqui temos o diretório ADM na raiz do Linux, alteramos a permissão para TOTAL para o dono "4+2+1" e para o GRUPO parcial "4+1", por fim, os demais não tem acesso "0".
```

## Servidores
#### Arquivo
#### Web
#### Banco de dados
