unit-hosting
=============

This is a command to manage virtual servers on UnitHosting(http://www.unit-hosting.com).

[![Build Status](https://travis-ci.org/tumf/unit-hosting.png?branch=master)](https://travis-ci.org/tumf/unit-hosting)

Install
-------

    sudo gem install unit-hosting
 
 > **RubyGems.org**
 > https://rubygems.org/gems/unit-hosting

Usage
-----

 unit-hosting [global options] command [command options] args..

Global Options
---------------


Development
-----------

MySQLサーバの起動

```
sudo mysql.server start
```


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

Copyright (c) 2011 Yoshihiro TAKAHARA. See LICENSE.txt for
further details.

