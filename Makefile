dev:
	cp caddy/dev.Caddyfile caddy/Caddyfile
	cp docker-compose.local.yml docker-compose.yml	
	#docker-compose up --build
	make dev

prod:
	cp caddy/prod.Caddyfile caddy/Caddyfile
	cp docker-compose.prod.yml docker-compose.yml
	#docker-compose up --build -d
	make prod
	php composer.phar i
	php artisan migrate