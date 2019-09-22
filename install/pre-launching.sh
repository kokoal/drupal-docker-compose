#!/bin/bash

# Set up drupal version delimiter
drupal_version_delimiter=".";
# Set up the Drupal maximum version number
drupal_max_version_number=3;
# Get Drupal git repository from ${DRUPAL_VERSION}
# Split version
IFS=${drupal_version_delimiter} read -ra split_version <<< "${DRUPAL_VERSION}";
# Get version length
version_size=${#split_version[@]};
# Get git representing version. Exemple : 8.x, 8.7.x, 8.7.4 
drupal_git_version=${split_version[0]};
for (( i=1; i<${version_size}; i++ ));
do
    drupal_git_version="${drupal_git_version}${drupal_version_delimiter}${split_version[$i]}";
done

if [ ${version_size} -lt ${drupal_max_version_number} ]
then
    is_full_drupal_version=false;
    drupal_git_version="${drupal_git_version}${drupal_version_delimiter}x";
else
    is_full_drupal_version=true;
fi

# Set up Drupal github repository
drupal_github_repository_uri="https://github.com/drupal/drupal.git"
# Set up tmp folder to use git clone
drupal_tmp_folder_name="tmp_drupal";
# Clone Drupal repository
git clone --depth=1 ${drupal_github_repository_uri} ${drupal_tmp_folder_name};

if [ ${is_full_drupal_version} = true ]
then
    cd ${drupal_tmp_folder_name};
    git checkout tags/${drupal_git_version};
    cd ..;
fi

# Get composer file
cat ${drupal_tmp_folder_name}/composer.json > ./composer.json;
# Get shared folders
cp -R ${drupal_tmp_folder_name}/modules ./modules;
cp -R ${drupal_tmp_folder_name}/profiles ./profiles
cp -R ${drupal_tmp_folder_name}/themes ./themes;
cp -R ${drupal_tmp_folder_name}/sites ./sites;
cp ${drupal_tmp_folder_name}/robots.txt ./robots.txt;
cp ${drupal_tmp_folder_name}/web.config ./web.config;
# Create a composer.lock to prevent docker-compose error on volumes mount
touch ./composer.lock;

rm -rf tmp_drupal;

echo "Preparation completed !";
echo "Launch now : docker-compose up -d";