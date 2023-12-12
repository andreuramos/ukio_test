build:
	docker-compose up -d

test: 
	mix test

start:
	mix phx.server