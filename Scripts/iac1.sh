#!/bin/bash

echo "Criando diretórios..."

mkdir /publico
mkdir /adm
mkdir /ven
mkdir /sec

echo "Criando grupos..."

groupadd GRP_ADM
groupadd GRP_VEN
groupadd GRP_SEC

echo "Criando users..."

useradd carlos -c "Carlos Eduardo" -m -s /bin/bash -p Mudar123 -G GRP_ADM 
useradd maria -c "Maria Silva" -m -s /bin/bash -p Mudar123 -G GRP_ADM
useradd joao -c "João Pedro" -m -s /bin/bash -p Mudar123 -G GRP_ADM

useradd debora -c "Debora Cristina" -m -s /bin/bash -p Mudar123 -G GRP_VEN 
useradd sebastiana -c "Sebastiana Santos" -m -s /bin/bash -p Mudar123 -G GRP_VEN 
useradd roberto -c "Roberto Romeu" -m -s /bin/bash -p Mudar123 -G GRP_VEN 

useradd josefina -c "Josefina Fiocruz" -m -s /bin/bash -p Mudar123 -G GRP_SEC 
useradd amanda -c "Amanda Memes" -m -s /bin/bash -p Mudar123 -G GRP_SEC 
useradd rogerio -c "Rogerio Senna" -m -s /bin/bash -p Mudar123 -G GRP_SEC 

echo "Alterando permissoes..."

chown root:GRP_ADM /adm
chown root:GRP_VEN /ven
chown root:GRP_SEC /sec

chmod 777 /publico
chmod 770 /adm
chmod 770 /ven
chmod 770 /sec

echo "Finalizado..."
