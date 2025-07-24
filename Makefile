all: up

up:
	docker-compose up -d primary replica toxiproxy
	docker-compose up --build test

down:
	docker-compose down -v

clean: down
