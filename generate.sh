#!/bin/bash

echo "Enter project name:"
read project_name
echo "Enter Ruby version:"
read ruby_version
echo "Enter Rails version:"
read rails_version
echo "Path to db-data directory"
read db_data_path

echo "Generating Dockerfile."
curl -s https://raw.githubusercontent.com/sidapa/project-generator/wip/lib/Dockerfile \
  | sed "s/<ruby_version>/$ruby_version/g" \
  | sed "s/<project_name>/$project_name/g" \
  > ./Dockerfile

echo "Generating entrypoint.sh"
curl -s https://raw.githubusercontent.com/sidapa/project-generator/wip/lib/entrypoint.sh \
  | sed "s/<project_name>/$project_name/g" \
  > entrypoint.sh
chmod +x entrypoint.sh

echo "Generating docker-compose.yml file."
curl -s https://raw.githubusercontent.com/sidapa/project-generator/wip/lib/docker-compose.yml \
  | sed "s/<project_name>/$project_name/g" \
  > ./docker-compose.yml

echo "Generating docker-compose.override.yml.sample file."
curl -s https://raw.githubusercontent.com/sidapa/project-generator/wip/lib/docker-compose.override.yml.sample \
  | sed "s/<project_name>/$project_name/g" \
  | sed "s/<db_data_path>/$db_data_path/g" \
  > ./docker-compose.override.yml.sample

echo "Generating .env.sample file."
curl -s https://raw.githubusercontent.com/sidapa/project-generator/wip/lib/.env.sample \
  | sed "s/<project_name>/$project_name/g" \
  > ./.env.sample

echo "Generating .npmrc"
curl -s https://raw.githubusercontent.com/sidapa/project-generator/wip/lib/.npmrc \
  > ./.npmrc

echo "Generating initial Gemfile"
curl -s https://raw.githubusercontent.com/sidapa/project-generator/wip/lib/Gemfile \
  | sed "s/<ruby_version>/$ruby_version/g" \
  | sed "s/<rails_version>/$rails_version/g" \
  > ./Gemfile

echo "Generating empty files."
declare -a FileList=(
                  "Gemfile.lock"
                  "package.json"
                )
for entry in "${FileList[@]}"
do
  echo "- $entry"
  echo "" > $entry
done

echo "Generating files from samples."
cp docker-compose.override.yml.sample docker-compose.override.yml
cp .env.sample .env