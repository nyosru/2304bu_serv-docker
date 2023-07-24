dev:
	cp caddy/dev.Caddyfile caddy/Caddyfile
	cp docker-compose.local.yml docker-compose.yml	
	cp bu72_front/code/nuxt.config.local.ts bu72_front/code/nuxt.config.ts

	#make start
	docker-compose up --build
	
prod:
	cp caddy/prod.Caddyfile caddy/Caddyfile
	cp docker-compose.prod.yml docker-compose.yml
	cp bu72_front/code/nuxt.config.prod.ts bu72_front/code/nuxt.config.ts

	make start

start:

	docker-compose up --build -d

	docker-compose exec bu72_back composer i
	docker-compose exec bu72_back php artisan migrate
