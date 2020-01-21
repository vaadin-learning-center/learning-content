# Vaadin Learning Center content

This is the repository for the source content used on vaadin.com. Below are some instructions on authoring.

Also see `TEMPLATE.adoc` for a content template

## Contribution and branches

When contributing, please keep your branch naming as follows:
`author/author-name/tutorial-name`

When you are ready to get the content added, make a pull request to the `development` branch.

There is an automated contribution script `create.sh` that can create the branches and proper file structure for you with the following prerequisites:
- Unix/Linux environment
- No pending git changes and clean git status
- Visual Studio Code as an editor:

        If you are not using VSCode, you will get an error while attempting to run it.
        You can ignore the error and use your preferred editor.

To use the script, follow these instructions:

1. Create a new `profile` file based on the `profile.example` file:

```sh
cp profile.example profile
```

2. Modify the `profile` file in your home directory with your details, e.g.:

```sh
fullname="A.Mahdy Abdelaziz"
id=f484d2b8-7747-40c0-8a81-461808f32786
github=amahdy
```

3. Make `create.sh` executable

```sh
$ chmod +x create.sh
```

4. Run the script

```sh
$ ./create.sh
```

5. When asked for the new content name, enter a proper title for the content. It is used for the branch name, content title, and eventually the content URL on the website. So, make sure to provide a good title with proper format, e.g. `Intro to String Theory and Black Holes`.

6. If everything is ok, `Code` opens and the file where you should start writing your content `content.adoc` gets highlighted. Please note that you still have to update the `topics` value in `article.properties` file.

7. When you have done writing your content, push it to Github for review. You should be on the proper branch already.

## Definitions

### Article

An article encapsulates a set of sections and provides general meta data like the author and an introduction or teaser. If an article only has one section it is called a flat or simple article.

Meta data source: article.properties or in the content.adoc for flat articles.

| Property     | Mandatory                       | Definition                                                                                                                                                                                                                                                                                                         | Source                                                                                                                       |
| ------------ | ------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------- |
| id           | x                               |                                                                                                                                                                                                                                                                                                                    | folder name                                                                                                                  |
| path         | x                               | URL to the topic                                                                                                                                                                                                                                                                                                   | parent path + id                                                                                                             |
| title        | x                               |                                                                                                                                                                                                                                                                                                                    | meta data                                                                                                                    |
| url          | x                               | URL to the article                                                                                                                                                                                                                                                                                                 | resolved from the path if not specified as meta data (for external URLs)                                                     |
| author       | x                               | Author name, fallback                                                                                                                                                                                                                                                                                              | meta data                                                                                                                    |
| author_id    |                                 | UUID, screen name or email address of the author                                                                                                                                                                                                                                                                   | If specified the user will be looked up in the DB and 'author' property will be overridden and author image URL will be set. |
| topics       | x                               | Comma separated list of topic IDs. See [Topics](#topics) section below.                                                                                                                                                                                                                                            | meta data                                                                                                                    |
| publish_date |                                 | when to publish the article                                                                                                                                                                                                                                                                                        | if specified the article will not be visible before the given date                                                           |
| teaser       | x                               | a short paragraph that attracts the user to read the article                                                                                                                                                                                                                                                       | teaser.adoc                                                                                                                  |
| content      | x                               | the content of the first section of this article                                                                                                                                                                                                                                                                   | content.adoc or sections                                                                                                     |
| sections     | x                               | the sections the article consists of                                                                                                                                                                                                                                                                               | subfolders or content.adoc                                                                                                   |
| tags         |                                 |                                                                                                                                                                                                                                                                                                                    | meta data                                                                                                                    |
| og_image     |                                 | relative path (relative to `article.properties`) to image that is set as `og:image` for the Article view (e.g for tutorial series view). Example values `images/social-media.png`, `01__first_part/images/main-image.png`.                                                                                         | meta data                                                                                                                    |
| card_image   |                                 | relative path (relative to `article.properties`) to the preview image used in cards on e.g. Tutorials page. Not strictly mandatory, but should be always set, otherwise card doesn't look good without image. Example values `images/thumbnail.png`, `01__first_part/images/thumbnail.png`.                        | meta data                                                                                                                    |
| get_started_highlight |                        | Positive integer for specifying the order of this article/series to be shown in the "Get started with Vaadin" section on the main Tutorials page. If this property is not set, the tutorial/series will not be shown in the "Get started with Vaadin" section.                                                     | meta data                                                                                                                    |
| hidden       |                                 | When this property is set, the article is not shown in vaadin.com. Useful e.g. for work in progress articles that are not yet ready (or that need to be temporarily hidden) but are already committed to `development` branch. Example `hidden=true` in `article.properties` or just `:hidden:` in `content.adoc`. |                                                                                                                              |
| meta         | additional but custom meta data | everything that is part of the front matter or defined in property files or in asciidoc                                                                                                                                                                                                                            |                                                                                                                              |
| hubspot_form_id | ID of a hubspot form | displayed under the tutorial listing, mainly used to allow users to subscribe to articles/insights                                                                                                                                                                                                                            |                                                                                                                              |

### Section

The section provides the actual content. It has comparable meta data as the article and **overrides them**.

Meta data source: content.adoc

| Property              | Mandatory                       | Definition                                                                                                                                                                                                                                                                                                         | Source                                                                                                                       |
| --------------------- | ------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------- |
| id                    | x                               |                                                                                                                                                                                                                                                                                                                    | folder name                                                                                                                  |
| path                  | x                               | URL to the topic                                                                                                                                                                                                                                                                                                   | parent path + id                                                                                                             |
| order                 |                                 | number to order sections, not part of the URL                                                                                                                                                                                                                                                                      | prefix (e.g. 01\_\_) of the folder name                                                                                      |
| title                 | x                               |                                                                                                                                                                                                                                                                                                                    | meta data                                                                                                                    |
| url                   | x                               | URL to the article                                                                                                                                                                                                                                                                                                 | resolved from the path if not specified as meta data (for external URLs)                                                     |
| author                | x                               | Author name, fallback                                                                                                                                                                                                                                                                                              | meta data                                                                                                                    |
| author_id             |                                 | UUID, screen name or email address of the author                                                                                                                                                                                                                                                                   | If specified the user will be looked up in the DB and 'author' property will be overridden and author image URL will be set. |
| publish_date          |                                 | when to publish the article                                                                                                                                                                                                                                                                                        | if specified the article will not be visible before the given date                                                           |
| content               | x                               |                                                                                                                                                                                                                                                                                                                    | content.adoc                                                                                                                 |
| tags                  |                                 |                                                                                                                                                                                                                                                                                                                    | meta data                                                                                                                    |
| og_image              |                                 | relative path (relative to `imagesdir`) to image that is set as `og:image` for the Section view (e.g for tutorial details view). Example value `social-media.png`.                                                                                                                                                 | meta data                                                                                                                    |
| related_tutorials     |                                 | Comma-separated list of series ids (in practice any of the directory names directly under "tutorials"). Atm only first one will be displayed as a link under the tutorial content. A future design might show more than one.                                                                                       | meta data                                                                                                                    |
| recommended_tutorials |                                 | Comma-separated list of series ids (in practice any of the directory names directly under "tutorials"). Atm only first one will be displayed as a link under the tutorial content. A future design might show more than one.                                                                                       | meta data                                                                                                                    |
| hidden                |                                 | When this property is set, the section is not shown in vaadin.com. Useful e.g. for work in progress sections that are not yet ready (or that need to be temporarily hidden) but are already committed to `development` branch. Example `hidden=true` in `article.properties` or just `:hidden:` in `content.adoc`. |                                                                                                                              |
| meta                  | additional but custom meta data | everything that is part of the front matter or defined in property files or in asciidoc                                                                                                                                                                                                                            |                                                                                                                              |

### Topics

A topic is a special form of a tag with additional meta data. Articles must have one or more of the defined topics.

Meta data source: topics.json

| Property    | Definition                      | Source                                                                                  |
| ----------- | ------------------------------- | --------------------------------------------------------------------------------------- |
| id          |                                 | meta data                                                                               |
| title       | URL to the topic                | meta data                                                                               |
| icon        | vc-product icon                 | meta data                                                                               |
| meta        | additional but custom meta data | everything that is part of the front matter or defined in property files or in asciidoc |
| description |                                 | meta data                                                                               |

## URL mapping

The default is to map the filesystem path directly to the URLs. That means articles available via `content-base/<article-id>` in the file system are available via vaadin.com/content-base/<article-id>.

## Content format

_All content should be authored in AsciiDoc_. AsciiDoc provides its own way to define meta data:

```
= Creating a LitElement project

:title: Creating a LitElement project
:authors: marcus
:type: text, video
```

## Folder structure examples

This overview tries to sum up possible folder structures with flat/full articles.

```
    ├── <article>
    │   ├── article.properties (mandatory)
    │   ├── teaser.adoc (optional)
    │   ├── 01__<section name>
    │   │   ├── images
    │   │   │   └── blubb.png
    │   │   └── content.adoc (mandatory, asciidoc contains section properties already)
    │   ├── 02__<section name>
    │   │   ├── images
    │   │   │   └── moep.png
    │   │   ├── content.adoc (mandatory)
    │   │   └── section.properties (mandatory)
    ├── <flat-article>
    │   ├── article.properties (mandatory)
    │   ├── teaser.adoc (optional)
    │   └── content.adoc (mandatory)
```

Might be outdated, check https://gitlab.vaadin.com/vaadincom/webpage/blob/development/webpage-persistence/src/main/java/com/vaadin/backend/service/article/CategoryService.java#L23

## Sub Pages

/tutorials maps tutorial series and tutorials to articles, and article sections.

## FAQ

**1. What is the author id? Where should we add it, the article itself or the article.properties file?**

The author ID (UUID, LR screen name or email address of the author) is used to resolve the author in the DB to get the real name and portrait. Everything defined in the article.properties file is the default for the whole article but can always be overwritten by section properties. As an UUID please take the existing ID from the source of the vaadin.com team page.

**2. Where is the teaser shown? How long should it be?**

Depends on the sub page. The idea of a teaser is to attract people to read the article. For blog posts a teaser is displayed in the list view. For tutorials it makes sense to display it in the tutorial series view.

**3. Could we define ordering of a series through a properties file instead of by folder name? In case I would for instance want to add a tutorial between number 2 or 3. This way the URLs wouldn't break**

The URLs will not break as the order is not part of it. Putting it into the content files will hide them away and you will likely duplicate numbers or forget some (both will not break the page but might result in random ordering).

**4. What are the required attributes? Which ones are supported?**

Necessary attributes are in content.adoc (title, authors, type, topic, tags, description) and in article.properties (title, author,
author_id, topics). Valid values for the "topic[s]" attribute can be found in topics.json and for the "tags" attribute in allowed_tags.lst. How to get the UUI is described in FAQ #1.  

Check definitions of articles and sections above.

**5. What should the folder structure be for single articles?**

Check the folder example above.

**6. Checklist for publishing an article?

1. create files and folders like in the above described structure
2. set the right meta data configuration in the header of the content.adoc as well as in the article.properties. Valid values can be found in allowed_tags.lst and topics.json. Please check FAQ #4.
3. check consistency with test.py file. Therefor install python3 on your machine and let it run to make sure your article is consistent with the system
4. create a Pull Request to this repository.  
