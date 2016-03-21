# Beavy Base Docker Image

This is a Dockerfile for building [beavy](http://beavy.xyz) projects. It contains the commons used by all builds to make deployment faster.

In particular it:

 - is based on the latest Python 3 image
 - updates and upgrades all system libs
 - installs latest ICU for proper localisation
 - fetches and ships with the base-requirements from beavy-master, thus caching a bunch of common libs for you

Further more it has all commands set up for you copy all relevant python files over and install missing dependencies as beavy requires you to.
