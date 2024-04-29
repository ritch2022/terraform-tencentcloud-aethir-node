#!/bin/bash

file_name="AethirCheckerClient.tar"
curl -fsSL https://aethir-checker-client.s3.ap-southeast-1.amazonaws.com/sg/AethirCheckerClient-linux-cli-installer.tar -o ./$file_name

tar xf $file_name

echo "Aethir installed directory: $(pwd)"
