#!/bin/bash

# Get Drupal version from local .env file.
eval "$(grep ^DRUPAL_VERSION= .env)"

# Set up drupal version delimiter
drupal_version_delimiter=".";
# Set up the Drupal maximum version number
drupal_max_version_number=3;
# Get Drupal git repository from $DRUPAL_VERSION
# Split version
IFS=${drupal_version_delimiter} read -ra split_version <<< "$DRUPAL_VERSION";
# Get version length
version_size=${#split_version[@]};
# Get git representing version. Exemple : 8.x, 8.7.x, 8.7.4 
drupal_git_version=${split_version[0]};
for (( i=1; i<version_size; i++ ));
do
    drupal_git_version="${drupal_git_version}${drupal_version_delimiter}${split_version[$i]}";
done

if [ ${version_size} -lt ${drupal_max_version_number} ]
then
    is_full_drupal_version=false;
    drupal_git_version="${drupal_git_version}${drupal_version_delimiter}x";
    drupal_git_branch=${drupal_git_version};
else
    is_full_drupal_version=true;
    drupal_git_branch="${split_version[0]}${drupal_version_delimiter}${split_version[1]}${drupal_version_delimiter}x";
fi

# Set up Drupal github repository
drupal_github_repository_uri="https://github.com/drupal/drupal.git"
# Set up tmp folder to use git clone
drupal_tmp_folder_name="tmp_drupal";
# Clone Drupal repository
git clone -b ${drupal_git_branch} --single-branch  --depth=1 ${drupal_github_repository_uri} ${drupal_tmp_folder_name};
# If the version is full checkout corresponding tag
if [ ${is_full_drupal_version} = true ]
then
	cd ${drupal_tmp_folder_name};
    git checkout tags/${drupal_git_version};
	cd ..;
fi

# Get composer files
cat ${drupal_tmp_folder_name}/composer.json > ./composer.json;
cat ${drupal_tmp_folder_name}/composer.lock > ./composer.lock;
# Get shared folders
cp -R ${drupal_tmp_folder_name}/modules ./;
cp -R ${drupal_tmp_folder_name}/profiles ./;
cp -R ${drupal_tmp_folder_name}/themes ./;
cp -R ${drupal_tmp_folder_name}/sites ./;
# Get shared files
cp ${drupal_tmp_folder_name}/robots.txt ./robots.txt;
cp ${drupal_tmp_folder_name}/web.config ./web.config;
cp ${drupal_tmp_folder_name}/.htaccess ./.htaccess;

rm -rf tmp_drupal;

echo "Preparation completed !";
echo "Launch now : docker-compose up -d";