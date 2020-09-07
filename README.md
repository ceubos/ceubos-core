# ceubos-core
CeubOS Core Team 


# Atualizar seus repositorios para o backports
\</etc/apt/sources.list\> \
deb http://deb.debian.org/debian buster-backports main contrib non-free \
deb-src http://deb.debian.org/debian buster-backports main contrib non-free 

Apos isso, atualizar os seus repostorios e a maquina
`sudo apt update && sudo apt upgrade`


# Instalar as dependencias
`sudo apt install live-build live-manual live-config schroot`

# Compilar sua primeira versao
1. Clone o repositorio para sua maquina \
`git clone https://github.com/francisco-pc7063/ceubos-core.git`
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
# Referencias
https://live-team.pages.debian.net/live-manual/html/live-manual/about-manual.en.html
