# Imagem Base com PHP-7.2 e o Apache instalado, vai pegar a imagem mais atual
FROM php:7.2-apache

# Repository/Image Maintainer
LABEL maintainer="Lucas Lima <lucas.developmaster@gmail.com>"

USER root
RUN rm -rf /var/lib/apt/lists/*
RUN rm -rf /etc/apt/sources.list.d/*

#Installing SSL
RUN apt-get update -y

# Extensao que auxilia o composer 
RUN apt-get install unzip -y

# Instalando e abilitando o SSL/TLS
RUN apt-get install openssl -y
RUN a2enmod ssl && a2ensite default-ssl && a2enmod rewrite

# Copying certificate files SSL
COPY ./apache2/default-ssl.conf /etc/apache2/sites-enabled
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

# Criar pastas do projeto e criando link simbolico
RUN mkdir /app

# Application directory
WORKDIR "/app"

# Link simbolido da  pasta pulic do laravel para pasta html do apache
COPY ./project/ /app/
RUN ln -s /app/public/* /var/www/html/

# Dando permissao total na pasta APP para evitar problemas de permissao
RUN chmod 777 -R /app

# Gerando o Entrypoint para configurar o projeto
COPY ./laravel-entrypoint.sh /
RUN chmod 777 /laravel-entrypoint.sh
ENTRYPOINT [ "/laravel-entrypoint.sh" ]

# Portas abilitadas
EXPOSE 80 443

# Dando vida ao container
CMD ["apachectl", "-D", "FOREGROUND"]