echo "Enter project name:"
read project_name
echo "Enter Ruby version:"
read ruby_version
echo "Enter Rails version:"
read rails_version

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

echo "Generating initial Gemfile"
curl -s https://raw.githubusercontent.com/sidapa/project-generator/wip/lib/Gemfile \
  | sed "s/<ruby_version>/$ruby_version/g" \
  | sed "s/<rails_version>/$rails_version/g" \
  > ./Dockerfile