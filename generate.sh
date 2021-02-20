echo "Enter project name:"
read project_name
echo "Enter Ruby version tag:"
read ruby_version

echo "Generating Dockerfile."
cat lib/Dockerfile \
  | sed "s/<ruby_version>/$ruby_version/g" \
  | sed "s/<project_name>/$project_name/g" \
  > ./Dockerfile

echo "Generating entrypoint.sh"
cat lib/entrypoint.sh \
  | sed "s/<project_name>/$project_name/g" \
  > entrypoint.sh
chmod +x entrypoint.sh