---
title: Legacy libraries for your maven build
layout: post
primary_img: /img/post/legacy.png
categories: [alm, maven]
meta-description: Integrate legacy libraries in your maven builds
---

Legacy libraries
================

Dealing with legacy code is always tricky, and adapting your tooling to leverage them is sometimes plain hard. Especially when you're building your projects with Maven and your code happens to depend on some ancient library which appear to be unknown to the Internet™, you probably have to figure out how to tell Maven where to find that damn library. This is also the problem when dealing with e.g. proprietary third party libraries which don't ship with a POM, therefore they don't mavenly exist.

Local repositories FTW
======================

There are a number of possible solutions to the above mentioned problem, which ideally involve a shared, remote artifact repository where to deploy the JAR file that causes you headaches. Recently, I found myself in the need of creating (yet another) Maven build around some [Alfresco](http://www.alfresco.com), to enable [Lambdalf](http://skuro.tk/lambdalf/) to build its Clojure sources. The rocky road to Maven for Alfresco is still long, and as a result you find yourself dealing with some iffy libraries when coding against Alfresco. Some examples, just opening up the WAR files:

- `truezip.jar`
- `mybaties-3.0.4-patched.jar`
- `acegi-security-0.8.2_patched.jar`

One solution I found that doesn't require setting up your publicly available [Nexus](http://www.sonatype.org/nexus/) repository, nor using someone else's [Artifactory](http://www.jfrog.com/products.php), is to provide the problematic JARs in a maven repository as part of your sources. Suppose you have a mysterious `fluff.jar` library you need to include in your classpath, here's how it works:

* place the JAR file in `src/main/lib/fluff/fluff/unknown/fluff-unknown.jar`

* setup the dependency in your POM:

    <dependencies>
      <dependency>
        <groupId>fluff</groupId>
        <artifactId>fluff</artifactId>
        <version>unknown</version>
      </dependency>
    </dependencies>

* still in your POM, enable the local repository:

    <repositories>
      <repository>
        <id>legacy-artifacts</id>
        <url>file://${project.basedir}/src/main/lib</url>
      </repository>
    </repositories>

Voil&aacute;. You just created a local, portable repository in your sources and instructed Maven to look there for artifacts.

License
=======

A couple of golden rules for all the cowboy programmers out there:

* always, always, **always check if the license allows you to redistribute the libraries** you're going to include in your project
* never, never, **never distribute a piece of software you're not entitled to give away** and **attach the license of all third party libraries** along with your project

That said, I'll leave you to your local Maven repositories. Happy building!
