*clafer+ruby*
=============

In this project, we are investigating different ways of **enhancing data modling** capabilities of Ruby by incorporating constructs from [Clafer](http://clafer.org) or even by seamlessly embedding Clafer into Ruby.

Clafer is a lightweight structural modeling language with minimalistic syntax and powerful yet simple constraint language.

*team*
------

**[GSD Lab](http://gsd.uwaterloo.ca), University of Waterloo, Canada**

* [Michał Antkiewicz](http://gsd.uwaterloo.ca/mantkiew), project lead
* [Pavel Valov](http://gsd.uwaterloo.ca/pvalov), researcher
* [Krzysztof Czarnecki](http://gsd.uwaterloo.ca/kczarnec), advisor

**[Process & System Models Group](http://www.itu.dk/research/pls), IT University Copenhagen, Denmark**

* Paulius Juodisius, researcher
* [Andrzej Wąsowski](http://http://www.itu.dk/~wasowski/), advisor

*goals*
-------

The goal of the project is to demonstrate the way domain modeling could be used in the implementation and testing activities of a software project lifecycle. So far, we explored applications of Clafer in domain elicitation, requirements modeling, and architectural design. [Clafer Tools](http://www.clafer.org/p/software.html) is a set of Clafer-based tools that can be used for modeling: [Clafer Compiler](https://github.com/gsdlab/clafer/) can transform a clafer model into multiple output formats (Alloy, XML, HTML, DOT), Clafer Instance Generator [ClaferIG](https://github.com/gsdlab/claferIG/) can be used for model consistency checking and validation with respect to the domain by instance generation (valid instance should be generated, invalid ones should not), and [ClaferWiki](https://github.com/gsdlab/claferwiki) can be used for collaborative informal to formal domain modeling allowing mixing richtext with model fragments in Clafer.

In this project, we are exploring how domain models can be seamlessly and directly used in the implementation and testing activities: 

* a domain model in Clafer can serve as a data model (similarly to Rails ActiveRecord), 
* the constraints expressed in the model are business rules that can be checked during system's run-time, 
* the constraints can be used as pre- and post-conditions of methods, 
* instance generation can be used for combinatorial and guided test-data generation.

*example scenario*
------------------

[to be constructed... Below is the general idea...]

* create a domain model during domain elicitation and requirements engineering activities
* ideally, copy/paste or include into Ruby code. Clafer model should be Ruby code! Clafers from the model should be enhanced Ruby classes
* add methods to classes
* add pre- and post-conditions to methods

