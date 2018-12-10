# Vaadin Learning Center content

This is the repository for the source content used on vaadin.com. Below are some instructions on authoring.

Also see `TEMPLATE.adoc` for a content template

## Definitions

### Article

An article encapsulates a set of sections and provides general meta data like the author and an introduction or teaser. If an article only has one section it is called a flat or simple article.

Meta data source: article.properties or in the content.adoc for flat articles.

| Property     | Mandatory                       | Definition                                                                              | Source                                                                                                                       |
| ------------ | ------------------------------- | --------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------- |
| id           | x                               |                                                                                         | folder name                                                                                                                  |
| path         | x                               | URL to the topic                                                                        | parent path + id                                                                                                             |
| title        | x                               |                                                                                         | meta data                                                                                                                    |
| url          | x                               | URL to the article                                                                      | resolved from the path if not specified as meta data (for external URLs)                                                     |
| author       | x                               | Author name, fallback                                                                   | meta data                                                                                                                    |
| author_id    |                                 | UUID, screen name or email address of the author                                        | If specified the user will be looked up in the DB and 'author' property will be overridden and author image URL will be set. |
| publish_date |                                 | when to publish the article                                                             | if specified the article will not be visible before the given date                                                           |
| teaser       | x                               | a short paragraph that attracts the user to read the article                            | teaser.adoc                                                                                                                  |
| content      | x                               | the content of the first section of this article                                        | content.adoc or sections                                                                                                     |
| sections     | x                               | the sections the article consists of                                                    | subfolders or content.adoc                                                                                                   |
| tags         |                                 |                                                                                         | meta data                                                                                                                    |
| meta         | additional but custom meta data | everything that is part of the front matter or defined in property files or in asciidoc |

### Section

The section provides the actual content. It has comparable meta data as the article and **overrides them**.

Meta data source: content.adoc

| Property     | Mandatory                       | Definition                                                                              | Source                                                                                                                       |
| ------------ | ------------------------------- | --------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------- |
| id           | x                               |                                                                                         | folder name                                                                                                                  |
| path         | x                               | URL to the topic                                                                        | parent path + id                                                                                                             |
| order        |                                 | number to order sections, not part of the URL                                           | prefix (e.g. 01\_\_) of the folder name                                                                                      |
| title        | x                               |                                                                                         | meta data                                                                                                                    |
| url          | x                               | URL to the article                                                                      | resolved from the path if not specified as meta data (for external URLs)                                                     |
| author       | x                               | Author name, fallback                                                                   | meta data                                                                                                                    |
| author_id    |                                 | UUID, screen name or email address of the author                                        | If specified the user will be looked up in the DB and 'author' property will be overridden and author image URL will be set. |
| publish_date |                                 | when to publish the article                                                             | if specified the article will not be visible before the given date                                                           |
| content      | x                               |                                                                                         | content.adoc                                                                                                                 |
| tags         |                                 |                                                                                         | meta data                                                                                                                    |
| related_tutorials | | Comma-separated list of series ids (in practice any of the directory names directly under "tutorials"). Atm only first one will be displayed as a link under the tutorial content. A future design might show more than one. | meta data |
| recommended_tutorials | | Comma-separated list of series ids (in practice any of the directory names directly under "tutorials"). Atm only first one will be displayed as a link under the tutorial content. A future design might show more than one. | meta data |
| meta         | additional but custom meta data | everything that is part of the front matter or defined in property files or in asciidoc |


### Topics

A topic is a special form of a tag with additional meta data. Articles must have one or more of the defined topics.

Meta data source: topics.json

| Property | Definition                      | Source                                                                                  |
| -------- | ------------------------------- | --------------------------------------------------------------------------------------- |
| id       |                                 | meta data                                                                             |
| title     | URL to the topic                | meta data      
| icon     | vc-product icon                | meta data      |
| meta     | additional but custom meta data | everything that is part of the front matter or defined in property files or in asciidoc |
| description |                                 | meta data                                                                         |

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

The author ID (UUID, LR screen name or email address of the author) is used to resolve the author in the DB to get the real name and portrait. Everything defined in the article.properties file is the default for the whole article but can always be overwritten by section properties.

**2. Where is the teaser shown? How long should it be?**

Depends on the sub page. The idea of a teaser is to attract people to read the article. For blog posts a teaser is displayed in the list view. For tutorials it makes sense to display it in the tutorial series view.

**3. Could we define ordering of a series through a properties file instead of by folder name? In case I would for instance want to add a tutorial between number 2 or 3. This way the URLs wouldn't break**

The URLs will not break as the order is not part of it. Putting it into the content files will hide them away and you will likely duplicate numbers or forget some (both will not break the page but might result in random ordering).

**4. What are the required attributes? Which ones are supported?**

Check definitions of articles and sections above.

**5. What should the folder structure be for single articles?**

Check the folder example above.
