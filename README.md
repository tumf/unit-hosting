Unit Hosting support libs for Ruby
==================================

[![Build Status](https://travis-ci.org/tumf/unit-hosting.png?branch=master)](https://travis-ci.org/tumf/unit-hosting)
[![Gem Version](https://badge.fury.io/rb/unit-hosting.png)](http://badge.fury.io/rb/unit-hosting)
[![Code Climate](https://codeclimate.com/github/tumf/unit-hosting.png)](https://codeclimate.com/github/tumf/unit-hosting)
[![Dependency Status](https://gemnasium.com/tumf/unit-hosting.png)](https://gemnasium.com/tumf/unit-hosting)
[![Coverage Status](https://coveralls.io/repos/tumf/unit-hosting/badge.png?branch=master)](https://coveralls.io/r/tumf/unit-hosting?branch=master)

This is a library and CLI tools to manage virtual servers on [UnitHosting](http://www.unit-hosting.com).

Ruby versions 1.8.7, 1.9.2, 1.9.3, 2.0.0

> **GitHub**
> https://github.com/tumf/unit-hosting


Install
-------

    [sudo] gem install unit-hosting
 
 > **RubyGems.org**
 > https://rubygems.org/gems/unit-hosting

Usage
-----

    unit-hosting [global options] command [command options] args..

Global Options
---------------


Commands
--------

* login
* logout
* vm create|destroy|boot|shutdown
* group add|delete

See Also
--------

* [UnitHosting API Specifications(Japanese Only)](http://blog.unit-hosting.com/doc/api-spec)

Copyright
---------

Copyright (c) 2011-2014 Yoshihiro TAKAHARA. See LICENSE.txt for further details.
