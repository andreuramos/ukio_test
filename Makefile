build:
	docker-compose up -d

test: 
	docker-compose exec ukio_test_elixir mix test