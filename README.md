[![PartKeepr](https://partkeepr.org/images/partkeepr-banner.png)](https://www.partkeepr.org)

[![JSON-LD enabled](http://json-ld.org/images/json-ld-button-88.png)](http://json-ld.org)
[![Build Status](https://travis-ci.org/partkeepr/PartKeepr.svg?branch=sf2migration)](https://travis-ci.org/partkeepr/PartKeepr)
[![SensioLabsInsight](https://insight.sensiolabs.com/projects/a9f5bdce-ac86-4c51-b87d-56fd0f241155/mini.png)](https://insight.sensiolabs.com/projects/a9f5bdce-ac86-4c51-b87d-56fd0f241155)
[![Code Climate](https://codeclimate.com/github/partkeepr/PartKeepr/badges/gpa.svg)](https://codeclimate.com/github/partkeepr/PartKeepr)
[![Test Coverage](https://codeclimate.com/github/partkeepr/PartKeepr/badges/coverage.svg)](https://codeclimate.com/github/partkeepr/PartKeepr/coverage)
[![codecov](https://codecov.io/gh/partkeepr/PartKeepr/branch/master/graph/badge.svg)](https://codecov.io/gh/partkeepr/PartKeepr)


PartKeepr is an [inventory management software](https://en.wikipedia.org/wiki/Inventory_management_software), primarily
designed for electronic components.

PartKeepr is written in **PHP** and using the [**Symfony2**](http://symfony.com) framework.

Demo Site
---------

To test everything which has been written so far, please visit http://demo.partkeepr.org for a demo which is built from
the git sources once an hour.

Requirements
------------

PartKeepr needs:

* PHP between 7.0 and 7.1 - migration to newer symfony is needed before we support current php 7.x
* A MySQL or PostgreSQL database

Installation
------------

Please read our [setup guide](documentation/Installation.md)

Installation using Docker
-------------------------

* clone the repository from git
* edit docker-compose.yml, setting an appropriate MYSQL_PASSWORD
* $ docker-compose up
* open your browser and visit localhost:8080/web/setup/index.html

* setup cron
  
  `0 0,6,12,18 * * * cd /full/path/to/partkeepr && docker-compose exec app /usr/local/bin/php app/console partkeepr:cron:run`


Thanks
------

A very big "thank you" goes out to Georgyo of NYC resistor - although he claimed that he isn't creative, he invented the
name "PartKeepr" which eventually became the project's name.
