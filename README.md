= BrewBit Protocol Buffers

== Installation

* Install `protoc` executables
  * Mac OS X
```
brew install protoc
```
  * Ubuntu
```
apt-get install protoc
```
* Install Python bindings
```
wget https://github.com/rem/python-protobuf/archive/master.zip
unzip master.zip
cd python-protobuf-master
# Next command might have to be run as sudo
python setup.py install
```
* For Ruby
  * Install Ruby 2.0
  * Run `bundle install` to get the gems

== Building

* Run `make`. This will create `.h` / `.c` files, as well as Ruby file
