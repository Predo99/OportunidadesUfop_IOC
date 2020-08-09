# Imagem Base com PHP-7.2 e o Apache instalado, vai pegar a imagem mais atual
FROM php:7.2-apache

# Repository/Image Maintainer
LABEL maintainer="Lucas Lima <lucas.developmaster@gmail.com>"

# Selecionando usuario root
USER root

# Acentando o data e a hora do container
ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN echo "date.timezone=$TZ" >> /usr/local/etc/php/conf.d/default.ini

# previnindo problemas de update dos pacotes do sistema
RUN rm -rf /var/lib/apt/lists/*
RUN rm -rf /etc/apt/sources.list.d/*

# Atualando pacotes do sistema
RUN apt-get update -y

# Extensao que auxilia o composer 
RUN apt-get install unzip -y

# Instalando, abilitando e configurando o SSL/TLS
RUN apt-get install openssl -y
RUN a2enmod ssl
RUN a2ensite default-ssl
RUN a2enmod rewrite

# Copying certificate files SSL
COPY ./apache2/default-ssl.conf /etc/apache2/sites-enabled
COPY ./apache2/000-default.conf /etc/apache2/sites-enabled
COPY ./apache2/apache2.conf /etc/apache2/

# Criar pastas para salvas arquivo SSL/TLS
RUN mkdir /etc/apache2/private && mkdir /etc/apache2/certs

# Instalando extensoes do php
RUN docker-php-ext-install bcmath
RUN docker-php-ext-install ctype
RUN docker-php-ext-install fileinfo
RUN docker-php-ext-install json
RUN docker-php-ext-install mbstring
RUN docker-php-ext-install pdo
RUN docker-php-ext-install pdo_mysql
RUN docker-php-ext-install tokenizer
RUN docker-php-ext-install mysqli

# Instalando o composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

# Lipando pacotes do sistema, deixando a imagem com um tamanho menor
RUN rm -rf /var/lib/apt/lists/*
RUN rm -rf /etc/apt/sources.list.d/*
RUN rm -rf /tmp/*

# Criar pasta do projeto alterar usuario padrao e permissao
RUN mkdir /app
RUN chmod 777 -R /app
RUN chown -R www-data:www-data /app

# Pasta principal de trabalho
WORKDIR "/app"

# Gerando o Entrypoint para configurar o projeto
COPY ./laravel-entrypoint.sh /
RUN chmod 777 /laravel-entrypoint.sh
ENTRYPOINT [ "/laravel-entrypoint.sh" ]

# Portas abilitadas
EXPOSE 80 443

# Dando vida ao container
CMD ["apachectl", "-D", "FOREGROUND"]