#!/bin/sh

#Read profile data
. profile
echo "Profile:"
echo "$fullname"
echo "$id"
echo "$github"
echo "====================="

#Read new content name
echo "Please enter a name for the new content"
echo "e.g. Hello World Tutorial"
read name
content=$(echo "$name" | tr '[:upper:]' '[:lower:]' | tr " " -)
echo "Alright, creating content for $content.."

#Create Git branch
git branch "author/$github/$content"
git checkout "author/$github/$content"

#Create file structure
mkdir "tutorials/$content"
mkdir "tutorials/$content/images"
touch "tutorials/$content/article.properties"
touch "tutorials/$content/content.adoc"

#Fill default data
echo "title=$fullname" >> "tutorials/$content/article.properties"
echo "author=$github" >> "tutorials/$content/article.properties"
echo "author_id=$id" >> "tutorials/$content/article.properties"
echo "topics=<check topics.json>" >> "tutorials/$content/article.properties"
echo "#card_image=" >> "tutorials/$content/article.properties"

echo "= $name" >> "tutorials/$content/content.adoc"
echo "" >> "tutorials/$content/content.adoc"
echo ":type: text" >> "tutorials/$content/content.adoc"
echo ":tags: <check>, <allowed_tags.lst>, <foo>, <bar>" >> "tutorials/$content/content.adoc"
echo ":description: <put detailed description here>" >> "tutorials/$content/content.adoc"
echo ":repo:" >> "tutorials/$content/content.adoc"
echo ":linkattrs:" >> "tutorials/$content/content.adoc"
echo ":imagesdir: ./images" >> "tutorials/$content/content.adoc"
echo ":related_tutorials:" >> "tutorials/$content/content.adoc"
echo "" >> "tutorials/$content/content.adoc"
echo "<Write content here>" >> "tutorials/$content/content.adoc"

#Success
echo "======================"
echo "Please write your tutorial in tutorials/$content/content.adoc"
echo "IMPORTANT: Update topics value in tutorials/$content/article.properties"
echo "======================"

# Open editor
code "tutorials/$content/" "tutorials/$content/content.adoc"