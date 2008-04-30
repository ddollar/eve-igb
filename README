EVE IGB Support
===============

Support for EVE's In-Game Browser (IGB) including detection for respond_to and the IGB trust mechanisms.

IGB Detection
-------------

Example 1:

  respond_to :html, :xml, :eve
  
Example 2:

  respond_to do |wants|
    wants.html
    wants.xml
    wants.eve
  end

The new "eve" view type will work with or without a block passed to it. If there is no block passed, it
will search for a .reve file similar to the .rhtml and .rxml files for the html and xml types.

IGB Trust Mechanisms
--------------------

Example:

  before_filter :eve_trust_required