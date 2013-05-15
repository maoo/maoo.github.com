---
title: Using Maven Alfresco SDK with the Enterprise edition
layout: post
primary_img: /img/post/alfresco-logo.png
categories: [alfresco, maven, sdk, build]
meta-description: Using Maven Alfresco SDK with the Enterprise edition
---

If you're an Alfresco aficionado, you should already know that last year we've released a new [Alfresco SDK](https://artifacts.alfresco.com/nexus/content/repositories/alfresco-docs/alfresco-lifecycle-aggregator/latest/index.html) to make developer's life easier and to provide a solid, consistent and reliable way to manage your Alfresco (customisation) projects.

If it's the first time you hear about this, start with [Gab's post](http://mindthegab.com/2012/11/05/maven-alfresco-sdk-1-0-is-finally-out-and-ready-for-you-to-enjoy/) to read about the project's history and all pointers.

In both cases, you may have missed the 1.0.1 release, whose biggest improvement is to allow the SDK to work with Alfresco Enterprise 4.1.2 (and later) versions. Earlier versions are not supported at the moment. This post guides you through all the steps to build an Alfresco Enterprise customisation using the Maven SDK.

Prerequisites
================
In order to get at the bottom of this tutorial you need credentials (username/password) to access the [Alfresco Nexus instance](https://artifacts.alfresco.com/nexus)), where the Enterprise artifacts are hosted; use the Nexus web interface to search for dependencies, check versions and other coordinates of the artifacts you need.

If you are an Alfresco customer and you want to request your credentials, you can follow this [internal article](https://support.alfresco.com/ics/support/default.asp?deptID=15026&task=knowledge&questionID=91)

And Maven 3.0.x of course.
That's it. No database & no tomcat needed. True story.

Generate a Maven Project using the archetypes
================
First step is to generate a Maven project; for simplicity we will use the [alfresco-amp-archetype](https://artifacts.alfresco.com/nexus/content/repositories/alfresco-docs/alfresco-lifecycle-aggregator/latest/archetypes/alfresco-amp-archetype/index.html), although the very same steps apply for the all-in-one archetype.

    mvn archetype:generate -DarchetypeCatalog=https://artifacts.alfresco.com/nexus/content/groups/public/archetype-catalog.xml -Dfilter=org.alfresco.maven.archetype:

The following command will ask you to define the following parameters:

* <b>archetype</b> - at the time of writing there are only 2 types of archetypes available: **alfresco-allinone-archetype** (1) and **alfresco-amp-archetype** (2). Let's go with <b><i>1</i></b>
* <b>groupId</b> - no special rules apply, you can choose any string you want. In my case I choose <b><i>it.session.alfresco</i></b>
* <b>artifactId</b> - as above, with the difference that the artifactId will also be the name of the folder that Maven will create as a result of the current command execution. I choose <b><i>session-repo-amp</i></b>
* <b>version</b> - the SDK version to use. It is very important that you choose option #2 (<b><i>1.0.1</i></b>) or above, otherwise the generated project will fail during the first build.

You will be asked to confirm all properties; type <b><i>Y</i></b>.

<b>BUILD SUCCESSFUL</b>? Let's move on!

Building the Maven Project using the community edition
================
Before testing the build with the Enterprise edition, it is strongly advised to try building with the community first.

The downside of this approach is that you will have to download all Alfresco Community dependencies first and - after that - all Alfresco Enterprise ones. If you have a slow connection, you may consider to skip this step and move to the next one; however, if you're having a hard time with the SDK (Maven sometimes can be a bitch) I advise you to test this approach.

It is as simple as

    cd session-repo-amp && mvn integration-test -Pamp-to-war

(Maven will download roughly 300Mb during the first build; this is probably the best time to take a break)

Your command-line shell should end up with

    INFO::Started SelectChannelConnector@0.0.0.0:8080
	[INFO] Started Jetty Server

Point your browser to **http://localhost:8080/session-repo-amp** and try to login using admin/admin; if everything works as expected you can move to the next section.

Configure access to private repositories
================
Open your **~/.m2/settings.xml** (or create one if it does not exist) and define the following **<server>** item

    <settings>
      ...
      <servers>
        ...	
	    <server>
          <id>alfresco-private-repository</id>
          <username>your_usernmae</username>
          <password>your_plain_password</password>
        </server>

If you don't like to write plain passwords in XML configuration files (like me), I strongly advise you to follow the [Maven tutorial on password encryption](http://maven.apache.org/guides/mini/guide-encryption.html), <b><i>but not before running the first successful build with the Enterprise edition</b></i>. Just keep it for later.

<b>NOTE!</b> If you are new to Maven, I strongly advise to comment out any <mirror> configurations from your **settings.xml** (at least for the first run), since mirroring delegates the entire artifact resolution to one central repository which may have been wrongly configured, leading to unresolved artifacts during the build.

Switch your project to Enterprise
================
Open **session-repo-amp/pom.xml** and set the following property values

    <alfresco.version>4.1.2</alfresco.version>
    <alfresco.groupId>org.alfresco.enterprise</alfresco.groupId>

You also need to change the repository configuration: instead of using the public Alfresco Maven repository (defined in your current pom file as <b><i>alfresco-public</i></b>), we need to switch to the private one. We don't need to add a new **<repository>**, since <b><i>all public artifacts are also served through the private repo</i></b>.

    <repository>
      <id>alfresco-private-repository</id>
      <url>https://artifacts.alfresco.com/nexus/content/groups/private</url>
    </repository>

Make sure that the repository <id> matches with the one specified earlier in the **settings.xml** file

Run it (again)
================
As before:

    cd session-repo-amp && mvn integration-test -Pamp-to-war

And now?
================
Why don't you leave a message on the [discussion list](https://groups.google.com/forum/#!forum/maven-alfresco) and share your development experience with the rest of the community? Also, if you have problems with the build, that's the right place to ask for help.