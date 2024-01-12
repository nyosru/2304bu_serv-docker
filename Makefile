#
#creat: creat_caddyfile
#
#creat_caddyfile: ./../upr_serv/storage/app/caddy/777example.txt ./../upr_serv/storage/app/caddy/777example.txt
#	cat &^ > output_file.txt

ca:
	docker-compose up -d
	docker cp upr_serv:/home/upr_serv/storage/app/Caddyfile-new ./Caddyfile-new
	#docker-compose down
	#docker cp ./Caddyfile-new caddy:/etc/caddy/Caddyfile
	#docker cp ./Caddyfile-new /2304bu_serv-docker/caddy/Caddyfile
	#cp ./Caddyfile-new /2304bu_serv-docker/caddy/Caddyfile
	#cp ./Caddyfile-new /etc/caddy/Caddyfile
	cp ./Caddyfile-new ./caddy/Caddyfile
	cp ./Caddyfile-new ./caddy/Caddyfile.new
	#docker cp ./Caddyfile-new caddy:/etc/caddy/Caddyfile
	#docker cp ./Caddyfile-new caddy:/caddy/Caddyfile
	#cp docker-compose.local.yml docker-compose.yml
#	cp caddy/Caddyfile.new caddy/Caddyfile
	docker-compose up -d
	#cp caddy/dev.Caddyfile caddy/Caddyfile
	#make caddy_refresh_cfd
	#docker-compose up -d

dev:
	cp caddy/dev.Caddyfile caddy/Caddyfile
	# cp caddy/prod.Caddyfile caddy/Caddyfile
	cp docker-compose.local.yml docker-compose.yml
	# cp docker-compose.prod.yml docker-compose.yml	

	docker-compose up -d

#	make start_2309livewire
	make start_2308beget_dev
#	make start_test231012
#	make start_2302didrive
# make start_2401test
	make caddy_refresh_cfd

#	make start_2308beget_dev
#	make start_base17
# make start_base16sites

	# docker exec 2309larawire composer i
	# docker exec 2309larawire php artisan migrate

	# docker exec ttt72 composer i
	# docker exec ttt72 php artisan migrate

	# docker exec base17 composer i
	# docker exec base17 php artisan migrate
	# # docker exec base17_node npm i
	# # docker exec base17 npm i

	# docker exec sym_test composer i
	# docker exec sym_test symfony -h
	# docker exec sym_test php composer i

prod:
	cp caddy/prod.Caddyfile caddy/Caddyfile
	cp docker-compose.prod.yml docker-compose.yml
	# cp bu72_front/code/nuxt.config.prod.ts bu72_front/code/nuxt.config.ts
	docker-compose up -d --build

	#	make start
	# make start_2309livewire
	#make start_2309livewire_prod

	make start_2308beget
	make start_test231012_prod
	make start_2401test

	make caddy_refresh_cfd
	docker system prune --force

start:
	make caddy_refresh_cfd
	make start_2308beget
	make start_2309livewire

#	docker exec ttt72_laravel composer i --no-dev
#	docker exec ttt72_laravel php artisan migrate

#	docker exec base17 composer i --no-dev
#	docker exec base17 php artisan migrate
	# docker exec base17 npm i


start_2308beget:
	docker exec 2308beget composer i --no-dev
#	docker exec 2308beget composer i
	docker exec 2308beget php artisan migrate
	#docker exec 2308beget npm run build
	docker exec 2308beget chown -R www-data:www-data storage

start_2308beget_dev:
	docker exec 2308beget composer i
	docker exec 2308beget php artisan migrate
	#docker exec 2308beget npm run build
	#docker exec 2308beget php artisan storage:link


start_base17:
	docker exec base17 php composer.phar i
	#docker exec base17 composer i
	docker exec base17 php artisan migrate
	#docker exec base17 npm run build
	docker exec base17 npm run prod

start_base16sites:
	docker exec base16sites php composer.phar i
	#docker exec base17 composer i
	docker exec base16sites php artisan migrate
	#docker exec base17 npm run build
	#docker exec base16sites npm run prod

start_2309livewire:
	docker exec 2309livewire composer i
	docker exec 2309livewire php artisan migrate

start_test231012:
	docker exec test231012 composer i
	docker exec test231012 php artisan migrate
	docker exec test231012 php artisan l5-swagger:generate

start_test231012_prod:
	docker exec test231012 composer i --no-dev
	docker exec test231012 php artisan migrate
	docker exec test231012 php artisan l5-swagger:generate

start_2309livewire_prod:
	docker exec 2309livewire composer i --no-dev
	docker exec 2309livewire php artisan migrate

start_2302didrive:
	docker exec 2302didrive composer i
	docker exec 2302didrive php artisan migrate
	#docker exec 2302didrive php artisan l5-swagger:generate

start_2401test:
	docker exec 2401test composer i
	docker exec 2401test php artisan migrate

start_2302didrive_prod:
	docker exec 2302didrive composer i --no-dev
	docker exec 2302didrive php artisan migrate
	docker exec 2302didrive php artisan l5-swagger:generate


caddy_refresh_cfd:
	docker exec -w /etc/caddy caddy caddy reload












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

