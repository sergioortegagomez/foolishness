[![Build Status](https://travis-ci.org/sergioortegagomez/foolishness.svg?branch=master)](https://travis-ci.org/sergioortegagomez/foolishness)

# foolishness

## Requirements

- [Linux Ubuntu 18.04](https://ubuntu.com/)
- [Vagrant 2.0.2](https://www.vagrantup.com/)
- [VirtualBox 5.2.32](https://www.virtualbox.org/)

## How to run this project?

Start the platform:

```console
$ bin/platformcontrol.sh up
```

And enter to your dev virtual machine

```console
$ bin/platformcontrol.sh ssh
```

Move to workspace by default

```console
$ cd /vagrant
```

### Build your project

```console
$ bin/devcontrol.sh build
```

### Up up up! :)

```console
$ bin/devcontrol.sh start
```

# Test

## Gatling test

```console
$ bin/devcontrol.sh test gatling-runner-main
```

## Cucumber test

```console
$ bin/devcontrol.sh test cucumber-runner-main
```