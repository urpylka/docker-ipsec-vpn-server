all: build

build:
	docker-compose build

clean: down
	# docker rmi docker-ipsec-vpn-server_vpn
	docker rmi docker-ipsec-vpn-server_libreswan
	docker rmi docker-ipsec-vpn-server_xl2tpd

down:
	docker-compose down

setup:
	#docker exec -it ipsec-vpn-server vpncli
	docker exec -it xl2tpd vpncli

up: restart
restart: down start

start:
	docker-compose up -d

info: ps logs

ps:
	docker ps | grep "docker-ipsec-vpn-server_"

logs:
	docker logs xl2tpd
	docker logs libreswan

update: down reset-pull build start

reset-pull:
	git reset --hard HEAD~2
	git pull

debug:
	docker exec -it libreswan apt update
	docker exec -it libreswan apt install tcpdump
	docker exec -it libreswan tcpdump -i eth0

debug2:
	docker exec -it xl2tpd apt update
	docker exec -it xl2tpd apt install tcpdump
	docker exec -it xl2tpd tcpdump -i eth0