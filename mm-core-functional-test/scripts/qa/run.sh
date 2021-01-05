Deploy successfully stable version on pineline



#!/usr/bin/env bash
ENV="qa"

## command for update apt-get
apt-get update -y

## install python-dev for fix error when install pycrypto
apt-get install -y python-dev

## install virtualenv
pip3 install virtualenv

## create virtualenv for run robot
virtualenv acm-orbit-irs-base-robot-env

## use "." instead of "source" because os is ubuntu to activate env
. acm-orbit-irs-base-robot-env/bin/activate

## delete screenshot.png before running robot
rm -rf ../../selenium-screenshot*.png
rm -rf ../../results/$ENV/selenium-screenshot*.png

## install libs that using in robot
pip3 install -r ../../resources/requirements.txt

pip3 list

## command to run robot
python3 -m robot.run -L TRACE -v ENV:$ENV -v browser:headlesschrome -e not_used  -d ../../results/$ENV ../../testcases/

deactivate
exit 0