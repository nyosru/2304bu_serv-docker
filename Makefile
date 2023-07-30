dev:

	cp caddy/dev.Caddyfile caddy/Caddyfile
	cp docker-compose.local.yml docker-compose.yml	

	# # bu72	
	# cp bu72_front/code/nuxt.config.local.ts bu72_front/code/nuxt.config.ts

	# make start
	# docker-compose up --build

	# docker-compose down
	# docker-compose up --build -d --remove-orphans
	# docker-compose up --abort-on-container-exit
	docker-compose up --build -d

	# # docker-compose exec ttt72_laravel ./vendor/bin/sail up
	docker-compose exec ttt72_laravel composer i
	docker-compose exec ttt72_laravel php artisan migrate
	
prod:
	cp caddy/prod.Caddyfile caddy/Caddyfile
	cp docker-compose.prod.yml docker-compose.yml
	# cp bu72_front/code/nuxt.config.prod.ts bu72_front/code/nuxt.config.ts

	make start

start:

	docker-compose up --build -d --remove-orphans

	# docker-compose exec bu72_back composer i
	# docker-compose exec bu72_back php artisan migrate

	docker-compose exec ttt72_laravel ls 
	# docker-compose exec ttt72_laravel php composer.phar i
	# docker-compose exec ttt72_laravel php artisan migrate
