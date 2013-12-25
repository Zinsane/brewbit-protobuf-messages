# BrewBit Protocol Buffers

This project contains the platform independent protobuf message representations used by the Model-T to communicate with the server at brewbit.com.

## Protocol

### Connection Setup

```jsseq
Device->Server: AuthenticationRequest\n  device_id\n  auth_token
Note right of Server: Server looks up device_id/\nauth_token combo and\ndetermines validity
Server->Device: AuthenticationResponse\n  authenticated = true
Note left of Server: or
Server->Device: AuthenticationResponse\n  authenticated = false
```

## Installation

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

## Building

* Run `make`. This will create `.h` / `.c` files, as well as Ruby file
