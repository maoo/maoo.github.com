---
title: Reviewing Alfresco 4 Enterprise Content Management Implementation
layout: post
primary_img: /img/post/alf-4-ecm-impl-book.jpg
categories: [alfresco, book, review]
meta-description: Reviewing Alfresco 4 Enterprise Content Management Implementation
---

This weekend I've read [Alfresco 4 Enterprise Content Management Implementation](http://www.packtpub.com/alfresco-4-enterprise-content-management-implementation/book), published by Packt on July 2013; in this review I'd like to provide some high-level description (and observations) of the most important chapters.

The book is based on Alfresco Enterprise 4.1.4, released on April 2013; currently the latest Enterprise version released is 4.2.0, which introduces some key features mentioned in this review.

Considering the huge amount and quality of information contained in this book, I consider it almost mandatory to have:

* If you want to introduce Alfresco Enterprise in your company, but don't know how (yet)
* If you're going to design architectures and/or applications based on Alfresco
* If you're a devops team who's dealing with an Alfresco project but never heard of it 'til now

### 1. Introduction to Alfresco
Probably the chapter I've enjoyed most; it introduces the direction Alfresco is taking in the evolution of ECM Open solutions: the Hybrid story, the key role of Open Standards, modern challenges of Business Automation and all other Alfresco "components" that map the wide landscape of the "Enterprise Collaboration" use cases.  This overwiew contains key concepts about the "smart & simple" approach to ECM that Alfresco is proposing; any "Product Owner" investing on Alfresco should have this knowledge extremely clear.

### 2. Installing Alfresco
This chapter goes through the Alfresco installation process using the Alfresco installer (one, amongst many, strategy to install Alfresco); it lists and describes the most important third-party libraries used by Alfresco and how to install/configure them.

I'd have expected more about the new [Alfresco Maven SDK](http://docs.alfresco.com/4.2/topic/com.alfresco.enterprise.doc/concepts/dev-extensions-maven-sdk.html), which is now considered the de-facto standard for building Alfresco customisations and plugins.

I think that - especially for Enterprise needs - a chapter about installation should also mention concepts like Automation and Provisioning, using tools like [Chef](https://github.com/maoo/chef-alfresco) and [Puppet](https://github.com/jurgenlust/puppet-alfresco), especially looking at the amount of [related](http://summit.alfresco.com/barcelona/sessions/aws-cost-effective-scalable-secure-alfresco-deployments) [speeches](http://summit.alfresco.com/barcelona/sessions/publishing-alfresco-solutions-aws-test-drive) [delivered](http://summit.alfresco.com/barcelona/sessions/enabling-test-driven-rapid-dev-continuous-delivery-alfresco-apps) [at](http://summit.alfresco.com/barcelona/sessions/alfresco-virtual-appliance) the Alfresco Summit 2013

### 3. Getting Started with Alfresco
I found this chapter maybe too dense, but full of very interesting info; it basically delivers

1. How to use Alfresco as a Collaboration Suite as a first-time user (based on Alfresco Explorer interface, not Share); I'd have expected to see Alfresco Share being used instead of Alfresco Explorer, considering that the latter is an interface that Alfresco is just maintaining but not developing upon since a while (at least one year)
2. How to perform administration tasks as a first-time Alfresco Administrator (using Alfresco Explorer); with Alfresco 4.2 a [new Repository Admin Console](http://blogs.alfresco.com/wp/kevinr/2013/09/30/alfresco-repository-admin-console/) is available
3. How to perform the first Alfresco configuration/run as a sysadmin (on Linux/Windows)
4. How to shape your first Alfresco architecture as a J2EE architect (high-availability, fail-over, multi-tenancy)

### 4. Implementing Membership and Security
A deep and detailed explaination of the Alfresco Security Model (ACLs, authorities, permissions, roles); I found particularly interesting:

1. Authentication and Authorisation explained
3. Clear separation between configuration (out of the box features) and customisation
4. Choosing the right security model for you (including examples for sso and ldap)

The chapter is more interesting from a business perspective rather than technical; there are some interesting import/export scripts that allow to automate data migration

### 5. Implementing Document Management
The chapter presents the core Alfresco concepts (Spaces, Documents, Metadata, ...) using Alfresco Explorer as interface and guiding the reader through some of the mostly used features (like Versioning, Metadata editing, Transformation and Extraction, Checkout/Checkin, Categories and Tags and much much more); I'd have preferred to see Alfresco Share as user interface for this chapter.

### 8. Implementing Workflow
I found very valuable the clear distinction between built-in and customisable Workflows; the step-by-step tutorial on how to implement a custom workflow using the Eclipse Activiti Designer is very detailed (from design to deployment) and simple to follow.

### 9. Integrating External Applications with Alfresco
This chapter gives an overview of Alfresco built-in integrations (Office, Drupal, Facebook and some more), providing an example of custom integration using Webscripts (a very common practice due to the simplicity of Webscripts implementation). REST and CMIS API are also described in details; it's an interesting reading, mostly technical, although it can be useful to evaluate the level of integration of Alfresco with a specific external product.

If you're interested in 4.2, you cannot miss [this great article](http://ecmarchitect.com/archives/2013/09/15/3554) of Jeff Potts explaining what's new.

### 12. Search in Alfresco
The new Alfresco Search strategy implemented in 4 introduces many options and opportunities; this chapter provides a good overview of the Alfresco Search Service and the different (Lucene/Solr) engine configurations; it is extremely important - for any type of reader - to understand the potentials of the new search features, since it plays - in most cases - a key role in the overall platform performance.