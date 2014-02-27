#!/bin/bash
git config --global --add user.name "GentooJP"
git config --global --add user.email www@gentoo.gr.jp
git config --local --unset remote.origin.url
git config --local --add remote.origin.url git@github.com:gentoojp/gentoojp.github.io.git
bundle rake deploy
