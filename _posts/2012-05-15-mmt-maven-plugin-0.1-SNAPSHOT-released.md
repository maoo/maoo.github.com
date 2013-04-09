---
title: mmt-maven-plugin 0.1-SNAPSHOT released
layout: post
primary_img: /img/post/alfresco-logo.png
categories: [alfresco, maven, amp, mmt]
meta-description: mmt-maven-plugin 0.1-SNAPSHOT released
---

MMT Maven Plugin
================

<b>UPDATE</b><br/>
The mmt-maven-plugin have been deprecated in favour of the alfresco-maven-plugin and the [Maven Alfresco SDK](https://artifacts.alfresco.com/nexus/content/repositories/alfresco-docs/alfresco-lifecycle-aggregator/latest/index.html)

<hr/>

After a month (or so) of experiments, it was time to deploy [the first snapshot](http://maven.alfresco.com/nexus/content/repositories/snapshots/org/alfresco/maven/plugin/mmt-maven-plugin/0.1-SNAPSHOT/) of a new version of the [maven-amp-plugin](http://maven.alfresco.com/nexus/content/repositories/alfresco-docs/maven-alfresco-lifecycle/plugins/maven-amp-plugin/components.html), the **mmt-maven-plugin**. Since there is no official documentation yet, I just wanted to share with you an initial draft of the usage and goal configurations; you can start using it already and test it in your builds that are currently based on maven-amp-plugin. The plugin is currently committed as a branch of the [Maven Alfresco Archetypes Google Code project](http://code.google.com/p/maven-alfresco-archetypes), although it could be soon moved to an Alfresco internal code repository.

In a nutshell, the MMT plugin covers all features of his predecessor, the AMP Plugin; the difference is in the code; the AMP Plugin was a rewriting of the maven-war-plugin, replacing ".war" with ".amp" and disabling some code here and there; since it was working fine no effort was ever made to improve it; on the contrary, the MMT Plugin uses the Alfresco Repository internals to perform the AMP operations, drastically lowering complexity and amount of code to maintain.

MMT Goals
======================

The mmt-maven-plugin provides the following features:

* **Packages an AMP** starting from a simple (and configurable) Maven project folder structure
* Performs **AMP to WAR overlay** by using the Alfresco Repository ModuleManagementTool and emulating the same process during Alfresco boostrap

Packaging an AMP
=======

* Define your POM as

    <code>
	  <packaging>amp</packaging>
	</code>

* Specify a module.properties file in the project's root folder, containing the properties

    <pre>
    module.id=${project.artifactId}
    module.title=${project.name}
    module.description=${project.description}
    module.version=${project.version}
    </pre>

As you can see, the file is filtered with Maven project placeholders

Declare the mmt-maven-plugin in your POM build section, as follows

    <build>
      <plugins>
        <plugin>
          <groupId>org.alfresco.maven.plugin</groupId>
          <artifactId>mmt-maven-plugin</artifactId>
          <version>0.1-SNAPSHOT</version>
        </plugin>
      </plugins>
    </build>

you can optionally define the following configurations to override your Maven project's structure (although not recommended)

    <configuration>
      <classesDirectory>${project.build.outputDirectory}</classesDirectory>
      <webappDirectory>src/main/webapp</webappDirectory>
      <configDirectory>src/main/webapp</configDirectory>
    </configuration>

AMP to WAR Overlay
=======

To overlay an existing Alfresco WAR file, you'll need the following elements

* Add a dependency to the Alfresco WAR webapp

    <dependencies>
      <dependency>
        <groupId>org.alfresco.enterprise</groupId>
        <artifactId>alfresco</artifactId>
        <version>4.0.1</version>
        <type>war</type>
      </dependency>
    </dependencies>
 
* Add the mmt-plugin configuration to run the install goal after the AMP have been packaged

    <plugin>
      <groupId>org.alfresco.maven.plugin</groupId>
      <artifactId>mmt-maven-plugin</artifactId>
      <version>0.1-SNAPSHOT</version>
      <executions>
        <execution>
          <id>unpack-amps</id>
          <phase>package</phase>
          <goals>
            <goal>install</goal>
          </goals>
          <configuration>
            <singleAmp>${project.build.directory}/${project.build.finalName}.${project.packaging}</singleAmp>
          </configuration>
        </execution>
      </executions>
    </plugin>
 

Please be aware that this is still an experimental work; I hope to give you some updates about this effort by the end of this/next week; meantime, any comment/feedback is indeed more than welcome.