#!/bin/bash

#lancement serveur
cd server/ && vagrant up;

#lancement client
cd ../client && vagrant up;

#lancement dmz
cd ../dmz && vagrant up
