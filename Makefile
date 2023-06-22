dev:
	git fetch --all 
 	git reset --hard origin/main
	cp caddy/dev.Caddyfile caddy/Caddyfile
	cp docker-compose.local.yml docker-compose.yml
	docker-compose up --build
prod:
	git fetch --all 
 	git reset --hard origin/main
	cp caddy/prod.Caddyfile caddy/Caddyfile
	cp docker-compose.prod.yml docker-compose.yml
	docker-compose up --build