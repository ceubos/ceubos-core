# CEUB OS
**“Nos ensinem a ter liberdade novamente”** \
\- CeubOS Core


# Adicionar contrib e non-free para os repositorios
\</etc/apt/sources.list\> \
```
deb http://deb.debian.org/debian/ buster main non-free contrib
deb-src http://deb.debian.org/debian/ buster main non-free contrib

deb http://security.debian.org/debian-security buster/updates main non-free contrib
deb-src http://security.debian.org/debian-security buster/updates main non-free contrib

deb http://deb.debian.org/debian/ buster-updates main non-free contrib
deb-src http://deb.debian.org/debian/ buster-updates main non-free contrib
``` 

Apos isso, atualizar os seus repostorios e a maquina
`sudo apt update && sudo apt upgrade`


# Instalar as dependencias
`sudo apt install live-build live-manual live-config schroot`

# Compilar sua primeira versao
1. Clone o repositorio para sua maquina \
`git clone https://github.com/ceubos/ceubos-core.git`
2. Va para o diretorio que possui as instrucoes do live build \
`cd ./ceubos-core/live`
3. Dentro do repositorio, ha um script chamado **live.sh** executeu e depois mande o live-build construir a iso
```
./live.sh
sudo lb build
```
4. Se o live-build conseguir executar sem erros, sera criado um arquivo chamado **live-image-amd64.hybrid.iso**
Para executar novamente, sera necessario excluir o atual e buildar novamente:
```
sudo lb clean --all
./live.sh
sudo lb build
```

# Tags em commit
Ao adicionar: `--no-build` no commit para evitar que o commit passe pela build do [jenkins](https://jenkins.ceubos.com.br/job/CeubOS/)

# Referencias
[live-build docs](https://live-team.pages.debian.net/live-manual/html/live-manual/about-manual.en.html)
[live-build manual](https://manpages.debian.org/testing/live-build/live-build.7.en.html)
[live-build team salsa](https://salsa.debian.org/live-team)