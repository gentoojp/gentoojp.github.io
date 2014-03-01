#!/bin/bash
git config --global --add user.name "GentooJP"
git config --global --add user.email www@gentoo.gr.jp
git config --local --unset remote.origin.url
git config --local --add remote.origin.url git@github.com:gentoojp/gentoojp.github.io.git
git clone git@github.com:gentoojp/gentoojp.github.io.git _deploy
(cd _deploy && git checkout -b master origin/master)
bundle exec rake deploy
