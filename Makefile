dev:
	cp caddy/dev.Caddyfile caddy/Caddyfile
	cp docker-compose.local.yml docker-compose.yml	
	docker-compose up --build

prod:
	cp caddy/prod.Caddyfile caddy/Caddyfile
	cp docker-compose.prod.yml docker-compose.yml
	docker-compose up --build -d
	#php composer.phar i
	#php artisan migrate
	docker-compose exec bu72_back composer i
	docker-compose exec bu72_back php artisan migrate