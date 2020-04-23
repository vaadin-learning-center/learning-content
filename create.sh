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
git checkout -b "author/$github/$content"

#Create file structure
mkdir "learn/tutorials/$content"
mkdir "learn/tutorials/$content/images"
touch "learn/tutorials/$content/article.properties"
touch "learn/tutorials/$content/content.adoc"

#Fill default data
echo "title=$name" >> "learn/tutorials/$content/article.properties"
echo "author=$fullname" >> "learn/tutorials/$content/article.properties"
echo "author_id=$id" >> "learn/tutorials/$content/article.properties"
echo "topics=<check topics.json>" >> "learn/tutorials/$content/article.properties"
echo "#card_image=" >> "learn/tutorials/$content/article.properties"

echo "= $name" >> "learn/tutorials/$content/content.adoc"
echo "" >> "learn/tutorials/$content/content.adoc"
echo ":type: text" >> "learn/tutorials/$content/content.adoc"
echo ":tags: <check>, <allowed_tags.lst>, <foo>, <bar>" >> "learn/tutorials/$content/content.adoc"
echo ":description: <put detailed description here>" >> "learn/tutorials/$content/content.adoc"
echo ":repo:" >> "learn/tutorials/$content/content.adoc"
echo ":linkattrs:" >> "learn/tutorials/$content/content.adoc"
echo ":imagesdir: ./images" >> "learn/tutorials/$content/content.adoc"
echo ":related_tutorials:" >> "learn/tutorials/$content/content.adoc"
echo "" >> "learn/tutorials/$content/content.adoc"
echo "<Write content here>" >> "learn/tutorials/$content/content.adoc"

#Success
echo "======================"
echo "Please write your tutorial in learn/tutorials/$content/content.adoc"
echo "IMPORTANT: Update topics value in learn/tutorials/$content/article.properties"
echo "======================"
