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
Devem ser conhecidos:
- /etc/passwd (Aprofundaremos no tópico Usuários)
- /etc/group (Aprofundaremos no tópico Usuários)
- /etc/fstab (Aprofundaremos no tópico Servidores)

## Arquivos e Pastas
#### Executar arquivos
```bash
  ./executavel.sh (./ faz a mágica, lembre que o arquivo precisa ter permissão de execução para você, se n tiver, só usar o chmod +x executavel.sh)
```
#### Permissões
Temos algumas letras que podemos utilizar ao invés dos numéricos 777 para permissões completas por exemplo, "o", "u" e "g", que significam respectivamente "outros", "usuario", "grupo", enquanto leitura, escrita e execução seriam "r", "w" e "x"
```bash
  sudo chmod o-r secret_folder/ (remover leitura de todos os usuários, o O significa "outros")
  sudo chmod g+w secret_folder/ (adicionar escrita ao grupo)
```
#### Dono dos arquivos ou pastas
```bash
  chown root:GRP_ADM /adm (aqui estou atribuindo o root como dono do diretório adm e grupo adm)
```

#### Buscar arquivos
```bash
    find nomeArquivo.txt
    find nomeArquivo*(pesquisar por nome, independente da extensão)
    find ??c*(pesquisar por um nome onde o terceiro caractere é C)
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
    rmdir -rf (força a exclusão de diretórios e seus conteúdos)
```

## Usuários e grupos
diretórios que devem ser conhecidos:

##### cat /etc/passwd (Ajudará a visualizar os usuários existentes, assim como no cd /home, utilizando o ls poderá ver seus respectivos diretórios)

#### Super usuário - ROOT
```bash
    sudo passwd root (aqui com passwd vamos atribuir uma senha ao root)
```
Usuários onde o terminal identifica no final com $ são usuários comuns, o root é identificado com #.
#### Criando usuários
```bash
    useradd nomeUser -c "Usuário Teste" -s /bin/bash -m -p Senha123 -G GRP_NOME
    (-c serve para adicionar comentário, estamos colocando nome completo | -m cria o diretório do usuário na raiz | -s atribui um shell ao usuário, ajuda a identificar diretórios e arquivos através das cores do terminal no texto | -p é para definir senha | -G para definir um grupo ao qual pertencerá)
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
diretórios que devem ser conhecidos:

##### cat /etc/group (Permitirá ter uma visão geral dos grupos criados e usuários pertencentes a eles) 

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

## Discos
##### /etc/fstab -> Aqui temos o local onde declararemos os discos que devem ser montados

#### Visualizando discos
```bash
  lsblk (lista os discos existentes, os identificados como loop são discos virtuais, os fisicos sao identificados como sdb ou sda, sdb1, sda1 e por aí vai)
  fdisk -l (mostra os discos de forma mais organizada e permite identificar o local do disco mais facilmente)
```
identificado o disco e seu local, partiremos para o particionamento:
```bash
  fdisk /dev/sbd (caminho identificado usando o comando fdisk -l, se precisar use o m para ter help)
```
Com a ajuda do help usei "n" nova partição "p" primaria "1" numeração "w" salvar.

##### Hora de indicar o formato de arquivos que será usado no disco

```bash
   mkfs.ext4 /dev/sdb (depois do . indicar o formato, poderia ser ntfs)
```
##### Vamos montar o disco

Os discos no linux geralmente são montados na raiz em uma pasta chamada "mnt", então bora lá:

```bash
   cd /mnt
   mkdir disco2 (vou criar o diretório do segundo disco aqui)
   mount /dev/sdb/ /mnt/disco2 (montamos o disco na pasta disco2)
   umount /dev/sdb (desmontamos o disco, os arquivos não foram perdidos, mas precisamos montar se quisermos usar)
```
Hora de automatizar a montagem dos discos no arquivo devido:
```bash
   nano /etc/fstab (aqui colocamos os discos que devem ser montados automaticamente quando ligarmos a maquina)
```
###### Dentro do arquivo, no final coloque: disco_a_montar pasta formato defaults 0 0
Ficaria assim: /dev/sdb /mnt/disco2 ext4 defaults 0 0

Com isso, agora ao reiniciar o computador seus discos serão montados automaticamente!!

## Servidores
#### Arquivo
SAMBA -> Utilizaremos o Samba para criar o compartilhamento da pasta em um disco sob controle do servidor para demais usuários, lembrando que não deve ser feito no mesmo disco onde está o sistema operacional, nós usaremos o disco externo montado DISK2.

```bash
  apt samba -y (-y é para já avançar as perguntas durante a instalação com yes)
```

Após a instalação do SAMBA nós iremos criar uma pasta com nome "publica" no disk2.

```bash
  mkdir publica (aqui já estamos dentro de disk2)
  chmod 777 /publica (alterando permissao dos usuarios)
```
##### Configuraremos agora o arquivo de configuração do SAMBA -> /etc/samba/smb.conf

No fim do arquivo criaremos o compartilhamento

```bash
   [publica] (nome do compartilhamento)
   
   path = /disk2/publica (caminho da pasta)
   writable = yes (dizemos aqui que podem gravar na pasta)
   guest ok = yes (dizemos que as todas pessoas tem acesso a pasta)
   guest only = yes (dizemos que todos que acessarem são convidados)
```
Após isso precisamos reiniciar o SAMBA para funcionarem as alterações:

```bash
  systemctl restart smbd (pode usar o mesmo comando substituindo restart por status para ver se ta ok)
  systemctl enable smbd (para quando reiniciar o serviço já estar rodando)
```
  PS=daemon são os serviços de segundo plano, assim como o samba, por isso o smb tem um D no final.
  Agora só criar um caminho de rede ou acessar no windows o ip do host + o nome da pasta para testar o caminho (\\10.0.0.19\publica) e se pedir credencial é só usar um user criado no linux.
  
#### Web
APACHE
#### Banco de dados
MySQL


## Apêndice

Links úteis
 

O que é o Linux?
https://www.vivaolinux.com.br/linux/

https://www.redhat.com/pt-br/topics/linux/what-is-linux


O que é virtualização?
https://www.techtudo.com.br/listas/2020/07/o-que-e-virtualizacao-entenda-como-funciona-o-processo-no-pc.ghtml

https://www.redhat.com/pt-br/topics/virtualization/what-is-virtualization


O que é Cloud Computing?
https://aws.amazon.com/pt/what-is-cloud-computing/

https://azure.microsoft.com/pt-pt/resources/cloud-computing-dictionary/what-is-the-cloud/

Mais informações sobre o gerenciamento de pacotes:
https://docente.ifrn.edu.br/filiperaulino/disciplinas/isa-redes2n/linux-07-gerencia-de-pacotes
https://pt.linux-console.net/?p=1516


Mais informações sobre processos no Linux:
https://www.infowester.com/linprocessos.php#:~:text=Um%20PID%20(Process%20Identifier)%20%C3%A9,mais%20processos%20ao%20mesmo%20tempo.

 O que são servidores?
https://www.qnapbrasil.com.br/blog/post/o-que-e-servidor-armazenamento-de-dados

 

Modelo cliente-servidor
https://www.gta.ufrj.br/ensino/eel878/redes1-2016-1/16_1/p2p/modelo.html
 


Distribuições linux para programadores

https://sempreupdate.com.br/melhores-distribruicoes-linux-para-programar/

https://programadorviking.com.br/linux-para-desenvolvedores-as-13-melhores-distros-para-programar/

 
Aplicativos para Linux

https://sempreupdate.com.br/melhores-aplicativos-do-ubuntu-que-voce-deveria-usar/

 
Site oficial do Apache
https://www.apache.org/


Site oficial do SAMBA
https://www.samba.org/

 

Site oficial do Mysql
https://www.mysql.com/

