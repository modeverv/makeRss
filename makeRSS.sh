#! /bin/bash

PATH=$PATH:/home/seijiro/.nvm/v0.8.4/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games
export PATH="/home/seijiro/.rvm/bin:$PATH" # Add RVM to PATH for scripting
source /home/seijiro/.rvm/environments/ruby-2.3.0
ruby -v

cd /home/seijiro/Dropbox/code/ruby/makepodcast/

ruby make_podcast.rb > /var/www/chiaki/demo.rss
