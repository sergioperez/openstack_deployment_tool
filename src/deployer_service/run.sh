#!/bin/bash
./websocketd --staticdir="." --port 8080 ./deploy.rb
cp ../release1.tar.gz .

