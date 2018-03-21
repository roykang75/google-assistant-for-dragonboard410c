#!/bin/bash


echo "install libraies"
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get -y install python3-dev python3-venv nano vim
python3 -m venv env
env/bin/python -m pip install --upgrade pip setuptools
source env/bin/activate


sudo apt-get install portaudio19-dev libffi-dev libssl-dev
python -m pip install --upgrade google-auth-oauthlib[tool]

echo "progress oAuth"
google-oauthlib-tool --client-secrets /home/linaro/client_secret_XXXXXX.apps.googleusercontent.com.json --scope https://www.googleapis.com/auth/assistant-sdk-prototype --save --headless


echo "Install gRPC and download Google Assistant"
python -m pip install grpcio grpcio-tools
python -m pip install --upgrade google-assistant-sdk[samples]

echo "regist device model"
googlesamples-assistant-devicetool register-model --manufacturer "Assistant SDK developer" --product-name "Assistant SDK light" --type LIGHT --model roy-model
googlesamples-assistant-devicetool list --model
git clone https://github.com/googlesamples/assistant-sdk-python
cp -r assistant-sdk-python/google-assistant-sdk/googlesamples/assistant/grpc new-project
cd new-project

echo "run Google Assistant"
python -m pushtotalk --device-model-id roy-model --project-id lofty-ivy-192309