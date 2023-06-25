dev:
	cp caddy/dev.Caddyfile caddy/Caddyfile
	cp docker-compose.local.yml docker-compose.yml	
	cp bu72_fron/code/nuxt.config.local.ts bu72_fron/code/nuxt.config.ts

	docker-compose up --build

	docker-compose exec bu72_back composer i
	docker-compose exec bu72_back php artisan migrate

prod:
	cp caddy/prod.Caddyfile caddy/Caddyfile
	cp docker-compose.prod.yml docker-compose.yml
	cp bu72_fron/code/nuxt.config.prod.ts bu72_fron/code/nuxt.config.ts

	docker-compose up --build -d
	
	docker-compose exec bu72_back composer i
	docker-compose exec bu72_back php artisan migrate