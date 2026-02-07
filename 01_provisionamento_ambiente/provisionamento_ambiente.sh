docker build -t anotacao_variante:v1 ./docker

docker run -it -v .:/anotacao_variante -w /anotacao_variante anotacao_variante:v1