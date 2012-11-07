#RubyBB

A ruby bulletin board

##License

[GNU AFFERO GENERAL PUBLIC LICENSE VERSION 3](https://www.gnu.org/licenses/agpl-3.0.html)

## Installation

### Dependencies

    sudo apt-get install python-software-properties
    sudo add-apt-repository ppa:chris-lea/node.js
    sudo apt-get update
    sudo apt-get install libmysqld-dev nodejs curl git-core build-essential zlib1g-dev libssl-dev libreadline6-dev gem libyaml-dev

### Ruby 1.9 with RVM

    bash < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer)
    echo '[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"' >> ~/.bashrc
    source ~/.bashrc
    rvm install 1.9.3

### Gems

    gem install mysql2
    gem install bundler
    gem install rails

### Fork, git clone and config

    cp config/database.yml.example config/database.yml

Configure `config/database.yml`. Then:

    bundle exec rake db:create

### Update everything

    git pull origin master
    bundle install
    bundle exec rake db:migrate

You're ready!

## Start the server

    bundle exec rails s
