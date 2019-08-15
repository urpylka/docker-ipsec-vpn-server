all: up

setup: up
	docker exec -it ipsec-vpn-server vpncli

up:
	docker-compose up -d

build: clean
	docker-compose build

clean: down
	docker rmi docker-ipsec-vpn-server_vpn

down:
	docker-compose down

ps:
	docker ps | grep "ipsec-vpn-server"
