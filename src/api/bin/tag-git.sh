#! /bin/bash

# $TAGPERM environment variable
# generate a token at https://github.com/settings/tokens and encrypt it
# with `travis encrypt TAGPERM=<yoursecrettoken>`
# also see: https://docs.travis-ci.com/user/encryption-keys/#Usage
# and: https://docs.travis-ci.com/user/best-practices-security/

set email="builds@travis-ci.org"
set user="Travis CI"

git config --global user.email $email
git config --global user.name $user
export GIT_TAG=$TRAVIS_BRANCH-$TRAVIS_BUILD_NUMBER
git tag $GIT_TAG -a -m "Generated tag from Travis CI for build $GIT_TAG"
git push -q https://$TAGPERM@github.com/hackoregon/disaster-resilience-backend --tags
ls -R