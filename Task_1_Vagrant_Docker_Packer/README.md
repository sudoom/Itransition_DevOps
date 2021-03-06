Практические задания

1. Создать базовый box с `Ubuntu 14.04` с помощью `packer`, выходной формат - `vagrant` (`virtualbox`)
2. Запустить свежую виртуальную машину в `vagrant`
3. Добавить `chef-рецепты` для установки на виртуальной машине следующего ПО:

            • Apache/Nginx, 
            • Java
            • Tomcat
            • MySQL (client & server) - последних версий.
4. Пробросить порты следующим образом: 

        хост:22022->гость:22 
        хост:22080->гость:80 
        хост:22443->гость:443 
        хост:22306->гость:3306
5. С помощью `packer`.io собрать эту же виртуальную машину `QEMU`.
6. С использованием шаблонов виртуальной машины (для `virtualbox`) создать новый шаблон - с предустановленным `mariadb` вместо `mysql`
7.   Работа с Docker
        1. Создайте папку для проекта и перейдите в нее.
        2. Установите докер на машину.
        3. Найдите на `https://hub.docker.com/` последний образ `nginx`, скачайте его используя `pull` в текущий репозиторий.
        4. Создайте папку `nginx`. Создайте в ней папку `etc` (для настроек `nginx`)
        5. Запустите контейнер (`docker run`) подмонтировав созданную папку `etc` в `/etc/nginx`, а так же сделайте проброс порта `80` из контейнера на хост в порт `8080`
        6. Откройте в браузере `http://<IP_ХОСТА>:8080`, вы должны увидеть дефолтную страницу `nginx`. Если этого не произошло, вернитесь к настройкам и устраните проблему.
        7. Остановите контейнер с `nginx`

8.  Работа с Dockerfile
       1. Создайте файл `Dockerfile` в корневой папке проекта. В этом файле из образа `ubuntu:trusty` создайте контейнер в котором требуется, обновить все пакеты системы, установить `apache2`, `ntp`, `jdk` и назначить `WORKDIR` на `/var/www/site`. Пример такого докерфайла вы можете найти на `hub.docker.com`
       2. Создайте папку `web` и в ней 2 папки, `etc` и `www`
       3. Сделайте билд контейнера указав в качестве имени `<ВАША_ФАМИЛИЯ>/apache2`, например `ivanov/apache2`
       4. Сделайте `push` полученного образа в `докерхаб`.
       5. Запустите контейнер пробросив порт `80` на хост на порт `8081`.
       6. Откройте в браузере `http://<IP_ХОСТА>:8081`, вы должны увидеть дефолтную страницы `apache`. Если этого не произошло, вернитесь к настройкам и устраните проблему.
       7. Остановите контейнер с `apache`

9.   Работа с Docker Compose
        1. Установите `docker-compose` на хост
        2. Cоздайте в корневой папке проекта файл `docker-compose.yml`
        3. В файле нужно указать 3 контейнера, 2 сделанных вами ранее и один новый с `mysql`
        4. Файл должен содержать следующие имена контейнеров
            ```
            services:
              balancer: 
                image: <ИМЯ_ОБРАЗА_ИЗ_3.7.3>
                ports:
                - 80:80/tcp 
                ...
              web:
                <ВМЕСТО_IMAGE_ИСПОЛЬЗУЙТЕ_BUILD_ДЛЯ_СБОРКИ_КОНТЕЙНЕРА_ИЗ_Dockerfile>
                volumes:
                - <ПАПКА_ПРОЕКТА>/web/etc/sites-enabled:/etc/apache2/sites-enabled
                - <ПАПКА_ПРОЕКТА>/web/www:/var/www/site
                ...
              mysql57:
                image: percona:5.7
                environment:
                  MYSQL_ROOT_PASSWORD: <ROOT_PASSWORD>
                volumes:
                - <ПАПКА_ПРОЕКТА>/mysql/configs/my.cnf:/etc/mysql/conf.d/custom.cnf
                - <ПАПКА_ПРОЕКТА>/mysql/mysql:/var/lib/mysql 
                ...
            ```
                Файл заполнен не полностью, требуется указать требуемые параметры для контейнеров и настроить links 
                между balancer <--> web и web <--> mysql57
                Требуется настроить nginx из контейнера balancer как фронт перед apache из контейнера web.

        5. Запустите `compose` и проверьте, что все 3 контейнера запустились. Только контейнер `balancer` должен смотреть наружу портом `80`, остальные контейнеры должны быть доступны только локально.
        6. Зайдите на контейнер `web` и убедитесь, что вы создали связь верно и с контейнера `web` вы видите контейнер `mysql57`.
        7. Откройте в браузере `http://<IP_ХОСТА>:80`, вы должны увидеть дефолтную страницу `apache`. Если этого не произошло, вернитесь к настройкам и устраните проблему.
                
                На этом шаге у нас запущено 3 контейнера:
                ◦ Балансировщик Nginx
                ◦ App-сервер Apache
                ◦ DB-сервер MySQL
                
               В дополнение к ним, необходимо создать еще 1 контейнер с Tomcat-сервером
                
        8. В файле `docker-compose.yml` создайте еще один контейнер, по аналогии с `apache`.
        9. На контейнере установите `JDK` и `Tomcat` любых версий, допускается использование готовых образов с `Docker Hub`.
        10. Опубликуйте `Tomcat` по порту `8080`
        11. На балансировщике выполните настройку таким образом, чтобы запросы с `http://loadbalancer/tomcat/` направлялись на сервер `Tomcat`.
