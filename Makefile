.PHONY: up exec down remove server

up:
	docker compose up -d

exec:
	docker compose exec memoapp bash

down:
	docker compose down

remove:
	docker compose down --rmi all --volumes

server:
	rails server -b 0.0.0.0
