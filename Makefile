dev:
	cp caddy/Caddyfile.dev caddy/Caddyfile
	cp docker-compose.local.yml docker-compose.yml
	docker-compose up --build