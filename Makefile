all: build

build:
	docker-compose build

clean: down
	# docker rmi docker-ipsec-vpn-server_vpn
	docker rmi docker-ipsec-vpn-server_libreswan
	docker rmi docker-ipsec-vpn-server_xl2tpd

down:
	docker-compose down

setup: install
	# docker exec -it ipsec-vpn-server vpncli
	docker exec -it ipsec-vpn-server vpncli

up: install

install: down
	docker-compose up -d

info: ps logs

ps:
	docker ps | grep "docker-ipsec-vpn-server_"

logs:
	docker logs xl2tpd
	docker logs libreswan
