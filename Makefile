dev00:

	cp caddy/dev.Caddyfile caddy/Caddyfile
	cp docker-compose.local.yml docker-compose.yml	

	# # bu72	
	# cp bu72_front/code/nuxt.config.local.ts bu72_front/code/nuxt.config.ts

	# make start
	# docker-compose up --build
	# docker-compose down
	# docker-compose up --build -d --remove-orphans
	# docker-compose up --abort-on-container-exit
	# docker-compose up --build -d
	docker-compose up -d

	# docker exec -w /etc/caddy caddy caddy fmt

	make caddy_refresh_cfd

	# # docker-compose exec ttt72_laravel ./vendor/bin/sail up

	# ttt72_laravel 
	# docker-compose exec ttt72_laravel composer i
	# docker-compose exec ttt72_laravel php artisan migrate

dev:

	# cp caddy/dev.Caddyfile caddy/Caddyfile
	cp caddy/prod.Caddyfile caddy/Caddyfile
	cp docker-compose.local.yml docker-compose.yml	
	# cp docker-compose.prod.yml docker-compose.yml	

	docker-compose up -d

	make caddy_refresh_cfd

	docker exec ttt72_laravel composer i
	docker exec ttt72_laravel php artisan migrate

	# docker exec sym_test composer i
	# docker exec sym_test symfony -h
	# docker exec sym_test php composer i

prod:

	cp caddy/prod.Caddyfile caddy/Caddyfile
	cp docker-compose.prod.yml docker-compose.yml

	# cp bu72_front/code/nuxt.config.prod.ts bu72_front/code/nuxt.config.ts

	make start

start0:

	docker-compose exec ttt72_laravel php artisan storage:link
	docker-compose up -d

start00:

	# docker stop $(docker ps -a -q)
	# docker rm $(docker ps -a -q)

	# docker-compose up --build -d --remove-orphans
	docker-compose up -d

	# docker-compose exec bu72_back composer i
	# docker-compose exec bu72_back php artisan migrate

	# docker-compose exec ttt72_laravel ls 
	# docker-compose exec caddy restart caddy

	# docker-compose exec ttt72_laravel php composer.phar i --no-dev
	docker exec ttt72_laravel php composer.phar i --no-dev

	# docker-compose exec ttt72_laravel php artisan migrate
	docker exec ttt72_laravel php artisan migrate
	
	make caddy_refresh_cfd

start:

	docker-compose up -d

	make caddy_refresh_cfd
	
	docker exec ttt72_laravel composer i --no-dev
	docker exec ttt72_laravel php artisan migrate
	

caddy_refresh_cfd:

	docker exec -w /etc/caddy caddy caddy reload
