#!/bin/bash

# Downloads paas-dcos-installer and dcos-1.8-stratio0.3.0-SNAPSHOT.sh
# renames dcos-1.8-stratio0.3.0-SNAPSHOT.sh to dcos_generate_config.sh
# configures agent and master
# asks github credentials to download prepare_on_premise.sh
# dcos instalation

echo "Download paas and .sh"
curl -O https://s3-eu-west-1.amazonaws.com/dcos-packages/stratio-paas-dcos-installer-0.4.0-SNAPSHOT.tar.gz
tar -xvf stratio-paas-dcos-installer-0.4.0-SNAPSHOT.tar.gz
cd paas-dcos-installer/cli/
curl -O https://s3-eu-west-1.amazonaws.com/dcos-packages/dcos-1.8-stratio0.3.0-SNAPSHOT.sh
mv dcos-1.8-stratio0.3.0-SNAPSHOT.sh dcos_generate_config.sh
chmod +x dcos_generate_config.sh


echo "please, write agent ip"
read agent
echo "please, write master ip"
read master

#changes config.yml
cd genconf/
# set agent ip
sed -i -e "s/10.200.0.203/$agent/g" config.yaml
sed -i -e "s/- 10.200.0.204//g" config.yaml
# set master ip
sed -i -e "s/10.200.0.200/$master/g" config.yaml
sed -i -e "s/- 10.200.0.201//g" config.yaml
sed -i -e "s/- 10.200.0.202//g" config.yaml
cd ..


echo "prepare_on_premise"
cd ../..
echo "please, put your github username"
read user
echo "please, put your github password"
read pass
curl -L --retry 20 --retry-delay 2 -O https://raw.githubusercontent.com/Stratio/paas-dcos-installer/master/testsAT/src/test/resources/scripts/prepare_on_premise.sh -u "$user":"$pass"
echo "chmod de prepare on premise"
chmod +x prepare_on_premise.sh
cd paas-dcos-installer/
echo "delete ssh's"
rm -Rf /root/.ssh/id_rsa
echo "execute prepare on premise"
../prepare_on_premise.sh

echo "instalation DCOS"
./orchestrator.sh --install -t on_premise -f


#echo -n "Enter installation option "
#read option
#if [ "$option" = "1" ]; then
#    echo "option one."
#else
#    if [ "$option" = "2" ]; then
#        echo "option two."
#    else
#        if [ "$option" = "3" ]; then
#            echo "option three."
#        else
#            echo "option four"
#        fi
#    fi
#fi

