FROM atlassian/default-image

# PHP 7.1
RUN apt-key update && \
    apt-get -y update && \
    apt-get -y install software-properties-common && \
    add-apt-repository ppa:ondrej/php && \
    apt-get -y upgrade && \
    apt-get -y update --fix-missing && \
    apt-get -y --force-yes install \
        php7.1-common \
        php7.1-cli \
        php7.1-mysqlnd \
        php7.1-mcrypt \
        php7.1-curl \
        php7.1-bcmath \
        php7.1-mbstring \
        php7.1-soap \
        php7.1-xml \
        php7.1-zip \
        php7.1-json \
        php7.1-imap \
        php-pgsql

# AWS cli
RUN curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" && \
    unzip awscli-bundle.zip && \
    ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws

# Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('SHA384', 'composer-setup.php') === '544e09ee996cdf60ece3804abc52599c22b1f40f4323403c44d44fdfdd586475ca9813a858088ffbc1f233e9b180f061') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer